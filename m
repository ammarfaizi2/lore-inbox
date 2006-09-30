Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWI3SLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWI3SLV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 14:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWI3SLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 14:11:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:60627 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751342AbWI3SLU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 14:11:20 -0400
From: Andi Kleen <ak@suse.de>
To: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: [2.6.18-git] Lost all PCI devices
Date: Sat, 30 Sep 2006 20:11:13 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060930174247.GA31793@dreamland.darkstar.lan>
In-Reply-To: <20060930174247.GA31793@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609302011.13457.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 September 2006 19:42, Luca Tettamanti wrote:
> Hi Andi,
> I'm testing current git on my notebook, but kernel doesn't find any
> PCI device: no video card, no IDE, nothing.

Can you test it with this patch please? 

-Andi

Fix PCI BIOS config space access

Got broken by a earlier change.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/i386/pci/direct.c
===================================================================
--- linux.orig/arch/i386/pci/direct.c
+++ linux/arch/i386/pci/direct.c
@@ -256,6 +256,8 @@ static int __init pci_check_type2(void)
 
 void __init pci_direct_init(int type)
 {
+	if (type == 0)
+		return;
 	printk(KERN_INFO "PCI: Using configuration type %d\n", type);
 	if (type == 1)
 		raw_pci_ops = &pci_direct_conf1;
Index: linux/arch/i386/pci/init.c
===================================================================
--- linux.orig/arch/i386/pci/init.c
+++ linux/arch/i386/pci/init.c
@@ -28,6 +28,10 @@ static __init int pci_access_init(void)
 #ifdef CONFIG_PCI_DIRECT
 	pci_direct_init(type);
 #endif
+	if (!raw_pci_ops)
+		printk(KERN_ERR 
+		"PCI: Fatal: No config space access function found\n");
+
 	return 0;
 }
 arch_initcall(pci_access_init);
