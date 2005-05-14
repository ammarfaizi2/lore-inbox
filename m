Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262691AbVENHFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbVENHFq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 03:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbVENHFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 03:05:45 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:32778 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262691AbVENHFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 03:05:18 -0400
To: hbryan@us.ibm.com
CC: bulb@ucw.cz, ericvh@gmail.com, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com
In-reply-to: <OF61E069CA.D46E38EE-ON88257000.00738E9B-88257000.007F4E51@us.ibm.com>
	(message from Bryan Henderson on Fri, 13 May 2005 16:09:59 -0700)
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
References: <OF61E069CA.D46E38EE-ON88257000.00738E9B-88257000.007F4E51@us.ibm.com>
Message-Id: <E1DWqbP-0005G2-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 14 May 2005 08:58:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >For ptrace the definition is:
> >     If the tracee has different privileges, than the tracer, than it
> >     can't be traced.
> > For this definition, the check is not a hack. It's the only way to go.
> 
> I agree this is the proper goal for ptrace and this code is not a hack. 
> It's a bug.  In Linux, uid, euid, suid, gid, egid, and sgid do not by 
> themselves determine privileges.  And that's what ptrace checks.  The main 
> determiner of basic privileges is the process capabilities.  The euid, 
> etc. do also.   I have frequently have on my system a process that runs 
> with the same uid, euid, etc. as some other process, but should not be 
> allowed to ptrace it because the tracee has CAP_DAC_OVERRIDE (the 
> privilege to access files in spite of file permissions) and the tracer 
> does not.

I'm constantly getting lost in the maze of rules, on what exactly
happens on setuid() etc, but I know that setuid() resets the
capabilities as well.  What's the way of changing euid and suid back
to ruid, and yet keeping some capabilities?

> So as with the user space programs I mentioned (where the euid check is 
> indeed a hack), I have to fix ptrace too.  Fortunately, it looks as simple 
> as comparing capability sets.
> 
> > Now this definition is really what is needed for the filesystem case
> > too, so I think it's not a hack either. 
> 
> Maybe I got lost in the problem we were trying to solve, then.  What does 
> comparing the privileges of one process with those of another have to do 
> with this thread about making safe unprivileged mounts via namespaces?

If process A accesses a filesystem controlled by process B, then B
gets ptrace-like ability over A.

Controlling a filesystem means, that a userspace process provides the
data/metadata for the filesystem as requested by the kernel.  It could
be a v9fs, FUSE, or NFS served by a userspace entity.

So what exactly can B do with A?

  - Know the exact sequence and timing of file operations being
    performed.  This is an information leak, though without serious
    consequences in most cases

  - Provide arbitrary data/metadata.  Extremely large files, extremly
    deep directories, etc.  This can lead to DoS, by forcing a more
    privileged program to process/store more data, than the user could
    possibly provide otherwise (because of quota, or simply filesystem
    size limits).

  - Determine the time it takes for each filesystem operation.  This
    is the most serious problem, as delaying an operation will result
    in hanging of the requester, possibly causing other hanging
    resources (e.g. file locks).

For more detailed analysis of the problem see
Documentation/filesystems/fuse.txt in -mm.

> The post to which I replied said we have to deal with set-uid
> programs. Aren't we talking about the problem where someone sets a
> file's setuid flag on with the assumption that when the program
> within runs, it will see certain files at certain places?  And the
> fact that if one could mount whatever he wants, that would violate
> the assumption?

No.  That assumption can easily be satisfied, by limiting where the
user can mount.  If mounting is only allowed on files/directories that
the user has unlimited write capability, than it cannot modify files
directories that the privileged process has assumptions about.

For example, in a private namespace, it's perfectly safe to allow bind
mounts (without any restrictions about which processes can access it)
on user writable files/directories.

>  The two ways suggested of handling that are: 1) after the private
> mount, ignore all setuid flags. 2) after the private mount, don't
> let a program that has gained privileges via set-uid see the
> user-made names.
> 
> My point is still that (2) can't be done because you can't know that a 
> program has gained privileged via set-uid.
> 
> If it's really not about set-uid, but about ptrace-like privilege 
> borrowing, please enlighten me.

Yes, it's about ptrace-like privilege borrowing and not about set-uid.

And as such, it probably needs the capability fix that you propose for
ptrace as well.

Thanks,
Miklos
