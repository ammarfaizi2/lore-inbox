Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <153986-5740>; Sun, 15 Nov 1998 03:31:13 -0500
Received: from post-20.mail.demon.net ([194.217.242.27]:55043 "EHLO post.mail.demon.net" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154076-5740>; Sun, 15 Nov 1998 03:30:41 -0500
Message-ID: <19981115085947.B1316@tantalophile.demon.co.uk>
Date: Sun, 15 Nov 1998 08:59:47 +0000
From: Jamie Lokier <lkd@tantalophile.demon.co.uk>
To: linux-kernel@vger.rutgers.edu
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: virt_to_bus and >1G of memory (was MAX_DMA_ADDRESS ...)
References: <199811131032.CAA14582@dm.cobaltmicro.com> <19981113062952.A1449@tantalophile.demon.co.uk> <199811131032.CAA14582@dm.cobaltmicro.com> <19981113124717.A721@tantalophile.demon.co.uk> <199811131625.LAA11646@mercury.mv.net> <19981113182850.A754@tantalophile.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <19981113182850.A754@tantalophile.demon.co.uk>; from Jamie Lokier on Fri, Nov 13, 1998 at 06:28:50PM +0000
Sender: owner-linux-kernel@vger.rutgers.edu

On Fri, Nov 13, 1998 at 11:26:41AM -0500, Jeff Millar wrote:
> What's the best way to deal with a BIOS that assigns PCI addresses that 
> differ from the kernel's assumptions? The i386 io.h and page.h files appear 
> to make a hard coded assumptions about the location of non-prefetchable 
> memory.

I don't see anything in those files to do with non-prefetchable memory.
PAGE_OFFSET is a kernel virtual address thing only.

> The Ziatech board puts non-prefetchable memory including ethernet, SCSI, and 
> our special frame buffer device at 0x40000000 and up. But all the other 
> Linux systems we looked at put non-prefetchable devices at 0xFxxxxxx.
> We need to load the PCI bus address of our custom frame buffer device into 
> the video DMA engine of a BT-848 video decoder. But we ran into trouble 
> with page.h...

> The problem comes when we go to program the frame buffer address via BTTV. 
> We had to modify the code to not muck around with the high bits. Right now 
> the code explicitly tests for certain address ranges and programs the BT848 
> accordingly. But that doesn't make it work if another weird BIOS shows up.
> What's the right way to solve this problem?

To access MMIO memory from kernel C code, you need to use ioremap() when
you initialise the driver to get an address you can use, and iounmap()
when you unload the driver.  It is the PCI *bus* address that you pass
as argument to ioremap().

To pass the MMIO address of one device to another, simply pass the *bus*
address directly from one device to another.  Your problem is how to get
the bus address from a user-space mapping.

On a related note, you can pass kmalloc() returned addresses to a device
using virt_to_bus(), but in a bitter ironic twist, you can't pass
ioremap() returned addresses in this way.

> I have to admit that we don't really understand the kernel memory system all
> that well.  Alan Cox replied to this by suggesting that we use physical bus
> addresses...presumably by reading the address of the frame buffer as stored
> in the PCI base address registers and copying it to the VIDMEM parameter of
> BTTV.  

Yes, that's exactly what I'd suggest.

> We can do that but we think we prefer to map the frame buffer address
> into user space via mmap for use by applications and then convert a user
> space address back to physical to programming the bttv.
[There are some other problems in bttv.c too, notably a security problem
with mappings not getting cleaned up on error]

Your method certainly sounds like a friendly interface, ideal for video
to video applications.

But this is where you're getting into trouble.  mmaping the frame buffer
into user space is fine, but converting a generic user space address
back to a bus address is dubious.  There's code in bttv.c, but...  aha.
I see the problem now.

The problem is pte_page returning a kernel direct-mapped virtual address
(clear? :-).  But the pte actually points to an MMIO physical address,
which isn't a valid direct-mapped virtual address.  Yucky.

A little further, it seems there is no architecture-independent way to
translate the physical address in a pte to a bus address.  Nor is there
any way to get the physical address without it becoming a "virt" address.

Of course for a specific platform like x86 it can be hacked, but...
this whole area is messy.

> Hopefully this comment helps you with your driver.  If you have any suggests
> about how we can deal with this please feel free to comment.

You need to fix uvirt_to_bus in bttv.c, it's currently broken by design
for MMIO mapped regions.  You can hack it for x86 by extracting the
physical address directly and using it as a bus address.  Why don't you
try this completely untested patch I just wrote out by hand?

------begin-----------
--- linux/drivers/char/bttv.c
+++ linux/drivers/char/bttv.c
@@ -116,19 +116,27 @@
 static inline unsigned long uvirt_to_phys(unsigned long adr)
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *ptep, pte;
   
 	pgd = pgd_offset(current->mm, adr);
 	if (pgd_none(*pgd))
 		return 0;
 	pmd = pmd_offset(pgd, adr);
 	if (pmd_none(*pmd))
 		return 0;
 	ptep = pte_offset(pmd, adr/*&(~PGDIR_MASK)*/);
 	pte = *ptep;
 	if(pte_present(pte))
 		return 
+#ifdef __i386__
+		  __pa((void *)(pte_page(pte)|(adr&(PAGE_SIZE-1))));
+#else
 		  virt_to_phys((void *)(pte_page(pte)|(adr&(PAGE_SIZE-1))));
+#endif
 	return 0;
 }
 
 static inline unsigned long uvirt_to_bus(unsigned long adr) 
 {
+#ifdef __i386__
+	return uvirt_to_phys(adr);
+#else
 	return virt_to_bus(phys_to_virt(uvirt_to_phys(adr)));
+#endif
 }
---------end-----------

Or you can wait for my userdma.c driver which will try to tackle it.
Though this particular problem will only be solved by a hack, i386 only.

Thanks very much Jeff, I hadn't noticed this problem until now.

-- Jamie

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
