Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWJRJfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWJRJfL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 05:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWJRJfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 05:35:11 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:5552 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751016AbWJRJfJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 05:35:09 -0400
Message-ID: <4535F47D.4060009@aitel.hist.no>
Date: Wed, 18 Oct 2006 11:31:41 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.19-rc1-mm1 - locks when using "dd bs=1M"
 from card reader
References: <Pine.LNX.4.44L0.0610131408240.6612-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0610131408240.6612-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> Verbose usb-storage debugging messages would help more 
> (CONFIG_USB_STORAGE_DEBUG and CONFIG_USB_DEBUG).  If the kernel hangs very 
> badly you might need to use a serial console to capture all the logging 
> information.
>   
Version information first: This is 2.6.19-rc1, not mm1.  I apparently
forgot to apply the mm1 patch before compiling it.

I got a BUG, which I could write down by getting X out of the way first.
It is repeatable, just ask if I omitted something cruical. On bootup,
the verbose debugging complains about read errors on sdc,
I guess the kernel tries to get the partition table.  I have no idea
why there is read errors - that shouldn't hang anything though.

To bring it down:

dd if=/dev/sdc of=sdc.dump bs=1M

sd 0:0:0:2 ioctl_internal_command return code: 8000002
 :Current: Sense key: Hardware Error
  Additional Sense: End_of_data detected
cut here----
Kernel BUG at [Verbose debugging unavailable]
invalid opcode: 0000 [#1]
cpu:0
EIP: 0060:[<c031f823>] Not tainted VLI
Eflags: 00010002  (2.6.16-rc1 #16)
EIP is at start_unlink_async
eax:00000000 ebx:dfe69180 ecx:e0832020 edx:00000005
esi:dffdb6bc edi:00010021 ebp:dffdb6bc esp:c0664d58
ds:007b es:007b ss:0068
Process swapper . . .
stack . . .
Call trace
ehci_urb_dequeue
unlink1
usb_hcd_unlink_urb
sg_complete
usb_hcd_giveback_urb
qh_completions
ehci_work
ehci_irq
usb_hcd_irq
handle_IRQ_event
handle_fasteoi_irq
do_IRQ

Code 5d e9 8e 31 ff ff f6 43 28 01 75 b8 c7 43 24 00 00 00 00 eb af . . .
<0>Kernel Panic - not syncing fatal exception in interrupt
<0>Rebooting in 300 seconds

It did reboot in 300 seconds, I had to crash twice to get this much written down.
I checked that stuff written down the first time was identical.

Invalid opcode suggest a compiler bug or memory scribble, or possibly
calling a bad function pointer. The crash is trivial to reproduce,
just ask me.

In case it matters:
$ lspci
00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS645DX Host & Memory & AGP Controller
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI bridge (AGP)
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS962 [MuTIOL Media IO] (rev 04)
00:02.1 SMBus: Silicon Integrated Systems [SiS] SiS961/2 SMBus Controller
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] AC'97 Sound Controller (rev a0)
00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f)
00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f)
00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f)
00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller
00:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]


Helge 

