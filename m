Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263683AbUDQGlt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 02:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263689AbUDQGlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 02:41:49 -0400
Received: from mail0.lsil.com ([147.145.40.20]:19871 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S263683AbUDQGl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 02:41:26 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57033BC544@exa-atlanta.se.lsil.com>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'Jeff Garzik'" <jgarzik@pobox.com>, "Mukker, Atul" <Atulm@lsil.com>
Cc: "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>,
       "'paul@kungfoocoder.org'" <paul@kungfoocoder.org>,
       "'James.Bottomley@SteelEye.com'" <James.Bottomley@SteelEye.com>,
       "'arjanv@redhat.com'" <arjanv@redhat.com>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][RELEASE]: megaraid unified driver version 2.20.0.B1
Date: Sat, 17 Apr 2004 02:40:36 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>0) Am I to judge from megaraid_mbox_build_cmd that megaraid 
> does not 
> >>really support SCSI, but it translates instead?  This may 
> imply that 
> >>implementation as a SCSI driver is inappropriate.
> > 
> > 
> > MegaRAID is a very SCSI stack :-)
> 
> Well, the stack is irrelevant -- if you are not pushing real 
> SCSI CDBs 
> to the RAID arrays, then it is not terribly appropriate as a 
> SCSI driver.
> 
> We must distinguish use of Linux SCSI for driver API, from 
> use of Linux 
> SCSI for communicating with SCSI devices.
> 
> This is more of a Linux 2.7.x issue, since I don't expect LSI 
> to rewrite 
> the driver again as a block driver, at the moment :)

In fact, we have contemplated about moving the driver up in the block layer,
and there might be such a driver in near future. But it is not right to say
that driver does not handle native SCSI packets. In addition to the logical
drives - which have special packets, the driver has a passthru interface for
non disk SCSI device and even SCSI disk for certain RAID+SCSI combinations.
The reasons we have not yet published drivers with block interface are:
(a) - Driver would have two personalities - block interface for logical disk
drives and SCSI for non-disk devices
(b) - Certain SCSI commands are indeed valid for logical drives, e.g., to
setup the clustering with shared storage - driver should get SCSI RESERVE,
RELEASE, RESET for logical drives.

> 
> 
> >>1) Remove back-compat code from kdep.h.  It's OK for devel and for 
> >>vendor-specific branch, but we wouldn't want this in 2.6.x mainline.
> > 
> > 
> > The 2.4 portion of the code has a very small footprint in 
> the driver. Thanks
> > to earlier inputs from Christoph Hellwig, it will be even smaller.
> > Maintaining single code for lk 2.4 and 2.6 makes very sense 
> from logistics
> > and maintenance point of view. lk 2.4 is still very popular 
> :-) and we would
> > like to provide support for the same with the latest 
> drivers as well. 
> 
> I certainly agree that 2.4 maintenance will be required for 
> quite some 
> time.  My employer (Red Hat) has a maintenance lifetime of ~5 
> years or 
> more for its 2.4.x-based products.
> 
> The suggested direction, however is not to include back-compat in the 
> upstream kernel tree.  This leads to unnecessary levels of 
> indirection 
> in the upstream tree, which makes it more difficult for reviewers to 
> understand.
> 
> You _have_ done a good job of minimizing the 2.4/2.6 
> differences, but I 
> still feel it is preferable to leave these out of the 2.6 
> tree.  I have 
> done the same thing with my SATA driver (libata), which has several 
> differences
> 
> In particular, I feel that attempting to make the differences between 
> 2.4 and 2.6 SCSI layer probing is a big mistake.  2.6 SCSI 
> layer is far 
> more hotplug-friendly than 2.4, and supporting both in the 
> same source 
> base puts unreasonable constraints on the code over time, IMO.
>
We have not heard any other argument either in favor of or against
maintaining a single code base for 2.4 and 2.6. Although - there were mixed
sentiments when the alpha code was dropped. If 2.6 SCSI maintainers feel
strongly against have 2.4 specific code - we can patch the driver
appropriately. My only concern is, the same argument would then be valid for
2.4 version. It should not have 2.6 related code. But the 2.4 version of the
driver would be so "not 2.4'ish" since this driver is primarily 2.6 based. 
 
