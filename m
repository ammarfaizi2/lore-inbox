Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbUENTvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUENTvp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 15:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUENTvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 15:51:45 -0400
Received: from emulex.emulex.com ([138.239.112.1]:39656 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S262389AbUENTvb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 15:51:31 -0400
Message-ID: <3356669BBE90C448AD4645C843E2BF28034F9351@xbl.ma.emulex.com>
From: "Smart, James" <James.Smart@Emulex.com>
To: "'Christoph Hellwig'" <hch@infradead.org>
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [(re)Announce] Emulex LightPulse Device Driver
Date: Fri, 14 May 2004 15:51:14 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,

Here's a reply/status relative to your comments.

-- James



The following items are completed and should be in our next
drop (slated for today/tomorrow):

 - the hba api crap must die
	  Note: We have removed the hbaapi header and associated
dependencies.
	    We will continue to work on a common linux HBAAPI
implementation.
 - lpfc_fcp.h duplicates the scsi opcode - use those from scsi/scsi.h
 - #define EXPORT_SYMTAB in lpfc_fcp.c is wrong, you never need that
   one in 2.6.
 - why do you need <linux/if_arp.h> and <linux/rtnetlink.h> in there?
 - please always include <linux/*> first, then <asm/*>, then <scsi/*>,
   then private headers.
 - OpenSource in the module description is useless - MODULE_LICENSE
   already tels us that.
 - formatting of lpfc_driver is broken
 - not need to memset lpfcDRVR, it's 0 if it's in .bss already
 - please kill all those silly one-line wrappers in lpfc_mem.c.
 - lpfc_sysfs_set_show/lpfc_sysfs_set_store violate the one value per
   attribute rule
 - dito for lpfc_sysfs_params_show/lpfc_sysfs_params_store
 - dito for lpfc_sysfs_info_show, in short all your sysfs work is completely
   wrong, also you seem to use driver attributes instead of scsi device/host
   attributes.  why?


Will Do shortly - hopefully by next week's drop:

 - lots of strange typedefs in sSuDly Caps that want to die.
 - Dito for the strange pfoo pointer naming.
 - do you really care for pre-2.6.5 compat?
      Note: For now, it will remain, as we have a couple of consumers
	    that aren't on the latest and greatest. It will be removed
before
	    we're done.
 - lpfc_msg* stuff is not acceptable.   simply put the string you
   want to print into the printks
      Note: I'm not sure how we will resolve this yet. We place all error
	    strings in a single location so we can use automated tools to 
		generate documentation for customers. However, as
developers,
		we share the same sentiment you do. So, we'll figure
something out.
 - your module_param usage is b0rked.  Instead of duplicating every
   option 31 times use module_param_array.  You also seem to miss
   the paramter descriptions (MODULE_PARAM_DESC)
      Note: Our implementation will actually move away from arrays, etc.
        We're redesigning the interface so that it's variable and does
	    not have a maximum instance size.
 - you're using list_for_each{,_safe} a lot where you'd want to
   use the _entry versions.
 - why do you disable clustering in the 2.6 driver?
 - you must attach the driver attributes always unless pci_module_init
   failed, alese hotpluggin does´t work.
 - lpfc_sleep_ms is broken, it'll happily sleep under spinlock, please
   use mdelay directly in contexts where you can't sleep and
schedule_timeout
   only where you can sleep.
 - lpfc_sleep needs to die, it's just a broken reimplementation of
   sleep_on{,_interruptible,}{_timeout,}
 - lpfc_tasklet would probably benefit from a list_splice_init early on
   so the proceasing can happen without retaking the spinlock all the time
 - why all the EXPORT_SYMBOLS?
      Note: We'll ensure that these actually need to be exported.
 - you shouldn't need the scsi_{bus,target,lun} members in lpfc_cmd but
   always use the scsi_cmnd->device linked from there.
 - the lpfc_find_target usage in queuecommand looks bogus.  You have
   scsi_device->hostdata to put per-lun data, from which you can trivially
   link per-target data directly.  All the checks for inquiry and valid
   luns are similarly b0rked - scsi probing works by calling ->slave_alloc
   first so you'll a) have a place where you know the midlayer is probing
   and b) always private data when quecommand is called.
 - in lpfc_scsi_cmd_start you use lpfc_find_lun_device which is copletely
   bogus again, use scsi_cmnd->device->hostdata
 - 2nd email on findstatic results - adding static declarations


Things we haven't gotten to yet:

 - what do you need lpfcDRVR.loadtime for?
 - lpfcDRVR.hba_list_head should be initializes at compile time
   LIST_HEAD(hba_list); if properly taken out of the struct.
 - in lpfc_queuecommand you don't need to spin_lock_irqsave your drvlock
   as the host_lock is already taken with irqs disabled.  you should
probably
   redesign your driver to use the host_lock instead of the drvlock
everywhere.
 - the error return if queuecommand lpfc_get_scsi_buf fails looks bogus,
   why do you set DID_BUS_BUSY?  also instead of 1 please return
   SCSI_MLQUEUE_HOST_BUSY


Things we need to discuss/clarify:

 - please explain USE_HGP_HOST_SLIM and why only ppc64 sets it,
   per-arch ifdefs in LLDDs are very suspect

     Our hardware allows for control structures to be placed in adapter
	 memory rather than host memory. In general, this is the most
	 efficient mode of operation. USE_HGP_HOST_SLIM instructs us to
override
	 this optimization and place them in host memory.
	 For PPC64, to work around byte ordering issues relative to how the
	 hardware is accessing the control structures, we found it easier to
	 just use the unoptimized location.

 - lpfc_clock.c should go away, just use add_timer/etc. diretly and
   embedd the timer into your structures.  Yes, I know that's not
   how SVR4-derivates work, but Linux does.  You also have an
   unchecked kmalloc and a list_head cast in there..

     It's not an SVR4 vs linux thing.  This wrapper function does two
	 things - start the timer, and allocate/link a small control
structure.
	 The control structure allows us to just keep a record of every
	 outstanding timer. This is a safety check, for driver
	 unloads/kills/etc, to ensure that we have cancelled all the timers
	 that have been registered with the OS.

 - lpfcDRVR_t should go away in favour of a bunch of global variables

     Can you explain this comment further ?  

 - lpfc_linux_attach should be merged into lpfc_pci_detect, which would
   better be named lpfc_{,pci_}probe{,one}

	 We've kept this organization so it's more in line with the
	 organization of the 2.4 driver. I don't see a real need to change
	 this.
     Note: we have renamed the probe functions...

 - same for lpfc_linux_detach into lpfc_pci_release
     
	 Same as last item

 - you don't need a pci_pool per hba, just one per driver

	 The pools are pre-dma mapped. As there are systems that require
	 dma maps to be specific to the adapter using them, we're maintaing
	 a pool per hba.

	 Also - these are for the most part safety pools for elements we
	 use during discovery/port validation. We use the base os functions,
	 and only if they fail do we use these pools. We resort to this as
	 the results of failing discovery in low-memory configurations can
	 be catastrophic, especially if we are connected to a disk that is
	 a root or swap disk. As there's nothing that says all adapters
can't
	 be plugged into the same switch, thus see the same discovery event,
	 the safety pool must be sized to support all adapters. So - there's
	 little gain in sharing a pool.

 - four mempool per hba seems a little much, care to explain why they're
   needed?

     These are the safety pools just mentioned. 1 pool is for non-dma
	 mapped structures - which are used during discovery. The other 3
	 pools are pre-dma mapped buffers - of different allocation sizes
	 (256 bytes, 1k, and 4k). It's just an optimization on the amount
	 of memory used by the pool. I'm sure there's other methods, but...

 - don't mess with eh_timeout from a LLDD please

     This exists until we fully sync up with the IBM patch that allows
	 the LLD to set the peripheral driver's basic read/write timeout
	 value - which just went into the last scsi patches.
	 See prior discussions on linux-scsi.

 
