Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264632AbUEXTGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264632AbUEXTGb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 15:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264677AbUEXTGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 15:06:31 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:44371 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264632AbUEXTGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 15:06:30 -0400
Date: Mon, 24 May 2004 20:06:19 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] MAP_POPULATE prot 0
Message-ID: <Pine.LNX.4.44.0405242003270.27145-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems eccentric to implement MAP_POPULATE only on PROT_NONE mappings:
do_mmap_pgoff is passing down prot, then sys_remap_file_pages verifies
it's not set.  I guess that's an oversight from when we realized that
the prot arg to sys_remap_file_pages was misdesigned.

There's another oddity whose heritage is harder for me to understand,
so please let me leave it to you: sys_remap_file_pages is declared as
asmlinkage in mm/fremap.c, but is the one syscall declared without
asmlinkage in include/linux/syscalls.h.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.7-rc1/mm/mmap.c	2004-05-24 12:17:56.209179464 +0100
+++ linux/mm/mmap.c	2004-05-24 19:33:40.265678752 +0100
@@ -951,7 +951,7 @@ out:	
 	}
 	if (flags & MAP_POPULATE) {
 		up_write(&mm->mmap_sem);
-		sys_remap_file_pages(addr, len, prot,
+		sys_remap_file_pages(addr, len, 0,
 					pgoff, flags & MAP_NONBLOCK);
 		down_write(&mm->mmap_sem);
 	}

