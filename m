Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272786AbRIGRUd>; Fri, 7 Sep 2001 13:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272784AbRIGRUO>; Fri, 7 Sep 2001 13:20:14 -0400
Received: from porsta.cs.Helsinki.FI ([128.214.48.124]:14688 "EHLO
	porsta.cs.Helsinki.FI") by vger.kernel.org with ESMTP
	id <S272786AbRIGRUI>; Fri, 7 Sep 2001 13:20:08 -0400
Date: Fri, 7 Sep 2001 20:20:24 +0300 (EEST)
From: Jani Jaakkola <jjaakkol@cs.Helsinki.FI>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.2.19: Fix an APM suspend bug in drivers/usb/uhci.c
Message-ID: <Pine.LNX.4.33.0109071932360.1238-100000@hallikari.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If you are using uhci.c usb driver in a laptop, have apmd installed
and have complex suspend scripts you can get the following behaviour
when doing APM suspend with USB devices (a mouse) attached:

At boot everything works like charm:

<CLIP>
kernel: usb.c: registered new driver usbdevfs
kernel: usb.c: registered new driver hub
kernel: uhci.c: USB UHCI at I/O 0xff80, IRQ 11
kernel: uhci.c: detected 2 ports
kernel: usb.c: new USB bus registered, assigned bus number 1
kernel: usb.c: USB new device connect, assigned device number 1
kernel: hub.c: USB hub found
kernel: hub.c: 2 ports detected
kernel: usb.c: USB new device connect, assigned device number 2
kernel: usb.c: USB device 2 (vend/prod 0x46d/0xc00c) is not claimed by any
activ
e driver.
kernel: usb.c: registered new driver hid
kernel: input0: USB HID v1.10 Mouse [Logitech USB Mouse] on usb1:2.0
kernel: mouse0: PS/2 mouse device for input0
kernel: mice: PS/2 mouse device common for all mice
</CLIP>

But when I suspend my laptop something like this happens (this is a race
condition thing, so you might get different results):

At suspend:
<CLIP>
kernel: usb.c: USB disconnect on device 2
kernel: usb_control/bulk_msg: timeout
kernel: usb.c: USB device not accepting new address (error=-110)
kernel: usb.c: USB new device connect, assigned device number -1
kernel: usb_control/bulk_msg: timeout
kernel: usb.c: USB device not accepting new address (error=-110)
kernel: usb.c: USB disconnect on device -1
</CLIP>

And the host controller hangs. On other laptop I got this when attempting
to remove the USB driver in a suspend script:

<CLIP>
kernel: usb.c: USB disconnect on device 2
kernel: usb.c: USB disconnect on device 1
kernel: usb.c: USB bus 1 deregistered
kernel: Unable to handle kernel paging request at virtual address 8c42f470
kernel: current->tss.cr3 = 00101000, %%cr3 = 00101000
kernel: *pde = 0bcea063
kernel: *pte = 00000000
kernel: Oops: 0000
kernel: CPU:    0
kernel: EIP:
0010:[mousedev:__insmod_mousedev_O/lib/modules/2.2.19-csl2/usb/m
ousedev.o_+-95359/96]
kernel: EFLAGS: 00010286
kernel: eax: 8c42f464   ebx: 8b800e00   ecx: 8b8c3ee8   edx: 8bcebb60
kernel: esi: 8b8c3ee0   edi: 00000064   ebp: 8bcebb60   esp: 8b8c3ec0
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process khubd (pid: 53, process nr: 12, stackpage=8b8c3000)
kernel: Stack: 8bcebb60 8b800e00 80000180 8b91a700 8b8c3fa8 00000282
8b8c3ee0 8b
8c3ee0
kernel:        8b8c2000 8b8c3ed8 8b8c3edc 00000000 00000015 8c41fd99
8bcebb60 00
000064
kernel:        8b8c3f14 8b91a700 00000004 000000a3 00000004 00000282
8c41fe26 8b
800e00
kernel: Call Trace:
[mousedev:__insmod_mousedev_O/lib/modules/2.2.19-csl2/
/usb/mousedev.o_+-94823/96]
[mousedev:__insmod_mousedev_O/lib/modules/2.2.19-csl2/
usb/mousedev.o_+-94682/96]
[mousedev:__insmod_mousedev_O/lib/modules/2.2.19-csl2/
usb/mousedev.o_+-86417/96]
[mousedev:__insmod_mousedev_O/lib/modules/2.2.19-csl2/
usb/mousedev.o_+-84714/96]

<SNIP more of the same >
kernel: Code: 8b 40 0c ff d0 83 c4 04 c3 89 f6 b8 ed ff ff ff c3 89 f6 8b
</CLIP>

And the usb controller hangs.

This is reproducible on several Toshiba portege 3480 laptops with
the following USB Controller reported by lspci:
00:07.2 USB Controller: Intel Corporation 82440MX USB Universal Host Controller

And Toshiba portege 7100 laptops with the following USB host controller
reported by lspci:
00:05.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)

This happens because uhci.o resets the usb host controller with call to
reset_hc() when it receives PM_SUSPEND apm event. This works when apmd is
not running, since hardware enters suspend state almost immediately and
the usb controller is reinitialized to correct state immediately after
suspend. However, when apmd is running, it might take several seconds
(and in our setup it does) before the hw actually enters suspend state
and during this time the usb controller is in uninitalized state, which
confuses hub.c.

The usb-uhci driver has same kinds of problems which probably can be fixed
which I suspect could be fixed with almost exactly the same patch (I
havent tried patching it). However, it seems to cope better with the
problem and the driver actually works also after suspend. (Anyways, why
there is two almost exactly identical drivers for same hardware?)

Here is a patch against drivers/usb/uhci.c which works for me. Hmm. It
seems that hub.c still barfs, but at least the controller does not hang.
I am not a kernel or hardware hacker, so I would love to hear if I am doing
the Right Thing. Please Cc your replys to me, since I am not on the list.

--- uhci.c.orig Fri Sep  7 18:56:41 2001
+++ uhci.c      Fri Sep  7 18:56:00 2001
@@ -2078,10 +2078,16 @@
        nested_unlock(&uhci->urblist_lock, flags);
 }

-static void reset_hc(struct uhci *uhci)
+static void suspend_hc(struct uhci *uhci)
 {
        unsigned int io_addr = uhci->io_addr;
+       outw(USBCMD_EGSM, io_addr + USBCMD);
+}

+static void reset_hc(struct uhci *uhci)
+{
+       unsigned int io_addr = uhci->io_addr;
+       info("reset_hc called");
        /* Global reset for 50ms */
        outw(USBCMD_GRESET, io_addr + USBCMD);
        wait_ms(50);
@@ -2418,7 +2424,7 @@
        struct uhci *uhci = dev->data;
        switch (rqst) {
        case PM_SUSPEND:
-               reset_hc(uhci);
+               suspend_hc(uhci);
                break;
        case PM_RESUME:
                reset_hc(uhci);

- Jani

