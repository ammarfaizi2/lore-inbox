Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751896AbWAFG2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbWAFG2E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 01:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbWAFG2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 01:28:04 -0500
Received: from kcse.com ([66.147.204.154]:18377 "EHLO kcse.com")
	by vger.kernel.org with ESMTP id S1752155AbWAFG2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 01:28:02 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ppc/boot: Put flush_{instruction,data}_cache back in
 .relocate_code section
From: Paul Janzen <pcj@linux.sez.to>
Date: Thu, 05 Jan 2006 22:27:49 -0800
Message-ID: <oqzmm9oopm.fsf@merlin.sez.to>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the Great PowerPC Include Merge, the _GLOBAL() assembler
macro was changed to force code declared using _GLOBAL() to be in the
.text section.  As a result, two symbols defined in
arch/ppc/boot/common/util.S which are intended to be in the
.relocate_code section are being placed in .text instead, which causes
booting to fail.

There's another suspicious-looking usage at
arch/ppc/kernel/swsusp.S:37 (swsusp_save_area) that should be looked
into.  I did not exhaustively search the source tree, though.

This is the minimal patch that fixes the immediate problem.  I could
easily be convinced that the _GLOBAL macro should be modified to
remove the ".text;" line either instead of, or in addition to, this
fix.

Signed-off-by: Paul Janzen <pcj@linux.sez.to>
Acked-by: Tom Rini <trini@kernel.crashing.org>

--- a/arch/ppc/boot/common/util.S	2005-12-24 15:47:48.000000000 -0800
+++ b/arch/ppc/boot/common/util.S 	2006-01-04 14:07:12.000000000 -0800
@@ -234,7 +234,8 @@ udelay:
  * First, flush the data cache in case it was enabled and may be
  * holding instructions for copy back.
  */
-_GLOBAL(flush_instruction_cache)
+        .globl flush_instruction_cache
+flush_instruction_cache:
 	mflr	r6
 	bl	flush_data_cache
 
@@ -279,7 +280,8 @@ _GLOBAL(flush_instruction_cache)
  * Flush data cache
  * Do this by just reading lots of stuff into the cache.
  */
-_GLOBAL(flush_data_cache)
+        .globl flush_data_cache
+flush_data_cache:
 	lis	r3,cache_flush_buffer@h
 	ori	r3,r3,cache_flush_buffer@l
 	li	r4,NUM_CACHE_LINES


