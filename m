Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267353AbUIOUBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267353AbUIOUBk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUIOUBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:01:39 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:40189 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267352AbUIOUBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:01:20 -0400
Date: Wed, 15 Sep 2004 16:01:20 +0000 (UTC)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH] remove LOCK_SECTION from x86_64 spin_lock asm
Message-ID: <Pine.LNX.4.53.0409151458470.10849@musoma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William spotted this stray bit, LOCK_SECTION isn't used anymore on x86_64. 
Andrew i've diffed against -mm because i'd like for the irq enable on 
contention patch to be merged, i believe making spinlock functions out 
of line was a prerequisite Andi wanted before agreeing to the irq enable 
code.

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.9-rc1-mm5/include/asm-x86_64/spinlock.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm5/include/asm-x86_64/spinlock.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 spinlock.h
--- linux-2.6.9-rc1-mm5/include/asm-x86_64/spinlock.h	13 Sep 2004 12:46:47 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm5/include/asm-x86_64/spinlock.h	15 Sep 2004 08:47:52 -0000
@@ -45,20 +45,18 @@ typedef struct {
 #define spin_lock_string \
 	"\n1:\t" \
 	"lock ; decb %0\n\t" \
-	"js 2f\n" \
-	LOCK_SECTION_START("") \
+	"jns 3f\n" \
 	"2:\t" \
 	"rep;nop\n\t" \
 	"cmpb $0,%0\n\t" \
 	"jle 2b\n\t" \
 	"jmp 1b\n" \
-	LOCK_SECTION_END
+	"3:\n\t"
 
 #define spin_lock_string_flags \
 	"\n1:\t" \
 	"lock ; decb %0\n\t" \
-	"js 2f\n\t" \
-	LOCK_SECTION_START("") \
+	"jns 4f\n\t" \
 	"2:\t" \
 	"test $0x200, %1\n\t" \
 	"jz 3f\n\t" \
@@ -69,7 +67,7 @@ typedef struct {
 	"jle 3b\n\t" \
 	"cli\n\t" \
 	"jmp 1b\n" \
-	LOCK_SECTION_END
+	"4:\n\t"
 
 /*
  * This works. Despite all the confusion.
