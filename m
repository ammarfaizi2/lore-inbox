Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263606AbUA0Mzs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 07:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbUA0Mzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 07:55:48 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10514 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263587AbUA0Mzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 07:55:42 -0500
Date: Tue, 27 Jan 2004 12:55:39 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Angelo Dell'Aera" <buffer@antifork.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-Net <linux-net@vger.kernel.org>
Subject: Re: airo_cs problem - kernel 2.6.1
Message-ID: <20040127125539.F18409@flint.arm.linux.org.uk>
Mail-Followup-To: Angelo Dell'Aera <buffer@antifork.org>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linux-Net <linux-net@vger.kernel.org>
References: <20040127130709.50a3eaae.buffer@antifork.org> <20040127124538.E18409@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040127124538.E18409@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Tue, Jan 27, 2004 at 12:45:38PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 12:45:38PM +0000, Russell King wrote:
> On Tue, Jan 27, 2004 at 01:07:09PM +0100, Angelo Dell'Aera wrote:
> > Today I experienced this problem with a Cisco Aironet 350.
> > I just want to point out it's the first time it happens. 
> > In fact, I still used this NIC on this kernel (2.6.1) without 
> > any kind of problem. Attached is an extract from my log.
> 

Ok, actually the bug has been fixed in 2.6.2-rc, so this problem can
finally be laid to rest.  Here's the as-merged fix:

===== drivers/net/wireless/airo.c 1.80 vs 1.81 =====
--- 1.80/drivers/net/wireless/airo.c	Sun Dec  7 13:22:52 2003
+++ 1.81/drivers/net/wireless/airo.c	Sat Jan 10 16:04:13 2004
@@ -1027,7 +1027,6 @@
 #define FLAG_802_11	7
 #define FLAG_PENDING_XMIT 9
 #define FLAG_PENDING_XMIT11 10
-#define FLAG_PCI	11
 #define JOB_MASK	0x1ff0000
 #define JOB_DIE		16
 #define JOB_XMIT	17
@@ -4623,7 +4622,6 @@
 		return -ENODEV;
 
 	pci_set_drvdata(pdev, dev);
-	set_bit (FLAG_PCI, &((struct airo_info *)dev->priv)->flags);
 	return 0;
 }
 
@@ -4653,7 +4651,7 @@
 
 #ifdef CONFIG_PCI
 	printk( KERN_INFO "airo:  Probing for PCI adapters\n" );
-	pci_module_init(&airo_driver);
+	pci_register_driver(&airo_driver);
 	printk( KERN_INFO "airo:  Finished probing for PCI adapters\n" );
 #endif
 
@@ -4665,22 +4663,15 @@
 
 static void __exit airo_cleanup_module( void )
 {
-	int is_pci = 0;
 	while( airo_devices ) {
 		printk( KERN_INFO "airo: Unregistering %s\n", airo_devices->dev->name );
-#ifdef CONFIG_PCI
-		if (test_bit(FLAG_PCI, &((struct airo_info *)airo_devices->dev->priv)->flags))
-			is_pci = 1;
-#endif
 		stop_airo_card( airo_devices->dev, 1 );
 	}
 	remove_proc_entry("aironet", proc_root_driver);
 
-	if (is_pci) {
 #ifdef CONFIG_PCI
-		pci_unregister_driver(&airo_driver);
+	pci_unregister_driver(&airo_driver);
 #endif
-	}
 }
 
 #ifdef WIRELESS_EXT


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
