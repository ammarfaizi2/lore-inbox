Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319075AbSHMW2W>; Tue, 13 Aug 2002 18:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319076AbSHMW2W>; Tue, 13 Aug 2002 18:28:22 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:44995 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319075AbSHMW2S>; Tue, 13 Aug 2002 18:28:18 -0400
Message-ID: <3D598852.4070404@us.ibm.com>
Date: Tue, 13 Aug 2002 15:29:38 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel@vger.kernel.org, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Greg KH <gregkh@us.ibm.com>
Subject: Re: [patch] PCI Cleanup
References: <Pine.LNX.4.44.0208131323250.1260-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------070702080706060006050203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070702080706060006050203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus,
	I think I'm getting what you're aiming for here.  See if this patch comes close 
to what you're looking for.

	The basic idea is we get rid of the byte/word/dword functions and just put a 
size arg in the generic calls.  I put back the different struct pci_ops for 
conf1 and conf2, so that drivers and other code could use either config option. 
  I also fixed the macros in access.h so that it correctly calls the new functions.

Please *don't* apply this as it will break a bunch of stuff (just about all PCI 
code ;)

Cheers!

-Matt


Linus Torvalds wrote:
> On 13 Aug 2002, Alan Cox wrote:
> 
>>>OK, that IDE thing smacks of unmitigated evil to me, but if things are relying 
>>>on it, we shouldn't change it.
>>
>>It wants to force its own conf1/conf2 over the BIOS even if BIOS is
>>preferred because some BIOSes dont honour the size requested and the
>>hardware has bugs.
>>
>>That to me says there may well be cleaner approaches.
> 
> 
> The thing I liked about the separate structures for function pointers for 
> conf1/conf2 is that I could at least _see_ that the IDE driver might some 
> day be changed to just do
> 
> 	..
> 	conf2_struct->pci_config_read_byte(..)
> 	..
> 
> even if (judging by past performance) this would never happen ;)
> 
> This is why I'd like to continue with the notion of having a well-defined 
> structure that contains all the pointers (and one default case). Now, 
> shrinking those structures down to 2 entries instead of 6 sounds like a 
> fine idea to me, but short-circuiting them internally sounds bad because 
> it loses the ability to use the pci config space functions independently 
> of each other.
> 
> 		Linus
> 
> 


--------------070702080706060006050203
Content-Type: text/plain;
 name="new_pci_fix-2531.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="new_pci_fix-2531.patch"

diff -Nur linux-2.5.31-vanilla/arch/i386/pci/direct.c linux-2.5.31-patched/arch/i386/pci/direct.c
--- linux-2.5.31-vanilla/arch/i386/pci/direct.c	Sat Aug 10 18:41:23 2002
+++ linux-2.5.31-patched/arch/i386/pci/direct.c	Tue Aug 13 15:22:03 2002
@@ -69,75 +69,23 @@
 	return 0;
 }
 
-
 #undef PCI_CONF1_ADDRESS
 
-static int pci_conf1_read_config_byte(struct pci_dev *dev, int where, u8 *value)
+static int pci_conf1_read_size_indep(struct pci_dev *dev, int where, int size, u32 *value)
 {
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
 	return pci_conf1_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 4, value);
+		PCI_FUNC(dev->devfn), where, size, value);
 }
 
-static int pci_conf1_write_config_byte(struct pci_dev *dev, int where, u8 value)
+static int pci_conf1_write_size_indep(struct pci_dev *dev, int where, int size, u32 value)
 {
 	return pci_conf1_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
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
+		PCI_FUNC(dev->devfn), where, size, value);
 }
 
 static struct pci_ops pci_direct_conf1 = {
-	pci_conf1_read_config_byte,
-	pci_conf1_read_config_word,
-	pci_conf1_read_config_dword,
-	pci_conf1_write_config_byte,
-	pci_conf1_write_config_word,
-	pci_conf1_write_config_dword
+	pci_conf1_read_size_indep,
+	pci_conf1_write_size_indep
 };
 
 
@@ -217,57 +165,21 @@
 
 #undef PCI_CONF2_ADDRESS
 
