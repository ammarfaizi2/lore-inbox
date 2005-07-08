Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262815AbVGHTwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbVGHTwF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbVGHTuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:50:15 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:10694 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262815AbVGHTso
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:48:44 -0400
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
Organization: IBM
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] audit: file system auditing based on location and name
Date: Fri, 8 Jul 2005 14:48:03 -0500
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, linux-audit@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>,
       Mounir Bsaibes <mbsaibes@us.ibm.com>, Steve Grubb <sgrubb@redhat.com>,
       Serge Hallyn <serue@us.ibm.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Klaus Weidner <klaus@atsec.com>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, Robert Love <rml@novell.com>,
       Christoph Hellwig <hch@infradead.org>,
       Daniel H Jones <danjones@us.ibm.com>, Amy Griffis <amy.griffis@hp.com>,
       Maneesh Soni <maneesh@in.ibm.com>
References: <1120668881.8328.1.camel@localhost> <200507071449.16280.tinytim@us.ibm.com> <20050708174645.GE30908@kroah.com>
In-Reply-To: <20050708174645.GE30908@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507081448.04394.tinytim@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 July 2005 12:46, Greg KH wrote:
> On Thu, Jul 07, 2005 at 02:49:15PM -0500, Timothy R. Chavez wrote:
> > 
> > Even if access control prohibits us from actually seeing the content of 
> > /etc/shadow, if we're auditing /etc/shadow, attempts should be logged 
> > and not gone unnoticed.
> > 
> > watch /etc/shadow
> > passwd
> > <inode changes before execution ends>
> > cat /etc/shadow (goes unaudited)
> > <send event to user space>
> > ln /etc/shadow /home/foo/evil_shadow (goes unaudited)
> > <process in user space>
> > cat /home/foo/evil_shadow (goes unaudited)
> > <send back instructions to kernel to watch the new /etc/shadow>
> > cat /etc/shadow (audited)
> > 
> > Hmmm...
> 
> Then you watch the directory /etc/ which would have caught all of this,
> right?  My argument is that wouldn't inotify also want to know this
> exact same thing?
> 
> > > > I've yet to be convinced that merging these two projects or implementing 
> > > > one in terms of the other has any real benefit to either project in terms of
> > > > their individual goals and requirements.
> > > 
> > > You have common hooks in the kernel.  You do almost the same thing
> > > (report fs changes to userspace.)  Seems a natural thing to me.
> > 
> > This patch reports "fs changes" to the audit subsystem which then adds them 
> > to the audit_context of the current task.  Then, at system call exit, the audit_context 
> > is sent to user space, effectively logging not only the "fs change", but information 
> > regarding the process, system call, path, etc, to give the complete account.
> 
> Great, so your userspace notification is different than inotify, that's
> fine.  But what you are trying to do within the kernel is pretty much
> the same, which is my main point.
> 
> > > > The only real similarty between the two projects from my POV is that they 
> > > > are both interested in reporting a subset of file system activity and could 
> > > > benefit from a set of common hooks (ie: fsnotify) where it makes sense.
> > > 
> > > Exactly.  What else is there?
> > 
> > The fact that audit is interested in more activity then Inotify (like permission()),
> 
> Fine, inotify users can just ignore those messages.  Or perhaps they
> will grow to want to see them.
> 
> > must strive to never lose events,
> 
> Why is this not a good goal for inotify to also have?
> 
> > interacts with the audit subsystem directly, 
> 
> Ok, a difference.
> 
> > must conform to security requirements placed on it by various
> > Protection Profiles (for the time being, CAPP),
> 
> And those "security requirements" are what?
> 
> > defers sending the event record to user space until system call exit,
> 
> Again, not a big deal for inotify.
> 
> > the inode is relevant only if it's associated with the last component
> > of an audited path (not just the inode targetted initially)...
> 
> Again, something that I think inotify would like to also know.
> 
> > And I'm sure Robert could point out things that Inotify does that
> > audit doesn't do (and isn't very interested in doing).
> 
> Sure, just because you all do some things differently, doesn't mean that
> you shouldn't use the same core code.
> 
> Now I know you don't want to worry about another project's code getting
> into the kernel tree to depend on your changes, but hey, that's life.
> Try working with the inotify developers instead of ignoring them and
> duplicating the same stuff.
> 
> Also, you still have not pointed out what auditfs is for and how to use
> it.
> 

Yeah, it's admittedly named badly.  Perhaps that can change.

kernel/audit.c
kernel/auditsc.c
kernel/auditfs.c

> 
> thanks,
> 
> greg k-h

Hello Greg,

I've chosen not to respond to individual segments because the overall theme
is that the right thing to do is to not duplicate functionality.  Your suggestion 
is to merge the two projects.  In your mind, this benefits both projects.  It will 
consolidate the common functionality and enhance Inotify such that it is not 
only an event notification system for user space, but for other parts of the 
kernel -- namely audit -- as well.  Is this a fair assessment?

I think we can all agree that functionality should not be duplicated.  I have 
conceded that having two seperate hooks side-by-side that have the same 
purpose should be consolidated.  Because this would be generic, all other
notification hooks should be available to Inotify (and any other subsystem) 
as well.  Agreed?

My vision is that audit, Inotify, and whatever else plugs into this framework 
and receives notifications this way -- a file system event notification system 
for the kernel.  Then, audit, Inotify, etc would process this even information 
it receives and does with it what they will.

Ultimately, the part where we differ most, is the processing of information in 
fs/dcache.c to give dynamic updates in response to file system activity (such 
as attaching audit information to an auditable file whose inode just changed).  
I believe this should be kept seperate and not part of this framework nor Inotify.  
It's a specific requirement for audit, but not for Inotify.  This is one of the places 
the two systems are functionally different.

By doing it this way, both projects can retain their original goals and meet 
their individual requirements, and all the common pieces are consolidated in 
a logical way.  This is something Robert and I had discussed on LKML in early  
December 2004, and was brought up in a discussion more recently for an RFC 
on LKML in early June between Christoph Hellwig and myself.

Can this patch not be placed in -mm for the time being, as-is?  Surely the 
logic it implements, what I envision will ultimately be retained, could benefit 
from the exposure in the interim?

-tim
