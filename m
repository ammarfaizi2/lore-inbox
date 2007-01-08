Return-Path: <linux-kernel-owner+w=401wt.eu-S932599AbXAHILf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbXAHILf (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbXAHILe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:11:34 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:58984 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932599AbXAHIL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:11:26 -0500
Date: Mon, 8 Jan 2007 13:41:22 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Greg KH <gregkh@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4/4] Make noirqdebug_setup function non init to fix modpost warning
Message-ID: <20070108081122.GF7889@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o noirqdebug_setup() is __init but it is being called by
  quirk_intel_irqbalance() which if of type __devinit. If CONFIG_HOTPLUG=y,
  quirk_intel_irqbalance() is put into text section and it is wrong to
  call a function in __init section.

o MODPOST flags this on i386 if CONFIG_RELOCATABLE=y

WARNING: vmlinux - Section mismatch: reference to .init.text:noirqdebug_setup from .text between 'quirk_intel_irqbalance' (at offset 0xc010969e) and 'i8237A_suspend'

o Make noirqdebug_setup() non-init. 

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 kernel/irq/spurious.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN kernel/irq/spurious.c~make-noirqdebug_setup-function-non-init kernel/irq/spurious.c
--- linux-2.6.20-rc2-mm1-reloc/kernel/irq/spurious.c~make-noirqdebug_setup-function-non-init	2007-01-08 09:49:47.000000000 +0530
+++ linux-2.6.20-rc2-mm1-reloc-root/kernel/irq/spurious.c	2007-01-08 09:50:12.000000000 +0530
@@ -176,7 +176,7 @@ void note_interrupt(unsigned int irq, st
 
 int noirqdebug __read_mostly;
 
-int __init noirqdebug_setup(char *str)
+int noirqdebug_setup(char *str)
 {
 	noirqdebug = 1;
 	printk(KERN_INFO "IRQ lockup detection disabled\n");
_
