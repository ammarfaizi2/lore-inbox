Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbUBXApp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 19:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbUBXApo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 19:45:44 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.116]:25829 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S262119AbUBXAoi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 19:44:38 -0500
Date: Mon, 23 Feb 2004 16:44:35 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: mc@cs.Stanford.EDU, Madanlal S Musuvathi <madan@stanford.edu>,
       <dill@cs.Stanford.EDU>
Subject: [CHECKER] warning in 2.4.19/fs/open.c:filp_open where a file is
 created but user application believes it is not created
Message-ID: <Pine.GSO.4.44.0402231640430.16632-100000@epic8.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We checked the VFS and EXT2 filesystem code for linux 2.4.19 recently and
found several cases that look like bugs.  I eyeballed the latest kernels
and seems to me the same cases exist in 2.6, too.

The bug reported in this message appears to leave non-reclaimable garbage
inodes on disk. I am not sure if it is real bugs or not, so your
confirmations /clarifications will be greatly appericated.

Please let me know if anything isn't clear.

-Junfeng

----------------------------------------------------------------------------
[BUG] File is created on disk but user application who invokes sys_create
will believe it hasn't because sys_create will return an error.  This is
because sys_create will first create the file on disk, then calls
dentry_open to get a file pointer.  dentry_open can fail because
it calls file_table.c:get_empty_filp and get_empty_filp can fail.

Detailed explanation:

The call-chain is sys_create --> sys_open --> filp_open.

(1) filp_open calls open_namei to create the file on disk.

(2) filp_open calls dentry_open to get a struct file* pointer.

(3) dentry_open calls get_empty_filp to allocate a file pointer.

if (3) fails the file will be created on disk but the system call
sys_create will return an error code to the user application.  This will
either cause a garbage file on disk which is not reclaimable by fsck
(since it is perfectly legal), or the poor user application may be stuck
by trying to create the same file again and again but always get an EEXIST
error code.

ERROR: Filesystem images differ before and after a failed system call (sys_creat("2")) when kmalloc failed at 'file_table.c:get_empty_filp:64 open.c:dentry_open:684 open.c:filp_open:671 '

============ Filesystem Image Before System Call ===================
0 files, 1 dirs, 2 nodes
[0:D]
  [1:D]
============= Filesystem Image After System Call ===================
1 files, 1 dirs, 3 nodes
[0:D]
  [1:D]
  [2:F]

