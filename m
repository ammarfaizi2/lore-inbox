Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263920AbUDPWyd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263931AbUDPWyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:54:25 -0400
Received: from mail0.lsil.com ([147.145.40.20]:10982 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S263920AbUDPWwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 18:52:12 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57033BC543@exa-atlanta.se.lsil.com>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'Jeff Garzik'" <jgarzik@pobox.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'Christoph Hellwig'" <hch@infradead.org>
Cc: "'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>,
       "'paul@kungfoocoder.org'" <paul@kungfoocoder.org>,
       "Mukker, Atul" <Atulm@lsil.com>,
       "'James.Bottomley@SteelEye.com'" <James.Bottomley@SteelEye.com>,
       "'arjanv@redhat.com'" <arjanv@redhat.com>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][RELEASE]: megaraid unified driver version 2.20.0.B1
Date: Fri, 16 Apr 2004 18:50:48 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 0) Am I to judge from megaraid_mbox_build_cmd that megaraid does not 
> really support SCSI, but it translates instead?  This may imply that 
> implementation as a SCSI driver is inappropriate.

MegaRAID is a very SCSI stack :-)

> 
> 
> 1) Remove back-compat code from kdep.h.  It's OK for devel and for 
> vendor-specific branch, but we wouldn't want this in 2.6.x mainline.

The 2.4 portion of the code has a very small footprint in the driver. Thanks
to earlier inputs from Christoph Hellwig, it will be even smaller.
Maintaining single code for lk 2.4 and 2.6 makes very sense from logistics
and maintenance point of view. lk 2.4 is still very popular :-) and we would
like to provide support for the same with the latest drivers as well. 

> 
> 
> 2) Buggy ADDR definitions:
> 
> +#define ADDR_LO(addr)  (((unsigned long)(addr)) & 0xffffffff)
> +#define ADDR_HI(addr)  ((((ulong)(addr)) & 
> 0xffffffff00000000ULL) >> 32)
> +#define ADDR_64(hi, lo)        ((((uint64_t)(hi)) << 32) | (lo))
> 
> Don't cast to unsigned long, cast to u64.
This will be removed, it is not used in the driver anyway

> 
> 
> 3) Delete non-standard types:  ulong
ok

> 
> 
> 5) No foo_t structures.  Linux kernel style is "struct foo" 
> not "foo_t":
> 
> +typedef struct mraid_hba_info {
> +} __attribute__ ((packed)) mraid_hba_info_t;
> +
> +typedef struct mcontroller {
> +} __attribute__ ((packed)) mcontroller_t;
We also prefer to have "struct foo" mostly. But this should not be a rule.
E.g., having adapter_t instead of "struct adapter" is very convenient,
simply because it used so widely throughout the driver. But point taken :-)

> 
> 
> 6) Kill uses of "volatile".  _Most_ of the time, this indicates buggy 
> code.  You should have the proper barriers in place:  mb(), wmb(), 
> rmb(), barrier(), and cpu_relax().  This has been mentioned before :)
We have carefully used "volatile" only on the fields, which are touch by the
hardware and/or firmware. The proper barriers are used when we want to make
sure access is properly sequenced.

> 
> 
> 7) Allow me to compliment you on proper kernel-doc documentation.
> 
Thanks!

> 
> 8) Consider adding ____cacheline_aligned markers to the definition of 
> struct adapter (a.k.a. adapter_t, before item #5 is fixed).  
> Re-arrange 
> your adapter structure so that struct members that are used 
> together are 
> kept in the same cacheline.  For example, in net drivers, I usually 
> split the structures into "TX", "RX", and "everything else" sections. 
> Keep in mind that cacheline size varies (32/64/128 usually), 
> so this is 
> not an absolute limit, just a marker where to physically 
> separate into 
> distinct cachelines.
ok

> 
> 
> 9) {SET,IS}_PRV_INTF_AVAILABLE's use of atomic_foo() seems racy.
> 
This is not necessary and will be removed.


> 
> 10) In 2.6, use the type-safe module_param() rather than MODULE_PARM()
> 
We will explore and reply

> 
> 11) Why is PAGE_SIZE chosen here?
> 
> +       /*
> +        * Allocate all pages in a loop
> +        */
> +       for (i = 0; i < num_pages; i++) {
> +
> +               pool->page_arr[i] = pci_alloc_consistent( 
> dev, PAGE_SIZE-1,
> + 
> &pool->dmah_arr[i] );
> +               if (pool->page_arr[i] == NULL) {
> +                       con_log(CL_ANN, (KERN_WARNING
> +                               "megaraid: Failed to alloc 
> page # %d\n", 
> i ));
> +                       goto memlib_fail_alloc;
> +               }
> +       }
> 
This API will only be used by low level drivers which require multiple small
chunks of DMAable memory. This chunk are assumed to be much smaller than a
PAGE therefore many can fit in a single PAGE. Driver portions requiring
bigger buffers (>4KB) use pci_alloc_consistent directly.

