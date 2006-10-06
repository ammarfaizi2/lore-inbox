Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbWJFA5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbWJFA5S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 20:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWJFA5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 20:57:18 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:56715 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932519AbWJFA5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 20:57:18 -0400
Message-ID: <4525A9E9.6080301@garzik.org>
Date: Thu, 05 Oct 2006 20:57:13 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
References: <200610051910.25418.ak@suse.de> <452564B9.4010209@garzik.org> <Pine.LNX.4.64.0610051536590.3952@g5.osdl.org> <200610060052.46538.ak@suse.de> <Pine.LNX.4.64.0610051600440.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610051600440.3952@g5.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------090103010903080107050901"
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090103010903080107050901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> (And we should probably have the "pci=mmiocfg" kernel command line entry 
> that forces MMIOCFG regardless of any e820 issues, even for normal 
> accesses).

Something like this?


--------------090103010903080107050901
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"


Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 arch/i386/pci/common.c     |    4 ++++
 arch/i386/pci/mmconfig.c   |    3 ++-
 arch/x86_64/pci/mmconfig.c |    3 ++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/i386/pci/common.c b/arch/i386/pci/common.c
index 68bce19..38d9f4f 100644
--- a/arch/i386/pci/common.c
+++ b/arch/i386/pci/common.c
@@ -237,6 +237,10 @@ #ifdef CONFIG_PCI_MMCONFIG
 		pci_probe &= ~PCI_PROBE_MMCONF;
 		return NULL;
 	}
+	else if (!strcmp(str, "mmconf")) {
+		pci_probe |= PCI_PROBE_MMCONF | PCI_NO_CHECKS;
+		return NULL;
+	}
 #endif
 	else if (!strcmp(str, "noacpi")) {
 		acpi_noirq_set();
diff --git a/arch/i386/pci/mmconfig.c b/arch/i386/pci/mmconfig.c
index d0c3da3..056cb0a 100644
--- a/arch/i386/pci/mmconfig.c
+++ b/arch/i386/pci/mmconfig.c
@@ -237,7 +237,8 @@ void __init pci_mmcfg_init(int type)
 
 	/* Only do this check when type 1 works. If it doesn't work
 	   assume we run on a Mac and always use MCFG */
-	if (type == 1 && !e820_all_mapped(pci_mmcfg_config[0].base_address,
+	if ((type == 1) && (!(pci_probe & PCI_NO_CHECKS)) &&
+		!e820_all_mapped(pci_mmcfg_config[0].base_address,
 			pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
 			E820_RESERVED)) {
 		printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %x is not E820-reserved\n",
diff --git a/arch/x86_64/pci/mmconfig.c b/arch/x86_64/pci/mmconfig.c
index 7732f42..d942fc7 100644
--- a/arch/x86_64/pci/mmconfig.c
+++ b/arch/x86_64/pci/mmconfig.c
@@ -209,7 +209,8 @@ void __init pci_mmcfg_init(int type)
 
 	/* Only do this check when type 1 works. If it doesn't work
            assume we run on a Mac and always use MCFG */
-	if (type == 1 && !e820_all_mapped(pci_mmcfg_config[0].base_address,
+	if ((type == 1) && (!(pci_probe & PCI_NO_CHECKS)) &&
+	     !e820_all_mapped(pci_mmcfg_config[0].base_address,
 			pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
 			E820_RESERVED)) {
 		printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %x is not E820-reserved\n",

--------------090103010903080107050901--
