Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319697AbSH3WZh>; Fri, 30 Aug 2002 18:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319698AbSH3WZh>; Fri, 30 Aug 2002 18:25:37 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:3844 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319697AbSH3WZe>;
	Fri, 30 Aug 2002 18:25:34 -0400
Date: Fri, 30 Aug 2002 15:28:57 -0700
From: Greg KH <greg@kroah.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI ops cleanups for 2.5.32-bk
Message-ID: <20020830222857.GC10877@kroah.com>
References: <20020830220720.GA10783@kroah.com> <20020830222642.GB10877@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020830222642.GB10877@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 03:26:42PM -0700, Greg KH wrote:
> 
> Here's the patch for sparc64.  David, please apply to your tree.

And here's the patch for sparc.  I am guessing that it should go to you
too.

thanks,

greg k-h

diff -Nru a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
--- a/arch/sparc/kernel/pcic.c	Fri Aug 30 13:59:38 2002
+++ b/arch/sparc/kernel/pcic.c	Fri Aug 30 13:59:38 2002
@@ -196,36 +196,34 @@
 static int pcic_read_config_dword(struct pci_dev *dev, int where, u32 *value);
 static int pcic_write_config_dword(struct pci_dev *dev, int where, u32 value);
 
-static int pcic_read_config_byte(struct pci_dev *dev, int where, u8 *value)
+static int pcic_read_config(struct pci_bus *bus, unsigned int devfn,
+			    int where, int size, u32 *value)
 {
 	unsigned int v;
+	unsigned char busnum = bus->number;
+	struct linux_pcic *pcic;
+	unsigned long flags;
+	/* unsigned char where; */
 
-	pcic_read_config_dword(dev, where&~3, &v);
-	*value = 0xff & (v >> (8*(where & 3)));
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int pcic_read_config_word(struct pci_dev *dev, int where, u16 *value)
-{
-	unsigned int v;
-	if (where&1) return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	pcic_read_config_dword(dev, where&~3, &v);
-	*value = 0xffff & (v >> (8*(where & 3)));
-	return PCIBIOS_SUCCESSFUL;
-}
+	switch (size) {
+	case 1:
+		pcic_read_config(bus, devfn, where&~3, 4, &v);
+		*value = 0xff & (v >> (8*(where & 3)));
+		return PCIBIOS_SUCCESSFUL;
+		break;
 
-static int pcic_read_config_dword(struct pci_dev *dev, int where, u32 *value)
-{
-	unsigned char bus = dev->bus->number;
-	unsigned char device_fn = dev->devfn;
-	/* unsigned char where; */
+	case 2:
+		if (where&1) return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	struct linux_pcic *pcic;
-	unsigned long flags;
+		pcic_read_config(bus, devfn, where&~3, 4, &v);
+		*value = 0xffff & (v >> (8*(where & 3)));
+		return PCIBIOS_SUCCESSFUL;
+		break;
+	}
 
+	/* size == 4, i.e. dword */
 	if (where&3) return PCIBIOS_BAD_REGISTER_NUMBER;
-	if (bus != 0) return PCIBIOS_DEVICE_NOT_FOUND;
+	if (busnum != 0) return PCIBIOS_DEVICE_NOT_FOUND;
 	pcic = &pcic0;
 
 	save_and_cli(flags);
@@ -233,7 +231,7 @@
 	pcic_speculative = 1;
 	pcic_trapped = 0;
 #endif
-	writel(CONFIG_CMD(bus,device_fn,where), pcic->pcic_config_space_addr);
+	writel(CONFIG_CMD(busnum,devfn,where), pcic->pcic_config_space_addr);
 #if 0 /* does not fail here */
 	nop();
 	if (pcic_trapped) {
@@ -257,52 +255,46 @@
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int pcic_write_config_byte(struct pci_dev *dev, int where, u8 value)
-{
-	unsigned int v;
-
-	pcic_read_config_dword(dev, where&~3, &v);
-        v = (v & ~(0xff << (8*(where&3)))) |
-            ((0xff&(unsigned)value) << (8*(where&3)));
-	return pcic_write_config_dword(dev, where&~3, v);
-}
-
-static int pcic_write_config_word(struct pci_dev *dev, int where, u16 value)
+static int pcic_write_config(struct pci_bus *bus, unsigned int devfn,
+			     int where, int size, u32 value)
 {
 	unsigned int v;
-
-	if (where&1) return PCIBIOS_BAD_REGISTER_NUMBER;
-	pcic_read_config_dword(dev, where&~3, &v);
-	v = (v & ~(0xffff << (8*(where&3)))) |
-	    ((0xffff&(unsigned)value) << (8*(where&3)));
-	return pcic_write_config_dword(dev, where&~3, v);
-}
-
-static int pcic_write_config_dword(struct pci_dev *dev, int where, u32 value)
-{
-	unsigned char bus = dev->bus->number;
-	unsigned char devfn = dev->devfn;
+	unsigned char busnum = bus->number;
 	struct linux_pcic *pcic;
 	unsigned long flags;
 
+	switch (size) {
+	case 1:
+		pcic_read_config(bus, devfn, where&~3, 4, &v);
+	        v = (v & ~(0xff << (8*(where&3)))) |
+	            ((0xff&(unsigned)value) << (8*(where&3)));
+		return pcic_write_config(bus, devfn, where&~3, 4, v);
+		break;
+
+	case 2:
+		if (where&1) return PCIBIOS_BAD_REGISTER_NUMBER;
+		pcic_read_config(bus, devfn, where&~3, 4, &v);
+		v = (v & ~(0xffff << (8*(where&3)))) |
+		    ((0xffff&(unsigned)value) << (8*(where&3)));
+		return pcic_write_config(bus, devfn, where&~3, 4, v);
+		break;
+	}
+
+	/* size == 4, i.e. dword */
 	if (where&3) return PCIBIOS_BAD_REGISTER_NUMBER;
-	if (bus != 0) return PCIBIOS_DEVICE_NOT_FOUND;
+	if (busnum != 0) return PCIBIOS_DEVICE_NOT_FOUND;
 	pcic = &pcic0;
 
 	save_and_cli(flags);
-	writel(CONFIG_CMD(bus,devfn,where), pcic->pcic_config_space_addr);
+	writel(CONFIG_CMD(busnum,devfn,where), pcic->pcic_config_space_addr);
 	writel(value, pcic->pcic_config_space_data + (where&4));
 	restore_flags(flags);
 	return PCIBIOS_SUCCESSFUL;
 }
 
 static struct pci_ops pcic_ops = {
-	pcic_read_config_byte,
-	pcic_read_config_word,
-	pcic_read_config_dword,
-	pcic_write_config_byte,
-	pcic_write_config_word,
-	pcic_write_config_dword,
+	.read =		pcic_read_config,
+	.write =	pcic_write_config,
 };
 
 /*
