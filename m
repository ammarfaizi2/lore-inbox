Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVA3LOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVA3LOD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 06:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVA3LOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 06:14:03 -0500
Received: from rev.193.226.232.37.euroweb.hu ([193.226.232.37]:62639 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261677AbVA3LNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 06:13:48 -0500
To: lkcl@lkcl.net
CC: abo@kth.se, openafs-devel@openafs.org, opendce@opengroup.org,
       selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org
In-reply-to: <20050130033020.GE6357@lkcl.net> (message from Luke Kenneth
	Casson Leighton on Sun, 30 Jan 2005 03:30:20 +0000)
Subject: Re: Using fuse for AFS/DFS (was Re: [OpenAFS-devel] openafs / opendfs collaboration)
References: <Pine.A41.4.31.0501181606230.24934-100000@slickville.cac.psu.edu> <Pine.GSO.4.61-042.0501210900060.15636@johnstown.andrew.cmu.edu> <20050121152803.GB29598@jadzia.bu.edu> <Pine.GSO.4.61-042.0501211222080.15636@johnstown.andrew.cmu.edu> <1106923508.7063.37.camel@tudor.e.kth.se> <20050130033020.GE6357@lkcl.net>
Message-Id: <E1CvD0q-0006To-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 30 Jan 2005 12:13:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > *) Last time I looked at FUSE the security model was: If the current uid
> > equals the owner of the mountpoint then forward the request to the
> > userland daemon, without any authentication information like for example
> > the current uid. This might have or could be changed though.
> 
>  as of 2.6.7-ish (last time i looked: 2.5 months) there was
>  no forwarding of security: in fact there was nothing in any of the
>  APIs about security at all: in fact, root as a user was banned (with
>  good justification iirc)

There are two choices for the security model in FUSE.  The first
choice is that the userspace filesystem does the permission checking
in each operation.  Current uid and gid is available, group list is
presently not.

The other choice is that the kernel does the normal file mode based
permission checking.  Obviously in this case the filesystem can still
implement an additional (stricter) permission policy.

The "root banning" issue is in fact orthogonal to this.  The default
operation is that only the user who mounted the filesystem is allowed
to access the contents.  This behavior can be switched off with a
mount option, to allow access to all users.

>  also, the xattr handling was (is?) non-existant and i had to add
>  it,

Looking at the changelog it was added on 2004-03-30, so you must be
using a pretty outdated version.

>  but it was unsuitable for selinux, and that's a design mismatch
>  between fuse's way of communicating with its userspace daemon (err
>  -512 "please try later") and selinux's requirement for instant
>  answers (inability to cope with err -512)

Heh?  Where did you see error value 512 (ERESTARTSYS)?  It's not
something that the userspace daemon can return.

>  so i started to look at lufs instead, which appeared to be a much
>  cleaner design.

That's pretty subjective.  Please back up your statement with concrete
examples, so maybe then I can do something about it.

>  lufs expects the userspace daemon to handle and manage inodes,
>  whereas fuse instead keeps an in-memory cache of inodes in
>  the userspace daemon, does a hell of a lot of extra fstat'ing
>  for you in order to guarantee file consistency, that sort of thing.

Well, how much "hell of a lot" actually is depends on a lot of things.
E.g. on whether the backed up filesystem is modified externally (not
just through the kernel).  If not, then it will stay consistent
without any extra messaging.  This can be set by a timeout parameter
for each looked up entry.

The extra flexibility offered by an inode based kernel interface
(FUSE) instead of a path based one (LUFS) I think outweighs the
disadvantage of having to once look up each path element.

>  there is an API / library which your userspace daemon is expected to
>  use: this library handles the communication to the kernel and also it
>  handles the inode proxy redirection and cacheing for you.

Yes, useful for some filesystems (sshfs, ftpfs) useless for others.  I
plan to add a generic caching layer to the FUSE library as well.

>  lufs has a heck of a lot more examples available for it than fuse
>  does.

In the LUFS package yes.  However I bet, currently there are much more
applications which use FUSE than LUFS.

Thanks,
Miklos
