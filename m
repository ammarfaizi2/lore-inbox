Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTICGc6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 02:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbTICGc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 02:32:58 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:37381 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S263590AbTICGcx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 02:32:53 -0400
From: Michael Frank <mhf@linuxmail.org>
To: Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] 2.6.0-test4 - PL2303 OOPS - see also 2.4.22: OOPS on disconnect PL2303 adapter
Date: Wed, 3 Sep 2003 14:32:16 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
References: <200309020139.08248.mhf@linuxmail.org> <200309030613.19800.mhf@linuxmail.org> <20030902235224.GA20901@kroah.com>
In-Reply-To: <20030902235224.GA20901@kroah.com>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309031432.17209.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 September 2003 07:52, Greg KH wrote:
>
> Try the patch below and let me know if this solves it for you or not.

If it is meant to reset the buffers, it has _no_ effect.

Some more observations:

Besides it just stopping without obvious reason: 

1) It does not like when something is typed on cu and not received by the serial port side 
   connected to PL2303 (CTS low). It tends to hang and the trouble starts....

Sep  3 12:52:15 mhfl2 kernel: ttyUSB0: 1 input overrun(s)
Sep  3 12:54:30 mhfl2 last message repeated 2 times
Sep  3 12:55:17 mhfl2 kernel: usb 1-2: USB disconnect, address 2
Sep  3 12:55:17 mhfl2 kernel: usb 1-2: pl2303_write_bulk_callback - failed resubmitting write urb, error -19

cu hang - exit cu _first_, _then_ pull out from hub

Sep  3 12:55:17 mhfl2 kernel: pl2303 1-2:0: device disconnected
Sep  3 12:55:30 mhfl2 kernel: PL-2303 ttyUSB0: PL-2303 converter now disconnected from ttyUSB0

2) When serial port of PL2303 is connected (to a serial port ready to send data)
   and PL2303 is plugged into hub, it does not init:

plug in
Sep  3 12:55:47 mhfl2 kernel: hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
Sep  3 12:55:48 mhfl2 kernel: hub 1-0:0: new USB device on port 2, assigned address 3
Sep  3 12:55:48 mhfl2 kernel: usb 1-2: device not accepting address 3, error -110
pull out, plug in
Sep  3 12:55:48 mhfl2 kernel: hub 1-0:0: new USB device on port 2, assigned address 4
Sep  3 12:55:49 mhfl2 kernel: usb 1-2: device not accepting address 4, error -110
Sep  3 12:56:06 mhfl2 kernel: hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
pull out, plug in
Sep  3 12:56:06 mhfl2 kernel: hub 1-0:0: new USB device on port 2, assigned address 5
Sep  3 12:56:06 mhfl2 kernel: usb 1-2: device not accepting address 5, error -110
Sep  3 12:56:07 mhfl2 kernel: hub 1-0:0: new USB device on port 2, assigned address 6
pull out

_disconnect_ serial port side of PL2303

plug in - OK
Sep  3 12:56:07 mhfl2 kernel: usbserial 1-2:0: PL-2303 converter detected
Sep  3 12:56:07 mhfl2 kernel: usb 1-2: PL-2303 converter now attached to ttyUSB0 (or usb/tts/0 for devfs)

After a while it hang again, this time unloaded USB _without_ exit cu