> 
> >>6) Kill uses of "volatile".  _Most_ of the time, this 
> indicates buggy 
> >>code.  You should have the proper barriers in place:  mb(), wmb(), 
> >>rmb(), barrier(), and cpu_relax().  This has been mentioned 
> before :)
> > 
> > We have carefully used "volatile" only on the fields, which 
> are touch by the
> > hardware and/or firmware. The proper barriers are used when 
> we want to make
> > sure access is properly sequenced.
> 
> The vast majority of Linux drivers are volatile-free, for 
> several reasons:
> 1) it hurts performance (inhibits valid compiler optimizations)
> 2) it hides bugs
> 3) it is not necessary for proper operation of hardware
> 
> I request that megaraid follow the example of the "vast majority".
Haven't had many arguments against this as well. So, we will remove all
volatile keywords in next version. 

> 
> 
> >>11) Why is PAGE_SIZE chosen here?
> >>
> >>+       /*
> >>+        * Allocate all pages in a loop
> >>+        */
> >>+       for (i = 0; i < num_pages; i++) {
> >>+
> >>+               pool->page_arr[i] = pci_alloc_consistent( 
> >>dev, PAGE_SIZE-1,
> >>+ 
> >>&pool->dmah_arr[i] );
> >>+               if (pool->page_arr[i] == NULL) {
> >>+                       con_log(CL_ANN, (KERN_WARNING
> >>+                               "megaraid: Failed to alloc 
> >>page # %d\n", 
> >>i ));
> >>+                       goto memlib_fail_alloc;
> >>+               }
> >>+       }
> >>
> > 
> > This API will only be used by low level drivers which 
> require multiple small
> > chunks of DMAable memory. This chunk are assumed to be much 
> smaller than a
> > PAGE therefore many can fit in a single PAGE. Driver 
> portions requiring
> > bigger buffers (>4KB) use pci_alloc_consistent directly.
> 
> Now that I understand the purpose, the preference is the same 
> as in my 
> other reply -- let's fix the problems with pci_pool_xxx API.
> 
> We have a kernel API precisely for this purpose; it should be used.
> 
> pci_pool is also present in 2.4.x...
We will investigate this further and share with lists. But this should not
be a pre-requisite for driver making in the kernel. We have made sure that
the semantics for pci_pool_xxx match closely with this our API - so it would
be a simple substitution.

 
> 
> >>14) the following check doesn't scale, please remove:
> >>
> >>+       if (subsysvid && (subsysvid != PCI_VENDOR_ID_AMI) &&
> >>+                       (subsysvid != PCI_VENDOR_ID_DELL) &&
> >>+                       (subsysvid != PCI_VENDOR_ID_HP) &&
> >>+                       (subsysvid != PCI_VENDOR_ID_INTEL) &&
> >>+                       (subsysvid != PCI_SUBSYS_ID_FSC) &&
> >>+                       (subsysvid != PCI_VENDOR_ID_LSI_LOGIC)) {
> >>+
> >>+               con_log(CL_ANN, (KERN_WARNING
> >>+                       "megaraid: not loading for 
> >>subsysvid:%#4.04x\n",
> >>+                       subsysvid));
> >>+
> >>+               return -ENODEV;
> >>+       }
> >>
> > 
> > Please elaborate. We simply want to make sure the pci 
> vendor, device and
> > subsystem ID are appropriate before loading the driver. 
> 
> Two points:
> 
> a) Such limitations should be in the pci_device_table, not 
> the code itself
Combinig the subsystem id with pci vendor and device id in the device table
would result in many permuations and combinations.

