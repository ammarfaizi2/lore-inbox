Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270208AbTGRLIN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 07:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271532AbTGRLIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 07:08:13 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:28943 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270208AbTGRLIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 07:08:09 -0400
Date: Fri, 18 Jul 2003 12:23:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b4).
Message-ID: <20030718122304.A23013@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linux-SCSI <linux-scsi@vger.kernel.org>
References: <B179AE41C1147041AA1121F44614F0B0598B10@AVEXCH02.qlogic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <B179AE41C1147041AA1121F44614F0B0598B10@AVEXCH02.qlogic.org>; from andrew.vasquez@qlogic.com on Thu, Jul 17, 2003 at 04:40:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


More comments:

 - Documentation/scsi/qla2xxx.txt seems to document a 2.4ish driver
 - Documentation/scsi/qla2xxx.release.txt looks superflous, can you
   merge it into the (updated) qla2xxx.txt?
 - drivers/scsi/qla2xxx/ has duplicates of the documentation

 - the (v8) comments in drivers/scsi/qla2xxx/Kconfig are superflous
 - drivers/scsi/qla2xxx/Makefile is a mess.  If you want to compile
   a single source file multiple times in different ways create a
   new source file that sets the needed defines and #includes the
   source file.  But in general this should be avoided in favour of
   a common library module..

 - please document which files are shared with other operating systems
   (some look like they do, don't they?)
 - the driver still has multipath support in the lowlevel driver which
   we don't want in Linux
 - UNIQUE_FW_NAME is still there.  shouldn't this be enabled uncdontionally?
 - still tons of typedefs that want cleaning up
 - your include structures is very confusing.  Please include the linux
   headers directly i nthe files using them (except of course for
   source files shares with other OSes)
 
 - qla2x00_intr_handler should use spin_lock, not spin_lock_irqsave
 - you're using down_interruptible without checking the return value
 - please switch to newstyle module/boot parameter handling (module_param)
   (oh, okay, found the TODO comment)
 - what is #if defined (CONFIG_SCSIFCHOTSWAP) || defined(CONFIG_GAMAP)?
   that's never defined in a 2.5 tree and the code looks ugly as hell.
 - .unchecked_isa_dma      = 0 in the host template is superflous,
   it's 0 by default.
 - what is CONFIG_MD_MULTIHOST_FC?
 - you are using a static buffer in qla2x00_info, there's a lock needed
   to protect it
 - in qla2x00_queuecommand you need to call spin_unlock_irq/spin_lock_irq
   on the hostlock, otherwise your whole ->queuecommand runs with (local)
   interrupts disabled
 - qla2x00_biosparam is superflous, if there's no ->biosparam the midlayer
   calls scsicam_bios_param directly
 - you don't need to call scsi_set_device if you pass the proper struct device
   to scsi_add_host
 - please don't use scsi_assign_lock.  In 2.5 we already have a per-HBA
   lock and using a different one than the default one doesn't make sense.
 - you need to check the return value from scsi_add_host
 - please remove the "sanity check" in qla2x00_remove_device.  If you
   can't trust the pci layer you have worse problems..
 - ->proc_info is deprecated, please implement shost and sdev sysfs
   attributes instead.
 
 - all contents of qla_ip.c is surrounded by a big if defined(FC_IP_SUPPORT),
   please compile the file conditionally instead.  (also in linux we prefer
   #ifdef over #if defined)
 - where is qla2200_ip_inquiry/qla2300_ip_inquiry called??  also it makes
   more sense to pass the scsi_qla_host_t directrly to it instead of an
   adapter number that requires list walking

