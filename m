Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265815AbSLSRhn>; Thu, 19 Dec 2002 12:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbSLSRhm>; Thu, 19 Dec 2002 12:37:42 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:14596 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265815AbSLSRhY>;
	Thu, 19 Dec 2002 12:37:24 -0500
Date: Thu, 19 Dec 2002 09:42:36 -0800
From: Greg KH <greg@kroah.com>
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pcibios functions left in m68knommu port
Message-ID: <20021219174236.GE6380@kroah.com>
References: <20021217172107.GA21714@kroah.com> <3DFFC5EA.6010201@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DFFC5EA.6010201@snapgear.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 10:48:42AM +1000, Greg Ungerer wrote:
> Greg KH wrote:
> >I just noticed the arch/m68knommu/kernel/comempci.c file, which contains
> >a lot of pcibios functions that are now removed from the rest of the
> >kernel.  Are these present for any specific reason, or would you be
> >willing to take a patch removing them?
> 
> Happy to take a patch.
> Most of that baggage has been carried through since that support
> was first coded (circa linux-2.0.38).

Great, here's a patch against 2.5.52 that removes the unneeded
functions.  I think you might be able to remove a few of the static
variables in this file now too, but I don't want to break anything, as I
don't have a machine to test this on.

Hm, I think I have a uCsimm around here somewhere...

thanks,

greg k-h


# removed unused pcibios functions from the m68knommu code.

diff -Nru a/arch/m68knommu/kernel/comempci.c b/arch/m68knommu/kernel/comempci.c
--- a/arch/m68knommu/kernel/comempci.c	Thu Dec 19 09:43:11 2002
+++ b/arch/m68knommu/kernel/comempci.c	Thu Dec 19 09:43:11 2002
@@ -338,254 +338,6 @@
 
 /*****************************************************************************/
 