> 
> 12) Don't invent your own printk() wrappers.  I don't see the 
> need for 
> con_log()
Actually we do, since the debug level can be changed on the fly using ioctl
and sysfs

> 
> 
> 13) try_assertion{}, catch_assertion{}, and end_assertion attempt to 
> turn C code into C++ code.  This will inevitably fail :)
We see it as better error handling. It would be very useful specially when
we move to more fine-grained locks in the drivers.

> 
> 
> 14) the following check doesn't scale, please remove:
> 
> +       if (subsysvid && (subsysvid != PCI_VENDOR_ID_AMI) &&
> +                       (subsysvid != PCI_VENDOR_ID_DELL) &&
> +                       (subsysvid != PCI_VENDOR_ID_HP) &&
> +                       (subsysvid != PCI_VENDOR_ID_INTEL) &&
> +                       (subsysvid != PCI_SUBSYS_ID_FSC) &&
> +                       (subsysvid != PCI_VENDOR_ID_LSI_LOGIC)) {
> +
> +               con_log(CL_ANN, (KERN_WARNING
> +                       "megaraid: not loading for 
> subsysvid:%#4.04x\n",
> +                       subsysvid));
> +
> +               return -ENODEV;
> +       }
> 
Please elaborate. We simply want to make sure the pci vendor, device and
subsystem ID are appropriate before loading the driver. 

> 
> 15) Don't set a DMA mask, then change it.  in 
> megaraid_probe_one() you 
> have enough info to decide whether 64-bit can be supported.
> 
> 
ok

> 16) Use normal Linux kernel style to handle errors.  Don't duplicate
> +               kfree(adapter);
> +
> +               pci_disable_device(pdev);
> 
> in multiple error handling paths.
ok

> 
> 
> 17) Eliminate MAX_CONTROLLERS.  There is no reason for this limit. 
> Global structures such as mraid_driver_g are generally not needed.
We need it, since management module and applications need to see a global
picture of all adapters in the system

> 
> 
> 18) Use pci_request_regions() in megaraid_probe_one(), rather than 
> request_region or request_mem_region.  To free, you use 
> pci_release_regions().
ok

> 
> 
> 19) When hardware is malfunctioning or removed, the following 
> code turns 
> into an infinite loop:
> 
> +               // FIXME: this may not be required
> +               while (RDINDOOR(raid_dev) & 0x02) cpu_relax();
Is there is bette way to do it. If there is, please suggest - we will
definitely us it. In fact, this is not the only such loop in the ISR - there
are two more.

> 
> 
> 20) You don't need spin_lock_irqsave() in interrupt handler, only 
> spin_lock()
ok

> 
> 
> 21) VERY unfriendly to shared interrupts.  
> megaraid_iombox_ack_sequence 
> MUST check immediately for
> 	(a) no irq at all (shared interrupt)
> 	(b) status return of 0xffffffff (hardware is 
> malfunctioning/unplugged)
This is for EOL controllers. We are planning to phase out this portion.

> 
> 
> 22) MAJOR bug:  sleep inside spinlock.  The SCSI error 
> handler calls its 
> error handling hooks with the adapter lock held.  You cannot yield() 
> inside mbox_post_sync_cmd
> 
> 
> 23) Alongside #22, the following code is unacceptable:
> 
> +               // wait for maximum 1 second for status to post
> +               for (i = 0; i < 40000; i++) {
> +                       if (mbox->numstatus != 0xFF) break;
> +                       udelay(25); yield();
> +               }
> 
> Besides yield(), the maximum delay with spinlock held is far too long.
> 
> 
> 24) Same issues as #22 and #23 in __megaraid_busywait_mbox: 
> unacceptable delay inside spinlock, and schedule inside spinlock:
> 
> +       for (counter = 0; counter < 10000; counter++) {
> +
> +               if (!mbox->busy) return MRAID_SUCCESS;
> +
> +               udelay(100); yield();
> +       }
> 

Very good point! We would fix in the next drop.

> 
> 
> 25) sleep_on_timeout() is deprecated and should not be used:
> 
> +       while (adp->outstanding_cmds > 0)
> +               sleep_on_timeout( &wq, 1*HZ );
> 
What is the recommended way to do it?

> 
> 
> 26) General question:  do you ever call down() inside a 
> spinlock?  I did 
> not look closely, but I think you do.  That would be wrong, as down() 
> can sleep.
That should not happen since down() is only done in ioctl() through
management module. Will double check though.

> 
> 
> 27) drivers/scsi/megaraid/readme belongs in the 
> Documentation/ directory
ok