-static int pci_conf2_read_config_byte(struct pci_dev *dev, int where, u8 *value)
-{
-	int result; 
-	u32 data;
-	result = pci_conf2_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 1, &data);
-	*value = (u8)data;
-	return result;
-}
-
-static int pci_conf2_read_config_word(struct pci_dev *dev, int where, u16 *value)
-{
-	int result; 
-	u32 data;
-	result = pci_conf2_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 2, &data);
-	*value = (u16)data;
-	return result;
-}
-
-static int pci_conf2_read_config_dword(struct pci_dev *dev, int where, u32 *value)
+static int pci_conf2_read_size_indep(struct pci_dev *dev, int where, int size, u32 *value)
 {
 	return pci_conf2_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 4, value);
-}
-
-static int pci_conf2_write_config_byte(struct pci_dev *dev, int where, u8 value)
-{
-	return pci_conf2_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 1, value);
+		PCI_FUNC(dev->devfn), where, size, value);
 }
 
-static int pci_conf2_write_config_word(struct pci_dev *dev, int where, u16 value)
+static int pci_conf2_write_size_indep(struct pci_dev *dev, int where, int size, u32 value)
 {
 	return pci_conf2_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 2, value);
-}
-
-static int pci_conf2_write_config_dword(struct pci_dev *dev, int where, u32 value)
-{
-	return pci_conf2_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 4, value);
+		PCI_FUNC(dev->devfn), where, size, value);
 }
 
 static struct pci_ops pci_direct_conf2 = {
-	pci_conf2_read_config_byte,
-	pci_conf2_read_config_word,
-	pci_conf2_read_config_dword,
-	pci_conf2_write_config_byte,
-	pci_conf2_write_config_word,
-	pci_conf2_write_config_dword
+	pci_conf2_read_size_indep,
+	pci_conf2_write_size_indep
 };
 
 
@@ -292,16 +204,16 @@
 	bus.number = 0;
 	dev.bus = &bus;
 	for(dev.devfn=0; dev.devfn < 0x100; dev.devfn++)
