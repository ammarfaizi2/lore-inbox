Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264118AbTLAXWZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 18:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264235AbTLAXWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 18:22:25 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:4293 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264118AbTLAXWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 18:22:23 -0500
Date: Mon, 01 Dec 2003 15:22:11 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1620] New: Kernel oops when pulling out a USB device which is stillin use 
Message-ID: <117740000.1070320931@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1620

           Summary: Kernel oops when pulling out a USB device which is still
                    in use
    Kernel Version: 2.6.0-test11 (all 2.4 and 2.6 versions in fact)
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: paul@acorp.ro


Distribution: Fedora Core 1
Hardware Environment: IBM ThinkPad T23/T30/T40
Software Environment: NA
Problem Description:
If a USB device which is in use, is pulled out without stopping the processes
which uses them, usualy give a kernel oops, and sometimes hangs the machine.
After kernel oops, if the machine is still usable, it is not stable any more.
I know is not good to take out a USB device while still in use, but this should
not affect the kernel, or hang the machine.

Steps to reproduce:
Use a USB device, then pull it out before finising using it.
For instance lets take a USB to serial converter based on pl2303 chipset:
Plug the USB to Serial converter in USB port.
do "cat /dev/ttyUSB0" in one xterm console
pull out the USB serial converter (while it is in use in the other console)
press Ctrl+C in the xterm console where the "cat /dev/ttyUSB0" was issued
and you'll have something like this:
(note that this output is from Fedora original kernel, but you get same results
from a 2.6.0-test11 kernel)
usb.c: registered new driver serial
usbserial.c: USB Serial support registered for Generic
usbserial.c: USB Serial Driver core v1.4
usbserial.c: USB Serial support registered for PL-2303
usbserial.c: PL-2303 converter detected
usbserial.c: PL-2303 converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.9
usb-uhci.c: interrupt, status 3, frame# 1
usb.c: USB disconnect on device 00:07.2-1 address 2
usb.c: USB disconnect on device 00:07.2-1.1 address 3
usb.c: USB disconnect on device 00:07.2-1.2 address 4
Unable to handle kernel NULL pointer dereference at virtual address 00000998
 printing eip:
f08e94da
*pde = 00000000
Oops: 0002
pl2303 usbserial printer parport_pc lp parport autofs rfcomm l2cap bluez tulip
floppy sg scsi_mod keybdev mousedev 
hid input usb-uhci usbcore ext3 jbd  
CPU:    0
EIP:    0060:[<f08e94da>]    Not tainted
EFLAGS: 00010246

EIP is at usb_serial_disconnect [usbserial] 0x6a (2.4.22-1.2115.nptl)
eax: 00000000   ebx: ea1c3000   ecx: ea574000   edx: ea1c3000
esi: ea1c301c   edi: 00000000   ebp: ea1c3000   esp: ef7adeec
ds: 0068   es: 0068   ss: 0068
Process khubd (pid: 74, stackpage=ef7ad000)
Stack: ea1c301c 00000000 edcba540 f08eb480 f08eb460 00000000 edcba640 f0830274 
       eeee8a00 ea1c3000 eeee8a04 00000004 00000000 eeee8a00 eeee8604 f0840d40 
       0000000e edcba400 f0830314 eeee8710 edcba400 eeee8604 00000002 00000018 
Call Trace:   [<f08eb480>] usb_serial_driver [usbserial] 0x20 (0xef7adef8)
[<f08eb460>] usb_serial_driver [usbserial] 0x0 (0xef7adefc)
[<f0830274>] usb_disconnect_R1a2445d3 [usbcore] 0x94 (0xef7adf08)
[<f0840d40>] hub_driver [usbcore] 0x0 (0xef7adf28)
[<f0830314>] usb_disconnect_R1a2445d3 [usbcore] 0x134 (0xef7adf34)
[<f08330cf>] usb_hub_port_connect_change [usbcore] 0x26f (0xef7adf60)
[<f0832b2c>] usb_hub_port_status [usbcore] 0x6c (0xef7adf74)
[<f08333b8>] usb_hub_events [usbcore] 0x2d8 (0xef7adf94)
[<f0833446>] usb_hub_thread [usbcore] 0x36 (0xef7adfc0)
[<f0833410>] usb_hub_thread [usbcore] 0x0 (0xef7adfc4)
[<f0833410>] usb_hub_thread [usbcore] 0x0 (0xef7adfe0)
[<c010727d>] kernel_thread_helper [kernel] 0x5 (0xef7adff0)


Code: c7 80 98 09 00 00 00 00 00 00 8d 4e 58 ff 43 74 0f 8e 74 05


