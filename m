Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTLOKCd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 05:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbTLOKCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 05:02:33 -0500
Received: from fmr99.intel.com ([192.55.52.32]:30693 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S263453AbTLOKCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 05:02:03 -0500
Message-ID: <3FDD8691.80206@intel.com>
Date: Mon, 15 Dec 2003 12:01:53 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Martin Mares <mj@ucw.cz>,
       zaitcev@redhat.com, hch@infradead.org
Subject: Re: PCI Express support for 2.4 kernel
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com>
In-Reply-To: <3FDCCC12.20808@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------030604060408070004080506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030604060408070004080506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Thanks for comments. Jeff, I specially appreciate time you spent walking 
through code.

I am not subscribed to lkml, thus please CC me
(Vladimir Kondratiev <vladimir.kondratiev@intel.com>) in replies.

To keep posting short, I skipped most of original mail.
I attached fixed version for the patch. Sure, I tested it prior to posting.

> <Jeff>
> The patch could use some cleaning up, for coding style.  The general 
> style is documented in CodingStyle file in the kernel source tree.  
> But also, you should consider the "golden rule of style" for 
> programmers: When modifying a file, follow the same formatting as is 
> found in the rest of the file.
>
Agree. It was my fault to not do it from the beginning. I habited to 
trust Emacs. Fixed.

>> +/**
>> + * Virtual address for RRBAR
>> + */
>> +static void* rrbar_virt=NULL;
>
>
> Do not bother initializing static variables to zero.  This just wastes 
> bss space, since these variables are automatically zeroed for you, 
> anyway.

I did not found this feature in standard. More, future versions of gcc 
will give at least warning, if not error, like "use of uninitialized 
variable". Many good sources also say it is good practice to initialize 
all variables. I rely on its value later. I' ll keep it as is unless 
really strong arguments provided.

>> +/**
>> + * It used to be #define, but I am going to change it.
>> + */
>> +extern int PCI_CFG_SPACE_SIZE;
>
>
> Hopefully this is temporary...  variables should not be ALL CAPS.  If 
> you change it to a variable, also change its case.

Agree. Fixed.

>> +/**
>> + * Initializes PCI Express method for config space access.
>> + * + * There is no standard method to recognize presence of PCI 
>> Express,
>> + * thus we will assume it is PCI-E, and rely on sanity check to
>> + * deassert PCI-E presense. If PCI-E not present,
>> + * there is no physical RAM on RRBAR address, and we should read
>> + * something like 0xff.
>> + * + * Creates mapping for whole 256M area.
>> + * + * @return 1 if OK, 0 if error
>> + */
>> +static int pci_express_init(void)
>> +{
>> +  /* TODO: check PCI-Ex presense */
>
>
> Um, this sounds critical.  We should not merge this patch until this 
> 'TODO' is complete, in my opinion.

As I explained in comment to function, it is not really critical. The 
problem is, there is no generic way (or I don't know it) to recognize 
PCI-E. One suggest to go over all devices and see whether PCI-E 
capability present for at least one of them. I don't think it is good 
way to do. Sanity check do pretty good job here. If it is not PCI-E 
platform, this address in physical memory will not be connected to 
anything real. You will get 0xff's.

>> +static int pci_exp_read (int seg, int bus, int dev, int fn, int reg, 
>> int len, u32 *value)
>
>
> I think these arguments should be 'unsigned int', not 'int'.
>
> Let's be proactive, and protect against signed/unsigned problems now, 
> before they appear.

Sound reasonable. But this is how this function prototyped:

int (*pci_config_read)(int seg, int bus, int dev, int fn, int reg, int 
len, u32 *value) = NULL;
int (*pci_config_write)(int seg, int bus, int dev, int fn, int reg, int 
len, u32 value) = NULL;

I think it is better to ask author (Martin) of this code, may be he had 
some reason for this prototype?
I added him to CC list.

>> +  void* addr=rrbar_virt+(bus << 20)+(dev << 15)+(fn << 12)+reg;
>
>
> Why do you prefer '+' to '|' here?
>
> '|' normally has less side effects.
>
Agree. Fixed, except 1-st "+", since virtual addres may be not aligned 
on 256M boundary

> Further, PCI posting:  a writeb() / writew() / writel() will not be 
> flushed immediately to the processor.  The CPU and/or PCI bridge may 
> post (delay/combine) such writes.  I do not think this is a desireable 
> effect, for PCI config register accesses.
>
Good point. Fixed.

> As with other code, define a macro that creates these functions.  Then 
> add a series of lines such as
>
> DEF_PCIEX_READ(word, 2)
> DEF_PCIEX_READ(dword, 4)
> ...
>
2 'read' functions (one do not follow pattern) and 3 'write' functions 
do not worth 2 macros. Also, coding style for
the rest of file is different. Other methods defined w/o macros.

<Pete>

>+    if (rrbar_virt) {	<====== Not trusting own code
>> +        iounmap(rrbar_virt);
>> +    }
>  
>
>
>All in all, raw. Also, a healthy dose of Itanium is prescribed.
>
>  
>
Extra check is here for the case code will be modified. In not 
frequently executed code, it is better to check twice rather then forget 
to check.

<Christoph>

>It should go into 2.6 first. though.  And while you're at it add your
>copyright info to the top of the file instead of the middle.
>
Copyright - done, thanks for input.
Regarding 2.6 - you are right, but now I need it for 2.4, and I have no 
2.6 handy. I will do it in a week or 2.

Vladimir.


--------------030604060408070004080506
Content-Type: text/plain;
 name="pciexp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pciexp.patch"

Enable PCI Express access method for configuration space
This path includes:
 * access routines itself
 * command line argument "pci=exp" to force PCI Express, similar to "conf1" and "conf2"
 * full 4k config accessed through /proc/bus/pci/...

How it works:

With PCI-E, config space accessed through memory. Each device gets its own 4k memory mapped config,
total 256M for all devices.

At init time, I map whole region to not spent time for mapping later.

For /proc/bus/pci/..., I changed PCI_CFG_SPACE_SIZE to variable and changed it to 4k for PCI-E.

It is tested on 1 platform.

Author: "Vladimir Kondratiev" <vladimir.kondratiev@intel.com> 

diff -dur linux-2.4.23/arch/i386/kernel/pci-i386.h linux-2.4.23-pciexp/arch/i386/kernel/pci-i386.h
--- linux-2.4.23/arch/i386/kernel/pci-i386.h	2003-11-28 20:26:19.000000000 +0200
+++ linux-2.4.23-pciexp/arch/i386/kernel/pci-i386.h	2003-12-14 11:08:17.000000000 +0200
@@ -15,6 +15,7 @@
 #define PCI_PROBE_BIOS		0x0001
 #define PCI_PROBE_CONF1		0x0002
 #define PCI_PROBE_CONF2		0x0004
+#define PCI_PROBE_EXP		0x0008
 #define PCI_NO_SORT		0x0100
 #define PCI_BIOS_SORT		0x0200
 #define PCI_NO_CHECKS		0x0400
diff -dur linux-2.4.23/arch/i386/kernel/pci-pc.c linux-2.4.23-pciexp/arch/i386/kernel/pci-pc.c
--- linux-2.4.23/arch/i386/kernel/pci-pc.c	2003-11-28 20:26:19.000000000 +0200
+++ linux-2.4.23-pciexp/arch/i386/kernel/pci-pc.c	2003-12-15 10:35:46.000000000 +0200
@@ -2,6 +2,9 @@
  *	Low-Level PCI Support for PC
  *
  *	(c) 1999--2000 Martin Mares <mj@ucw.cz>
+ *
+ *	(c) 2003 Vladimir Kondratiev <vladimir.kondratiev@intel.com>
+ *		PCI Express
  */
 
 #include <linux/config.h>
@@ -20,7 +23,7 @@
 
 #include "pci-i386.h"
 
-unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2;
+unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2 | PCI_PROBE_EXP;
 
 int pcibios_last_bus = -1;
 struct pci_bus *pci_root_bus = NULL;
@@ -427,6 +430,159 @@
 	pci_conf2_write_config_dword
 };
 
+/**
+ * PCI Express routines
+ * "Vladimir Kondratiev" <vladimir.kondratiev@intel.com>
+ */
+/**
+ * RRBAR (memory base for PCI-E config space) resides here.
+ * Initialized to default address. Actually, it is platform specific, and
+ * value may vary.
+ * I don't know how to detect it properly, it is chipset specific.
+ */
+static u32 rrbar_phys = 0xe0000000UL;
+/**
+ * RRBAR is always 256M
+ */
+static u32 rrbar_size = 0x10000000UL;
+/**
+ * Virtual address for RRBAR
+ */
+static void *rrbar_virt = NULL;
+/**
+ * It used to be #define, but I am going to modify it.
+ */
+extern int pci_cfg_space_size;
+
+/**
+ * Initializes PCI Express method for config space access.
+ * 
+ * There is no standard method to recognize presence of PCI Express,
+ * thus we will assume it is PCI-E, and rely on sanity check to
+ * deassert PCI-E presense. If PCI-E not present,
+ * there is no physical RAM on RRBAR address, and we should read
+ * something like 0xff.
+ * 
+ * Creates mapping for whole 256M area.
+ * 
+ * @return 1 if OK, 0 if error
+ */
+static int pci_express_init(void)
+{
+	/* TODO: check PCI-Ex presence */
+	rrbar_virt = ioremap(rrbar_phys, rrbar_size);
+	if (!rrbar_virt)
+		return 0;
+	return 1;
+}
+
+/**
+ * Shuts down PCI-E resources.
+ */
+static void pci_express_fini(void)
+{
+	if (rrbar_virt)
+		iounmap(rrbar_virt);
+}
+
+static int pci_exp_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+{
+	void *addr = rrbar_virt + ((bus << 20) | (dev << 15) | (fn << 12) | reg);
+	if ((bus > 255 || dev > 31 || fn > 7 || reg > 4095)) 
+		return -EINVAL;
+	switch (len) {
+	case 1:
+		*value = readb(addr);
+		break;
+	case 2:
+		if (reg & 1)
+			return -EINVAL;
+		*value = readw(addr);
+		break;
+	case 4:
+		if (reg & 3)
+			return -EINVAL;
+		*value = readl(addr);
+		break;
+	}
+	return 0;
+}
+
+static int pci_exp_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+{
+	void *addr = rrbar_virt + ((bus << 20) | (dev << 15) | (fn << 12) | reg);
+	if ((bus > 255 || dev > 31 || fn > 7 || reg > 4095)) 
+		return -EINVAL;
+	switch (len) {
+	case 1:
+		writeb(value, addr);
+		break;
+	case 2:
+		if (reg & 1) return -EINVAL;
+		writew(value, addr);
+		break;
+	case 4:
+		if (reg & 3) return -EINVAL;
+		writel(value, addr);
+		break;
+	}
+	/* dummy read to flush PCI write */
+	readb(addr);
+	return 0;
+}
+
+static int pci_exp_read_config_byte(struct pci_dev *dev, int where, u8 *value)
+{
+	int result; 
+	u32 data;
+	result = pci_exp_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+			PCI_FUNC(dev->devfn), where, 1, &data);
+	*value = (u8)data;
+	return result;
+}
+
+static int pci_exp_read_config_word(struct pci_dev *dev, int where, u16 *value)
+{
+	int result; 
+	u32 data;
+	result = pci_exp_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+			PCI_FUNC(dev->devfn), where, 2, &data);
+	*value = (u16)data;
+	return result;
+}
+
+static int pci_exp_read_config_dword(struct pci_dev *dev, int where, u32 *value)
+{
+	return pci_exp_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+			PCI_FUNC(dev->devfn), where, 4, value);
+}
+
+static int pci_exp_write_config_byte(struct pci_dev *dev, int where, u8 value)
+{
+	return pci_exp_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+			PCI_FUNC(dev->devfn), where, 1, value);
+}
+
+static int pci_exp_write_config_word(struct pci_dev *dev, int where, u16 value)
+{
+	return pci_exp_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+			PCI_FUNC(dev->devfn), where, 2, value);
+}
+
+static int pci_exp_write_config_dword(struct pci_dev *dev, int where, u32 value)
+{
+	return pci_exp_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+			PCI_FUNC(dev->devfn), where, 4, value);
+}
+
+static struct pci_ops pci_express_conf = {
+	pci_exp_read_config_byte,
+	pci_exp_read_config_word,
+	pci_exp_read_config_dword,
+	pci_exp_write_config_byte,
+	pci_exp_write_config_word,
+	pci_exp_write_config_dword
+};
 
 /*
  * Before we decide to use direct hardware access mechanisms, we try to do some
@@ -465,6 +621,22 @@
 
 	__save_flags(flags); __cli();
 
+	/**
+	 * Check if PCI-express access work
+	 */
+	if (pci_express_init()) {
+		if (pci_sanity_check(&pci_express_conf)) {
+			/* PCI-E provides 4k config space */
+			pci_cfg_space_size = 4096;
+			__restore_flags(flags);
+			printk(KERN_INFO "PCI: Using configuration type PCI Express\n");
+			request_mem_region(rrbar_phys, rrbar_size, "PCI-Express config space");
+			return &pci_express_conf;
+		} else {
+			pci_express_fini();
+		}
+	}
+
 	/*
 	 * Check if configuration type 1 works.
 	 */