> 
> b) It is considered "unfriendly" and maintenance-intensive to 
> add such 
> checks.  If a hardware vendor (let's pick FSC as example) 
> comes out with 
> new megaraid hardware, you should make every effort to ensure 
> that the 
> driver _already works_ for that hardware.
> 
> We see from the megaraid 2.10.3 driver this patch:
> 
> @@ -311,6 +327,7 @@
>                                  (subsysvid != DELL_SUBSYS_VID) &&
>                                  (subsysvid != HP_SUBSYS_VID) &&
>                                  (subsysvid != INTEL_SUBSYS_VID) &&
> +                               (subsysvid != FSC_SUBSYS_VID) &&
>                                  (subsysvid != LSI_SUBSYS_VID) )
> 
> The hardware CLEARLY did not need FSC-specific modifications. 
>  However, 
> the FSC hardware would not work without this simple patch.
> 
> It is better to eliminate the need for such patches.  If the 
> driver and 
> hardware both comply to the specification, it should Just 
> Work(tm).  We 
> call this "future-proofing" the driver.
> 
> You provide better value to your customers by future-proofing 
> your drivers.
You are right about future-proofing. But when we do this, we have something
else in mind, which is totally opposite. I am sure, it seems abstruse to
redundantly check for the subsystem ids, when the vendor and device ids are
provided in the device table. This is done, so that we do not try to take
ownership of controller, which actually belongs to some other vendor. I know
of at least one example, where the qlogic driver loads for an AMI MegaRAID
controller - because both share the same vendor and device ids. Now the
driver assumes it to be a qlogic controller and tries to start it,
eventually hanging the server.

There definitely are other ways we driver simply wants to support a new
controller, which should Just Work(tm), e.g., by accepting new PCI vendor
id, device id and subsystem id as module parameters. It is unlikely we need
this in near future because the frequency at which we update drivers makes
it very easy to sneak in another set of PCI ids in the driver :-))

> 
> 
> >>17) Eliminate MAX_CONTROLLERS.  There is no reason for this limit. 
> >>Global structures such as mraid_driver_g are generally not needed.
> > 
> > We need it, since management module and applications need 
> to see a global
> > picture of all adapters in the system
> 
> I agree -- but I think you misunderstand.
> 
> It is possible to give mm and apps global picture of all adapters, 
> without introducing an arbitrary hardcoded limit.  megaraid 
> already has 
> a global list of adapters, that should be sufficient.
> 
> Dynamic allocation of each adapter, plus a global list, provides all 
> that megaraid needs, without any hardcoded MAX_CONTROLLERS limit.
> 
Understood and accepted :-)


> 
> >>19) When hardware is malfunctioning or removed, the following 
> >>code turns 
> >>into an infinite loop:
> >>
> >>+               // FIXME: this may not be required
> >>+               while (RDINDOOR(raid_dev) & 0x02) cpu_relax();
> > 
> > Is there is bette way to do it. If there is, please suggest 
> - we will
> > definitely us it. In fact, this is not the only such loop 
> in the ISR - there
> > are two more.
> 
> Typically, one includes a simple counter to ensure the loop is not 
> infinite...
> 
> 	while (condition && (counter-- > 0))
> 		cpu_relax()
> 
The hard part is arriving at the counter value. Given that this driver might
run on a 700MHz singe cpu, one of my test servers :-( or a 3.2GHz SMP server
- the typical counter value is difficult to set. But you are right, we
should find out the typical time a cpu would take to execute so many
iterations and base counter value over it.

> 
> >>21) VERY unfriendly to shared interrupts.  
> >>megaraid_iombox_ack_sequence 
> >>MUST check immediately for
> >>	(a) no irq at all (shared interrupt)
> >>	(b) status return of 0xffffffff (hardware is 
> >>malfunctioning/unplugged)
> > 
> > This is for EOL controllers. We are planning to phase out 
> this portion.
> 
> The (a) and (b) checks I describe are -required- for all controllers, 
> EOL or not...
Looks like missed your point completely. Are you reffering to the irq
parameter passed to the ISR? In our ISR, it first thing we check is, whether
the controller raised an interrupt. If yes, then do further processing,
otherwise return immediately.


Thanks
-Atul Mukker
LSI Logic
