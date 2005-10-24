Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbVJXQpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVJXQpj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 12:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVJXQpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 12:45:38 -0400
Received: from 253-121.adsl.pool.ew.hu ([193.226.253.121]:10765 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751151AbVJXQpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 12:45:38 -0400
To: akpm@osdl.org
CC: viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/8] FUSE improvements + VFS changes
Message-Id: <E1EU5RZ-0005qg-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Oct 2005 18:45:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are a small number of features that are missing from the VFS
interface (and hence from the FUSE interface), that are needed to
allow a special class of filesystems to provide a full UNIX (Posix,
SUS, whatever) file semantics.

The filesystems in question are served by a process that runs

  - in userspace 
  - without special privileges

A trivial example is sshfs (sftp-server runs on remote server with
normal user privileges).

The limitations are:

  1) open("foo", O_CREAT | O_WRONLY, 0444) or similar won't work

  2) ftruncate on a file not having write permission (but file opened
     in write mode) will fail

  3) statfs() cannot return different values based on the path within
     a filesystem

1) and 2) arise from the fact, that the VFS separates the permission
checking from the actual operations while the above described
filesystem can't do that.

1) can be solved by allowing a create+open atomic operation.  The
infrastructure for this is already in -mm from the NFS tree.

2) can be solved by distinguishing ftruncate() from trunate() invoked
->setattr().  For ftruncate() the filesystem also needs to find a
handle for a file opened for writing.  The file on which ftuncate()
was performed is always a good candidate, so an obvious solution is to
pass the open file to ->setattr().

3) comes from the fact that ->statfs() is a sb operation not an inode
operation.  The only place where this is used is in sys_ustat() which
is deprecated and also useless for virtual (non disk based)
filesystems.  So introduce a i_op->statfs() operation, which if
implemented will be used instead of s_op->statfs().

Changes to VFS:

  1 - pass file pointer to ->setattr() if invoked from ftruncate()
  2 - per inode statfs (core)
  3 - per inode statfs (architectures)

Changes to FUSE:

  4 - bump interface minor version
  5 - add access call to interface
  6 - atomic open+create
  7 - pass file handle to userspace in setattr call
  8 - per inode statfs (fuse)

Miklos
