Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbULJCun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbULJCun (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 21:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbULJCun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 21:50:43 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:58630 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261673AbULJCuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 21:50:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=CDyYZI/+roXkkmjEwn3w9RM50Y8utBOQ5M8eTvBb9DhB52RYBJfUbzFTYMGrSR5kJPv6K34lSJkta2MdeArs/+UFVt+tGlOsdG+SBGE8wh6N2k0zwmOyq1Tr4W2uPHctZaImgK+o2JUCblVhfGHibck7efTkE9c8A1MFrKyw3fw=
Message-ID: <f2833c76041209185024cb1c4d@mail.gmail.com>
Date: Fri, 10 Dec 2004 02:50:01 +0000
From: Timothy Chavez <chavezt@gmail.com>
Reply-To: Timothy Chavez <chavezt@gmail.com>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: [audit] Upstream solution for auditing file system objects
Cc: linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, rml@novell.com,
       ttb@tentacle.dhs.org
In-Reply-To: <20041209174610.K469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <f2833c760412091602354b4c95@mail.gmail.com>
	 <20041209174610.K469@build.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris,

Thanks for the response.  Reply embedded...

(Also I removed serue from the CC, I guess I copied the wrong address for Serge)


On Thu, 9 Dec 2004 17:46:10 -0800, Chris Wright <chrisw@osdl.org> wrote:
> * Timothy Chavez (chavezt@gmail.com) wrote:
> 
> 
> > Over the last two months, I've been given the daunting task of
> > implementing a feature by which an administrator can specify from user
> > space, a list of file system objects (namely regular files and
> > directories) that he/she wishes to audit.  The administrator would
> > presumably like to,
> >
> > 1.  Specify a file, "/etc/shadow"
> >
> > 2.  Filter based on some criteria, "I only care if /etc/shadow is
> > open()'d by uid=X" (Filtering could be more granular then this or
> > less, that's arbitrary at this point)
> >
> > 3.  Be reassured that one may not bypass the audit subsystem nor lose
> > an audit record.
> >
> > Assuming we can do the filtering aspect in user space via auditd (or
> > whatever), we've introduced some kernel work.  For instance, when we
> > say we want to audit a file or directory, what we're really saying is,
> >
> > "I'm interested in knowing when X syscall accesses/alters Y
> > file/directory, so send me a record of this activity."
> >
> > Some notable design problems to introduce now are with the "identity"
> > of Y file/directory with respect to the kernel.  In fact, we only
> > really care about paths of which file/directory Y completes.  I.e: If
> > we want to audit /etc/shadow, we might not care if /etc/shadow is
> > moved to /tmp/shadow.  This means that any access/alteration of
> 
> Of course you would.  A mv to /tmp/shadow includes an unlink, which
> should be an auditable event.

Yes, you're absolutely right.  Anyway, the point I was trying to drive
home is that once moved to /tmp/shadow from an auditable path,
/etc/shadow, audit records will no longer be generated.  If we do mv
/tmp/shadow to /etc/shadow then audit will resume on /etc/shadow...
onward..

> > /tmp/shadow would go unnoticed (unless otherwise specified).  However,
> > if /tmp/shadow were a hardlink to /etc/shadow, we would then still
> > care, because we are still effectively /etc/shadow... if that makes
> > sense :-)
> 
> Yes, at this point you care about the inode not the pathname (the latter
> is just a handle to the former).
> 
> > These are things that our design must consider in some way.
> >
> > 1.  Identifying a file, such as /etc/shadow, solely by a pathname,
> > enables someone to create a hardlink to /etc/shadow from a different
> > directory and by-pass the audit subsystem.  Also, we can't assume we
> > have this user space definition of a file/directory in the kernel.
> 
> What does that mean, "user space definition of a file/dir in kernel"?

Oh, I suppose description would have been a better word then
definition.  I was trying to say that we can't deal with path names. 
How we handle a file/directory in the kernel will be with dentry's and
inodes.  Sorry about that.

> > 2.  Identifying a file, such as /etc/shadow, solely by its inode,
> > enables a by-pass of the audit subsystem, when say, /etc/shadow gets
> > copied to /etc/shadow+ and moved back.  Because the inode has changed,
> > we're no longer the "same" file system object.  Similarly, if we
> 
> OK, depends on the mechanism (O_TRUNC and write or unlink and rename).

Sure.  But the fact remains that if we say, "audit /etc/shadow" that
regardless of the underlying inode, relevant access / alterations to
/etc/shadow are audited.
 
> > delete an audited file, /tmp/ultra_secret (in /tmp? sounds like my old
> > university), and recreate it, we'd like /tmp/ultra_secret to be
> > audited.  This falls back on the "we don't want audit records to be
> > lost" requirement.
> 
> So the pathname is relative to the parent dir, which needs to know the
> about these special names.

