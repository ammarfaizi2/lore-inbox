Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129541AbRCBVmG>; Fri, 2 Mar 2001 16:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129540AbRCBVlw>; Fri, 2 Mar 2001 16:41:52 -0500
Received: from [62.172.234.2] ([62.172.234.2]:55510 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129537AbRCBVlT>; Fri, 2 Mar 2001 16:41:19 -0500
Date: Fri, 2 Mar 2001 21:41:09 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: [PATCH] getname() buffer overflow
In-Reply-To: <E14YteS-00020L-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0103022139240.1440-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The pathname slab cache size was "reduced" from PAGE_SIZE to
PATH_MAX + 1 during the 2.4.0-test series, and len similarly
adjusted in do_getname().  But its "are we near top of task space?"
test should have been adjusted too: could overflow if page size >4KB.
Patch below against 2.4.2-ac9, applies equally to 2.4.[012].

Hugh

--- 2.4.2-ac9/fs/namei.c	Fri Dec 29 22:07:23 2000
+++ linux/fs/namei.c	Fri Mar  2 18:23:42 2001
@@ -113,7 +113,7 @@
 	if ((unsigned long) filename >= TASK_SIZE) {
 		if (!segment_eq(get_fs(), KERNEL_DS))
 			return -EFAULT;
-	} else if (TASK_SIZE - (unsigned long) filename < PAGE_SIZE)
+	} else if (TASK_SIZE - (unsigned long) filename < PATH_MAX + 1)
 		len = TASK_SIZE - (unsigned long) filename;
 
 	retval = strncpy_from_user((char *)page, filename, len);

