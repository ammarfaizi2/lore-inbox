Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268999AbUJELw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268999AbUJELw7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 07:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269006AbUJELww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 07:52:52 -0400
Received: from ozlabs.org ([203.10.76.45]:5869 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269007AbUJELw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 07:52:29 -0400
Date: Tue, 5 Oct 2004 21:49:51 +1000
From: Anton Blanchard <anton@samba.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Core scsi layer crashes in 2.6.8.1
Message-ID: <20041005114951.GD22396@krispykreme.ozlabs.ibm.com>
References: <1096401785.13936.5.camel@localhost.localdomain> <1096467125.2028.11.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096467125.2028.11.camel@mulgrave>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi James,

> These state transition warnings are currently expected in this code
> (they're basically verbose warnings).
> 
> What was the oops?
> 
> I have a theory that we should be taking a device reference before
> waking up the error handler, otherwise host removal can race with error
> handling.

Did this get sorted out? Here is an oops from a few week old BK tree.
FYI I just noticed I have disabled host reset in the sym2 driver (it
was locking up at the time and I never went back to work out why).
However, even with a host reset this could happen right?

Below we get a WARN_ON then an oops (the bit starting with NIP, the
address we tried to access was 0x100510.

Anton

sym0: <1010-66> rev 0x1 at pci 0004:03:01.0 irq 87
sym.0004:03:01.0: No NVRAM, ID 7, Fast-80, LVD, parity checking
xics_enable_irq 47 buid 4 gqirm 255
sym.0004:03:01.0: SCSI BUS has been reset.
scsi0 : sym-2.1.18j
Using anticipatory io scheduler
sym.0004:03:01.0:10: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 31)
  Vendor: IBM       Model: IC35L036UCDY10-0  Rev: S25M
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym.0004:03:01.0:10:0: tagged command queuing enabled, command queue depth 16.
scsi(0:0:10:0): Beginning Domain Validation
sym.0004:03:01.0:10: asynchronous.
sym.0004:03:01.0:10: wide asynchronous.
sym.0004:03:01.0:10: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
scsi(0:0:10:0): Ending Domain Validation
sym.0004:03:01.0:11:0:phase change 2-7 6@01050368 resid=5.
sym.0004:03:01.0:11:0:phase change 2-3 6@01050368 resid=5.
sym.0004:03:01.0:11: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 31)
sym.0004:03:01.0:11:control msgout: c.
sym.0004:03:01.0: TARGET 11 has been reset.
sym.0004:03:01.0:11:0: ABORT operation started.
sym.0004:03:01.0:11:0: ABORT operation complete.
sym.0004:03:01.0:11:0: DEVICE RESET operation started.
sym.0004:03:01.0:11:0: DEVICE RESET operation complete.
sym.0004:03:01.0:11:control msgout: c.
sym.0004:03:01.0: TARGET 11 has been reset.
sym.0004:03:01.0:11:0: ABORT operation started.
sym.0004:03:01.0:11:0: ABORT operation complete.
sym.0004:03:01.0:11:0: BUS RESET operation started.
sym.0004:03:01.0:11:0: BUS RESET operation complete.
sym.0004:03:01.0: SCSI BUS reset detected.
sym.0004:03:01.0: SCSI BUS has been reset.
scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 11 lun 0
Badness in kref_get at lib/kref.c:32
Call Trace:
[c0000025fe1b3bd0] [c0000030262bf4b0] 0xc0000030262bf4b0 (unreliable)
[c0000025fe1b3c50] [c00000000021f5b8] .get_device+0x20/0x3c
[c0000025fe1b3cc0] [c000000000294c60] .scsi_device_get+0x38/0xe4
[c0000025fe1b3d40] [c000000000294e30] .__scsi_iterate_devices+0x60/0xfc
[c0000025fe1b3de0] [c000000000299bf8] .scsi_run_host_queues+0x34/0x58
[c0000025fe1b3e60] [c0000000002989f8] .scsi_error_handler+0x268/0xaa0
[c0000025fe1b3f90] [c000000000017aac] .kernel_thread+0x4c/0x68
sym.0004:03:01.0:11:control msgout: c.
NIP: C000000000294C48 XER: 0000000020000000 LR: C000000000294E30
REGS: c0000025fe1b3a40 TRAP: 0300   Not tainted  (2.6.9-rc2-bml)
MSR: 9000000000001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 0000000000100510, DSISR: 0000000040000000
TASK: c000001dfe1b72c0[1467] 'scsi_eh_0' THREAD: c0000025fe1b0000 CPU: 3
GPR00: FFFFFFFFFFFFFFFA C0000025FE1B3CC0 C0000000007297B8 00000000001000F0
GPR04: C000000FFE185000 0000000000000001 0000000000000000 0000000000000000
GPR08: 0000000000000000 0000000000100100 C000000000B96228 9000000000009032
GPR12: 0000000024FFFF22 C000000000542700 0000000000000000 0000000000000000
GPR16: 0000000000000000 C00000000040D188 C000000000587058 C0000025FE1B3ED0
GPR20: 00000000000000FC C00000000040D188 C000000000587058 C0000025FE1B3F00
GPR24: C0000025FE1B3EF0 0000040100000000 C000002FFE128D30 C000000FFE185000
GPR28: 9000000000009032 C0000007FFFCF800 00000000001002D8 00000000001000F0
NIP [c000000000294c48] .scsi_device_get+0x20/0xe4
LR [c000000000294e30] .__scsi_iterate_devices+0x60/0xfc
Call Trace:
[c0000025fe1b3cc0] [c000000000294da8] .scsi_device_put+0x9c/0xc4 (unreliable)
[c0000025fe1b3d40] [c000000000294e30] .__scsi_iterate_devices+0x60/0xfc
[c0000025fe1b3de0] [c000000000299bf8] .scsi_run_host_queues+0x34/0x58
[c0000025fe1b3e60] [c0000000002989f8] .scsi_error_handler+0x268/0xaa0
[c0000025fe1b3f90] [c000000000017aac] .kernel_thread+0x4c/0x68
