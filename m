Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWIDLw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWIDLw3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 07:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWIDLw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 07:52:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17080 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964824AbWIDLw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 07:52:26 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060901195009.187af603.akpm@osdl.org> 
References: <20060901195009.187af603.akpm@osdl.org>  <20060831102127.8fb9a24b.akpm@osdl.org> <20060830135503.98f57ff3.akpm@osdl.org> <20060830125239.6504d71a.akpm@osdl.org> <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com> <27414.1156970238@warthog.cambridge.redhat.com> <9849.1157018310@warthog.cambridge.redhat.com> <9534.1157116114@warthog.cambridge.redhat.com> <20060901093451.87aa486d.akpm@osdl.org> <1157130044.5632.87.camel@localhost> 
To: Andrew Morton <akpm@osdl.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       steved@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock sharing [try #13] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 04 Sep 2006 12:52:12 +0100
Message-ID: <28945.1157370732@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> sony:/home/akpm> ls -l /net/bix/usr/src
> total 0
> 
> sony:/home/akpm> showmount -e bix
> Export list for bix:
> /           *
> /usr/src    *
> /mnt/export *

Yes, but what's your /etc/exports now?  Not all options appear to showmount.

Can you add "nohide" to the /usr/src and /mnt/export lines and "fsid=0" to the
/ line if you don't currently have them and try again?

> iirc, we decided this is related to the fs-cache infrastructure work which
> went into git-nfs.  I think David can reproduce this?

I'd only reproduced it with SELinux in enforcing mode.

Under such conditions, unless there's a readdir on the root directory, the
subdirs under which exports exist will remain as incorrectly negative
dentries.

The problem is a conjunction of circumstances:

 (1) nfs_lookup() has a shortcut in it that skips contact with the server if
     we're doing a lookup with intent to create.  This leaves an incorrectly
     negative dentry if there _is_ actually an object on the server.

 (2) The mkdir procedure is aborted between the lookup() op and the mkdir() op
     by SELinux (see vfs_mkdir()).  Note that SELinux isn't the _only_ method
     by which the abort can occur.

 (3) One of my patches correctly assigns the security label to the automounted
     root dentry.

 (4) SELinux then aborts the automounter's mkdir() call because the automounter
     does _not_ carry the correct security label to write to the NFS directory.

 (5) The incorrectly set up dentry from (1) remains because the the mkdir() op
     is not invoked to set it right.

The only bit I added was (3), but that's not the only circumstance in which
this can occur.


If, for example, I do "chmod a-w /" on the NFS server, I can see the same
effects on the client without the need for SELinux to put its foot in the door.
Automount does:

[pid  3838] mkdir("/net", 0555)         = -1 EEXIST (File exists)
[pid  3838] stat64("/net", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
[pid  3838] mkdir("/net/trash", 0555)   = -1 EEXIST (File exists)
[pid  3838] stat64("/net/trash", {st_mode=S_IFDIR|0555, st_size=1024, ...}) = 0
[pid  3838] mkdir("/net/trash/mnt", 0555) = -1 EACCES (Permission denied)

And where I was listing the disputed directory, I see:

	[root@andromeda ~]# ls -lad /net/trash/usr/src
	drwxr-xr-x 4 root root 1024 Aug 30 10:35 /net/trash/usr/src/
	[root@andromeda ~]#

which isn't what I'd expect.  What I'd expect is:

	[root@andromeda ~]# ls -l /net/trash/usr/src
	total 15
	drwxr-xr-x 3 root root  1024 Aug 30 10:35 debug/
	-rw-r--r-- 1 root root     0 Aug 16 10:01 hello
	drwx------ 2 root root 12288 Aug 16 10:00 lost+found/
	[root@andromeda ~]#

David

-- 
VGER BF report: U 0.499013