-		if ((!o->read_word(&dev, PCI_CLASS_DEVICE, &x) &&
+		if ((!o->read(&dev, PCI_CLASS_DEVICE, 2, &x) &&
 		     (x == PCI_CLASS_BRIDGE_HOST || x == PCI_CLASS_DISPLAY_VGA)) ||
-		    (!o->read_word(&dev, PCI_VENDOR_ID, &x) &&
+		    (!o->read(&dev, PCI_VENDOR_ID, 2, &x) &&
 		     (x == PCI_VENDOR_ID_INTEL || x == PCI_VENDOR_ID_COMPAQ)))
 			return 1;
 	DBG("PCI: Sanity check failed\n");
 	return 0;
 }
 
-static struct pci_ops * __devinit pci_check_direct(void)
+static int __init pci_direct_init(void)
 {
 	unsigned int tmp;
 	unsigned long flags;
@@ -312,6 +224,8 @@
 	 * Check if configuration type 1 works.
 	 */
 	if (pci_probe & PCI_PROBE_CONF1) {
+		pci_config_read = pci_conf1_read;
+		pci_config_write = pci_conf1_write;
 		outb (0x01, 0xCFB);
 		tmp = inl (0xCF8);
 		outl (0x80000000, 0xCF8);
@@ -321,8 +235,10 @@
 			local_irq_restore(flags);
 			printk(KERN_INFO "PCI: Using configuration type 1\n");
 			if (!request_region(0xCF8, 8, "PCI conf1"))
-				return NULL;
-			return &pci_direct_conf1;
+				pci_root_ops = NULL;
+			else
+				pci_root_ops = &pci_direct_conf1;
+			return 0;
 		}
 		outl (tmp, 0xCF8);
 	}
@@ -331,6 +247,8 @@
 	 * Check if configuration type 2 works.
 	 */
 	if (pci_probe & PCI_PROBE_CONF2) {
+		pci_config_read = pci_conf2_read;
+		pci_config_write = pci_conf2_write;
 		outb (0x00, 0xCFB);
 		outb (0x00, 0xCF8);
 		outb (0x00, 0xCFA);
@@ -339,28 +257,15 @@
 			local_irq_restore(flags);
 			printk(KERN_INFO "PCI: Using configuration type 2\n");
 			if (!request_region(0xCF8, 4, "PCI conf2"))
-				return NULL;
-			return &pci_direct_conf2;
+				pci_root_ops = NULL;
+			else
+				pci_root_ops = &pci_direct_conf2;
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
 
diff -Nur linux-2.5.31-vanilla/drivers/pci/access.c linux-2.5.31-patched/drivers/pci/access.c
--- linux-2.5.31-vanilla/drivers/pci/access.c	Sat Aug 10 18:41:29 2002
+++ linux-2.5.31-patched/drivers/pci/access.c	Tue Aug 13 15:09:56 2002
@@ -19,24 +19,38 @@
 #define PCI_word_BAD (pos & 1)
 #define PCI_dword_BAD (pos & 3)
 
-#define PCI_OP(rw,size,type) \
-int pci_##rw##_config_##size (struct pci_dev *dev, int pos, type value) \
+#define PCI_OP_READ(size,type,len) \
+int pci_read_config_##size (struct pci_dev *dev, int pos, type *value) \
 {									\
 	int res;							\
 	unsigned long flags;						\
+	u32 data;							\
 	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
 	spin_lock_irqsave(&pci_lock, flags);				\
-	res = dev->bus->ops->rw##_##size(dev, pos, value);		\
+	res = dev->bus->ops->read(dev, pos, len, &data);		\
+	*value = (type)data;						\
 	spin_unlock_irqrestore(&pci_lock, flags);			\
 	return res;							\
 }
 
-PCI_OP(read, byte, u8 *)
-PCI_OP(read, word, u16 *)
-PCI_OP(read, dword, u32 *)
-PCI_OP(write, byte, u8)
-PCI_OP(write, word, u16)
-PCI_OP(write, dword, u32)
+#define PCI_OP_WRITE(size,type,len) \
+int pci_write_config_##size (struct pci_dev *dev, int pos, type value) \
+{									\
+	int res;							\
+	unsigned long flags;						\
+	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
+	spin_lock_irqsave(&pci_lock, flags);				\
+	res = dev->bus->ops->write(dev, pos, len, value);		\
+	spin_unlock_irqrestore(&pci_lock, flags);			\
+	return res;							\
+}
+
+PCI_OP_READ(byte, u8, 1)
+PCI_OP_READ(word, u16, 2)
+PCI_OP_READ(dword, u32, 4)
+PCI_OP_WRITE(byte, u8, 1)
+PCI_OP_WRITE(word, u16, 2)
+PCI_OP_WRITE(dword, u32, 4)
 
 EXPORT_SYMBOL(pci_read_config_byte);
 EXPORT_SYMBOL(pci_read_config_word);
diff -Nur linux-2.5.31-vanilla/include/linux/pci.h linux-2.5.31-patched/include/linux/pci.h
--- linux-2.5.31-vanilla/include/linux/pci.h	Sat Aug 10 18:41:28 2002
+++ linux-2.5.31-patched/include/linux/pci.h	Tue Aug 13 14:49:36 2002
@@ -456,12 +456,8 @@
 /* Low-level architecture-dependent routines */
 
 struct pci_ops {
-	int (*read_byte)(struct pci_dev *, int where, u8 *val);
-	int (*read_word)(struct pci_dev *, int where, u16 *val);
-	int (*read_dword)(struct pci_dev *, int where, u32 *val);
-	int (*write_byte)(struct pci_dev *, int where, u8 val);
-	int (*write_word)(struct pci_dev *, int where, u16 val);
-	int (*write_dword)(struct pci_dev *, int where, u32 val);
+	int (*read)(struct pci_dev *, int where, int size, u32 *val);
+	int (*write)(struct pci_dev *, int where, int size, u32 val);
 };
 
 struct pbus_set_ranges_data

--------------070702080706060006050203--

