Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWGYA0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWGYA0v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 20:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWGYA0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 20:26:51 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:51620 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932352AbWGYA0u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 20:26:50 -0400
Subject: [PATCH] [efi] Add lock annotations for efi_call_phys_prelog and
	efi_call_phys_epilog
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Walt Drummond <drummond@valinux.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>,
       Stephane Eranian <eranian@hpl.hp.com>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 17:26:51 -0700
Message-Id: <1153787211.31581.34.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The functions efi_call_phys_prelog and efi_call_phys_epilog in
arch/i386/kernel/efi.c wrap the spinlock efi_rt_lock: efi_call_phys_prelog
returns with the lock held, and efi_call_phys_epilog releases the lock without
acquiring it.  Add lock annotations to these two functions so that sparse can
check callers for lock pairing, and so that sparse will not complain about
these functions since they intentionally use locks in this manner.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 arch/i386/kernel/efi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/i386/kernel/efi.c b/arch/i386/kernel/efi.c
index fe15804..f943698 100644
--- a/arch/i386/kernel/efi.c
+++ b/arch/i386/kernel/efi.c
@@ -65,7 +65,7 @@ static unsigned long efi_rt_eflags;
 static DEFINE_SPINLOCK(efi_rt_lock);
 static pgd_t efi_bak_pg_dir_pointer[2];
 
-static void efi_call_phys_prelog(void)
+static void efi_call_phys_prelog(void) __acquires(efi_rt_lock)
 {
 	unsigned long cr4;
 	unsigned long temp;
@@ -109,7 +109,7 @@ static void efi_call_phys_prelog(void)
 	load_gdt(cpu_gdt_descr);
 }
 
-static void efi_call_phys_epilog(void)
+static void efi_call_phys_epilog(void) __releases(efi_rt_lock)
 {
 	unsigned long cr4;
 	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, 0);


