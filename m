Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266196AbUIIWEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266196AbUIIWEe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 18:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267625AbUIIWD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 18:03:29 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:9422 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268001AbUIIWAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 18:00:54 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp: kill crash when too much memory is free
Date: Fri, 10 Sep 2004 00:01:28 +0200
User-Agent: KMail/1.6.2
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040909154219.GB11742@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20040909154219.GB11742@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409100001.28781.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thursday 09 of September 2004 17:42, Pavel Machek wrote:
> Hi!
> 
> If too much memory is free, swsusp dies in quite a ugly way. Even when
> it is not neccessary to relocate pagedir, it is proably still
> neccessary to relocate individual pages. Thanks to Kurt Garloff and
> Stefan Seyfried...
> 								Pavel
> PS: And could I have one brown paper bag, please?

I applied this and it didn't fix my problems with resuming, unfortunately, but 
it changed the symptoms.  Namely, if USB modules are not unloaded before 
suspending, I get:

Relocating pagedir .....:::::|
Reading image data (11315 
pages): ...................................................................................
Stopping tasks: ==|
Freeing memory: |
PM: Restoring saved image.
<7>PM: Image restored successfully.
Losing some ticks... checking if CPU frequency changed.
warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip free_hot_cold_page+0x31/0x130
Warning: CPU frequency out of sync: cpufreq and timing core thinks of 800000, 
is 1800000 kHz.
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: HC died; cleaning up
usb 1-2: USB disconnect, address 3
Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1310

Call Trace:<ffffffffa0045b80>{:usbcore:hcd_endpoint_disable+0}
       <ffffffffa0045beb>{:usbcore:hcd_endpoint_disable+107}
       <ffffffffa0046bb9>{:usbcore:usb_disable_endpoint+41}
       <ffffffffa0046d3a>{:usbcore:usb_disable_device+26}
       <ffffffffa0042b7c>{:usbcore:usb_disconnect+188} 
<ffffffffa0042ac2>{:usbcore:usb_disconnect+2}
       <ffffffffa0044890>{:usbcore:hcd_panic+0} 
<ffffffffa00448da>{:usbcore:hcd_panic+74}
       <ffffffff80152742>{worker_thread+674} 
<ffffffff80136930>{default_wake_function+0}
       <ffffffff80134e23>{__wake_up_common+67} 
<ffffffff80136930>{default_wake_function+0}
       <ffffffff801524a0>{worker_thread+0} <ffffffff8015945d>{kthread+205}
       <ffffffff80111673>{child_rip+8} <ffffffff80159390>{kthread+0}
       <ffffffff8011166b>{child_rip+0}
Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1310

If they _are_ unloaded (ie "rmmod ehci_hcd ohci_hcd usbserial usbhid") before 
suspending, I get:

Relocating pagedir not necessary
Reading image data (11335 
pages): ...................................................................................
Stopping tasks: ==|
Freeing memory: |
PM: Restoring saved image.
<7>PM: Image restored successfully.
Losing some ticks... checking if CPU frequency changed.
warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip swsusp_free+0xfe/0x1a0
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:02.0 to 64
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:02.1 to 64
ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:02.2 to 64
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:06.0 to 64
Warning: CPU frequency out of sync: cpufreq and timing core thinks of 800000, 
is 1800000 kHz.
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 11 (level, low) -> IRQ 11

And then silence (the box hangs solid and there's no more output on the serial 
console).

Well, this would indicate that there's a problem related to CPU scaling, so I 
compiled it out.  Then, I got:

Relocating pagedir .....:::::|
Reading image data (11667 
pages): ...................................................................................
Stopping tasks: ==|
Freeing memory: |
PM: Restoring saved image.
<0>double fault: 0000 [1]
CPU 0
Modules linked in: parport_pc lp parport joydev sg st sd_mod sr_mod scsi_mod 
snd_seq_oss snd_seq_midi_event snd_seq d
Pid: 12161, comm: bash Not tainted 2.6.9-rc1-mm4
RIP: 0010:[<ffffffff801245d7>] <ffffffff801245d7>{do_page_fault+55}
RSP: 0000:000001001fdfff48  EFLAGS: 00010016
RAX: ffffffff801245a0 RBX: 0000000000000001 RCX: 000ffffffffff000
RDX: 000000001fce3000 RSI: 0000000000000000 RDI: 000001001fe00068
RBP: 0000000080111203 R08: 0000000000000000 R09: 000001001fe27e64
R10: 0000000000000000 R11: 0000000000000064 R12: 0000000000000000
R13: 000001001b746618 R14: 000001000e0a3430 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff805b7340(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 0000000080050033
CR2: 000001001fdfff38 CR3: 0000000000101000 CR4: 00000000000006e0
Process bash (pid: 12161, threadinfo 00000100102b6000, task 000001000e0a3430)
Stack:

and nothing more.  Next time I unloaded dm_mod additionally before suspending 
and I got:

Relocating pagedir .....:::::|
Reading image data (11498 
pages): ...................................................................................
Stopping tasks: ==|
Freeing memory: |
PM: Restoring saved image.
<7>PM: Image restored successfully.
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:02.0 to 64
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:02.1 to 64
ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:02.2 to 64
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:06.0 to 64
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 11 (level, low) -> IRQ 11

And then silence ...

This is 100% reproducible (ie unload USB modules and dm_mod, suspend the 
machine, try to wake it up, hangs solid).

Can you tell me, please, if there's anything I can compile out/in to debug it 
a bit more?  Or can I put some printk()s somewhere in the code to get some 
more info?  Any suggestions welcome.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
