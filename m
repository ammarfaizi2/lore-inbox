Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVFKRBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVFKRBA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 13:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVFKRA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 13:00:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50050 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261741AbVFKRA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 13:00:27 -0400
Date: Sat, 11 Jun 2005 18:00:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Serge Hallyn <serue@us.ibm.com>, David Woodhouse <dwmw2@infradead.org>,
       Steve Grubb <sgrubb@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
       Chris Wright <chrisw@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Mounir Bsaibes <bsaibes@us.ibm.com>
Subject: Re: [RFC][PATCH] filesystem auditing by location+name
Message-ID: <20050611170021.GA1175@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Timothy R. Chavez" <tinytim@us.ibm.com>,
	linux-kernel@vger.kernel.org, Serge Hallyn <serue@us.ibm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@osdl.org>,
	Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Mounir Bsaibes <bsaibes@us.ibm.com>
References: <200506101728.25709.tinytim@us.ibm.com> <20050610223806.GA16506@infradead.org> <200506111155.12439.tinytim@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506111155.12439.tinytim@us.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 11:55:11AM -0500, Timothy R. Chavez wrote:
> 1) Coverage
> 
> Inotify is only interested in a portion of the fs ops that we are interested 
> in.  Most notably, we need the ability to generate records every time the 
> [exec_]permission[_lite]() function is called.

That still means you could use the same infrastructure and now forward
these events to inotify-ish clients, right?

> 2) Processing
> 
> The processing of events has to occur in the kernel, not in user space.  
> Inotify collects events and tosses them back over the fence for processing.  
> We cannot introduce any window of opportunity for audit subversion.

still means it could be a client to the same core event processing code
and filesystem hooks, right?

> 
> You see, auditfs is interested in the inode at location+name, whatever it may 
> be when the auditable event occurs.  Thus, we've had to hook dcache to help 
> us with this processing.  This is something Inotify does not care about nor 
> should it.

Nor should the auditing code.  There's no way to find a good name for an
inode _at all_, and only the last pathname component for a dentry.  If you
try anything else your code is broken and will not get anywhere the mainline
kernel.

> 3) Queue
> 
> Depending on the work, there may be a requirement that no audit record can be 
> lost.  The message queue structure of inotify has the potential to overflow 
> and drop events.  This is a no-go for us, but perfectly reasonable for 
> inotify.
> 
> To make this work for us we'd have to hook the queueing functions to forward 
> events on to the audit subsystem.  This would basically mean fitting a system 
> that has been designed for interaction with userspace to also have 
> interaction with other parts of the kernel... again, hackish.

Or build inotify ontop of your system.  It's not like inotify is perfect
as-is (it's not, the userland interface is extremly horrible)

