Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbUBXAvu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 19:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbUBXAvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 19:51:50 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.116]:64492 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S262125AbUBXAus
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 19:50:48 -0500
Date: Mon, 23 Feb 2004 16:50:46 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: mc@cs.Stanford.EDU, Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.Stanford.EDU>
Subject: [CHECKER] warning in 2.4.19/fs/ext2/dir.c:ext2_find_entry where a
 dir may contain two entries with identical names
Message-ID: <Pine.GSO.4.44.0402231647480.16698-100000@epic8.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The two bugs reported here appears to cause a dir to have more than one
entries with identical names.

-Junfeng

----------------------------------------------------------------------------
[BUG] A dir may contain two dir entries with identical names. This is
because ext2_find_entry returns NULL either the entry to create doesn't
exist or ext2_get_page fails.

Detailed explanation:

The call-chain is sys_open --> filp_open --> open_namei.

(1) open_namei calls lookup_hash on the parent dir, to see if there's an
    dir entry with the same name.

(2) lookup_hash calls cached_lookup to try to find the dentry from the
    dcache, if it can not find the target in the dcache, it will invoke
    ext2_lookup to look it up on disk.

(3) ext2_lookup calls ext2_inode_by_name, which calls ext2_find_entry to
    lookup the dir entry.

(4) ext2_find_entry calls ext2_get_page to get the dir page. If
    ext2_get_page fails by returning ERR_PTR(-ENOMEM), ext2_find_entry
    will return NULL.

(5) ext2_inode_by_name returns NULL when ext2_find_entry returns NULL.
    This causes ext2_lookup to return NULL, falsely indicating that the
    target file or dir doesn't exist in the parent dir.

(6) open_namei calls vfs_create to create the file/dir on disk.  For ext2
    fs, the new dir entry will be placed in the first dir slot that fits.

if at step (4) ext2_get_page fails, a dir may contains more than one
entries with identical names.

ERROR: System call (sys_creat("2")) succeeds but read_cache_page failed at 'dir.c:ext2_get_page:154 dir.c:ext2_find_entry:325 dir.c:ext2_inode_by_name:366 '

============= Filesystem Image Before System Call ===================
1 files, 1 dirs, 3 nodes
[0:D]
  [1:D]
============= Filesystem Image After System Call ===================
1 files, 1 dirs, 3 nodes
[0:D]
  [1:D]
  [2:F]

----------------------------------------------------------------------------
[BUG] similar bug on sys_mkdir.  ext2_lookup can fail either because the
dir entry doesn't exist, or ext2_get_page fails to get memory.

ERROR: System call (sys_mkdir("2")) succeeds but read_cache_page failed at 'dir.c:ext2_get_page:154 dir.c:ext2_find_entry:325 dir.c:ext2_inode_by_name:366 '

============= Filesystem Image Before System Call ===================
1 files, 1 dirs, 3 nodes
[0:D]
  [1:D]
============= Filesystem Image After System Call ===================
0 files, 2 dirs, 3 nodes
[0:D]
  [1:D]
  [2:D]

