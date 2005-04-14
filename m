Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVDNXeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVDNXeJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 19:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVDNXeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 19:34:09 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:644 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261651AbVDNXeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 19:34:03 -0400
Subject: Re: Serverworks LE and MTRR write-combining question
From: Lee Revell <rlrevell@joe-job.com>
To: Mike Russo <miker@readq.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <425EF60F.9080901@readq.com>
References: <425EF60F.9080901@readq.com>
Content-Type: text/plain
Date: Thu, 14 Apr 2005 19:34:02 -0400
Message-Id: <1113521642.19830.33.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-14 at 19:00 -0400, Mike Russo wrote:Just 
> wondering if anyone had any updates on this issue, and if not, hey, 
> that's why the source is there -- for me to screw around with. ;)
> 

I think it didn't go in just because no one bothered to repost the patch
with the comment fixed, as requested in that old thread.

Here's the patch from that thread against 2.6.12-rc2.  It also fixes an
unrelated typo in nearby code.  Obviously untested, as I don't have the
hardware ;-)

Summary: Enable write combining for server works LE rev > 6 per
http://www.ussg.iu.edu/hypermail/linux/kernel/0104.3/1007.html

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

--- linux-2.6.12-rc2-k7/arch/i386/kernel/cpu/mtrr/main.c~	2005-04-14 19:29:31.000000000 -0400
+++ linux-2.6.12-rc2-k7/arch/i386/kernel/cpu/mtrr/main.c	2005-04-14 19:29:16.000000000 -0400
@@ -72,17 +72,21 @@
 static int have_wrcomb(void)
 {
 	struct pci_dev *dev;
+	u8 rev;
 	
 	if ((dev = pci_get_class(PCI_CLASS_BRIDGE_HOST << 8, NULL)) != NULL) {
-		/* ServerWorks LE chipsets have problems with write-combining 
+		/* ServerWorks LE chipsets < rev 6 have problems with write-combining 
 		   Don't allow it and leave room for other chipsets to be tagged */
 		if (dev->vendor == PCI_VENDOR_ID_SERVERWORKS &&
 		    dev->device == PCI_DEVICE_ID_SERVERWORKS_LE) {
-			printk(KERN_INFO "mtrr: Serverworks LE detected. Write-combining disabled.\n");
-			pci_dev_put(dev);
-			return 0;
+			pci_read_config_byte(dev, PCI_CLASS_REVISION, &rev);
+			if (rev <= 5) {
+				printk(KERN_INFO "mtrr: Serverworks LE rev < 6 detected. Write-combining disabled.\n");
+				pci_dev_put(dev);
+				return 0;
+			}
 		}
-		/* Intel 450NX errata # 23. Non ascending cachline evictions to
+		/* Intel 450NX errata # 23. Non ascending cacheline evictions to
 		   write combining memory may resulting in data corruption */
 		if (dev->vendor == PCI_VENDOR_ID_INTEL &&
 		    dev->device == PCI_DEVICE_ID_INTEL_82451NX) {