@@ -1398,16 +1570,18 @@
 #endif
 
 #ifdef CONFIG_PCI_DIRECT
-	if ((pci_probe & (PCI_PROBE_CONF1 | PCI_PROBE_CONF2)) 
+	if ((pci_probe & (PCI_PROBE_CONF1 | PCI_PROBE_CONF2 | PCI_PROBE_EXP)) 
 		&& (tmp = pci_check_direct())) {
 		pci_root_ops = tmp;
 		if (pci_root_ops == &pci_direct_conf1) {
 			pci_config_read = pci_conf1_read;
 			pci_config_write = pci_conf1_write;
-		}
-		else {
+		} else if (pci_root_ops == &pci_direct_conf2) {
 			pci_config_read = pci_conf2_read;
 			pci_config_write = pci_conf2_write;
+		} else if (pci_root_ops == &pci_express_conf) {
+			pci_config_read = pci_exp_read;
+			pci_config_write = pci_exp_write;
 		}
 	}
 #endif
@@ -1489,6 +1663,10 @@
 		pci_probe = PCI_PROBE_CONF2 | PCI_NO_CHECKS;
 		return NULL;
 	}
+	else if (!strcmp(str, "exp")) {
+		pci_probe = PCI_PROBE_EXP | PCI_NO_CHECKS;
+		return NULL;
+	}
 #endif
 	else if (!strcmp(str, "rom")) {
 		pci_probe |= PCI_ASSIGN_ROMS;
diff -dur linux-2.4.23/drivers/pci/proc.c linux-2.4.23-pciexp/drivers/pci/proc.c
--- linux-2.4.23/drivers/pci/proc.c	2002-11-29 01:53:14.000000000 +0200
+++ linux-2.4.23-pciexp/drivers/pci/proc.c	2003-12-15 11:48:16.000000000 +0200
@@ -16,7 +16,10 @@
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
 
-#define PCI_CFG_SPACE_SIZE 256
+/**
+ * For PCI Express, it will be set to 4096 during PCI init
+ */
+int pci_cfg_space_size=256;
 
 static loff_t
 proc_bus_pci_lseek(struct file *file, loff_t off, int whence)
@@ -31,12 +34,12 @@
 		new = file->f_pos + off;
 		break;
 	case 2:
-		new = PCI_CFG_SPACE_SIZE + off;
+		new = pci_cfg_space_size + off;
 		break;
 	default:
 		return -EINVAL;
 	}
