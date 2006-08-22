Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWHVXTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWHVXTx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 19:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWHVXTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 19:19:53 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:8104 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750864AbWHVXTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 19:19:52 -0400
Subject: [PATCH RESEND] mtrr: Add lock annotations for prepare_set and
	post_set
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 16:19:56 -0700
Message-Id: <1156288796.4510.3.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The functions prepare_set and post_set in kernel/cpu/mtrr/generic.c wrap the
spinlock set_atomicity_lock: prepare_set returns with the lock held, and
post_set releases the lock without acquiring it.  Add lock annotations to
these two functions so that sparse can check callers for lock pairing, and so
that sparse will not complain about these functions since they intentionally
use locks in this manner.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 arch/i386/kernel/cpu/mtrr/generic.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/i386/kernel/cpu/mtrr/generic.c b/arch/i386/kernel/cpu/mtrr/generic.c
index 169ac8e..0b61eed 100644
--- a/arch/i386/kernel/cpu/mtrr/generic.c
+++ b/arch/i386/kernel/cpu/mtrr/generic.c
@@ -243,7 +243,7 @@ static DEFINE_SPINLOCK(set_atomicity_loc
  * has been called.
  */
 
-static void prepare_set(void)
+static void prepare_set(void) __acquires(set_atomicity_lock)
 {
 	unsigned long cr0;
 
@@ -274,7 +274,7 @@ static void prepare_set(void)
 	mtrr_wrmsr(MTRRdefType_MSR, deftype_lo & 0xf300UL, deftype_hi);
 }
 
-static void post_set(void)
+static void post_set(void) __releases(set_atomicity_lock)
 {
 	/*  Flush TLBs (no need to flush caches - they are disabled)  */
 	__flush_tlb();


