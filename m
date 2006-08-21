Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751813AbWHUJxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbWHUJxH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 05:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbWHUJxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 05:53:07 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:37830 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1751813AbWHUJxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 05:53:06 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus@valinux.co.jp>, ebiederm@xmission.com, ak@suse.de
Message-Id: <20060821095328.3132.40575.sendpatchset@cherry.local>
Subject: [PATCH][RFC] x86_64: Reload CS when startup_64 is used.
Date: Mon, 21 Aug 2006 18:54:16 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64: Reload CS when startup_64 is used.

The current x86_64 startup code never reloads CS during the early boot process
if the 64-bit function startup_64 is used as entry point. The 32-bit entry 
point startup_32 does the right thing and reloads CS, and this is what most 
people are using if they use bzImage.

This patch fixes the case when the Linux kernel is booted into using kexec
under Xen. The Xen hypervisor is using large CS values which makes the x86_64
kernel fail - but only if vmlinux is booted, bzImage works well because it
is using the 32-bit entry point.

The main question is if we require that the boot loader should setup CS
to some certain offset to be able to boot the kernel. The sane solution IMO
should be that the kernel requires that the loaded descriptors are correct, 
but that the exact offset within the GDT the boot loader is using should not 
matter. This is the way the i386 boot works if I understand things correctly.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 Applies on top of 2.6.18-rc4

 head.S |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- 0001/arch/x86_64/kernel/head.S
+++ work/arch/x86_64/kernel/head.S	2006-08-21 18:22:57.000000000 +0900
@@ -165,6 +165,25 @@ startup_64:
 	 */
 	lgdt	cpu_gdt_descr
 
+	/* Reload CS with a value that is within our GDT. We need to do this
+	 * if we were loaded by a 64 bit bootloader that happened to use a 
+	 * CS that is larger than the GDT limit. This is true if we came here
+	 * from kexec running under Xen.
+	 */
+	movq	%rsp, %rdx
+	movq	$__KERNEL_DS, %rax
+	pushq	%rax /* SS */
+	pushq	%rdx /* RSP */
+	movq	$__KERNEL_CS, %rax
+	movq	$cs_reloaded, %rdx
+	pushq	%rax /* CS */
+	pushq	%rdx /* RIP */
+	lretq
+	
+cs_reloaded:			
+	/* Setup the boot time stack again */
+	movq init_rsp(%rip),%rsp
+	
 	/* 
 	 * Setup up a dummy PDA. this is just for some early bootup code
 	 * that does in_interrupt() 
