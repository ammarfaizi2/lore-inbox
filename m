Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131205AbRCRLw0>; Sun, 18 Mar 2001 06:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131206AbRCRLwQ>; Sun, 18 Mar 2001 06:52:16 -0500
Received: from [139.134.6.78] ([139.134.6.78]:5621 "EHLO mailin5.bigpond.com")
	by vger.kernel.org with ESMTP id <S131205AbRCRLwP>;
	Sun, 18 Mar 2001 06:52:15 -0500
Subject: Re: USB Mouse Problem in 2.4 Kernels - 2.2.18 Works Fine
From: Andree Leidenfrost <aleidenf@bigpond.net.au>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010317221129.A15218@devserv.devel.redhat.com>
Content-Type: text/plain
X-Mailer: Evolution (0.9/+cvs.2001.03.16.09.00 - Preview Release)
Date: 18 Mar 2001 22:50:32 +1100
Mime-Version: 1.0
Message-Id: <20010318115215Z131205-406+1390@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Mar 2001 22:11:29 -0500, Pete Zaitcev wrote:
> > From: Andree Leidenfrost (aleidenf@bigpond.net.au)
> 
> > I am experiencing problems with a USB mouse: The machine boots, X 
> > starts, I log on, everything works as expected. When I restart X or just 
> > change to an alpha terminal and back to x the mouse does not work any 
> > more.  [...]
> > Hardware is an ASUS K7V motherboard (VIA chip set), [...]
> > T: Bus=01 Lev=02 Prnt=02 Port=02 Cnt=02 Dev#= 5 Spd=1.5 MxCh= 0 
> 
> I am working on something similar. 
> After a device reset a hub drops PORT_CONNECTION
> flag from wPortStatus. The reason is unknown.
> 
> Unfortunately, I do not have a hardware that exibits this.
> If would be invaluable someone enabled
> dbg() in devices/usb/hub.c only, run the test with
> BOTH working (2.2) and not working (2.4) kernels
> then sent me dmesg. If you do, please tell me precisely what
> you were doing to trip this.
> 
> Here is an example of a change:
> 
> --- linux-2.4.2-0.1.19/drivers/usb/hub.c        Tue Mar 13 12:04:05 2001
> +++ linux-2.4.2-0.1.19-p3/drivers/usb/hub.c     Tue Mar 13 13:49:32 2001
> @@ -29,6 +29,10 @@
> 
>  #include "hub.h"
> 
> +/* P3 #23670 run01 */
> +#undef dbg
> +#define dbg(format, arg...) printk(KERN_DEBUG __FILE__ ": " format "\n" , ## arg)
> +
>  /* Wakes up khubd */
>  static spinlock_t hub_event_lock = SPIN_LOCK_UNLOCKED;
>  static DECLARE_MUTEX(usb_address0_sem);
> 
> Example output of broken kernel:
> 
> ub.c: enabling power on all ports
> hub.c: port 1 connection change
> hub.c: port 1, portstatus 301, change 1, 1.5 Mb/s
> hub.c: port 1, portstatus 303, change 0, 1.5 Mb/s
> hub.c: USB new device connect on bus1/1, assigned device number 2
> usb.c: USB device 2 (vend/prod 0x458/0x3) is not claimed by any active driver.
> usb.c: registered new driver hid
> input0: USB HID v1.00 Mouse [KYE Genius USB Wheel Mouse] on usb1:2.0
> mouse0: PS/2 mouse device for input0
> mice: PS/2 mouse device common for all mice
> ....................  [ok, works, pulling the cable]
> hub.c: port 1 connection change
> hub.c: port 1, portstatus 100, change 3, 12 Mb/s
> usb.c: USB disconnect on device 2
> hub.c: port 1 enable change, status 100
> ....................  [cable pulled, putting it back]
> hub.c: port 1 connection change
> hub.c: port 1, portstatus 301, change 1, 1.5 Mb/s
> hub.c: port 1, portstatus 100, change 0, 12 Mb/s
> hub.c: port 1 of hub 1 not enabled, trying reset again...
> hub.c: port 1, portstatus 100, change 0, 12 Mb/s
> hub.c: port 1 of hub 1 not enabled, trying reset again...
> hub.c: port 1, portstatus 100, change 0, 12 Mb/s
> hub.c: port 1 of hub 1 not enabled, trying reset again...
> hub.c: port 1, portstatus 100, change 0, 12 Mb/s
> hub.c: port 1 of hub 1 not enabled, trying reset again...
> hub.c: port 1, portstatus 100, change 0, 12 Mb/s
> hub.c: port 1 of hub 1 not enabled, trying reset again...
> hub.c: Cannot enable port 1 of hub 1, disabling port.
> hub.c: Maybe the USB cable is bad?
> 
> Now I need something like that for a working kernel
> on the same hardware.
> 
> I'll let folks know if I find anything. If anyone wants
> to investigate in parallel, it would be appreciated too.
> 
> -- Pete

