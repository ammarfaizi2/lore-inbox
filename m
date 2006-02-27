Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWB0Pch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWB0Pch (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 10:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWB0Pcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 10:32:35 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:21958 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751473AbWB0PcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 10:32:19 -0500
Subject: [Patch 1/4] avoid entry.S functions from reordering
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Cc: akpm@osdl.org, ak@suse.de
In-Reply-To: <1141053825.2992.125.camel@laptopd505.fenrus.org>
References: <1141053825.2992.125.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Feb 2006 16:31:43 +0100
Message-Id: <1141054303.2992.142.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch puts the code from head.S in a special .bootstrap.text
section.

I'm working on a patch to reorder the functions in the kernel (I'll post
that later), but for x86-64 at least the kernel bootstrap requires that the
head.S functions are on the very first page/pages of the kernel text. This
is understandable since the bootstrap is complex enough already and not a
problem at all, it just means they aren't allowed to be reordered. This
patch puts these special functions into a separate section to document this,
and to guarantee this in the light of possibly reordering the rest later.

(So this patch doesn't fix a bug per se, but makes things more robust by
making the order of these functions explicit)

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/x86_64/kernel/head.S        |    1 +
 arch/x86_64/kernel/vmlinux.lds.S |    1 +
 2 files changed, 2 insertions(+)

Index: linux-reorder2/arch/x86_64/kernel/head.S
===================================================================
--- linux-reorder2.orig/arch/x86_64/kernel/head.S
+++ linux-reorder2/arch/x86_64/kernel/head.S
@@ -26,6 +26,7 @@
  */
 
 	.text
+	.section .bootstrap.text
 	.code32
 	.globl startup_32
 /* %bx:	 1 if coming from smp trampoline on secondary cpu */ 
Index: linux-reorder2/arch/x86_64/kernel/vmlinux.lds.S
===================================================================
--- linux-reorder2.orig/arch/x86_64/kernel/vmlinux.lds.S
+++ linux-reorder2/arch/x86_64/kernel/vmlinux.lds.S
@@ -20,6 +20,7 @@ SECTIONS
   phys_startup_64 = startup_64 - LOAD_OFFSET;
   _text = .;			/* Text and read-only data */
   .text :  AT(ADDR(.text) - LOAD_OFFSET) {
+	*(.bootstrap.text)
 	*(.text)
 	SCHED_TEXT
 	LOCK_TEXT

