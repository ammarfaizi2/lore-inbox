Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262552AbVA0KQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbVA0KQW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 05:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262554AbVA0KPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 05:15:39 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:42756 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262552AbVA0KNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 05:13:51 -0500
Date: Thu, 27 Jan 2005 10:13:50 +0000
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: Patch 5/6 randomize mmap addresses
Message-ID: <20050127101350.GF9760@infradead.org>
References: <20050127101117.GA9760@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127101117.GA9760@infradead.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch below randomizes the starting point of the mmap area.
This has the effect that all non-prelinked shared libaries and all bigger
malloc()s will be randomized between various invocations of the binary.
Prelinked binaries get a address-hint from ld.so in their mmap and are thus
exempt from this randomisation, in order to not break the prelink advantage.
The randomisation range is 1 megabyte (this is bigger than the stack
randomisation since the stack randomisation only needs 16 bytes alignment
while the mmap needs page alignment, a 64kb range would not have given
enough entropy to be effective)

Signed-off-by: Arjan van de Ven <arjan@infradead.org>


diff -purN linux-step/arch/i386/mm/mmap.c linux-step5/arch/i386/mm/mmap.c
--- linux-step/arch/i386/mm/mmap.c	2004-12-24 22:34:33.000000000 +0100
+++ linux-step5/arch/i386/mm/mmap.c	2005-01-27 10:23:17.000000000 +0100
@@ -26,6 +26,7 @@
 
 #include <linux/personality.h>
 #include <linux/mm.h>
+#include <linux/random.h>
 
 /*
  * Top of mmap area (just below the process stack).
@@ -38,13 +39,17 @@
 static inline unsigned long mmap_base(struct mm_struct *mm)
 {
 	unsigned long gap = current->signal->rlim[RLIMIT_STACK].rlim_cur;
+	unsigned long random_factor = 0;
+
+	if (current->flags & PF_RANDOMIZE)
+		random_factor = get_random_int() % (1024*1024);
 
 	if (gap < MIN_GAP)
 		gap = MIN_GAP;
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
 
-	return TASK_SIZE - (gap & PAGE_MASK);
+	return PAGE_ALIGN(TASK_SIZE - gap - random_factor);
 }
 
 /*

