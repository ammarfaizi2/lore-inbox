Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUFRULV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUFRULV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266816AbUFRULK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:11:10 -0400
Received: from guru.webcon.ca ([216.194.67.26]:59816 "EHLO guru.webcon.ca")
	by vger.kernel.org with ESMTP id S261605AbUFRUDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:03:32 -0400
Date: Fri, 18 Jun 2004 16:02:15 -0400 (EDT)
From: Ian Morgan <imorgan@webcon.ca>
X-X-Sender: imorgan@light.int.webcon.net
To: Duncan Sands <baldrick@free.fr>
cc: linux-usb-devel@lists.sourceforge.net,
       "Zephaniah E. Hull" <warp@mercury.d2dc.net>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David A. Desrosiers" <desrod@gnu-designs.com>
Subject: Re: [linux-usb-devel] Re: USBDEVFS_RESET deadlocks USB bus.
In-Reply-To: <200406082219.41213.baldrick@free.fr>
Message-ID: <Pine.LNX.4.60.0406181529370.4796@light.int.webcon.net>
References: <20040604193911.GA3261@babylon.d2dc.net> <200406072111.32827.baldrick@free.fr>
 <20040607231348.GB10404@babylon.d2dc.net> <200406082219.41213.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2004, Duncan Sands wrote:

>> Great, could you send me the patch? (So I have something usable until it
>> gets into mainline and a kernel is released with it.)
>
> Sure - I just have to write it first!  It's a bit tricky to do right...

Any further status on this?

I don't know for sure that the problem I'm having is related, but it sure
sound like it:

I've tried these kernels:
 	2.6.6
 	2.6.7
 	2.6.7 + 2.6.7-rc3-mm2's big USB patch
all both with and witout kernel pre-emption enabled.

I have 3 Addonics 4-slot PCMCIA card reader attached via two 7-port D-Link
hub. All units are USB 2.0 (reported in /proc/bus/usb/devices as 480Mbps).
The problem occurs even with just one slot connected by one hub and
everything else disconncted. All readers and hubs are powered by extrernal
AC adapters, so power draw from the bus should not be an issue.

I can insert a PCMCIA card and, w/ usb-storage, see it as /dev/sda. But here
is the problem: I can only do this (roughly) twice. After ejecting it the
2nd time, and inserting it the 3rd time, the USB subsystem seems to hang,
and rather than detecting the card, goes into an infinite cycle of
attempting and failing to reset the bus. The 3 insertion cycles is almost
always constant, but it has once allowed me 6 cycles before it locked up.
During that one 6-cycle count, the same hang appeard after the 3rd
insertion, but the bus actually recovered after one reset attempt, but then
locked up after the 6th insertion never to recover again.

The kernel processes [usb-storage] and [scsi_eh_n] appear locked, with the
[scsi_eh_n] in D state:

root      4297  0.0  0.0     0    0 ?        SW   15:21   0:00 [usb-storage]
root      4298  0.0  0.0     0    0 ?        DW   15:21   0:00 [scsi_eh_6]

Here is a stack trace of usb-storage and scsi_eh_6:

