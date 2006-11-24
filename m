Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934460AbWKXMFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934460AbWKXMFE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 07:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934457AbWKXMFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 07:05:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:65310 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S934429AbWKXMFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 07:05:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=rGDxKw4bLsOIBDjole2aauXfFUqWYFtBft6kmVdGmVNjyXvF2KiNsOM/30Df1d9iHMlNRIARrgT9/7pCz5pkENmMJOsd4e76FCNx7T3/HxaeoNhWwV1Op5mrMdc3pVt8A7twXjsDAu1cZN5/uHUYb9eMm3ec9sLEofVSJ6sxato=
Message-ID: <4566DF0A.3050803@gmail.com>
Date: Fri, 24 Nov 2006 14:01:14 +0200
From: Yan Burman <burman.yan@gmail.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: trivial@kernel.org, wli@holomorphy.com
Subject: [PATCH 2.6.19-rc6] sparc: replace kmalloc+memset with kzalloc
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc+memset with kzalloc 

Signed-off-by: Yan Burman <burman.yan@gmail.com>

diff -rubp linux-2.6.19-rc5_orig/arch/sparc/kernel/ioport.c linux-2.6.19-rc5_kzalloc/arch/sparc/kernel/ioport.c
--- linux-2.6.19-rc5_orig/arch/sparc/kernel/ioport.c	2006-11-09 12:16:21.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/arch/sparc/kernel/ioport.c	2006-11-11 22:44:04.000000000 +0200
@@ -317,9 +317,8 @@ void *sbus_alloc_consistent(struct sbus_
 	if ((va = __get_free_pages(GFP_KERNEL|__GFP_COMP, order)) == 0)
 		goto err_nopages;
 
-	if ((res = kmalloc(sizeof(struct resource), GFP_KERNEL)) == NULL)
+	if ((res = kzalloc(sizeof(struct resource), GFP_KERNEL)) == NULL)
 		goto err_nomem;
-	memset((char*)res, 0, sizeof(struct resource));
 
 	if (allocate_resource(&_sparc_dvma, res, len_total,
 	    _sparc_dvma.start, _sparc_dvma.end, PAGE_SIZE, NULL, NULL) != 0) {
@@ -589,12 +588,11 @@ void *pci_alloc_consistent(struct pci_de
 		return NULL;
 	}
 
-	if ((res = kmalloc(sizeof(struct resource), GFP_KERNEL)) == NULL) {
+	if ((res = kzalloc(sizeof(struct resource), GFP_KERNEL)) == NULL) {
 		free_pages(va, order);
 		printk("pci_alloc_consistent: no core\n");
 		return NULL;
 	}
-	memset((char*)res, 0, sizeof(struct resource));
 
 	if (allocate_resource(&_sparc_dvma, res, len_total,
 	    _sparc_dvma.start, _sparc_dvma.end, PAGE_SIZE, NULL, NULL) != 0) {
diff -rubp linux-2.6.19-rc5_orig/arch/sparc/kernel/of_device.c linux-2.6.19-rc5_kzalloc/arch/sparc/kernel/of_device.c
--- linux-2.6.19-rc5_orig/arch/sparc/kernel/of_device.c	2006-11-09 12:16:21.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/arch/sparc/kernel/of_device.c	2006-11-11 22:44:04.000000000 +0200
@@ -793,10 +793,9 @@ struct of_device* of_platform_device_cre
 {
 	struct of_device *dev;
 
-	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return NULL;
-	memset(dev, 0, sizeof(*dev));
 
 	dev->dev.parent = parent;
 	dev->dev.bus = bus;
diff -rubp linux-2.6.19-rc5_orig/arch/sparc/kernel/sun4d_irq.c linux-2.6.19-rc5_kzalloc/arch/sparc/kernel/sun4d_irq.c
--- linux-2.6.19-rc5_orig/arch/sparc/kernel/sun4d_irq.c	2006-11-09 12:16:21.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/arch/sparc/kernel/sun4d_irq.c	2006-11-11 22:44:04.000000000 +0200
@@ -545,8 +545,7 @@ void __init sun4d_init_sbi_irq(void)
 	nsbi = 0;
 	for_each_sbus(sbus)
 		nsbi++;
-	sbus_actions = (struct sbus_action *)kmalloc (nsbi * 8 * 4 * sizeof(struct sbus_action), GFP_ATOMIC);
-	memset (sbus_actions, 0, (nsbi * 8 * 4 * sizeof(struct sbus_action)));
+	sbus_actions = kzalloc (nsbi * 8 * 4 * sizeof(struct sbus_action), GFP_ATOMIC);
 	for_each_sbus(sbus) {
 #ifdef CONFIG_SMP	
 		extern unsigned char boot_cpu_id;
diff -rubp linux-2.6.19-rc5_orig/arch/sparc/mm/io-unit.c linux-2.6.19-rc5_kzalloc/arch/sparc/mm/io-unit.c
--- linux-2.6.19-rc5_orig/arch/sparc/mm/io-unit.c	2006-11-09 12:16:21.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/arch/sparc/mm/io-unit.c	2006-11-11 22:44:04.000000000 +0200
@@ -41,9 +41,8 @@ iounit_init(int sbi_node, int io_node, s
 	struct linux_prom_registers iommu_promregs[PROMREG_MAX];
 	struct resource r;
 
-	iounit = kmalloc(sizeof(struct iounit_struct), GFP_ATOMIC);
+	iounit = kzalloc(sizeof(struct iounit_struct), GFP_ATOMIC);
 
-	memset(iounit, 0, sizeof(*iounit));
 	iounit->limit[0] = IOUNIT_BMAP1_START;
 	iounit->limit[1] = IOUNIT_BMAP2_START;
 	iounit->limit[2] = IOUNIT_BMAPM_START;



Regards
Yan Burman
