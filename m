Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267821AbUHPR0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267821AbUHPR0M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 13:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267815AbUHPRZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 13:25:55 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:25184 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267814AbUHPRZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 13:25:46 -0400
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Centralize i386 Constants
X-Message-Flag: Warning: May contain useful information
References: <1092619849.29612.49.camel@bach>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 16 Aug 2004 10:25:43 -0700
In-Reply-To: <1092619849.29612.49.camel@bach> (Rusty Russell's message of
 "Mon, 16 Aug 2004 11:30:50 +1000")
Message-ID: <52n00vm1uw.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Aug 2004 17:25:43.0737 (UTC) FILETIME=[0F4F7A90:01C483B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Rusty> __FIXADDR_TOP and PAGE_OFFSET are hardcoded in various
    Rusty> places.  I had to change it to run the kernel under
    Rusty> qemu-fast, so I wanted to centralize them.

I like this patch -- I recently built a kernel with PAGE_OFFSET
0xb0000000 to avoid highmem on my box with 1G of RAM, based on recent
discussion, and I made the same change to vmlinux.lds.S (although
since <asm-i386/thread_info.h> includes <asm-i386/page.h>, I didn't
bother adding the "#include <asm/page.h>" line).

In any case it seems there is at least one more place where 0xc0000000
is hardcoded in arch/i386.  The patch below uses PAGE_OFFSET instead
of 0xc0000000 in doublefault.c's ptr_ok() macro.

 - Roland

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-2.6.8.1.orig/arch/i386/kernel/doublefault.c	2004-08-14 03:54:50.000000000 -0700
+++ linux-2.6.8.1/arch/i386/kernel/doublefault.c	2004-08-14 10:44:55.000000000 -0700
@@ -13,7 +13,7 @@
 static unsigned long doublefault_stack[DOUBLEFAULT_STACKSIZE];
 #define STACK_START (unsigned long)(doublefault_stack+DOUBLEFAULT_STACKSIZE)
 
-#define ptr_ok(x) ((x) > 0xc0000000 && (x) < 0xc1000000)
+#define ptr_ok(x) ((x) > PAGE_OFFSET && (x) < PAGE_OFFSET + 0x1000000)
 
 static void doublefault_fn(void)
 {