Jun 18 15:27:05 light kernel: usb-storage   S C03A1C40     0  4297      1       4298  2515 (L-TLB)
Jun 18 15:27:05 light kernel: d5b43f58 00000046 d737e0b0 c03a1c40 00000001 d5b43f48 c0117575 df892b30 
Jun 18 15:27:05 light kernel:        00000001 00000000 d5d86030 00002274 32de0b8e 0000006f d737e258 c158dd04 
Jun 18 15:27:05 light kernel:        00000286 d5b42000 d737e0b0 c02a9512 c158dd0c 00000000 00000001 d737e0b0 
Jun 18 15:27:05 light kernel: Call Trace:
Jun 18 15:27:05 light kernel:  [<c0117575>] __wake_up_common+0x38/0x57
Jun 18 15:27:05 light kernel:  [<c02a9512>] __down_interruptible+0x9b/0x101
Jun 18 15:27:05 light kernel:  [<c011752b>] default_wake_function+0x0/0x12
Jun 18 15:27:05 light kernel:  [<c011a559>] printk+0xef/0x12c
Jun 18 15:27:05 light kernel:  [<c02a958b>] __down_failed_interruptible+0x7/0xc
Jun 18 15:27:05 light kernel:  [<e0ddd29e>] .text.lock.usb+0x5/0x5b [usb_storage]
Jun 18 15:27:05 light kernel:  [<c0105d4e>] ret_from_fork+0x6/0x14
Jun 18 15:27:05 light kernel:  [<e0ddc4b9>] usb_stor_control_thread+0x0/0x2b5 [usb_storage]
Jun 18 15:27:05 light kernel:  [<e0ddc4b9>] usb_stor_control_thread+0x0/0x2b5 [usb_storage]
Jun 18 15:27:05 light kernel:  [<c0104291>] kernel_thread_helper+0x5/0xb
Jun 18 15:27:05 light kernel: 
Jun 18 15:27:05 light kernel: scsi_eh_6     D C03A20E8     0  4298      1       4297 (L-TLB)
Jun 18 15:27:05 light kernel: d5eabed0 00000046 df892b30 c03a20e8 00000073 00000000 c02f76b8 00000001 
Jun 18 15:27:05 light kernel:        d9c03e01 00000073 df892b30 000024bb d9c04dd3 00000073 d5d861d8 df8ff424 
Jun 18 15:27:05 light kernel:        00000286 d5d86030 df8ff42c c02a942c 00000001 d5d86030 c011752b df8ff42c 
Jun 18 15:27:05 light kernel: Call Trace:
Jun 18 15:27:05 light kernel:  [<c02a942c>] __down+0x7c/0xc7
Jun 18 15:27:05 light kernel:  [<c011752b>] default_wake_function+0x0/0x12
Jun 18 15:27:05 light kernel:  [<c011a674>] release_console_sem+0x9a/0x9c
Jun 18 15:27:05 light kernel:  [<c02a9580>] __down_failed+0x8/0xc
Jun 18 15:27:05 light kernel:  [<e08dd6ff>] .text.lock.hub+0x87/0x98 [usbcore]
Jun 18 15:27:05 light kernel:  [<e0dda35e>] bus_reset+0xc9/0xeb [usb_storage]
Jun 18 15:27:05 light kernel:  [<e0dcb146>] scsi_try_bus_reset+0x54/0x8a [scsi_mod]
Jun 18 15:27:05 light kernel:  [<e0dcb265>] scsi_eh_bus_reset+0x5f/0x101 [scsi_mod]
Jun 18 15:27:05 light kernel:  [<e0dcb095>] scsi_eh_bus_device_reset+0x75/0xd2 [scsi_mod]
Jun 18 15:27:05 light kernel:  [<e0dcb7a0>] scsi_eh_ready_devs+0x63/0x93 [scsi_mod]
Jun 18 15:27:05 light kernel:  [<e0dcb8f4>] scsi_unjam_host+0xa1/0xa3 [scsi_mod]
Jun 18 15:27:05 light kernel:  [<e0dcb994>] scsi_error_handler+0x9e/0xc6 [scsi_mod]
Jun 18 15:27:05 light kernel:  [<e0dcb8f6>] scsi_error_handler+0x0/0xc6 [scsi_mod]
Jun 18 15:27:05 light kernel:  [<c0104291>] kernel_thread_helper+0x5/0xb

And here are the debug logs leading up the the lockup:

