Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbUBXAs1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 19:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbUBXAs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 19:48:27 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.116]:38377 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S262111AbUBXAri
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 19:47:38 -0500
Date: Mon, 23 Feb 2004 16:47:36 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: mc@cs.Stanford.EDU, Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.Stanford.EDU>
Subject: [CHECKER] warning in 2.4.19/fs/ext2/dir.c:ext2_empty_dir where a
 non-empty dir may be wrongly deleted
Message-ID: <Pine.GSO.4.44.0402231645240.16698-100000@epic8.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The bug reported in this messaage appears to cause a non-empty directory
to be wrongly deleted by sys_rmdir.

-Junfeng

----------------------------------------------------------------------------
[BUG] A non-empty dir may be deleted by sys_rmdir. This is because
ext2_empty_dir returns 1 either the dir is empty or ext2_get_page
fails.

Detailed explanation:

sys_rmdir will call ext2_rmdir to remove a dir in an EXT2
partition.

(1) ext2_rmdir first invokes ext2_empty_dir to see if the target dir is
    empty.

(2) ext2_empty_dir will do a simple lookup on the target dir, trying to
    find a dir entry which is not "." or "..".  It calls ext2_get_page to
    grab the pages that contain the dir entries for the target.

(3) ext2_get_page calls read_cache_page to fetch each dir page.  If the
    page to fetch is not in the page cache, and new page allocatin fails,
    read_cache_page will return ERR_PTR(-ENOMEM).

(4) ext2_empty_dir see an error return from ext2_get_page.  It'll skip
    this page.  If the dir has only 1 page, ext2_empty_dir will return 1,
    falsely indicating the target dir is empty.

(5) ext2_rmdir calls ext2_unlink to remove the dir since ext2_empty_dir
    returns 1.

In short, if ext2_get_page fails at step (3), a non-empty dir may be
deleleted when read_cache_page fails.

ERROR: Filesystem images differ before and after a failed system call (sys_rmdir("1")) when read_cache_page failed at 'dir.c:ext2_get_page:154 dir.c:ext2_empty_dir:557 namei.c:ext2_rmdir:251 '
============ Filesystem Image Before System Call ===================
0 files, 2 dirs, 3 nodes
[0:D]
  [1:D]
    [2:D]
============= Filesystem Image After System Call ===================
0 files, 0 dirs, 1 nodes
[0:D]

