Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318885AbSHMAHj>; Mon, 12 Aug 2002 20:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318884AbSHMAHj>; Mon, 12 Aug 2002 20:07:39 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:59023 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318883AbSHMAHe>;
	Mon, 12 Aug 2002 20:07:34 -0400
Message-ID: <3D584DF8.9020206@us.ibm.com>
Date: Mon, 12 Aug 2002 17:08:24 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Martin Bligh <mjbligh@us.ibm.com>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Greg KH <gregkh@us.ibm.com>
Subject: [patch] PCI Cleanup
Content-Type: multipart/mixed;
 boundary="------------030202050206070003050103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030202050206070003050103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus, Alan, et al.

	Here's a patch I'd like to see included in the 2.5 mainline.  Some of the code 
in arch/i386/pci/direct.c is a bit ugly and definitely redundant.  This patch 
cleans that up.  I've tested in on PCI configuration 1 systems, but I haven't 
had a chance to test this on any systems that use PCI configuration 2.  If 
anyone can do that, that would be awesome.

[mcd@arrakis src]$ diffstat pci_fix-2531.patch
  direct.c | 158 
+++++++++++++++++++-------------------------------------------- 1 files 
changed, 48 insertions(+), 110 deletions(-)

	The gist of the patch is that it move the indirection one layer down and saves 
about 60+ lines of code.  Rather than having 
pci_conf{1|2}_{read|write}_config_{byte|word|dword}, this patch removes the 1/2 
distinction by pushing that down a layer, and calling a generic pointer 
instead.  That pointer is set at init time by the PCI init code.  This pulls 
out 6 functions (pci_conf2_*) that were exact duplicates of the others 
(pci_conf1_*), but differed by 1 character each (s/conf1/conf2/).

Linus, please apply...

Cheers!

-Matt

--------------030202050206070003050103
Content-Type: text/plain;
 name="pci_fix-2531.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_fix-2531.patch"

diff -Nur linux-2.5.30-vanilla/arch/i386/pci/direct.c linux-2.5.30-patched/arch/i386/pci/direct.c
--- linux-2.5.30-vanilla/arch/i386/pci/direct.c	Thu Aug  1 14:16:14 2002
+++ linux-2.5.30-patched/arch/i386/pci/direct.c	Mon Aug 12 10:41:32 2002
@@ -69,76 +69,8 @@
 	return 0;
 }
 
-
 #undef PCI_CONF1_ADDRESS
 
