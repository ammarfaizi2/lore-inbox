Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVA3Mla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVA3Mla (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 07:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVA3Mla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 07:41:30 -0500
Received: from rev.193.226.232.37.euroweb.hu ([193.226.232.37]:26288 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261696AbVA3MlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 07:41:10 -0500
To: lkcl@lkcl.net
CC: abo@kth.se, openafs-devel@openafs.org, opendce@opengroup.org,
       selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org
In-reply-to: <20050130121301.GB10895@lkcl.net> (message from Luke Kenneth
	Casson Leighton on Sun, 30 Jan 2005 12:13:02 +0000)
Subject: Re: Using fuse for AFS/DFS (was Re: [OpenAFS-devel] openafs / opendfs collaboration)
References: <Pine.A41.4.31.0501181606230.24934-100000@slickville.cac.psu.edu> <Pine.GSO.4.61-042.0501210900060.15636@johnstown.andrew.cmu.edu> <20050121152803.GB29598@jadzia.bu.edu> <Pine.GSO.4.61-042.0501211222080.15636@johnstown.andrew.cmu.edu> <1106923508.7063.37.camel@tudor.e.kth.se> <20050130033020.GE6357@lkcl.net> <E1CvD0q-0006To-00@dorka.pomaz.szeredi.hu> <20050130121301.GB10895@lkcl.net>
Message-Id: <E1CvENX-0006fY-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 30 Jan 2005 13:40:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > There are two choices for the security model in FUSE.  The first
> > choice is that the userspace filesystem does the permission checking
> > in each operation.  Current uid and gid is available, group list is
> > presently not.
> 
> > The other choice is that the kernel does the normal file mode based
> > permission checking.  Obviously in this case the filesystem can still
> > implement an additional (stricter) permission policy.
> 
>  if your users are okay with having to run a fuse-mount themselves,
>  that's okay [to have the kernel do the file mode checking]
> 
>  the problem with that is that you can't have a "publicly accessible"
>  mount point like you do on an nfs server.
> 
>  also if you have a completely different kind of file permission
>  checking system (which AFS and DFS do), you're stuffed.

No.  Just fall back on the first option (permission checking in each
operation)

> > Looking at the changelog it was added on 2004-03-30, so you must be
> > using a pretty outdated version.
>  
>   ... Release 1.3 - 2004-07-14.
> 
>  hm, error-at-memory-recall fault, redo from start...

OK.  From 1.2 onwards it was just a bugfix branch with the new
features going into the FUSE-2 release.

> > Heh?  Where did you see error value 512 (ERESTARTSYS)?  It's not
> > something that the userspace daemon can return.
>  
>  userspace no, kernel, yes.
> 
>  the kernel-part of fuse tells any kernel-level callers to
>  "go away, come back later".
> 
>  obviously this gives time for the kernel-part to "wake up" the
>  userspace daemon, obtain an answer, such that when the kernel-level
>  caller _does_ come back, the information is available.

It doesn't do that and never did.  ERESTARTSYS is only returned if the
operation is interrupted, and in that case the operation is restarted
from scratch, the answer to the old request is never used.

>  the problem with using SELinux to obtain xattrs
>  "security.selinux" in order to perform security checks
>  is that the checking is done from in the kernel ITSELF
>  (security/hooks.c), not by a userspace function call RESULTING
>  in a kernel call.
> 
>  therefore when you even attempt to _mount_ a selinux-enabled fuse
>  filesystem, hooks.c tests to see whether the filesystem supports
>  xattrs, gets this silly 512 (ERESTARTSYS) error message and goes "nope,
>  doesn't look like it does".
> 
>  for various reasons, the details of which i am not aware of,
>  from what i can gather, getting selinux to support ERESTARTSYS
>  is tricky.

Just disable signal delivery while calling FUSE, and it will never
return -ERESTARTSYS or -ERESTARTNOINTR.

> > The extra flexibility offered by an inode based kernel interface
> > (FUSE) instead of a path based one (LUFS) I think outweighs the
> > disadvantage of having to once look up each path element.
> 
>  mrr, yehhh... mmmm :)
>  
>  what about a remote NTFS filesystem which supports NT Security
>  Descriptors, which are "inherited" where you not only don't
>  have the concept of inodes, but also due to the security
>  model, a client must look up every path element _anyway_
>  and perform a conglomeration of the "inheritance" parts of
>  the ACEs in each security descriptor of the path components?

There's not that much difference between the inode and the path model.
If you say each "path component" corresponds to an inode, you have
just solved this problem.

>  btw so people don't freak out too badly at that concept,
>  there _has_ existed for a couple of decades the concept of
>  "change notify" in remote NT filesystems, where the client
>  can watch for any significant changes on a filesystem, so you
>  don't have to end up re-reading all of the path components,
>  you can get the remote server to _tell_ you when they've
>  changed - cool, huh?

Yes.  And would be pretty easy to add support for this to the FUSE
interface.  It's currently isn't there just because nobody demanded
it.

>  [btw, nt's change notify is what spurred linux kernel's inotify and
>   dnotify to be written]
> 
>  
>  in a nutshell, inodes is an optimisation from a unix
>  perspective: by providing an inode based interface, you are
>  burdening _all_ filesystem implementers with that concept.

Yes.  However I think the burden on performance (nothing else), is
justified by the better flexibility.

Thanks,
Miklos