Sep  3 14:03:42 mhfl2 kernel: usb 1-2: USB disconnect, address 2
Sep  3 14:03:42 mhfl2 kernel: usbserial 1-2:0: device disconnected
Sep  3 14:03:47 mhfl2 kernel: drivers/usb/core/usb.c: deregistering driver usb-storage
Sep  3 14:03:47 mhfl2 kernel: ohci-hcd 0000:00:14.0: remove, state 3
Sep  3 14:03:47 mhfl2 kernel: usb usb1: USB disconnect, address 1
Sep  3 14:03:48 mhfl2 kernel: ohci-hcd 0000:00:14.0: USB bus 1 deregistered
Sep  3 14:03:53 mhfl2 kernel: PL-2303 ttyUSB0: pl2303_write - failed submitting write urb, error -19
Sep  3 14:03:53 mhfl2 kernel: PL-2303 ttyUSB0: PL-2303 converter now disconnected from ttyUSB0
Sep  3 14:03:53 mhfl2 kernel: Unable to handle kernel paging request at virtual address cf8981a8
Sep  3 14:03:53 mhfl2 kernel:  printing eip:
Sep  3 14:03:53 mhfl2 kernel: cf87bd94
Sep  3 14:03:53 mhfl2 kernel: *pde = 012b4067
Sep  3 14:03:53 mhfl2 kernel: *pte = 00000000
Sep  3 14:03:53 mhfl2 kernel: Oops: 0000 [#1]
Sep  3 14:03:53 mhfl2 kernel: CPU:    0
Sep  3 14:03:53 mhfl2 kernel: EIP:    0060:[<cf87bd94>]    Not tainted
Sep  3 14:03:53 mhfl2 kernel: EFLAGS: 00010282
Sep  3 14:03:53 mhfl2 kernel: EIP is at hcd_pci_release+0x14/0x20 [usbcore]
Sep  3 14:03:53 mhfl2 kernel: eax: cf898180   ebx: c03978c0   ecx: cf88b240   edx: c6513234
Sep  3 14:03:53 mhfl2 kernel: esi: 00000001   edi: ccb0c300   ebp: c5aa9de4   esp: c5aa9de0
Sep  3 14:03:53 mhfl2 kernel: ds: 007b   es: 007b   ss: 0068
Sep  3 14:03:53 mhfl2 kernel: Process cu (pid: 6763, threadinfo=c5aa8000 task=c61f72e0)
Sep  3 14:03:53 mhfl2 kernel: Stack: c6513234 c5aa9df0 cf8783c6 c6513234 c5aa9dfc c0233360 c651327c c5aa9e0c 
Sep  3 14:03:53 mhfl2 kernel:        c01d2498 c6513284 cd6c1600 c5aa9e18 c01d24ca c6513284 c5aa9e24 c02336cf 
Sep  3 14:03:53 mhfl2 kernel:        c6513284 c5aa9e30 cf8783ab c651327c c5aa9e44 cf8747ee c6513234 cd6c1600 
Sep  3 14:03:53 mhfl2 kernel: Call Trace:
Sep  3 14:03:53 mhfl2 kernel:  [<cf8783c6>] usb_host_release+0x16/0x1c [usbcore]
Sep  3 14:03:53 mhfl2 kernel:  [<c0233360>] class_dev_release+0x18/0x50
Sep  3 14:03:53 mhfl2 kernel:  [<c01d2498>] kobject_cleanup+0x28/0x44
Sep  3 14:03:53 mhfl2 kernel:  [<c01d24ca>] kobject_put+0x16/0x1c
Sep  3 14:03:53 mhfl2 kernel:  [<c02336cf>] class_device_put+0xf/0x14
Sep  3 14:03:53 mhfl2 kernel:  [<cf8783ab>] usb_bus_put+0x13/0x18 [usbcore]
Sep  3 14:03:53 mhfl2 kernel:  [<cf8747ee>] usb_release_dev+0x3a/0x48 [usbcore]
Sep  3 14:03:53 mhfl2 kernel:  [<c0231b0a>] device_release+0x16/0x50
Sep  3 14:03:53 mhfl2 kernel:  [<c01d2498>] kobject_cleanup+0x28/0x44
Sep  3 14:03:53 mhfl2 kernel:  [<c01d24ca>] kobject_put+0x16/0x1c
Sep  3 14:03:53 mhfl2 kernel:  [<c0231ddb>] put_device+0xf/0x14
Sep  3 14:03:53 mhfl2 kernel:  [<cf874931>] usb_put_dev+0x15/0x1c [usbcore]
Sep  3 14:03:53 mhfl2 kernel:  [<cf92b0b6>] destroy_serial+0x16e/0x180 [usbserial]
Sep  3 14:03:53 mhfl2 kernel:  [<c01d2498>] kobject_cleanup+0x28/0x44
Sep  3 14:03:53 mhfl2 kernel:  [<c01d24ca>] kobject_put+0x16/0x1c
Sep  3 14:03:53 mhfl2 kernel:  [<cf92a31c>] __serial_close+0x84/0x8c [usbserial]
Sep  3 14:03:53 mhfl2 kernel:  [<cf92a3b7>] serial_close+0x93/0xb0 [usbserial]
Sep  3 14:03:53 mhfl2 kernel:  [<c02199ac>] release_dev+0x23c/0x5c8
Sep  3 14:03:53 mhfl2 kernel:  [<c021a058>] tty_release+0xc/0x14
Sep  3 14:03:53 mhfl2 kernel:  [<c014705f>] __fput+0x43/0xd8
Sep  3 14:03:53 mhfl2 kernel:  [<c0147016>] fput+0x16/0x1c
Sep  3 14:03:53 mhfl2 kernel:  [<c0145daf>] filp_close+0x97/0xa4
Sep  3 14:03:53 mhfl2 kernel:  [<c0145e07>] sys_close+0x4b/0x60
Sep  3 14:03:53 mhfl2 kernel:  [<c010adc7>] syscall_call+0x7/0xb
Sep  3 14:03:53 mhfl2 kernel: 
Sep  3 14:03:53 mhfl2 kernel: Code: 8b 40 28 ff d0 89 ec 5d c3 8d 76 00 55 89 e5 83 ec 20 8d 45 

>
> Oh, and where is the copy of /proc/bus/usb/devices with your device
> plugged in?  :)
>

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc= 18/900 us ( 2%), #Int=  1, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-test4-mhf60 ohci-hcd
S:  Product=OHCI Host Controller
S:  SerialNumber=0000:00:14.0
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=067b ProdID=2303 Rev= 2.00
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=pl2303
E:  Ad=81(I) Atr=03(Int.) MxPS=  10 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms

Thank you

Regards
Michael

