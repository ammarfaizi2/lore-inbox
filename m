Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262882AbUD2ByN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbUD2ByN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 21:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbUD2ByN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 21:54:13 -0400
Received: from ozlabs.org ([203.10.76.45]:24768 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262882AbUD2Bxp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 21:53:45 -0400
Date: Thu, 29 Apr 2004 11:49:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: POWER5 erratum workaround
Message-ID: <20040429014959.GA18309@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply:

Early POWER5 revisions (<DD2.1) have a problem requiring slbie
instructions to be repeated under some circumstances.  The patch below
adds a workaround (patch made by Anton Blanchard).

Index: working-2.6/arch/ppc64/kernel/entry.S
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/entry.S	2004-04-20 11:04:31.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/entry.S	2004-04-28 14:30:30.069407648 +1000
@@ -311,6 +311,7 @@
 	beq	2f		/* if yes, don't slbie it */
 	oris	r6,r6,0x0800	/* set C (class) bit */
 	slbie	r6
+	slbie	r6		/* Workaround POWER5 < DD2.1 issue */
 2:
 END_FTR_SECTION_IFSET(CPU_FTR_SLB)
 	clrrdi	r7,r8,THREAD_SHIFT	/* base of new stack */
Index: working-2.6/arch/ppc64/kernel/stab.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/stab.c	2004-03-12 10:35:23.000000000 +1100
+++ working-2.6/arch/ppc64/kernel/stab.c	2004-04-28 14:33:48.446331536 +1000
@@ -474,14 +474,14 @@
 void flush_slb(struct task_struct *tsk, struct mm_struct *mm)
 {
 	unsigned long offset = __get_cpu_var(stab_cache_ptr);
+	union {
+		unsigned long word0;
+		slb_dword0 data;
+	} esid_data;
+
 
 	if (offset <= NR_STAB_CACHE_ENTRIES) {
 		int i;
-		union {
-			unsigned long word0;
-			slb_dword0 data;
-		} esid_data;
-
 		asm volatile("isync" : : : "memory");
 		for (i = 0; i < offset; i++) {
 			esid_data.word0 = 0;
@@ -493,6 +493,17 @@
 		asm volatile("isync; slbia; isync" : : : "memory");
 	}
 
+	/* Workaround POWER5 < DD2.1 issue */
+	if (offset == 1 || offset > NR_STAB_CACHE_ENTRIES) {
+		/* 
+		 * flush segment in EEH region, we dont normally access
+		 * addresses in this region.
+		 */
+		esid_data.word0 = 0;
+		esid_data.data.esid = EEH_REGION_ID;
+		asm volatile("slbie %0" : : "r" (esid_data));
+	}
+
 	__get_cpu_var(stab_cache_ptr) = 0;
 
 	preload_slb(tsk, mm);


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
