Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263425AbTJLG6e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 02:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263427AbTJLG6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 02:58:34 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:3511 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263425AbTJLG6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 02:58:32 -0400
Message-ID: <3F88FB90.7080801@colorfullife.com>
Date: Sun, 12 Oct 2003 08:58:24 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test7 DEBUG_PAGEALLOC oops
References: <5.2.1.1.2.20031011172153.01e49948@pop.gmx.net> <5.2.1.1.2.20031011120059.01e81718@pop.gmx.net> <5.2.1.1.2.20031011120059.01e81718@pop.gmx.net> <5.2.1.1.2.20031011172153.01e49948@pop.gmx.net> <5.2.1.1.2.20031012060658.01e3b840@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20031012060658.01e3b840@pop.gmx.net>
Content-Type: multipart/mixed;
 boundary="------------060503030806000307050403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060503030806000307050403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Could you try the attached patch?
It updates the end of stack detection to handle unaligned stacks.

--
    Manfred

--------------060503030806000307050403
Content-Type: text/plain;
 name="patch-end-of-stack"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-end-of-stack"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 0
//  EXTRAVERSION = -test7
--- 2.6/include/asm-i386/thread_info.h	2003-10-09 21:20:00.000000000 +0200
+++ build-2.6/include/asm-i386/thread_info.h	2003-10-12 08:50:12.000000000 +0200
@@ -101,6 +101,16 @@
 
 #endif
 
+static inline int kstack_end(void *addr)
+{
+	unsigned long offset = (unsigned long)addr & (THREAD_SIZE-1);
+
+	/* Some APM bios versions misalign the stack */
+	if (offset == 0 || offset > (THREAD_SIZE-sizeof(void*)))
+			return 1;
+	return 0;
+}
+
 /*
  * thread information flags
  * - these are process state flags that various assembly files may need to access
--- 2.6/mm/slab.c	2003-10-09 21:23:19.000000000 +0200
+++ build-2.6/mm/slab.c	2003-10-12 08:51:13.000000000 +0200
@@ -862,7 +862,7 @@
 		unsigned long *sptr = &caller;
 		unsigned long svalue;
 
-		while (((long) sptr & (THREAD_SIZE-1)) != 0) {
+		while (!kstack_end(sptr)) {
 			svalue = *sptr++;
 			if (kernel_text_address(svalue)) {
 				*addr++=svalue;
--- 2.6/arch/i386/kernel/traps.c	2003-10-09 21:23:03.000000000 +0200
+++ build-2.6/arch/i386/kernel/traps.c	2003-10-12 08:50:41.000000000 +0200
@@ -104,7 +104,7 @@
 #ifdef CONFIG_KALLSYMS
 	printk("\n");
 #endif
-	while (((long) stack & (THREAD_SIZE-1)) != 0) {
+	while (!kstack_end(stack)) {
 		addr = *stack++;
 		if (kernel_text_address(addr)) {
 			printk(" [<%08lx>] ", addr);
@@ -138,7 +138,7 @@
 
 	stack = esp;
 	for(i = 0; i < kstack_depth_to_print; i++) {
-		if (((long) stack & (THREAD_SIZE-1)) == 0)
+		if (kstack_end(stack))
 			break;
 		if (i && ((i % 8) == 0))
 			printk("\n       ");

--------------060503030806000307050403--

