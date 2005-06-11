Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVFKRlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVFKRlX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 13:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVFKRlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 13:41:23 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:38849 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261760AbVFKRkO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 13:40:14 -0400
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
Organization: IBM
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Serge Hallyn <serue@us.ibm.com>, David Woodhouse <dwmw2@infradead.org>,
       Steve Grubb <sgrubb@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
       Chris Wright <chrisw@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Mounir Bsaibes <bsaibes@us.ibm.com>
Subject: Re: [RFC][PATCH] filesystem auditing by location+name
Date: Sat, 11 Jun 2005 12:40:34 -0500
User-Agent: KMail/1.8
References: <200506101728.25709.tinytim@us.ibm.com> <200506111155.12439.tinytim@us.ibm.com> <20050611170021.GA1175@infradead.org>
In-Reply-To: <20050611170021.GA1175@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200506111240.35982.tinytim@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 June 2005 12:00, Christoph Hellwig wrote:
> On Sat, Jun 11, 2005 at 11:55:11AM -0500, Timothy R. Chavez wrote:
> > 1) Coverage
> > 
> > Inotify is only interested in a portion of the fs ops that we are interested 
> > in.  Most notably, we need the ability to generate records every time the 
> > [exec_]permission[_lite]() function is called.
> 
> That still means you could use the same infrastructure and now forward
> these events to inotify-ish clients, right?

I believe a common infrastructure is appropriate, yes.  I think it should
forward on events to whomever is interested, yes ;)  

> 
> > 2) Processing
> > 
> > The processing of events has to occur in the kernel, not in user space.  
> > Inotify collects events and tosses them back over the fence for processing.  
> > We cannot introduce any window of opportunity for audit subversion.
> 
> still means it could be a client to the same core event processing code
> and filesystem hooks, right?

Yes, this too is workable.  I do not believe, however, that this should be merged
into inotify's logic though.  I believe that auditfs and inotify would each be their 
own discreet client.  I think a common set of filesystem hooks is appropriate, but
I think processing of the events being channeled through those hooks should 
be left up to the recipient/client (like it already is).

> 
> > 
> > You see, auditfs is interested in the inode at location+name, whatever it may 
> > be when the auditable event occurs.  Thus, we've had to hook dcache to help 
> > us with this processing.  This is something Inotify does not care about nor 
> > should it.
> 
> Nor should the auditing code.  There's no way to find a good name for an
> inode _at all_, and only the last pathname component for a dentry.  If you
> try anything else your code is broken and will not get anywhere the mainline
> kernel.

Sure it should :)  The point is, you have a security relevant file like /etc/shadow
at a well defined path and you want to audit it.  If you rely solely on (inode,dev)-
based filtering, you'll lose audit before your "passwd" completes its execution
because the underlying inode associated with "shadow" would has changed.
This is no-good.

There are other locations+names you'd also like to audit as well, such as the
audit logs themselves, configuration files for the various trusted programs, etc.

>From an auditing stand point it makes perfect sense to audit a database as
such.  Or at the very least, have the option to do so.  Where auditing strictly
on (inode,device) makes sense or meets the administrators goals, it is 
encouraged.

However, being able to have a complete and comprehensive record of a 
security relevant database is crucial, I think ;)

> 
> > 3) Queue
> > 
> > Depending on the work, there may be a requirement that no audit record can be 
> > lost.  The message queue structure of inotify has the potential to overflow 
> > and drop events.  This is a no-go for us, but perfectly reasonable for 
> > inotify.
> > 
> > To make this work for us we'd have to hook the queueing functions to forward 
> > events on to the audit subsystem.  This would basically mean fitting a system 
> > that has been designed for interaction with userspace to also have 
> > interaction with other parts of the kernel... again, hackish.
> 
> Or build inotify ontop of your system.  It's not like inotify is perfect
> as-is (it's not, the userland interface is extremly horrible)

I think inotify's has sufficiently distinct goals that both projects would benefit
more from a common framework rather then a merger.  I think Robert would
agree.

I really do appreciate your comments.  The main goal here is to give the
mainline kernel a robust and useful audit subsystem.

-tim