-static int pci_conf1_read_config_byte(struct pci_dev *dev, int where, u8 *value)
-{
-	int result; 
-	u32 data;
-
-	if (!value) 
-		return -EINVAL;
-
-	result = pci_conf1_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 1, &data);
-
-	*value = (u8)data;
-
-	return result;
-}
-
-static int pci_conf1_read_config_word(struct pci_dev *dev, int where, u16 *value)
-{
-	int result; 
-	u32 data;
-
-	if (!value) 
-		return -EINVAL;
-
-	result = pci_conf1_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 2, &data);
-
-	*value = (u16)data;
-
-	return result;
-}
-
-static int pci_conf1_read_config_dword(struct pci_dev *dev, int where, u32 *value)
-{
-	if (!value) 
-		return -EINVAL;
-
-	return pci_conf1_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 4, value);
-}
-
-static int pci_conf1_write_config_byte(struct pci_dev *dev, int where, u8 value)
-{
-	return pci_conf1_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 1, value);
-}
-
-static int pci_conf1_write_config_word(struct pci_dev *dev, int where, u16 value)
-{
-	return pci_conf1_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 2, value);
-}
-
-static int pci_conf1_write_config_dword(struct pci_dev *dev, int where, u32 value)
-{
-	return pci_conf1_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 4, value);
-}
-
-static struct pci_ops pci_direct_conf1 = {
-	pci_conf1_read_config_byte,
-	pci_conf1_read_config_word,
-	pci_conf1_read_config_dword,
-	pci_conf1_write_config_byte,
-	pci_conf1_write_config_word,
-	pci_conf1_write_config_dword
-};
 
 
 /*
@@ -217,57 +149,70 @@
 
 #undef PCI_CONF2_ADDRESS
 
-static int pci_conf2_read_config_byte(struct pci_dev *dev, int where, u8 *value)
+
+
+static int pci_config_read_byte(struct pci_dev *dev, int where, u8 *value)
 {
 	int result; 
 	u32 data;
-	result = pci_conf2_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+
+	if (!value) 
+		return -EINVAL;
+
+	result = pci_config_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
 		PCI_FUNC(dev->devfn), where, 1, &data);
 	*value = (u8)data;
 	return result;
 }
 
-static int pci_conf2_read_config_word(struct pci_dev *dev, int where, u16 *value)
+static int pci_config_read_word(struct pci_dev *dev, int where, u16 *value)
 {
 	int result; 
 	u32 data;
-	result = pci_conf2_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+
+	if (!value) 
+		return -EINVAL;
+
+	result = pci_config_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
 		PCI_FUNC(dev->devfn), where, 2, &data);
 	*value = (u16)data;
 	return result;
 }
 
-static int pci_conf2_read_config_dword(struct pci_dev *dev, int where, u32 *value)
+static int pci_config_read_dword(struct pci_dev *dev, int where, u32 *value)
 {
-	return pci_conf2_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+	if (!value) 
+		return -EINVAL;
+
+	return pci_config_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
 		PCI_FUNC(dev->devfn), where, 4, value);
 }
 
-static int pci_conf2_write_config_byte(struct pci_dev *dev, int where, u8 value)
+static int pci_config_write_byte(struct pci_dev *dev, int where, u8 value)
 {
-	return pci_conf2_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+	return pci_config_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
 		PCI_FUNC(dev->devfn), where, 1, value);
 }
 
-static int pci_conf2_write_config_word(struct pci_dev *dev, int where, u16 value)
+static int pci_config_write_word(struct pci_dev *dev, int where, u16 value)
 {
-	return pci_conf2_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+	return pci_config_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
 		PCI_FUNC(dev->devfn), where, 2, value);
 }
 
-static int pci_conf2_write_config_dword(struct pci_dev *dev, int where, u32 value)
+static int pci_config_write_dword(struct pci_dev *dev, int where, u32 value)
 {
-	return pci_conf2_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+	return pci_config_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
 		PCI_FUNC(dev->devfn), where, 4, value);
 }
 
-static struct pci_ops pci_direct_conf2 = {
-	pci_conf2_read_config_byte,
-	pci_conf2_read_config_word,
-	pci_conf2_read_config_dword,
-	pci_conf2_write_config_byte,
-	pci_conf2_write_config_word,
-	pci_conf2_write_config_dword
+static struct pci_ops pci_direct = {
+	pci_config_read_byte,
+	pci_config_read_word,
+	pci_config_read_dword,
+	pci_config_write_byte,
+	pci_config_write_word,
+	pci_config_write_dword
 };
 
 
@@ -301,7 +246,7 @@
 	return 0;
 }
 
-static struct pci_ops * __devinit pci_check_direct(void)
+static int __init pci_direct_init(void)
 {
 	unsigned int tmp;
 	unsigned long flags;
@@ -312,17 +257,21 @@
 	 * Check if configuration type 1 works.
 	 */
 	if (pci_probe & PCI_PROBE_CONF1) {
+		pci_config_read = pci_conf1_read;
+		pci_config_write = pci_conf1_write;
 		outb (0x01, 0xCFB);
 		tmp = inl (0xCF8);
 		outl (0x80000000, 0xCF8);
 		if (inl (0xCF8) == 0x80000000 &&
-		    pci_sanity_check(&pci_direct_conf1)) {
+		    pci_sanity_check(&pci_direct)) {
 			outl (tmp, 0xCF8);
 			local_irq_restore(flags);
 			printk(KERN_INFO "PCI: Using configuration type 1\n");
 			if (!request_region(0xCF8, 8, "PCI conf1"))
-				return NULL;
-			return &pci_direct_conf1;
+				pci_root_ops = NULL;
+			else
+				pci_root_ops = &pci_direct;
+			return 0;
 		}
 		outl (tmp, 0xCF8);
 	}
@@ -331,36 +280,25 @@
 	 * Check if configuration type 2 works.
 	 */
 	if (pci_probe & PCI_PROBE_CONF2) {
+		pci_config_read = pci_conf2_read;
+		pci_config_write = pci_conf2_write;
 		outb (0x00, 0xCFB);
 		outb (0x00, 0xCF8);
 		outb (0x00, 0xCFA);
 		if (inb (0xCF8) == 0x00 && inb (0xCFA) == 0x00 &&
-		    pci_sanity_check(&pci_direct_conf2)) {
+		    pci_sanity_check(&pci_direct)) {
 			local_irq_restore(flags);
 			printk(KERN_INFO "PCI: Using configuration type 2\n");
 			if (!request_region(0xCF8, 4, "PCI conf2"))
-				return NULL;
-			return &pci_direct_conf2;
+				pci_root_ops = NULL;
+			else
+				pci_root_ops = &pci_direct;
+			return 0;
 		}
 	}
 
 	local_irq_restore(flags);
-	return NULL;
-}
-
-static int __init pci_direct_init(void)
-{
-	if ((pci_probe & (PCI_PROBE_CONF1 | PCI_PROBE_CONF2)) 
-		&& (pci_root_ops = pci_check_direct())) {
-		if (pci_root_ops == &pci_direct_conf1) {
-			pci_config_read = pci_conf1_read;
-			pci_config_write = pci_conf1_write;
-		}
-		else {
-			pci_config_read = pci_conf2_read;
-			pci_config_write = pci_conf2_write;
-		}
-	}
+	pci_root_ops = NULL;
 	return 0;
 }
 

--------------030202050206070003050103--