Jun 18 15:21:17 light kernel: hub 1-1:1.0: port 2, status 0101, change 0001, 12 Mb/s
Jun 18 15:21:17 light kernel: hub 1-1:1.0: debounce: port 2: total 100ms stable 100ms status 0x101
Jun 18 15:21:17 light kernel: usb 1-1.2: new full speed USB device using address 17
Jun 18 15:21:17 light kernel: usb 1-1.2: new device strings: Mfr=73, Product=82, SerialNumber=99
Jun 18 15:21:17 light kernel: usb 1-1.2: default language 0x0409
Jun 18 15:21:17 light kernel: usb 1-1.2: Product: USB to IDE Cable
Jun 18 15:21:17 light kernel: usb 1-1.2: Manufacturer: Addonics
Jun 18 15:21:17 light kernel: usb 1-1.2: SerialNumber: 0123456789AB
Jun 18 15:21:17 light kernel: usb 1-1.2: hotplug
Jun 18 15:21:17 light kernel: usb 1-1.2: adding 1-1.2:2.0 (config #2, interface 0)
Jun 18 15:21:17 light kernel: usb 1-1.2:2.0: hotplug
Jun 18 15:21:17 light kernel: usb-storage 1-1.2:2.0: usb_probe_interface
Jun 18 15:21:17 light kernel: usb-storage 1-1.2:2.0: usb_probe_interface - got id
Jun 18 15:21:17 light kernel: usb-storage: USB Mass Storage device detected
Jun 18 15:21:17 light kernel: usb-storage: altsetting is 0, id_index is 92
Jun 18 15:21:17 light kernel: usb-storage: -- associate_dev
Jun 18 15:21:18 light kernel: usb-storage: Transport: Bulk
Jun 18 15:21:18 light kernel: usb-storage: Protocol: Transparent SCSI
Jun 18 15:21:18 light kernel: usb-storage: Endpoints: In: 0xd6c4ba54 Out: 0xd6c4ba68 Int: 0xd6c4ba7c (Period 32)
Jun 18 15:21:18 light kernel: usb-storage: usb_stor_control_msg: rq=fe rqtype=a1 value=0000 index=00 len=1
Jun 18 15:21:18 light kernel: usb-storage: GetMaxLUN command result is 1, data is 0
Jun 18 15:21:18 light kernel: usb-storage: *** thread sleeping.
Jun 18 15:21:18 light kernel: scsi6 : SCSI emulation for USB Mass Storage devices
Jun 18 15:21:18 light kernel: usb-storage: queuecommand called
Jun 18 15:21:18 light kernel: usb-storage: *** thread awakened.
Jun 18 15:21:18 light kernel: usb-storage: Command INQUIRY (6 bytes)
Jun 18 15:21:18 light kernel: usb-storage:  12 00 00 00 24 00
Jun 18 15:21:18 light kernel: usb-storage: Bulk Command S 0x43425355 T 0xd1 L 36 F 128 Trg 0 LUN 0 CL 6
Jun 18 15:21:18 light kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 18 15:21:18 light kernel: usb-storage: Status code 0; transferred 31/31
Jun 18 15:21:18 light kernel: usb-storage: -- transfer complete
Jun 18 15:21:18 light kernel: usb-storage: Bulk command transfer result=0
Jun 18 15:21:18 light kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
Jun 18 15:21:23 light kernel: usb-storage: command_abort called
Jun 18 15:21:23 light kernel: usb-storage: usb_stor_stop_transport called
Jun 18 15:21:23 light kernel: usb-storage: -- cancelling URB
Jun 18 15:21:23 light kernel: usb-storage: Status code -104; transferred 0/36
Jun 18 15:21:23 light kernel: usb-storage: -- transfer cancelled
Jun 18 15:21:23 light kernel: usb-storage: Bulk data transfer result 0x4
Jun 18 15:21:23 light kernel: usb-storage: -- command was aborted
Jun 18 15:21:23 light kernel: usb-storage: usb_stor_Bulk_reset called
Jun 18 15:21:23 light kernel: usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
Jun 18 15:21:43 light kernel: usb-storage: Timeout -- cancelling URB
Jun 18 15:21:43 light kernel: usb-storage: Soft reset failed: -104
Jun 18 15:21:43 light kernel: usb-storage: scsi command aborted
Jun 18 15:21:43 light kernel: usb-storage: *** thread sleeping.
Jun 18 15:21:43 light kernel: usb-storage: queuecommand called
Jun 18 15:21:43 light kernel: usb-storage: *** thread awakened.
Jun 18 15:21:43 light kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 18 15:21:43 light kernel: usb-storage:  00 00 00 00 00 00
Jun 18 15:21:43 light kernel: usb-storage: Bulk Command S 0x43425355 T 0xd1 L 0 F 0 Trg 0 LUN 0 CL 6
Jun 18 15:21:43 light kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 18 15:21:43 light kernel: usb-storage: Status code 0; transferred 31/31
Jun 18 15:21:43 light kernel: usb-storage: -- transfer complete
Jun 18 15:21:43 light kernel: usb-storage: Bulk command transfer result=0
Jun 18 15:21:43 light kernel: usb-storage: Attempting to get CSW...
Jun 18 15:21:43 light kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 18 15:21:53 light kernel: usb-storage: command_abort called
Jun 18 15:21:53 light kernel: usb-storage: usb_stor_stop_transport called
Jun 18 15:21:53 light kernel: usb-storage: -- cancelling URB
Jun 18 15:21:53 light kernel: usb-storage: Status code -104; transferred 0/13
Jun 18 15:21:53 light kernel: usb-storage: -- transfer cancelled
Jun 18 15:21:53 light kernel: usb-storage: Bulk status result = 4
Jun 18 15:21:53 light kernel: usb-storage: -- command was aborted
Jun 18 15:21:53 light kernel: usb-storage: usb_stor_Bulk_reset called
Jun 18 15:21:53 light kernel: usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
Jun 18 15:22:13 light kernel: usb-storage: Timeout -- cancelling URB
Jun 18 15:22:13 light kernel: usb-storage: Soft reset failed: -104
Jun 18 15:22:13 light kernel: usb-storage: scsi command aborted
Jun 18 15:22:13 light kernel: usb-storage: *** thread sleeping.
Jun 18 15:22:13 light kernel: usb-storage: device_reset called
Jun 18 15:22:13 light kernel: usb-storage: usb_stor_Bulk_reset called
Jun 18 15:22:13 light kernel: usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
Jun 18 15:22:33 light kernel: usb-storage: Timeout -- cancelling URB
Jun 18 15:22:33 light kernel: usb-storage: Soft reset failed: -104
Jun 18 15:22:33 light kernel: usb-storage: bus_reset called
Jun 18 15:24:02 light kernel: hub 1-1:1.0: transfer --> -84
Jun 18 15:24:33 light last message repeated 79 times
Jun 18 15:25:00 light last message repeated 71 times

Notice that after several bus reset timeouts, the "-84" error repeats ad-
infinitum.

This particular test was with only uhci_hcd, but the same deadlock occurs
with ehci_hcd as well, though the end result is different only in the
reported error over and over:

Jun 18 14:42:04 light kernel: ehci_hcd 0000:00:1d.7: devpath 2 ep1in 3strikes
Jun 18 14:42:04 light kernel: hub 4-2:1.0: transfer --> -71

Can anyone help, or at least tell me that this is the same problem seen in the
earlier parts of this thread?

Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
  Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
  imorgan at webcon dot ca       PGP: #2DA40D07       www.webcon.ca
     *  Customized Linux Network Solutions for your Business  *
-------------------------------------------------------------------
