Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269161AbUINC5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269161AbUINC5t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269146AbUINCzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:55:10 -0400
Received: from holomorphy.com ([207.189.100.168]:20112 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269147AbUINCxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:53:11 -0400
Date: Mon, 13 Sep 2004 19:53:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [procfs] [1/1] fix task_mmu.c text size reporting
Message-ID: <20040914025304.GT9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913015003.5406abae.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 01:50:03AM -0700, Andrew Morton wrote:
> Due to master.kernel.org being on the blink, 2.6.9-rc1-mm5 Is currently at
>  http://www.zip.com.au/~akpm/linux/patches/2.6.9-rc1-mm5/
> and will later appear at
>  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm5/
> Please check kernel.org before using zip.com.au.

Not all binfmts page align ->end_code and ->start_code, so the task_mmu
statistics calculations need to perform this allocation themselves.

Index: mm5-2.6.9-rc1/fs/proc/task_mmu.c
===================================================================
--- mm5-2.6.9-rc1.orig/fs/proc/task_mmu.c	2004-09-13 16:27:35.915357248 -0700
+++ mm5-2.6.9-rc1/fs/proc/task_mmu.c	2004-09-13 19:43:19.681033496 -0700
@@ -9,7 +9,7 @@
 	unsigned long data, text, lib;
 
 	data = mm->total_vm - mm->shared_vm - mm->stack_vm;
-	text = (mm->end_code - mm->start_code) >> 10;
+	text = (PAGE_ALIGN(mm->end_code) - (mm->start_code & PAGE_MASK)) >> 10;
 	lib = (mm->exec_vm << (PAGE_SHIFT-10)) - text;
 	buffer += sprintf(buffer,
 		"VmSize:\t%8lu kB\n"
@@ -36,7 +36,8 @@
 	       int *data, int *resident)
 {
 	*shared = mm->shared_vm;
-	*text = (mm->end_code - mm->start_code) >> PAGE_SHIFT;
+	*text = (PAGE_ALIGN(mm->end_code) - (mm->start_code & PAGE_MASK))
+								>> PAGE_SHIFT;
 	*data = mm->total_vm - mm->shared_vm - *text;
 	*resident = mm->rss;
 	return mm->total_vm;