-int pcibios_present(void)
-{
-	return(pci_bus_is_present);
-}
-
-/*****************************************************************************/
-
-int pcibios_read_config_dword(unsigned char bus, unsigned char dev,
-	unsigned char offset, unsigned int *val)
-{
-	volatile unsigned long	*rp;
-	unsigned long		idsel, fnsel;
-
-#ifdef DEBUGPCI
-	printk("pcibios_read_config_dword(bus=%x,dev=%x,offset=%x,val=%x)\n",
-		 bus, dev, offset, val);
-#endif
-
-	if (bus || ((pci_slotmask & (0x1 << PCI_SLOT(dev))) == 0)) {
-		*val = 0xffffffff;
-		return(PCIBIOS_SUCCESSFUL);
-	}
-
-	rp = (volatile unsigned long *) COMEM_BASE;
-	idsel = COMEM_DA_CFGRD | COMEM_DA_ADDR(0x1 << ((dev >> 3) + 16));
-	fnsel = (dev & 0x7) << 8;
-
-	rp[LREG(COMEM_DAHBASE)] = idsel;
-	*val = rp[LREG(COMEM_PCIBUS + (offset & 0xfc) + fnsel)];
-
-#if 1
-	/* If we get back what we wrote, then nothing there */
-	/* This is pretty dodgy, but, hey, what else do we do?? */
-	if (!offset && (*val == ((idsel & 0xfffff000) | (offset & 0x00000fff))))
-		*val = 0xffffffff;
-#endif
-
-	return(PCIBIOS_SUCCESSFUL);
-}
-
-/*****************************************************************************/
-
-int pcibios_read_config_word(unsigned char bus, unsigned char dev,
-	unsigned char offset, unsigned short *val)
-{
-	volatile unsigned long	*rp;
-	volatile unsigned short	*bp;
-	unsigned long		idsel, fnsel;
-	unsigned char		swapoffset;
-
-#ifdef DEBUGPCI
-	printk("pcibios_read_config_word(bus=%x,dev=%x,offset=%x)\n",
-		bus, dev, offset);
-#endif
-
-	if (bus || ((pci_slotmask & (0x1 << PCI_SLOT(dev))) == 0)) {
-		*val = 0xffff;
-		return(PCIBIOS_SUCCESSFUL);
-	}
-
-	rp = (volatile unsigned long *) COMEM_BASE;
-	bp = (volatile unsigned short *) COMEM_BASE;
-	idsel = COMEM_DA_CFGRD | COMEM_DA_ADDR(0x1 << ((dev >> 3) + 16));
-	fnsel = (dev & 0x7) << 8;
-	swapoffset = (offset & 0xfc) + (~offset & 0x02);
-
-	rp[LREG(COMEM_DAHBASE)] = idsel;
-	*val = bp[WREG(COMEM_PCIBUS + swapoffset + fnsel)];
-
-	return(PCIBIOS_SUCCESSFUL);
-}
-
-/*****************************************************************************/
-
-int pcibios_read_config_byte(unsigned char bus, unsigned char dev,
-	unsigned char offset, unsigned char *val)
-{
-	volatile unsigned long	*rp;
-	volatile unsigned char	*bp;
-	unsigned long		idsel, fnsel;
-	unsigned char		swapoffset;
-
-#ifdef DEBUGPCI
-	printk("pcibios_read_config_byte(bus=%x,dev=%x,offset=%x)\n",
-		bus, dev, offset);
-#endif
-
-	if (bus || ((pci_slotmask & (0x1 << PCI_SLOT(dev))) == 0)) {
-		*val = 0xff;
-		return(PCIBIOS_SUCCESSFUL);
-	}
-
-	rp = (volatile unsigned long *) COMEM_BASE;
-	bp = (volatile unsigned char *) COMEM_BASE;
-	idsel = COMEM_DA_CFGRD | COMEM_DA_ADDR(0x1 << ((dev >> 3) + 16));
-	fnsel = (dev & 0x7) << 8;
-	swapoffset = (offset & 0xfc) + (~offset & 0x03);
-
-	rp[LREG(COMEM_DAHBASE)] = idsel;
-	*val = bp[(COMEM_PCIBUS + swapoffset + fnsel)];
-
-	return(PCIBIOS_SUCCESSFUL);
-}
-
-/*****************************************************************************/
-
-int pcibios_write_config_dword(unsigned char bus, unsigned char dev,
-	unsigned char offset, unsigned int val)
-{
-	volatile unsigned long	*rp;
-	unsigned long		idsel, fnsel;
-
-#ifdef DEBUGPCI
-	printk("pcibios_write_config_dword(bus=%x,dev=%x,offset=%x,val=%x)\n",
-		 bus, dev, offset, val);
-#endif
-
-	if (bus || ((pci_slotmask & (0x1 << PCI_SLOT(dev))) == 0))
-		return(PCIBIOS_SUCCESSFUL);
-
-	rp = (volatile unsigned long *) COMEM_BASE;
-	idsel = COMEM_DA_CFGRD | COMEM_DA_ADDR(0x1 << ((dev >> 3) + 16));
-	fnsel = (dev & 0x7) << 8;
-
-	rp[LREG(COMEM_DAHBASE)] = idsel;
-	rp[LREG(COMEM_PCIBUS + (offset & 0xfc) + fnsel)] = val;
-	return(PCIBIOS_SUCCESSFUL);
-}
-
-/*****************************************************************************/
-
-int pcibios_write_config_word(unsigned char bus, unsigned char dev,
-	unsigned char offset, unsigned short val)
-{
-
-	volatile unsigned long	*rp;
-	volatile unsigned short	*bp;
-	unsigned long		idsel, fnsel;
-	unsigned char		swapoffset;
-
-#ifdef DEBUGPCI
-	printk("pcibios_write_config_word(bus=%x,dev=%x,offset=%x,val=%x)\n",
-		 bus, dev, offset, val);
-#endif
-
-	if (bus || ((pci_slotmask & (0x1 << PCI_SLOT(dev))) == 0))
-		return(PCIBIOS_SUCCESSFUL);
-
-	rp = (volatile unsigned long *) COMEM_BASE;
-	bp = (volatile unsigned short *) COMEM_BASE;
-	idsel = COMEM_DA_CFGRD | COMEM_DA_ADDR(0x1 << ((dev >> 3) + 16));
-	fnsel = (dev & 0x7) << 8;
-	swapoffset = (offset & 0xfc) + (~offset & 0x02);
-
-	rp[LREG(COMEM_DAHBASE)] = idsel;
-	bp[WREG(COMEM_PCIBUS + swapoffset + fnsel)] = val;
-	return(PCIBIOS_SUCCESSFUL);
-}
-
-/*****************************************************************************/
-
-int pcibios_write_config_byte(unsigned char bus, unsigned char dev,
-	unsigned char offset, unsigned char val)
-{
-	volatile unsigned long	*rp;
-	volatile unsigned char	*bp;
-	unsigned long		idsel, fnsel;
-	unsigned char		swapoffset;
-
-#ifdef DEBUGPCI
-	printk("pcibios_write_config_byte(bus=%x,dev=%x,offset=%x,val=%x)\n",
-		 bus, dev, offset, val);
-#endif
-
-	if (bus || ((pci_slotmask & (0x1 << PCI_SLOT(dev))) == 0))
-		return(PCIBIOS_SUCCESSFUL);
-
-	rp = (volatile unsigned long *) COMEM_BASE;
-	bp = (volatile unsigned char *) COMEM_BASE;
-	idsel = COMEM_DA_CFGRD | COMEM_DA_ADDR(0x1 << ((dev >> 3) + 16));
-	fnsel = (dev & 0x7) << 8;
-	swapoffset = (offset & 0xfc) + (~offset & 0x03);
-
-	rp[LREG(COMEM_DAHBASE)] = idsel;
-	bp[(COMEM_PCIBUS + swapoffset + fnsel)] = val;
-	return(PCIBIOS_SUCCESSFUL);
-}
-
-/*****************************************************************************/
-
-int pcibios_find_device(unsigned short vendor, unsigned short devid,
-	unsigned short index, unsigned char *bus, unsigned char *dev)
-{
-	unsigned int	vendev, val;
-	unsigned char	devnr;
-
-#ifdef DEBUGPCI
-	printk("pcibios_find_device(vendor=%04x,devid=%04x,index=%d)\n",
-		vendor, devid, index);
-#endif
-
-	if (vendor == 0xffff)
-		return(PCIBIOS_BAD_VENDOR_ID);
-
-	vendev = (devid << 16) | vendor;
-	for (devnr = 0; (devnr < 32); devnr++) {
-		pcibios_read_config_dword(0, devnr, PCI_VENDOR_ID, &val);
-		if (vendev == val) {
-			if (index-- == 0) {
-				*bus = 0;
-				*dev = devnr;
-				return(PCIBIOS_SUCCESSFUL);
-			}
-		}
-	}
-
-	return(PCIBIOS_DEVICE_NOT_FOUND);
-}
-
-/*****************************************************************************/
-
-int pcibios_find_class(unsigned int class, unsigned short index,
-	unsigned char *bus, unsigned char *dev)
-{
-	unsigned int	val;
-	unsigned char	devnr;
-
-#ifdef DEBUGPCI
-	printk("pcibios_find_class(class=%04x,index=%d)\n", class, index);
-#endif
-
-	/* FIXME: this ignores multi-function devices... */
-	for (devnr = 0; (devnr < 128); devnr += 8) {
-		pcibios_read_config_dword(0, devnr, PCI_CLASS_REVISION, &val);
-		if ((val >> 8) == class) {
-			if (index-- == 0) {
-				*bus = 0;
-				*dev = devnr;
-				return(PCIBIOS_SUCCESSFUL);
-			}
-		}
-	}
-
-	return(PCIBIOS_DEVICE_NOT_FOUND);
-}
-
-/*****************************************************************************/
-
 /*
  *	Local routines to interrcept the standard I/O and vector handling
  *	code. Don't include this 'till now - initialization code above needs
