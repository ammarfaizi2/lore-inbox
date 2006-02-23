Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWBWNT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWBWNT1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 08:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWBWNT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 08:19:27 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:39301 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751295AbWBWNT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 08:19:26 -0500
Subject: Patch to make the head.S-must-be-first-in-vmlinux order explicit
From: Arjan van de Ven <arjan@linux.intel.com>
To: ak@suse.de, linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Feb 2006 14:19:18 +0100
Message-Id: <1140700758.4672.51.camel@laptopd505.fenrus.org>
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

Index: linux-2.6.16-reorder/arch/x86_64/kernel/head.S
===================================================================
--- linux-2.6.16-reorder.orig/arch/x86_64/kernel/head.S
+++ linux-2.6.16-reorder/arch/x86_64/kernel/head.S
@@ -26,6 +26,7 @@
  */
 
 	.text
+	.section .bootstrap.text
 	.code32
 	.globl startup_32
 /* %bx:	 1 if coming from smp trampoline on secondary cpu */ 
Index: linux-2.6.16-reorder/arch/x86_64/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.16-reorder.orig/arch/x86_64/kernel/vmlinux.lds.S
+++ linux-2.6.16-reorder/arch/x86_64/kernel/vmlinux.lds.S
@@ -20,6 +20,7 @@ SECTIONS
   phys_startup_64 = startup_64 - LOAD_OFFSET;
   _text = .;			/* Text and read-only data */
   .text :  AT(ADDR(.text) - LOAD_OFFSET) {
+	*(.bootstrap.text)
 	*(.text)
 	SCHED_TEXT
 	LOCK_TEXT

