Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318209AbSHMQ7S>; Tue, 13 Aug 2002 12:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318218AbSHMQ7R>; Tue, 13 Aug 2002 12:59:17 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:27104 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318209AbSHMQ7O>; Tue, 13 Aug 2002 12:59:14 -0400
Message-ID: <3D593B37.3070009@us.ibm.com>
Date: Tue, 13 Aug 2002 10:00:39 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, Greg KH <gregkh@us.ibm.com>
Subject: Re: [patch] PCI Cleanup
References: <1029239133.20980.10.camel@irongate.swansea.linux.org.uk> 	<1847016869.1029223059@[10.10.2.3]> <1029250668.22847.34.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------040205060901090801000205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040205060901090801000205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> I pointed out before the null check was flawed. And all I see is the
> same identical patch churned out again. Regardless of whether that
> paticular stupid error was in the old code, not fixing it in the new
> code when its pointed out is a bit of a mess.
The NULL check has been removed.  The current version is attatched.  It now 
pulls out 75 lines of code.  I must have missed your complaints about the null 
check in previous emails...  The check was done in the old pci_conf1 funcs, and 
  not in the pci_conf2 ones.. I thought this was strange as well, but I just 
left them in...

> I'm not sure its a simplification either. More function pointers don't
> always make for neater - but thats a side issue. If the NULL check goes
> I'm not too worried about the other stuff.
I think that it is definitely a simplification, although I am a bit biased ;) 
It makes it easier for other configuration types to hook into the system as 
well (I'm partial to NUMA-Q as well ;).  All they have to do is hijack the 
pci_config_(read|write) function pointers.

Also, has anyone had a chance to look at it with pci_conf2?  I have no 
particular reason to believe it doesn't work, as the code paths are almost 
identical, I'd just be nice to have a confirmation.

Cheers!

-Matt

--------------040205060901090801000205
Content-Type: text/plain;
 name="pci_fix-2531.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_fix-2531.patch"

diff -Nur linux-2.5.31-vanilla/arch/i386/pci/direct.c linux-2.5.31-patched/arch/i386/pci/direct.c
--- linux-2.5.31-vanilla/arch/i386/pci/direct.c	Sat Aug 10 18:41:23 2002
+++ linux-2.5.31-patched/arch/i386/pci/direct.c	Tue Aug 13 09:45:12 2002
@@ -69,76 +69,7 @@
 	return 0;
 }
 
-
 #undef PCI_CONF1_ADDRESS
-
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
@@ -217,57 +149,58 @@
 
 #undef PCI_CONF2_ADDRESS
 
-static int pci_conf2_read_config_byte(struct pci_dev *dev, int where, u8 *value)
+
+static int pci_config_read_byte(struct pci_dev *dev, int where, u8 *value)
 {
 	int result; 
 	u32 data;
-	result = pci_conf2_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
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
+	result = pci_config_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
 		PCI_FUNC(dev->devfn), where, 2, &data);
 	*value = (u16)data;
 	return result;
 }
 
-static int pci_conf2_read_config_dword(struct pci_dev *dev, int where, u32 *value)
+static int pci_config_read_dword(struct pci_dev *dev, int where, u32 *value)
 {
-	return pci_conf2_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
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
 
 
@@ -301,7 +235,7 @@
 	return 0;
 }
 
-static struct pci_ops * __devinit pci_check_direct(void)
+static int __init pci_direct_init(void)
 {
 	unsigned int tmp;
 	unsigned long flags;
@@ -312,17 +246,21 @@
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
@@ -331,36 +269,25 @@
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
 

--------------040205060901090801000205--

