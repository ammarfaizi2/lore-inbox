Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbRCZUcX>; Mon, 26 Mar 2001 15:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129134AbRCZUcO>; Mon, 26 Mar 2001 15:32:14 -0500
Received: from NS.CenSoft.COM ([208.219.23.2]:60423 "EHLO
	ns.centurysoftware.com") by vger.kernel.org with ESMTP
	id <S129078AbRCZUb7>; Mon, 26 Mar 2001 15:31:59 -0500
Message-ID: <3ABFA772.2E29A559@censoft.com>
Date: Mon, 26 Mar 2001 13:32:50 -0700
From: Jordan Crouse <jordanc@Censoft.com>
Organization: Century Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCI lockup with multiple VGA cards
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC back to me, as I am not subscribed to the list (but I soon
will be!)

I am writing a new framebuffer driver for a PCI based Chips and
Technologies 69000 HiQVideo chipset in the 2.4.2 code base on an i386
machine.  (They are custom cards, but they use the standard BIOS and
setup provided by the vendor).  One of the requirements is that I
provide support for multiple cards.  I am having no problems at all with
the first card.  It gets probed correctly, all the framebuffer and
register memory gets allocated and remapped fine, and eventually Tux
pops up on the screen.  

Now, when the second card is probed, it locates and ioremap()s the
framebuffer and registers correctly, and I can even read and write to
the MMIO mapped registers, but
when I try to access the framebuffer memory, the system locks up.  I
have a LED attached to the chip to show access, and it is lit indicating
that the problem occurred while the chip was being accessed.  I
eliminated the possibility of bad hardware by using both cards
individually without problems.  My best guess is that this may be a PCI
problem, but that's only a shot in the dark.  

Looking back in the archives, I saw several old references to the
possibility that multiple PCI VGA cards could lock up under certain
circumstances.  I am wondering if I am seeing these problems in action. 
I would definitely like some guidance from somebody who may have been
down this road before, and can provide much needed insight.

My general system setup is as follows:

I have a i386 machine (Pentium II) with nothing unusual attached (except
for the two custom CT69000 cards).  The kernel is 2.4.2-ac25 not running
SMP.  I switched the PCI mode to "direct" to avoid having the BIOS get
involved.  Plug and play is not enabled.  

The two cards are being setup identically, except that the "primary"
card (the one that the BIOS discovered and is using for text output),
has IO enabled, where as the 
second one does not (giving the second one IO access has no effect on
the problem).  PCI burst write is turned on, and both cards do not have
access to the BIOS ROM.  I have tried both remapping the memory as
cached and uncached, and I have also tried using MTRR, all with no
results.
 
Attached is the PCI probe function.  The lockup will occur sometime
between when I write to the memory and when I read it back (sometimes
the write succeeds, and sometimes it doesn't.  The read never works).  

If anyone has any other questions, or wants a copy of the driver, I will
be happy to oblige (it is still not quite ready for prime time, as one
can tell by my blatant lack of K&R indentation, but I am happy to
provide it to one and all).  Thank you all for your help.

Jordan

------------------------

static int __init chips69000_probe(struct pci_dev *pdev, const struct
pci_device_id *dummy)
{
  int i;

  unsigned char *testaddr;

  unsigned long fb_size = (2 * 1024 * 1024);  /* 2 MB */  
  unsigned long blit_reg_size = 0x40;
  unsigned long blit_data_size = 0x20000;
  unsigned long io_reg_size = 0xAF;

  unsigned long addr;

  u_int32_t cmd;
  u_int32_t val;

  u_int16_t wval;
  int bval;

  struct fb_info_chips *fbinfo;
  
  /* First of all, verify that the card is really ours */
  pci_read_config_word(pdev, 0x00, &wval);

  if (wval != 0x102C) 
    {
      printk(KERN_ERR "Card in slot %s is not a C&T device!\n",
pdev->name);
      return(-1);
    }
  
  pci_read_config_word(pdev, 0x02, &wval);
  
  if (wval != 0x00C0) 
    {
      printk(KERN_ERR "Card in slot %s is not a C&T 69000 device!\n",
pdev->name);
      return(-1);
    }

  printk(KERN_INFO "69000: Found a %s in slot %s\n", pdev->name,
pdev->slot_name);
  
  /* And try to enable to the device */
  if (pci_enable_device(pdev)) 
    {
      printk(KERN_ERR "69000: Doh!  unable to enable the device\n");
      return(-1);
    }

  /* Good to go.  Now, allocate new memory to hold the device info */
  fbinfo = (struct fb_info_chips *) kmalloc(sizeof(*fbinfo),
GFP_KERNEL);
  
  if (!fbinfo) 
    {
      printk(KERN_ERR "69000:  Doh! Unable to access memory!\n");
      return(-1);
    }

  memset(fbinfo, 0, sizeof(*fbinfo));
  
  /* Now set up enough info for the acutal driver to get moving */

  fbinfo->pcidev = pdev;
  pdev->driver_data = fbinfo;
   
  /* Get the address of resource 0 */
  addr = pci_resource_start(fbinfo->pcidev, 0);
   
  printk(KERN_INFO "69000:  Discovered %x bytes of memory at %x\n",
pci_resource_len(fbinfo->pcidev, 0),
	addr);

  if (!request_mem_region(addr, pci_resource_len(fbinfo->pcidev, 0),
"chips69000 driver")) 
    {
      printk(KERN_ERR "69000:  Unable to request the appropriate driver
memory at %x (size %x)\n",
	     (unsigned long) addr, pci_resource_len(fbinfo->pcidev, 0));
      return(-1);
    }
  
  printk(KERN_INFO "69000:  Successfully allocated %dK bytes of memory
at %x\n",
	 pci_resource_len(fbinfo->pcidev, 0) / 1024, addr);

  /* Now start mapping those sections that we need */

  fbinfo->frame_buffer_phys = addr;
  printk(KERN_INFO "69000:  Discovered framebuffer at %x\n",
fbinfo->frame_buffer_phys);
  fbinfo->frame_buffer = (char *) ioremap(addr, fb_size); 

#ifdef CONFIG_MTRR
  bval = fbinfo->mtrr_vram = mtrr_add(fbinfo->frame_buffer_phys,
fb_size, MTRR_TYPE_WRCOMB, 1);

  if (bval) printk(KERN_ERR "MTRR returned %d\n", bval);
#endif

  printk(KERN_INFO "69000:  Framebuffer iomapped to %x\n", (unsigned
long) fbinfo->frame_buffer);

  /* Do a quick test of the memory */
  /* LOCKUP OCCURS HERE */

  fb_writew(0x5555, fbinfo->frame_buffer);

  printk(KERN_INFO "69000:  FB Memory write success!\n");
  
  wval = fb_readw(fbinfo->frame_buffer);
  
  if (wval != 0x5555) printk(KERN_INFO "69000:  FB Memory read
failed!\n");
  else printk(KERN_INFO "69000:  FB Memory read success!\n");

  /* the MMIO base starts at 0x400700 */

  fbinfo->io_base_phys = addr + 0x400760;   
  printk(KERN_INFO "69000:  Discovered iobase at %x\n",
fbinfo->io_base_phys);

  fbinfo->io_base = (__u32 *) ioremap_nocache(fbinfo->io_base_phys,
io_reg_size);
 
  printk(KERN_INFO "69000: iobase iomapped to %x\n", (unsigned long)
fbinfo->io_base);

  /* Now call the graphics setup routine */
  init_chips(fbinfo);

  return(0);
}