Here is the output of a 2.2.18 kernel with the above patch:

Mar 18 22:40:18 aurich kernel: usb.c: usb_mouse driver claimed interface
cdbc1960
Mar 18 22:40:26 aurich kernel: hub.c: port 3 connection change
Mar 18 22:40:26 aurich kernel: hub.c: portstatus 100, change 1, 12 Mb/s
Mar 18 22:40:26 aurich kernel: usb.c: USB disconnect on device 4
Mar 18 22:40:43 aurich kernel: hub.c: port 3 connection change
Mar 18 22:40:43 aurich kernel: hub.c: portstatus 301, change 1, 1.5 Mb/s
Mar 18 22:40:43 aurich kernel: hub.c: portstatus 303, change 10, 1.5
Mb/s
Mar 18 22:40:43 aurich kernel: usb.c: USB new device connect, assigned
device number 4
Mar 18 22:40:43 aurich kernel: usb.c: kmalloc IF cdbc19a0, numif 1
Mar 18 22:40:43 aurich kernel: usb.c: skipped 1 class/vendor specific
interface descriptors
Mar 18 22:40:43 aurich kernel: usb.c: new device strings: Mfr=1,
Product=2, SerialNumber=0
Mar 18 22:40:43 aurich kernel: usb.c: USB device number 4 default
language ID 0x409
Mar 18 22:40:43 aurich kernel: Manufacturer: KYE
Mar 18 22:40:43 aurich kernel: Product: Genius USB Wheel Mouse
Mar 18 22:40:43 aurich kernel: mouse0: PS/2 mouse device for input0
Mar 18 22:40:43 aurich kernel: input0: KYE Genius USB Wheel Mouse on
usb1:4.0
Mar 18 22:40:43 aurich kernel: usb.c: usb_mouse driver claimed interface
cdbc19a0
....................  [ok, works, pulling the cable]
Mar 18 22:41:41 aurich kernel: hub.c: port 3 connection change
Mar 18 22:41:41 aurich kernel: hub.c: portstatus 100, change 1, 12 Mb/s
Mar 18 22:41:41 aurich kernel: usb.c: USB disconnect on device 4
....................  [cable pulled, putting it back]
Mar 18 22:41:53 aurich kernel: hub.c: port 3 connection change
Mar 18 22:41:53 aurich kernel: hub.c: portstatus 301, change 1, 1.5 Mb/s
Mar 18 22:41:54 aurich kernel: hub.c: portstatus 303, change 10, 1.5
Mb/s
Mar 18 22:41:54 aurich kernel: usb.c: USB new device connect, assigned
device number 4
Mar 18 22:41:54 aurich kernel: usb.c: kmalloc IF cdbc18e0, numif 1
Mar 18 22:41:54 aurich kernel: usb.c: skipped 1 class/vendor specific
interface descriptors
Mar 18 22:41:54 aurich kernel: usb.c: new device strings: Mfr=1,
Product=2, SerialNumber=0
Mar 18 22:41:54 aurich kernel: usb.c: USB device number 4 default
language ID 0x409
Mar 18 22:41:54 aurich kernel: Manufacturer: KYE
Mar 18 22:41:54 aurich kernel: Product: Genius USB Wheel Mouse
Mar 18 22:41:54 aurich kernel: mouse0: PS/2 mouse device for input0
Mar 18 22:41:54 aurich kernel: input0: KYE Genius USB Wheel Mouse on
usb1:4.0
Mar 18 22:41:54 aurich kernel: usb.c: usb_mouse driver claimed interface
cdbc18e0

Please, let me know if there is anything els I can do.

Thanks a lot & best regards,

    Andree

