Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286311AbSA2XCP>; Tue, 29 Jan 2002 18:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286207AbSA2XBa>; Tue, 29 Jan 2002 18:01:30 -0500
Received: from ns.suse.de ([213.95.15.193]:50961 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S285692AbSA2XBP>;
	Tue, 29 Jan 2002 18:01:15 -0500
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org, nathans@sgi.com
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <p73aduwddni.fsf@oldwotan.suse.de.suse.lists.linux.kernel> <200201292208.g0TM8ql17622@ns.caldera.de.suse.lists.linux.kernel> <a377bn$1go$1@penguin.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 30 Jan 2002 00:01:12 +0100
In-Reply-To: torvalds@transmeta.com's message of "29 Jan 2002 23:28:38 +0100"
Message-ID: <p73d6zshidj.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds) writes:

> In article <200201292208.g0TM8ql17622@ns.caldera.de>,
> Christoph Hellwig  <hch@ns.caldera.de> wrote:
> >In article <p73aduwddni.fsf@oldwotan.suse.de> you wrote:
> >> "Most times". For example the EA patches have badly failed so far, just because
> >> Linus ignored all patches to add sys call numbers for a repeatedly discussed 
> >> and stable API and nobody else can add syscall numbers on i386. 
> >
> >There still seems to be a lot of discussion vs EAs and ACLs.
> >Setting the suboptimal XFS APIs in stone doesn't make the discussion
> >easier.
> 
> In fact, every time I thought that the extended attributes had reached
> some kind of consensus, somebody piped up with some apparently major
> complaint. 
> 
> I think last time it was Al Viro.  Admittedly (_very_ much admittedly),
> making Al happy is really really hard.  His perfectionism makes his
> patches very easy to accept, but they make it hard for others to try to
> make _him_ accept patches.  But since he effectively is the VFS
> maintainer whether he wants it to be written down in MAINTAINERS or not,
> a comment from him on VFS interfaces makes me jump. 
> 
> The last discussion over EA's in my mailbox was early-mid December, and
> there were worries from Al and Stephen Tweedie.  I never heard from the
> worried people whether their worries were calmed.

Stephen's objection was that the EA specification didn't define a standard
format for ACL EAs too. That's certainly true, but outside the EA spec
actually. First there are good reasons to have ACLs mapped to generic EAs.
There are also already other applications of EAs independent
of ACLs, for example there is an DMAPI implementation for XFS which needs
EAs, or HFS and NTFS need to map arbitary EAs defined by the foreign fs
to some common backupable format, and various extended security projects
need generic "blob" EAs too to store their per file security information.
Mapping the ACLs to EAs has the advantage that you can backup/archive/
network sync all these things with a single API, instead of teaching all
your backup tools about first ACLs and then generic EAs. 

About the common ACL spec: there are unfortunately different flavours of
ACLs. All the unix like implementations so far (ext2/3-acl and XFS acl)
use something very near the withdrawn POSIX draft, while NTFS/CIFS/NFSv4
have completely different ACLs, and AFS has another flavour. Trying to map 
these into a single ACL syscall seemed to hard and likely doesn't make 
sense. 

ext2/XFS currently rely on a single user space library that generates 
the POSIX ACLs. NTFS/NFSv4/etc. are out of scope because it's not clear
how to merge them. With generic EAs you could have a different user library
that manages NTFS ACLs (and another one for AFS etc.), it seems there will 
be no clean way around this.

For the ACL format used by the bestbits libacl there is afaik currently
no draft, just some source code, but the semantics are defined by the
POSIX draft and relatively fixed and also quite common in other Unixes. 

Al's objection seemed to be that the patch adding the new VFS functions
passed a struct inode * instead of a struct dentry * in one case. 
Fixing that is a trivial search'n'replace. I think it wasn't done at first
because it required changing the VFS to pass a dentry to i_op->permission() 
and they didn't want to bloat the patch with search-n-replace in every
filesystem yet. If you would integrate it that could be done of course.
[in short it is a non brainer, has nothing to do with the API but is 
just a small implementation detail that can be easily changed] 

Does that answer your questions? 
Would you look at a patch again? 

-Andi
