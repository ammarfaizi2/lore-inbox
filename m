Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264061AbSIVQDb>; Sun, 22 Sep 2002 12:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264327AbSIVQDb>; Sun, 22 Sep 2002 12:03:31 -0400
Received: from pa91.banino.sdi.tpnet.pl ([213.76.211.91]:43269 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S264061AbSIVQDa>; Sun, 22 Sep 2002 12:03:30 -0400
Subject: Re: Oops in usb_submit_urb with US_FL_MODE_XLATE (2.4.19 and 2.4.20-pre7)
In-Reply-To: <20020921225346.GA29052@kroah.com>
To: Greg KH <greg@kroah.com>
Date: Sun, 22 Sep 2002 18:08:30 +0200 (CEST)
CC: Marek Michalkiewicz <marekm@amelek.gda.pl>, mdharm-usb@one-eyed-alien.net,
       linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E17t9Hb-0006yp-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you try the patch at:
> 	http://marc.theaimsgroup.com/?l=linux-usb-devel&m=103255250215947&w=2
> for 2.4.20-pre7 and see if it fixes your problem?

It doesn't - consistent Oops about 40 seconds after boot (all drivers
compiled into the kernel), even if I don't try accessing the device,
disconnecting it, or anything like that.  After the Oops, any process
trying to access /dev/sda gets stuck forever in D state with WCHAN
scsi_block_when_processing_errors.  The rest of the USB subsystem
seems to work fine - the mouse is still working...

Another Oops (not as consistent, happens only sometimes) is in kfree(),
which would indicate a bad pointer somewhere, but I don't have that one
saved, as it happens in swapper task and klogd has no chance to log it.
I can try to write down more details if that would be helpful though.

EIP = 0xc012be28
c012bd54 T kmem_cache_free
c012bdfc T kfree
c012beac T kmem_cache_size

None of this happens without the US_FL_MODE_XLATE flag...
Then I get "test WP failed" instead of "Write Protect is off", none of
the "Command will be truncated to fit in SENSE6 buffer" messages, no
disconnect, and no Oops.

Below are the relevant kernel messages.

Marek

Sep 22 17:36:27 mm kernel: hub.c: new USB device 00:07.2-1, assigned address 2
Sep 22 17:36:27 mm kernel: usb-uhci.c: interrupt, status 2, frame# 1295
Sep 22 17:36:27 mm kernel: usb_control/bulk_msg: timeout
Sep 22 17:36:27 mm kernel: scsi2 : SCSI emulation for USB Mass Storage devices
Sep 22 17:36:27 mm kernel:   Vendor: Datafab   Model: KECF-USB          Rev: 0113
Sep 22 17:36:27 mm kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Sep 22 17:36:27 mm kernel: Attached scsi removable disk sda at scsi2, channel 0, id 0, lun 0
Sep 22 17:36:27 mm kernel: SCSI device sda: 125185 512-byte hdwr sectors (64 MB)
Sep 22 17:36:27 mm kernel: usb-storage: Command will be truncated to fit in SENSE6 buffer.
Sep 22 17:36:27 mm kernel: sda: Write Protect is off
Sep 22 17:36:27 mm kernel:  sda: sda1
Sep 22 17:36:27 mm kernel: WARNING: USB Mass Storage data integrity not assured
Sep 22 17:36:27 mm kernel: USB Mass Storage device found at 2
Sep 22 17:36:27 mm kernel: hub.c: new USB device 00:07.2-2, assigned address 3
Sep 22 17:36:27 mm kernel: input0: USB HID v1.00 Mouse [KYE Genius USB Wheel Mouse] on usb1:3.0

Sep 22 17:36:31 mm kernel: usb-storage: Command will be truncated to fit in SENSE6 buffer.
Sep 22 17:36:31 mm kernel: usb-storage: Command will be truncated to fit in SENSE6 buffer.
Sep 22 17:37:08 mm kernel: usb.c: USB disconnect on device 00:07.2-1 address 2
Sep 22 17:37:08 mm kernel: Unable to handle kernel paging request at virtual address 00140021
Sep 22 17:37:08 mm kernel:  printing eip:
Sep 22 17:37:08 mm kernel: c02a4811
Sep 22 17:37:08 mm kernel: *pde = 00000000
Sep 22 17:37:08 mm kernel: Oops: 0000
Sep 22 17:37:08 mm kernel: CPU:    0
Sep 22 17:37:08 mm kernel: EIP:    0010:[usb_submit_urb+25/48]    Not tainted
Sep 22 17:37:08 mm kernel: EFLAGS: 00010206
Sep 22 17:37:08 mm kernel: eax: 00140005   ebx: d3cff000   ecx: d3a5be78   edx: d3e43ec0
Sep 22 17:37:08 mm kernel: esi: 0000012c   edi: d3a5a000   ebp: d3a5be78   esp: d3a5be58
Sep 22 17:37:08 mm kernel: ds: 0018   es: 0018   ss: 0018
Sep 22 17:37:08 mm kernel: Process scsi_eh_2 (pid: 29, stackpage=d3a5b000)
Sep 22 17:37:08 mm kernel: Stack: c02a4902 d3e43ec0 d3cff000 85033b80 d3e27320 d3e272c0 00000109 d3a5be88
Sep 22 17:37:08 mm kernel:        d3a5be90 d3a5be90 00000000 00000000 00000000 d3a5a000 d3a5be78 d3a5be78
Sep 22 17:37:08 mm kernel:        c02a4a63 d3e43ec0 0000012c d3a5beb8 d3e27320 00000012 00000080 00000012
Sep 22 17:37:08 mm kernel: Call Trace:    [usb_start_wait_urb+138/396] [usb_internal_control_msg+95/116] [usb_control_msg+123/152] [usb_get_descriptor+150/176] [usb_reset_device+377/809]
Sep 22 17:37:08 mm kernel:   [bus_reset+93/336] [scsi_try_bus_reset+59/136] [scsi_unjam_host+1290/2416] [scsi_error_handler+317/412] [kernel_thread+40/56]
Sep 22 17:37:08 mm kernel:
Sep 22 17:37:08 mm kernel: Code: 8b 40 1c 85 c0 74 0a 52 8b 40 0c ff d0 83 c4 04 c3 b8 ed ff
Sep 22 17:37:08 mm kernel:  <6>hub.c: new USB device 00:07.2-1, assigned address 4
Sep 22 17:37:09 mm kernel: WARNING: USB Mass Storage data integrity not assured
Sep 22 17:37:09 mm kernel: USB Mass Storage device found at 4