Correct.  This is sufficient.

> > 3.  How do we treat mounts and --bind mounts?  I won't go into this in
> > this e-mail.  There's several design decisions to made with regards to
> > this issue.
> 
> Well, it's an important one, can't just punt on it.

I have carpel tunnel and ADD?? :-)  Can we treat the filesystem as
flat and just restart the auditd to recaliberate itself?  Is that
reasonable?  I'm not sure.  If designed right, I think we could slip
by --bind mounts unscathed.  If we mount --bind /etc/ /tmp/foo and we
do touch /tmp/foo/shadow, shadow will consult the table associated
with foo's inode, the same inode of /etc.  So, I might be missing
something, but this wouldn't give us any problem.

 
> > 4.  How can we obtain the full path of the file system object without
> > reconstructing it in the kernel?  Xattrs? Integer cookies/hashes that
> > key a table in user space?
> 
> There's no such thing.  How do you store a single path in an xattr (which
> is on an inode) for an inode that has multiple hardlinks, or multiple
> vfsmounts (since you can't punt on --bind ;-).  The _best_ you could do
> is go by the path that the user used (audit captures that already IIRC).

You're right.  But to be able to say something about the origin of the
audit....  If you're generating audit records for /etc/shadow, which
was specifically set "auditable," you at least will be able to get
this in the log.  The fact that /etc/shadow was accessed/altered is
whats really important and not necessarily from where it was
accessed/altered, should suffice.  Right?

> > 5.  Whats the best approach at capturing information about the syscall
> > accessing / altering the file/directory?  We might lose records if we
> > attempt to capture this information from VFS hooks as we could
> > short-circuit before we ever reached that point in the function.  We'd
> > then need a way of related the audit of a system call that in place
> > now with the file/directory its accessing. (This particiular issue is
> > not talked about in this e-mail in any detail, really)
> 
> I think you'd need to do more filtering in userspace, and generate a lot
> of extra audit records.  At each point (audit, and lsm hook) there's not
> enough context.  I can't recall when the record is created, if it's at
> the syscall exit point, then the hook can tell you if you actually cared
> about the transaction.

It's probably not wise to collect information in lsm hooks because we
could return out of the function before we ever hit the hook (I think
you talk about this further down) and we'll miss potentially important
audit records.  So auditd would just have to piece together the
complete message in userspace, based on a unique serial number or
something, for all the message that says, "such and such was accessed 
/ altered" with the their corresponding, "by this syscall under these
conditions" part.
> 
> 
> > The Reason:
> > ~~~~~~~~~~~
> >
> > The current audit subsystem does not contain this capability.  This
> > capability is essential for meeting Controlled Access Protection
> > Profile (CAPP) Evaluation Assurance Level (EAL) 4+ requirements.
> >
> > The Solutions:
> > ~~~~~~~~~~~~~~
> >
> > (These are brief notes.  More implementation detail can be provided it
> > asked for.  If someone is interested in discussing an actual solution,
> > we can get into that - I'd like to get into that.  I'm just trying to
> > give you a sense of some of the things that have been thought about).
> >
> > 1.  Inotify. Inotify implements a good portion of what we'd like to do
> > and looks like its well on its way into the mainline kernel.  What
> > would need to be added to inotify:
> >
> > A.  A way in which it could, if desired, auto-watch the file/directory
> > associated with an IN_CREATE_FILE/SUBDIR event.  This would also
> > require we have some way to communicate , "We want this
> > <file/directory> to be auto-watched" -- There might be an issue here
> > because we're now giving meaning to the file/directory name associated
> > with the inode.  We're now saying, "If the inode changes, but the name
> > associated with it is the same, watch the new inode automatically."
> 
> Not exactly, you're saying let me know if the name in this dir goes away
> or gets created.  If it's created then you register for all it's access
> activity. </handwavy>

Yes, but this decision and action would have to be taken in inotify. 

> 
> 
> 
> > B.  Inotify would have to be able to notify the audit subsystem of
> > events via a direct call internally, when the event is triggered.
> > You'd have some device with an "audit" flag on it that says, "Hey I'm
> > interested in receiving events on behalf of audit, send them to me,
> > and I'll pass them directly on to the audit subsystem."  This would be
> > fairly easy to do, but would undermine the inotify event queuing
> > process because we could not take any chances of losing event records
> > in a queue that's overflowed.
> 
> I wonder if you could register with inotify and it could callback to
> you for the events that you register for?  Then you're responsible
> for dealing with audit subsystem, not inotify.  Classic consumer deal,
> can you add yourself to being an event consumer?
> 

Some way for inotify to "notify" other parts of the kernel of file
system activity would be good.  This is the arguement I'd like to use.
 If inotify can notify userspace apps of activity/events, why can't it
notify kernel subsystems?  There might be a very good reason as to why
this can't be so.  "Just because" might be it :-) Whatever the reason,
it'd be good to hear.  I wouldn't want to destroy or degrade the
intended use of inotify, but expand it.  If that's not doable, then
there's no way we can use inotify.  This would have to be something
John and Rob and whoever else contributes to Inotify would like in
addition to the community as a whole.

> 
> > 2.  Linux Security Module.  This is perhaps the most daunting
> > approach. This solution would allow us to use the i_security field of
> > the inode to do our "book keeping."  We'd also have at our disposal
> > the the security hooks already in-place in the VFS.  This would allow
> > us to intercept the relevant syscalls via function pointers, to make
> > decisions on what we want to do.  Using the i_security field to hold
> > our table of auditable files/directories on parent directory inodes,
> > would enable us to ask the question, "Does this file/directory that's
> > just been created beneath me need to be marked as "auditable?" from
> > with in, say, security_inode_post_create().
> >
> > The advantages to a module is that we can make this audit option
> > more... optional.  We're not introducing any new hooks and we're using
> > the LSM's inode i_security field, too.  This keeps the inode
> > structure's size flat and minimizes our impact in the VFS.
> > Disadvantages are that for it to play nicely with other LSMs like
> > SELinux, we'd need the LSM stacker or else we'd need to disable
> > SELinux.  We'd also be forcing the question, "Is this an appropriate
> > use of the LSM framework?"  Although this feature is definitely
> > security-relevant and related, is what it does an appropriate context
> > for use of the LSM framework?  Some would say that the LSM framework
> > is for Access Control only, others would disagree.
> 
> It's on the edge.  LSM is designed for access control, but does give the
> hooking needed to do this security relevant operation.  We specifically
> did not include audit functionality into LSM because of the audit needs
> (syscall centric, early exit points are missed, etc.).
> 
> 
> > 3.  SELinux.  This feature is not currently in SELinux (as we've been
> > told), but we've had interest by the NSA in implementing this feature
> > for SELinux.  We'd have a similar solution to the LSM, except we'd
> > encapsulate ourselves within SELinux, and use its framework to drive
> > the solution.  This might prove less resilient, politically, because
> > we'd be under its umbrella.  I'm not clear on the exact implementation
> > of this in SELinux -- It sounds like it'd be a patch to the security
> > server and hooks, the creation of an audit label, and the invention of
> > some additional structure for "book keeping" purposes.  Also, there is
> > a general problem with using SELinux specifically with figuring out
> > how to certify with it enabled.  There's a lot of complications
> > (mostly unknowns) -- Complications we'd willingly work on, if need be.
> >  Obviously design decisions would have to be factor in as well.
> >
> > 4.  Audit subsystem.  To me, this is the best solution (maybe even
> > worst solution? we'll see what you have to say), but probably the
> > nastiest one.  Let the audit subsystem hook VFS in all the necessary
> > places and give audit an inode field to do the "book keeping."  The
> > advantages here is that we're encapsulating ourselves as much as
> > possible in the audit subsystem and not depending on any other
> > subsystem except for the one constant in all our solutions, VFS.  If
> > we were given the "go ahead" or some fuzzy feeling that this would be
> > the best approach/attempt, we could implement this feature in the
> > audit subsystem.  The disadvantages are fairly clear.  If this feature
> > were configured Y, the inode structure would grow in size and if this
> > were an inode field, we'd be keeping a list of "names," on it.  We'd
> > also be introducing yet another set of hooks to VFS which have a very
> > specific use.  And, on the kernel-side, we'd essentially be
> > duplicating some of inotify's behavior.
> 
> It's sounding like allowing the audit subsystem to subscribe to inotify
> events is the best alternative at first glance.
>

This would be good.  Inotify would need some definate changes to make
this work cleanly.  Right now its very specific in that it queues
events from the VFS to be written to a character device driver.  With
our method we assume everything being watched on a device with an
audit_notify=1 will call the audit_log() function (which writes out to
an audit buffer at which point the audit subsystem takes over).
 
> > However, the most obvious gain here, is that the subsystem is
> > centralized and its intentions are clearer.
> >
> > 5.  Kprobes.  I know nothing about them.  These have not been
> > considered, but were mentioned to me just recently by two different
> > people.  I'm not sure if this approach could be useful or not.  Any
> > help here?
> 
> Well, these just give you primarily ad-hoc hooking.
> 
> thanks,
> -chris
> --
> Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
> 

-- 
- Timothy R. Chavez