-	if (new < 0 || new > PCI_CFG_SPACE_SIZE)
+	if (new < 0 || new > pci_cfg_space_size)
 		return -EINVAL;
 	return (file->f_pos = new);
 }
@@ -57,7 +60,7 @@
 	 */
 
 	if (capable(CAP_SYS_ADMIN))
-		size = PCI_CFG_SPACE_SIZE;
+		size = pci_cfg_space_size;
 	else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
 		size = 128;
 	else
@@ -132,12 +135,12 @@
 	int pos = *ppos;
 	int cnt;
 
-	if (pos >= PCI_CFG_SPACE_SIZE)
+	if (pos >= pci_cfg_space_size)
 		return 0;
-	if (nbytes >= PCI_CFG_SPACE_SIZE)
-		nbytes = PCI_CFG_SPACE_SIZE;
-	if (pos + nbytes > PCI_CFG_SPACE_SIZE)
-		nbytes = PCI_CFG_SPACE_SIZE - pos;
+	if (nbytes >= pci_cfg_space_size)
+		nbytes = pci_cfg_space_size;
+	if (pos + nbytes > pci_cfg_space_size)
+		nbytes = pci_cfg_space_size - pos;
 	cnt = nbytes;
 
 	if (!access_ok(VERIFY_READ, buf, cnt))
@@ -389,7 +392,7 @@
 		return -ENOMEM;
 	e->proc_fops = &proc_bus_pci_operations;
 	e->data = dev;
-	e->size = PCI_CFG_SPACE_SIZE;
+	e->size = pci_cfg_space_size;
 	return 0;
 }
 

--------------030604060408070004080506--
