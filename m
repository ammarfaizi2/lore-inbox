Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbULJFli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbULJFli (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 00:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbULJFlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 00:41:37 -0500
Received: from sigma957.CIS.mcmaster.ca ([130.113.64.83]:33193 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261667AbULJFlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 00:41:31 -0500
Subject: Re: [audit] Upstream solution for auditing file system objects
From: John McCutchan <ttb@tentacle.dhs.org>
To: Timothy Chavez <chavezt@gmail.com>
Cc: linux-kernel@vger.kernel.org, serue@us.ltcfwd.linux.ibm.com,
       sds@epoch.ncsc.mil, Robert Love <rml@novell.com>
In-Reply-To: <f2833c760412091602354b4c95@mail.gmail.com>
References: <f2833c760412091602354b4c95@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Dec 2004 00:41:42 -0500
Message-Id: <1102657302.18119.27.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-PMX-Version-Mac: 4.7.0.111621, Antispam-Engine: 2.0.2.0, Antispam-Data: 2004.12.9.24
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-10 at 00:02 +0000, Timothy Chavez wrote:
>  
> 2.  Filter based on some criteria, "I only care if /etc/shadow is
> open()'d by uid=X" (Filtering could be more granular then this or
> less, that's arbitrary at this point)
>  
> 3.  Be reassured that one may not bypass the audit subsystem nor lose
> an audit record.
>  
> Assuming we can do the filtering aspect in user space via auditd (or
> whatever), we've introduced some kernel work.  For instance, when we
> say we want to audit a file or directory, what we're really saying is,

This could amount to a lot of data being passed from the kernel to user
space. To do a complete audit from user space you would need to provide
as much context from the kernel as possible. 

>  
> "I'm interested in knowing when X syscall accesses/alters Y
> file/directory, so send me a record of this activity."
>  
> Some notable design problems to introduce now are with the "identity"
> of Y file/directory with respect to the kernel.  In fact, we only
> really care about paths of which file/directory Y completes.  I.e: If
> we want to audit /etc/shadow, we might not care if /etc/shadow is
> moved to /tmp/shadow.  This means that any access/alteration of
> /tmp/shadow would go unnoticed (unless otherwise specified).  However,
> if /tmp/shadow were a hardlink to /etc/shadow, we would then still
> care, because we are still effectively /etc/shadow... if that makes
> sense :-)
> 
> These are things that our design must consider in some way. 
>  
> 1.  Identifying a file, such as /etc/shadow, solely by a pathname,
> enables someone to create a hardlink to /etc/shadow from a different
> directory and by-pass the audit subsystem.  Also, we can't assume we
> have this user space definition of a file/directory in the kernel.
>  

hardlinks share the same inode. 

> 2.  Identifying a file, such as /etc/shadow, solely by its inode,
> enables a by-pass of the audit subsystem, when say, /etc/shadow gets
> copied to /etc/shadow+ and moved back.  Because the inode has changed,
> we're no longer the "same" file system object.  Similarly, if we
> delete an audited file, /tmp/ultra_secret (in /tmp? sounds like my old
> university), and recreate it, we'd like /tmp/ultra_secret to be
> audited.  This falls back on the "we don't want audit records to be
> lost" requirement.
>  

Using inotify you can handle this. You watch /tmp for SUBFILE/SUBDIR
creations, and then when you see ultra_secret again, start watching it.
This is very racy though.

> 3.  How do we treat mounts and --bind mounts?  I won't go into this in
> this e-mail.  There's several design decisions to made with regards to
> this issue.

More detail please..



> A.  A way in which it could, if desired, auto-watch the file/directory
> associated with an IN_CREATE_FILE/SUBDIR event.  This would also
> require we have some way to communicate , "We want this
> <file/directory> to be auto-watched" -- There might be an issue here
> because we're now giving meaning to the file/directory name associated
> with the inode.  We're now saying, "If the inode changes, but the name
> associated with it is the same, watch the new inode automatically."
>  

Inotify can provide a racy solution to this problem [see above]. I don't
know if it could be possible to provide an atomic solution to this
problem. Al Viro has lots of nasty things to say about providing any
kind of accurate view of the filesystem to user space.

> B.  Inotify would have to be able to notify the audit subsystem of
> events via a direct call internally, when the event is triggered. 
> You'd have some device with an "audit" flag on it that says, "Hey I'm
> interested in receiving events on behalf of audit, send them to me,
> and I'll pass them directly on to the audit subsystem."  This would be
> fairly easy to do, but would undermine the inotify event queuing
> process because we could not take any chances of losing event records
> in a queue that's overflowed.

Inotify could easily produce events for any part of the system. 

This being said, I don't think that inotify should be the solution.
Inotify was not designed with any of this in mind. A more generic
solution is needed and inotify could sit on top of it.

> 4.  Audit subsystem.  To me, this is the best solution (maybe even
> worst solution? we'll see what you have to say), but probably the
> nastiest one.  Let the audit subsystem hook VFS in all the necessary
> places and give audit an inode field to do the "book keeping."  The
> advantages here is that we're encapsulating ourselves as much as
> possible in the audit subsystem and not depending on any other
> subsystem except for the one constant in all our solutions, VFS.  If
> we were given the "go ahead" or some fuzzy feeling that this would be
> the best approach/attempt, we could implement this feature in the
> audit subsystem.  The disadvantages are fairly clear.  If this feature
> were configured Y, the inode structure would grow in size and if this
> were an inode field, we'd be keeping a list of "names," on it.  We'd
> also be introducing yet another set of hooks to VFS which have a very
> specific use.  And, on the kernel-side, we'd essentially be
> duplicating some of inotify's behavior.
>  
> However, the most obvious gain here, is that the subsystem is
> centralized and its intentions are clearer.

This is probably your best course of action. Later on we could merge
generic bits from this and inotify.
 
-- 
John McCutchan <ttb@tentacle.dhs.org>
