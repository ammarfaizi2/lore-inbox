Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129393AbRCRDM7>; Sat, 17 Mar 2001 22:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129381AbRCRDMt>; Sat, 17 Mar 2001 22:12:49 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:43715 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129359AbRCRDM2>; Sat, 17 Mar 2001 22:12:28 -0500
Date: Sat, 17 Mar 2001 22:11:29 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: aleidenf@bigpond.net.au
Cc: linux-kernel@vger.kernel.org, zaitcev@redgat.com
Subject: Re: USB Mouse Problem in 2.4 Kernels - 2.2.18 Works Fine
Message-ID: <20010317221129.A15218@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andree Leidenfrost (aleidenf@bigpond.net.au)

> I am experiencing problems with a USB mouse: The machine boots, X 
> starts, I log on, everything works as expected. When I restart X or just 
> change to an alpha terminal and back to x the mouse does not work any 
> more.  [...]
> Hardware is an ASUS K7V motherboard (VIA chip set), [...]
> T: Bus=01 Lev=02 Prnt=02 Port=02 Cnt=02 Dev#= 5 Spd=1.5 MxCh= 0 

I am working on something similar. 
After a device reset a hub drops PORT_CONNECTION
flag from wPortStatus. The reason is unknown.

Unfortunately, I do not have a hardware that exibits this.
If would be invaluable someone enabled
dbg() in devices/usb/hub.c only, run the test with
BOTH working (2.2) and not working (2.4) kernels
then sent me dmesg. If you do, please tell me precisely what
you were doing to trip this.

Here is an example of a change:

--- linux-2.4.2-0.1.19/drivers/usb/hub.c        Tue Mar 13 12:04:05 2001
+++ linux-2.4.2-0.1.19-p3/drivers/usb/hub.c     Tue Mar 13 13:49:32 2001
@@ -29,6 +29,10 @@

 #include "hub.h"

+/* P3 #23670 run01 */
+#undef dbg
+#define dbg(format, arg...) printk(KERN_DEBUG __FILE__ ": " format "\n" , ## arg)
+
 /* Wakes up khubd */
 static spinlock_t hub_event_lock = SPIN_LOCK_UNLOCKED;
 static DECLARE_MUTEX(usb_address0_sem);

Example output of broken kernel:

ub.c: enabling power on all ports
hub.c: port 1 connection change
hub.c: port 1, portstatus 301, change 1, 1.5 Mb/s
hub.c: port 1, portstatus 303, change 0, 1.5 Mb/s
hub.c: USB new device connect on bus1/1, assigned device number 2
usb.c: USB device 2 (vend/prod 0x458/0x3) is not claimed by any active driver.
usb.c: registered new driver hid
input0: USB HID v1.00 Mouse [KYE Genius USB Wheel Mouse] on usb1:2.0
mouse0: PS/2 mouse device for input0
mice: PS/2 mouse device common for all mice
....................  [ok, works, pulling the cable]
hub.c: port 1 connection change
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
usb.c: USB disconnect on device 2
hub.c: port 1 enable change, status 100
....................  [cable pulled, putting it back]
hub.c: port 1 connection change
hub.c: port 1, portstatus 301, change 1, 1.5 Mb/s
hub.c: port 1, portstatus 100, change 0, 12 Mb/s
hub.c: port 1 of hub 1 not enabled, trying reset again...
hub.c: port 1, portstatus 100, change 0, 12 Mb/s
hub.c: port 1 of hub 1 not enabled, trying reset again...
hub.c: port 1, portstatus 100, change 0, 12 Mb/s
hub.c: port 1 of hub 1 not enabled, trying reset again...
hub.c: port 1, portstatus 100, change 0, 12 Mb/s
hub.c: port 1 of hub 1 not enabled, trying reset again...
hub.c: port 1, portstatus 100, change 0, 12 Mb/s
hub.c: port 1 of hub 1 not enabled, trying reset again...
hub.c: Cannot enable port 1 of hub 1, disabling port.
hub.c: Maybe the USB cable is bad?

Now I need something like that for a working kernel
on the same hardware.

I'll let folks know if I find anything. If anyone wants
to investigate in parallel, it would be appreciated too.

-- Pete
