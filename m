Return-Path: <linux-kernel-owner+w=401wt.eu-S1751914AbWLOLSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbWLOLSG (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 06:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbWLOLSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 06:18:06 -0500
Received: from www.osadl.org ([213.239.205.134]:50581 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751914AbWLOLSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 06:18:05 -0500
Subject: [PATCH] genirq: fix irq flow handler uninstall
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: LKML <linux-kernel@vger.kernel.org>
Cc: Sylvain Munaut <tnt@246tNt.com>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Date: Fri, 15 Dec 2006 12:21:53 +0100
Message-Id: <1166181714.29505.171.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sanity check for no_irq_chip in __set_irq_hander() is unconditional
on both install and uninstall of an handler. This triggers false
warnings and replaces no_irq_chip by dummy_irq_chip in the uninstall
case. 

Check only, when a real handler is installed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Index: 2.6.19-git19/kernel/irq/chip.c
===================================================================
--- 2.6.19-git19.orig/kernel/irq/chip.c
+++ 2.6.19-git19/kernel/irq/chip.c
@@ -517,8 +517,7 @@ __set_irq_handler(unsigned int irq, irq_
 
 	if (!handle)
 		handle = handle_bad_irq;
-
-	if (desc->chip == &no_irq_chip) {
+	else if (desc->chip == &no_irq_chip) {
 		printk(KERN_WARNING "Trying to install %sinterrupt handler "
 		       "for IRQ%d\n", is_chained ? "chained " : " ", irq);
 		/*


