Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264761AbTFEQs6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 12:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264758AbTFEQs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 12:48:58 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:48545 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264761AbTFEQsN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 12:48:13 -0400
Date: Thu, 5 Jun 2003 11:58:46 -0500
From: linas@austin.ibm.com
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org, olh@suse.de, groudier@free.fr, axboe@suse.de,
       acme@conectiva.com.br, linas@linas.org, linux-scsi@vger.kernel.org
Subject: Re: Patches for SCSI timeout bug
Message-ID: <20030605115846.A32018@forte.austin.ibm.com>
References: <20030604163415.A41236@forte.austin.ibm.com> <20030604214442.GI4939@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030604214442.GI4939@werewolf.able.es>; from jamagallon@able.es on Wed, Jun 04, 2003 at 11:44:43PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 11:44:43PM +0200, J.A. Magallon wrote:
> 
> On 06.04, linas@austin.ibm.com wrote:
> > 
> > I've got a SCSI timeout bug in kernels 2.4 and 2.5, and several 
> > different patches (appended) that fix it.  I'm not sure which way 
> > of fixing it is best.
> > 
> 
> Can you try with this:
> 
> --- linux-2.4.18-18mdk/drivers/scsi/scsi_error.c.scsi-eh-timeout	Thu May 30 16:22:37 2002

OK, some more details:
-- you patch doesn't affect operation of the 'old' symbios driver, since
   it doesn't use the 'new' eh code. 

-- I tried the new (version 2) symbios driver w/ your patch.  It does
   allow the machine to boot, but it disables the cdrom. This is bad,
   because it prevents a booting from CDROM (e.g. for install).

   BTW, the v2 code doesn't hit your patches either; I put a printk
   in there and it never showed up ... 

To reiterate; my cdrom needs 15 seconds after a bus reset before it
will respond to a queueed command.  The v2 symbios driver doesn't wait
that long-- it just keeps reseting again, too quickly, which does no 
good.

Below are the boot msgs from the symbios v2 driver:
(my cdrom is at scsi id 4)

--linas


SCSI subsystem driver Revision: 1.00
PCI: Enabling device 00:0c.0 (0140 -> 0143)
sym.0.12.0: setting PCI_COMMAND_MASTER...
sym.0.12.0: setting PCI_COMMAND_INVALIDATE.
PCI: Enabling device 00:11.0 (0140 -> 0143)
sym.0.17.0: setting PCI_COMMAND_MASTER...
sym.0.17.0: setting PCI_COMMAND_INVALIDATE.
sym0: <875> rev 0x4 on pci bus 0 device 12 function 0 irq 17
sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
sym1: <895> rev 0x1 on pci bus 0 device 17 function 0 irq 20
sym1: No NVRAM, ID 7, Fast-40, LVD, parity checking
sym1: SCSI BUS has been reset.
scsi0 : sym-2.1.17a
scsi1 : sym-2.1.17a
sym0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 15)
  Vendor: IBM       Model: DCHS04U           Rev: 2727
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym0:4:0: ABORT operation started.
sym0:4:0: ABORT operation timed-out.
sym0:4:0: DEVICE RESET operation started.
sym0:4:0: DEVICE RESET operation complete.
sym0:4:control msgout: c.
sym0: TARGET 4 has been reset.
sym0:4:0: ABORT operation started.
sym0:4:0: ABORT operation complete.
sym0:4:0: BUS RESET operation started.
sym0:4:0: BUS RESET operation failed.
sym0:4:0: HOST RESET operation started.
sym0:4:0: HOST RESET operation failed.
scsi: device set offline - command error recover failed: host 0 channel 0 id 4 0sym0:9: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 16)
  Vendor: IBM       Model: DNES-309170W      Rev: SAGU
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym0:0:0: tagged command queuing enabled, command queue depth 16.
sym0:9:0: tagged command queuing enabled, command queue depth 16.
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 9, lun 0
SCSI device sda: 8813870 512-byte hdwr sectors (4513 MB)
Partition check:
 sda: sda2 sda3 sda4
SCSI device sdb: 17774160 512-byte hdwr sectors (9100 MB)
 sdb: sdb1 sdb2 sdb3

