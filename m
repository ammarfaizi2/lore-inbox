Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbUCJIfj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 03:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbUCJIfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 03:35:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15007 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262258AbUCJIfY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 03:35:24 -0500
Message-ID: <404ED33D.3070504@pobox.com>
Date: Wed, 10 Mar 2004 03:35:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Smart, James" <James.Smart@Emulex.com>
CC: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [Announce] Emulex LightPulse Device Driver
References: <3356669BBE90C448AD4645C843E2BF2802C014D7@xbl.ma.emulex.com>
In-Reply-To: <3356669BBE90C448AD4645C843E2BF2802C014D7@xbl.ma.emulex.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Smart, James wrote:
> All,
> 
> Emulex is embarking on an effort to open source the driver for its
> LightPulse Fibre Channel Adapter family. This effort will migrate Emulex's
> current code base to a driver centric to the Linux 2.6 kernel, with the goal
> to eventually gain inclusion in the base Linux kernel.
> 
> A new project has been created on SourceForge to host this effort - see
> http://sourceforge.net/projects/lpfcxxxx/ . Further information, such as the
> lastest FAQ, can be found on the project site.
> 
> We realize that this will be a significant effort for Emulex. We welcome any
> feedback that the community can provide us.

Embark you shall, and let me join in the chorus of kudos for making the 
leap to open source.  :)

I'm only part way through a review of the driver, but I felt there is a 
rather large and important issue that needs addressing...  "wrappers." 
These are a common tool for many hardware vendors, which allow one to 
more easily port a kernel driver across operating systems. 
Unfortunately, these sorts of abstractions continually lead to bugs.  In 
particular, the areas of locking, memory management, and PCI bus 
interaction are often most negatively affected.

In particular, here is an example of such a bug:

void
elx_sli_lock(elxHBA_t * phba, unsigned long *iflag)
{

         unsigned long flag;
         LINUX_HBA_t *lhba;

         flag = 0;
         lhba = (LINUX_HBA_t *) phba->pHbaOSEnv;
         spin_lock_irqsave(&lhba->slilock.elx_lock, flag);
         *iflag = flag;
         return;
}

It is not portable for code to return the value stored in the 'flags' 
argument of spin_lock_irqsave.  The usage _must_ be inlined.  This fails 
on, e.g., sparc64's register windows.

But this bug is only an example that serves to highlight the importance 
of directly using Linux API functions throughout your code.  It may 
sound redundant, but "Linux code should look like Linux code."  This 
emphasis on style may sound trivial, but it's important for 
review-ability, long term maintenance, and as we see here, bug prevention.

It may not be immediately apparent, but elimination of these wrappers 
also increases performance.  Many of the Linux API functions are inlined 
in key areas, intentionally, to improve performance.  By further 
wrapping these functions in non-inline functions of your own, you 
eliminate several compiler optimization opportunties.  In the case of 
spinlocks (above), you violate the API.

So I would like to see a slow unwinding, and elimination, of several of 
the wrappers in prod_linux.c.

1) elx_kmem_alloc, elx_kmem_free:  directly use kmalloc(size, 
GFP_KERNEL/ATOMIC) in the driver code.

2) eliminate all *_init_lock, *_lock, and *_unlock wrappers, and 
directly call the Linux spinlock primitives throughout your code.

3) strongly consider eliminating elx_read_pci_cmd, elx_read_pci, and 
simply calling the Linux PCI API directly from the lpfc driver code.

4) eliminate elx_sli_write_pci_cmd hook, elx_write_pci_cmd wrapper, and 
directly call the Linux PCI API in the code.

5) eliminate elx_remap_pci_mem, elx_unmap_pci_mem

6) fix unacceptably long delay in elx_sli_brdreset().  udelay() and 
mdelay() functions are meant for very small delays, since they do not 
reschedule.  Delays such as
         if (skip_post) {
                 mdelay(100);
         } else {
                 mdelay(2000);
         }
should be converted to timers or (if in kernel thread context) 
schedule_timeout().

7) eliminate elx_sli_pcimem_bcopy(,,sizeof(uint32_t)) in favor of "u32 
foo = readl()"

8) replace code such as
        ((SLI2_SLIM_t *) phba->slim2p.virt)->un.slim.pcb.hgpAddrHigh =
   (uint32_t) (psli->sliinit.elx_sli_read_pci) (phba, PCI_BAR_1_REGISTER);
   Laddr = (psli->sliinit.elx_sli_read_pci) (phba, PCI_BAR_0_REGISTER);
   Laddr &= ~0x4;
with calls to pci_resource_start() and/or pci_resource_len()

9) call pci_set_master() when you wish to enable PCI busmastering.  This 
will set the busmaster bit in PCI_COMMAND for you, as well as set up the 
PCI latency timer.

10) call pci_dma_sync functions rather than elx_pci_dma_sync()

That should get you started ;-)

	Jeff



