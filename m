Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268000AbUI1RdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268000AbUI1RdG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 13:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267998AbUI1R1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 13:27:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:57252 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267928AbUI1R0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 13:26:38 -0400
Date: Tue, 28 Sep 2004 10:25:23 -0700
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       davej@codemonkey.org.uk, hpa@zytor.com, kernel-janitors@lists.osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hanna Linder <hannal@us.ibm.com>
Subject: Re: Create new function to see if pci dev is present
Message-ID: <20040928172523.GB29529@kroah.com>
References: <2480000.1095978400@w-hlinder.beaverton.ibm.com> <20040924200231.A30391@infradead.org> <20040924211912.GC7619@kroah.com> <1096059645.10797.1.camel@localhost.localdomain> <20040926141002.GA24942@kroah.com> <20040928172426.GA29529@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040928172426.GA29529@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 10:24:26AM -0700, Greg KH wrote:
> Ok, here's the patch that I applied to my trees, and I'll follow this up
> with a conversion of Hanna's two patches that I respun to use the new
> parameters of this function.

Here's the cyrix.c patch.

-------

PCI: change cyrix.c driver to use pci_dev_present

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/arch/i386/kernel/cpu/cyrix.c b/arch/i386/kernel/cpu/cyrix.c
--- a/arch/i386/kernel/cpu/cyrix.c	2004-09-28 10:21:10 -07:00
+++ b/arch/i386/kernel/cpu/cyrix.c	2004-09-28 10:21:10 -07:00
@@ -187,12 +187,19 @@
 }
 
 
+#ifdef CONFIG_PCI
+static struct pci_device_id cyrix_55x0[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5510) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520) },
+	{ },
+};
+#endif
+
 static void __init init_cyrix(struct cpuinfo_x86 *c)
 {
 	unsigned char dir0, dir0_msn, dir0_lsn, dir1 = 0;
 	char *buf = c->x86_model_id;
 	const char *p = NULL;
-	struct pci_dev *dev;
 
 	/* Bit 31 in normal CPUID used for nonstandard 3DNow ID;
 	   3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway */
@@ -275,16 +282,8 @@
 		/*
 		 *  The 5510/5520 companion chips have a funky PIT.
 		 */  
-		dev = pci_get_device(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5510, NULL);
-		if (dev) {
-			pci_dev_put(dev);
-			pit_latch_buggy = 1;
-		}
-		dev =  pci_get_device(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520, NULL);
-		if (dev) {
-			pci_dev_put(dev);
+		if (pci_dev_present(cyrix_55x0))
 			pit_latch_buggy = 1;
-		}
 
 		/* GXm supports extended cpuid levels 'ala' AMD */
 		if (c->cpuid_level == 2) {
