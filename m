Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUDPSBl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 14:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbUDPSBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 14:01:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34987 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261875AbUDPSBU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 14:01:20 -0400
Message-ID: <40801F5D.7030100@pobox.com>
Date: Fri, 16 Apr 2004 14:01:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
CC: "'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>,
       "'paul@kungfoocoder.org'" <paul@kungfoocoder.org>,
       "Mukker, Atul" <Atulm@lsil.com>,
       "'James.Bottomley@SteelEye.com'" <James.Bottomley@SteelEye.com>,
       "'arjanv@redhat.com'" <arjanv@redhat.com>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RELEASE]: megaraid unified driver version 2.20.0.B1
References: <0E3FA95632D6D047BA649F95DAB60E570230C7DB@exa-atlanta.se.lsil.com>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230C7DB@exa-atlanta.se.lsil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks much for attaching the patch to your email, that makes review a 
lot easier.

Comments:

0) Am I to judge from megaraid_mbox_build_cmd that megaraid does not 
really support SCSI, but it translates instead?  This may imply that 
implementation as a SCSI driver is inappropriate.


1) Remove back-compat code from kdep.h.  It's OK for devel and for 
vendor-specific branch, but we wouldn't want this in 2.6.x mainline.


2) Buggy ADDR definitions:

+#define ADDR_LO(addr)  (((unsigned long)(addr)) & 0xffffffff)
+#define ADDR_HI(addr)  ((((ulong)(addr)) & 0xffffffff00000000ULL) >> 32)
+#define ADDR_64(hi, lo)        ((((uint64_t)(hi)) << 32) | (lo))

Don't cast to unsigned long, cast to u64.


3) Delete non-standard types:  ulong


4) For kernel-internal code, prefer types u8/u16/u32/u64 to C99 types, 
though it's not a big deal.  Mainly, prefer consistency.


5) No foo_t structures.  Linux kernel style is "struct foo" not "foo_t":

+typedef struct mraid_hba_info {
+} __attribute__ ((packed)) mraid_hba_info_t;
+
+typedef struct mcontroller {
+} __attribute__ ((packed)) mcontroller_t;


6) Kill uses of "volatile".  _Most_ of the time, this indicates buggy 
code.  You should have the proper barriers in place:  mb(), wmb(), 
rmb(), barrier(), and cpu_relax().  This has been mentioned before :)


7) Allow me to compliment you on proper kernel-doc documentation.


8) Consider adding ____cacheline_aligned markers to the definition of 
struct adapter (a.k.a. adapter_t, before item #5 is fixed).  Re-arrange 
your adapter structure so that struct members that are used together are 
kept in the same cacheline.  For example, in net drivers, I usually 
split the structures into "TX", "RX", and "everything else" sections. 
Keep in mind that cacheline size varies (32/64/128 usually), so this is 
not an absolute limit, just a marker where to physically separate into 
distinct cachelines.


9) {SET,IS}_PRV_INTF_AVAILABLE's use of atomic_foo() seems racy.


10) In 2.6, use the type-safe module_param() rather than MODULE_PARM()


11) Why is PAGE_SIZE chosen here?

+       /*
+        * Allocate all pages in a loop
+        */
+       for (i = 0; i < num_pages; i++) {
+
+               pool->page_arr[i] = pci_alloc_consistent( dev, PAGE_SIZE-1,
+ 
&pool->dmah_arr[i] );
+               if (pool->page_arr[i] == NULL) {
+                       con_log(CL_ANN, (KERN_WARNING
+                               "megaraid: Failed to alloc page # %d\n", 
i ));
+                       goto memlib_fail_alloc;
+               }
+       }


12) Don't invent your own printk() wrappers.  I don't see the need for 
con_log()


13) try_assertion{}, catch_assertion{}, and end_assertion attempt to 
turn C code into C++ code.  This will inevitably fail :)


14) the following check doesn't scale, please remove:

+       if (subsysvid && (subsysvid != PCI_VENDOR_ID_AMI) &&
+                       (subsysvid != PCI_VENDOR_ID_DELL) &&
+                       (subsysvid != PCI_VENDOR_ID_HP) &&
+                       (subsysvid != PCI_VENDOR_ID_INTEL) &&
+                       (subsysvid != PCI_SUBSYS_ID_FSC) &&
+                       (subsysvid != PCI_VENDOR_ID_LSI_LOGIC)) {
+
+               con_log(CL_ANN, (KERN_WARNING
+                       "megaraid: not loading for subsysvid:%#4.04x\n",
+                       subsysvid));
+
+               return -ENODEV;
+       }


15) Don't set a DMA mask, then change it.  in megaraid_probe_one() you 
have enough info to decide whether 64-bit can be supported.


16) Use normal Linux kernel style to handle errors.  Don't duplicate
+               kfree(adapter);
+
+               pci_disable_device(pdev);

in multiple error handling paths.


17) Eliminate MAX_CONTROLLERS.  There is no reason for this limit. 
Global structures such as mraid_driver_g are generally not needed.


18) Use pci_request_regions() in megaraid_probe_one(), rather than 
request_region or request_mem_region.  To free, you use 
pci_release_regions().


19) When hardware is malfunctioning or removed, the following code turns 
into an infinite loop:

+               // FIXME: this may not be required
+               while (RDINDOOR(raid_dev) & 0x02) cpu_relax();


20) You don't need spin_lock_irqsave() in interrupt handler, only 
spin_lock()


21) VERY unfriendly to shared interrupts.  megaraid_iombox_ack_sequence 
MUST check immediately for
	(a) no irq at all (shared interrupt)
	(b) status return of 0xffffffff (hardware is malfunctioning/unplugged)


22) MAJOR bug:  sleep inside spinlock.  The SCSI error handler calls its 
error handling hooks with the adapter lock held.  You cannot yield() 
inside mbox_post_sync_cmd


23) Alongside #22, the following code is unacceptable:

+               // wait for maximum 1 second for status to post
+               for (i = 0; i < 40000; i++) {
+                       if (mbox->numstatus != 0xFF) break;
+                       udelay(25); yield();
+               }

Besides yield(), the maximum delay with spinlock held is far too long.


24) Same issues as #22 and #23 in __megaraid_busywait_mbox: 
unacceptable delay inside spinlock, and schedule inside spinlock:

+       for (counter = 0; counter < 10000; counter++) {
+
+               if (!mbox->busy) return MRAID_SUCCESS;
+
+               udelay(100); yield();
+       }



25) sleep_on_timeout() is deprecated and should not be used:

+       while (adp->outstanding_cmds > 0)
+               sleep_on_timeout( &wq, 1*HZ );



26) General question:  do you ever call down() inside a spinlock?  I did 
not look closely, but I think you do.  That would be wrong, as down() 
can sleep.


27) drivers/scsi/megaraid/readme belongs in the Documentation/ directory




