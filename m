Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270441AbTGWJQl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 05:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271179AbTGWJQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 05:16:41 -0400
Received: from ns.bmstu.ru ([195.19.32.2]:58896 "EHLO soap.bmstu.ru")
	by vger.kernel.org with ESMTP id S270441AbTGWJQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 05:16:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Serge A. Suchkov" <ss@e1.bmstu.ru>
Reply-To: ss@e1.bmstu.ru
Organization: BMSTU
To: "lkml" <linux-kernel@vger.kernel.org>
Subject: [Oops report]: 2.6.0-test1-ac1 oops in umount mass-storage device
Date: Wed, 23 Jul 2003 13:25:14 +0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <03072313251400.10306@XP1700>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Today I have oops in 2.6.0-test1-ac1, described below.
I have USB plugged CF card Reader/Writer with CF card inside.
I'm mount this device as SCSI /dev/sda1 device 

Next actions I'm comment by my dmesg output ...

1) Eject CF card from CF Reader without umount, and insert CF in digital 
camera (now camera not connected)

usb 1-1: USB disconnect, address 6
usb 1-2: USB disconnect, address 2
usb-storage: storage_disconnect() called
usb-storage: usb_stor_stop_transport called
usb-storage: -- dissociate_dev
usb-storage: -- sending exit command to thread
usb-storage: *** thread awakened.
usb-storage: -- exit command received
usb-storage: -- usb_stor_release_resources finished
hub 1-0:0: debounce: port 2: delay 400ms stable 0 status 0x100
hub 1-0:0: connect-debounce failed, port 2 disabled
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101

2) Connect my digital camera from USB (use usbdevfs), CF inside camera...

hub 1-0:0: new USB device on port 1, assigned address 7
usb 1-1: USB device not accepting new address=7 (error=-110)
hub 1-0:0: new USB device on port 1, assigned address 8

2) Start digikam and download photo files from CF card ...

usbfs: process 1445 (digikam) did not claim interface 1 before use

3) Kernel report about errors on /dev/sda1, OK.

bio too big device sda1 (1 > 0)
FAT: Directory bread(block 127) failed
bio too big device sda1 (1 > 0)
FAT: Directory bread(block 128) failed
bio too big device sda1 (1 > 0)
FAT: Directory bread(block 129) failed
bio too big device sda1 (1 > 0)
-- skip --
bio too big device sda1 (1 > 0)
FAT: Directory bread(block 156) failed
bio too big device sda1 (1 > 0)
FAT: Directory bread(block 157) failed
bio too big device sda1 (1 > 0)
FAT: Directory bread(block 158) failed

4) Disconnect my digital camera

usb 1-1: USB disconnect, address 8
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 2, assigned address 9
usb 1-2: USB device not accepting new address=9 (error=-110)
hub 1-0:0: new USB device on port 2, assigned address 10
usb 1-2: USB device not accepting new address=10 (error=-110)

5) Try umount /dev/sda1. CF Reader now empty...

Unable to handle kernel NULL pointer dereference at virtual address 000000a8
 printing eip:
c029c737
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c029c737>]    Tainted: P  
EFLAGS: 00010286
EIP is at scsi_device_put+0x7/0x60
eax: 00000000   ebx: 00000000   ecx: c7e520c0   edx: ffffffff
esi: c7e5e140   edi: c7e5e140   ebp: c5009ec0   esp: c5009ebc
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 1747, threadinfo=c5008000 task=c6bc19c0)
Stack: 00000000 c5009ed4 c02a4957 00000000 00000000 00000003 c5009f00 
c01621a2 
       c6c4e940 00000000 c7e5e158 c7e520c0 c6c4e940 00000000 00000000 
00000000 
       c7e5e0c0 c5009f2c c0162160 c7e5e140 00000003 c7e5e0d8 c7e520c0 
c6c4e800 
Call Trace:
 [<c02a4957>] sd_release+0x37/0x60
 [<c01621a2>] blkdev_put+0x1c2/0x1e0
 [<c0162160>] blkdev_put+0x180/0x1e0
 [<c0160a6c>] kill_block_super+0x3c/0x50
 [<c015fb5e>] deactivate_super+0x7e/0xe0
 [<c01767ac>] sys_umount+0x3c/0x80
 [<c0176809>] sys_oldumount+0x19/0x20
 [<c01092eb>] syscall_call+0x7/0xb

Code: ff 88 a8 00 00 00 8b 40 68 8b 40 44 8b 00 85 c0 74 20 bb 00 

Of course my actions look like stupid ;) 
but  2.4.22-pre6 (in same situation) no oops

 
In additional:

my /proc/modules

nvidia 1614152 8 - Live 0xccc47000
ipt_REJECT 6016 7 - Live 0xcca7c000
ipt_LOG 5184 6 - Live 0xcca79000
iptable_filter 2688 1 - Live 0xcca04000
uhci_hcd 32264 0 - Live 0xcca84000
ehci_hcd 24576 0 - Live 0xcca72000
ohci_hcd 18112 0 - Live 0xcca6c000
usb_storage 108304 1 - Live 0xcca2e000
usbcore 111188 6 uhci_hcd,ehci_hcd,ohci_hcd,usb_storage, Live 0xcca4f000
snd_ali5451 23428 3 - Live 0xcca17000
snd_ac97_codec 51332 1 snd_ali5451, Live 0xcca20000
capability 8132 0 - Live 0xcca06000
ip_tables 18368 3 ipt_REJECT,ipt_LOG,iptable_filter, Live 0xcca09000
ide_scsi 16064 0 - Live 0xcc9fd000
i2c_ali1535 7108 0 - Live 0xcc9be000
i2c_isa 1792 0 - Live 0xcc9d5000
i2c_dev 10176 0 - Live 0xcc9ea000
i2c_core 24772 3 i2c_ali1535,i2c_isa,i2c_dev, Live 0xcc9ef000
msr 2816 0 - Live 0xcc9d3000
cpuid 2432 0 - Live 0xcc9d1000
bsd_comp 5824 0 - Live 0xcc9ce000
pppoe 15552 0 - Live 0xcc9e1000
pppox 4104 1 pppoe, Live 0xcc9c1000
ppp_generic 31112 3 bsd_comp,pppoe,pppox, Live 0xcc9d8000
slip 14432 0 - Live 0xcc9c9000
slhc 7424 2 ppp_generic,slip, Live 0xcc9a1000
rtc 12900 0 - Live 0xcc9c4000
nls_koi8_r 5056 1 - Live 0xcc9ac000
nls_cp866 5056 1 - Live 0xcc9a4000
vfat 15872 2 - Live 0xcc9a7000
fat 49376 1 vfat, Live 0xcc9b0000

Regards,

/SS
