Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVCODJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVCODJG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 22:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVCODJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 22:09:06 -0500
Received: from fmr17.intel.com ([134.134.136.16]:59275 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261495AbVCODIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 22:08:44 -0500
Subject: [PATCH 2.6] fix mmap() return value to conform POSIX
From: Gordon Jin <gordon.jin@intel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, michael.fu@intel.com
In-Reply-To: <1110794148.26254.45.camel@yjin3-dev.sh.intel.com>
References: <1110794148.26254.45.camel@yjin3-dev.sh.intel.com>
Content-Type: text/plain
Message-Id: <1110855852.26254.59.camel@yjin3-dev.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 15 Mar 2005 11:04:12 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes 2 return values in mmap() to conform POSIX spec:

[EINVAL]
        The value of len is zero.
        
[ENOMEM]
        MAP_FIXED was specified, and the range [addr,addr+len) exceeds
        that allowed for the address space of a process; or, if
        MAP_FIXED was not specified and there is insufficient room in
        the address space to effect the mapping.

--- linux-2.6.11.3/mm/mmap.c.orig	2005-03-14 13:20:11.000000000 -0800
+++ linux-2.6.11.3/mm/mmap.c	2005-03-14 17:24:37.000000000 -0800
@@ -897,12 +897,12 @@ unsigned long do_mmap_pgoff(struct file 
 			prot |= PROT_EXEC;
 
 	if (!len)
-		return addr;
+		return -EINVAL;
 
 	/* Careful about overflows.. */
 	len = PAGE_ALIGN(len);
 	if (!len || len > TASK_SIZE)
-		return -EINVAL;
+		return -ENOMEM;
 
 	/* offset overflow? */
 	if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)


