Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264311AbUEIIU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264311AbUEIIU5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 04:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbUEIIU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 04:20:57 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:13072 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264309AbUEIIUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 04:20:50 -0400
Date: Sun, 9 May 2004 09:20:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Smart, James" <James.Smart@Emulex.com>
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [(re)Announce] Emulex LightPulse Device Driver
Message-ID: <20040509092045.A22643@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Smart, James" <James.Smart@Emulex.com>,
	"'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <3356669BBE90C448AD4645C843E2BF28034F92F0@xbl.ma.emulex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3356669BBE90C448AD4645C843E2BF28034F92F0@xbl.ma.emulex.com>; from James.Smart@Emulex.com on Sun, May 09, 2004 at 12:33:35AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A bunch of comments from looking over the headers and itnerface to
upper layers a little:  (next I'll try to understand what's going on
in the I/O submission path - it's just to freakin complicated..):

 - the hba api crap must die
 - lots of strange typedefs in sSuDly Caps that want to die.
 - Dito for the strange pfoo pointer naming.
 - please explain USE_HGP_HOST_SLIM and why only ppc64 sets it,
   per-arch ifdefs in LLDDs are very suspect
 - do you really care for pre-2.6.5 compat?
 - lpfc_fcp.h duplicates the scsi opcode - use those from scsi/scsi.h
 - lpfc_msg* stuff is not acceptable.   simply put the string you
   want to print into the printks
 - your module_param usage is b0rked.  Instead of duplicating every
   option 31 times use module_param_array.  You also seem to miss
   the paramter descriptions (MODULE_PARAM_DESC)
 - lpfc_clock.c should go away, just use add_timer/etc. diretly and
   embedd the timer into your structures.  Yes, I know that's not
   how SVR4-derivates work, but Linux does.  You also have an
   unchecked kmalloc and a list_head cast in there..
 - you're using list_for_each{,_safe} a lot where you'd want to
   use the _entry versions.
 - #define EXPORT_SYMTAB in lpfc_fcp.c is wrong, you never need that
   one in 2.6.
 - why do you need <linux/if_arp.h> and <linux/rtnetlink.h> in there?
 - please always include <linux/*> first, then <asm/*>, then <scsi/*>,
   then private headers.
 - OpenSource in the module description is useless - MODULE_LICENSE
   already tels us that.
 - why do you disable clustering in the 2.6 driver?
 - lpfcDRVR_t should go away in favour of a bunch of global variables
 - lpfc_linux_attach should be merged into lpfc_pci_detect, which would
   better be named lpfc_{,pci_}probe{,one}
 - same for lpfc_linux_detach into lpfc_pci_release
 - formatting of lpfc_driver is broken
 - not need to memset lpfcDRVR, it's 0 if it's in .bss already
 - what do you need lpfcDRVR.loadtime for?
 - lpfcDRVR.hba_list_head should be initializes at compile time
   LIST_HEAD(hba_list); if properly taken out of the struct.
 - you must attach the driver attributes always unless pci_module_init
   failed, alese hotpluggin does´t work.
 - lpfc_sleep_ms is broken, it'll happily sleep under spinlock, please
   use mdelay directly in contexts where you can't sleep and schedule_timeout
   only where you can sleep.
 - lpfc_sleep needs to die, it's just a broken reimplementation of
   sleep_on{,_interruptible,}{_timeout,}
 - lpfc_tasklet would probably benefit from a list_splice_init early on
   so the proceasing can happen without retaking the spinlock all the time
 - why all the EXPORT_SYMBOLS?
 - pleae kill all those silly one-line wrappers in lpfc_mem.c.
 - four mempool per hba seems a little much, care to explain why they're
   needed?
 - you don't need a pci_pool per hba, just one per driver
 - lpfc_sysfs_set_show/lpfc_sysfs_set_store violate the one value per
   attribute rule
 - dito for lpfc_sysfs_params_show/lpfc_sysfs_params_store
 - dito for lpfc_sysfs_info_show, in short all your sysfs work is completely
   wrong, also you seem to use driver attributes instead of scsi device/host
   attributes.  why?
 - in lpfc_queuecommand you don't need to spin_lock_irqsave your drvlock
   as the host_lock is already taken with irqs disabled.  you should probably
   redesign your driver to use the host_lock instead of the drvlock everywhere.
 - the error return if queuecommand lpfc_get_scsi_buf fails looks bogus,
   why do you set DID_BUS_BUSY?  also instead of 1 please return
   SCSI_MLQUEUE_HOST_BUSY
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
 - don't mess with eh_timeout from a LLDD please
