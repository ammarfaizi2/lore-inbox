Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264963AbSKNQhM>; Thu, 14 Nov 2002 11:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264968AbSKNQhM>; Thu, 14 Nov 2002 11:37:12 -0500
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:5761 "EHLO
	mtiwmhc13.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S264963AbSKNQhK>; Thu, 14 Nov 2002 11:37:10 -0500
Message-ID: <XFMail.20021114114355.f.duncan.m.haldane@worldnet.att.net>
X-Mailer: XFMail 1.5.3 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.33L2.0211132116580.1569-100000@dragon.pdx.osdl.net>
Date: Thu, 14 Nov 2002 11:43:55 -0500 (EST)
From: Duncan Haldane <f.duncan.m.haldane@worldnet.att.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [OOPS] Help needed for usb semaphore lock in 2.4.20-rc1 (since 2.4.13)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 14-Nov-2002 Randy.Dunlap wrote:
>| Hi,
> 
> On Thu, 14 Nov 2002, Duncan Haldane wrote:
> 
>| I am the current maintainer of the cpia webcam driver.
>|
>| I am tracking down a kernel Oops in 2.4.20-rc1 that was first
>| introduced in 2.4.13 by usb semaphore locking changes in usb.c,
>| and which was reported a while back on this list. See:
>|  http://www.uwsg.iu.edu/hypermail/linux/kernel/0208.1/1504.html
>| The Ooops occurs when the  system boots  if usb, video4linux ,
>| cpia and cpia_usb are compiled into the kernel.
>| There is no problem if they are compiled as modules.
>|
>|
>| No changes in the cpia drivers occurred when the Ooops was
>| introduced in 2.4.13.  usb_cpia-init() in drivers/media/video/cpia_usb.c
>| calls usb_register() in drivers/usb/usb.c to register itself.   \
>| usb_register() calls usb_scan_devices().  The Oops occurs when
>| the usb list is locked  in usb_scan_devices(), by a call to
>| " down (&usb_bus_list_lock);".
>| The result is: "Unable to handle kernel NULL pointer dereference at
>| virtual address 00000000","Oops: 0002".
> 
> It's good to have this info, but do you also have the decoded
> Oops (ksymoops output)?  I'd like to see the code sequence etc.,
> unless someone else just posts a patch first.  :)
> 
I couldn get ksymoops to give me anything useful,   there is a kernel panic
after the oops and the kernel is unbootable.  If I comment out the problematic
lock and recompile, the kernel boots, but is changed and the ksyms file doesnt
match.

This problem is reproducible in any 2.4 kernel since 2.4.13.   I tracked it
down to the lock by hacking in lots of printk 's. to see exactly where the
Oops occurred.....   The call to down() seems to invoke some inline asm code
in include/asm-i386/semaphore.h    and I can't go further to see what the
problem was.

I hope someone knowledgeable can help!
In particular, can this be fixed by initializing something in cpia_usb.c
by adding something to the declaration: 

static struct usb_driver cpia_driver = {
        name:           "cpia",
        probe:          cpia_probe,
        disconnect:     cpia_disconnect,
        id_table:       cpia_id_table,
};


Or is it completely a usb.c problem outside my scope as cpia maintainer?

For what its worth, here is a manually transcribed oops console screen:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
Printing eip
c0113e0a
*pde = 00000000
Oops: 0002
CPU:  0
EIP:  0010:[<c0113e0a>]   Not tainted
EFLAGS: 00010002
eax: c0342ea8  ebx: 00000000 ecx: c143ff84  edx: c143777c
esi: 00000202  edi: c0105000 ebp: c143ff74  esp: c143ff6c
ds: 0018  es: 0018 ss:  0018
Process swapper (pid: 1, stackpage=c143f000 )
Stack: c0324ea0 c143e000 c143ff94 c0105bab 00000001 c143e000 c0324ea8 00000000 
       c02b77c0 c02e5fbc c143ffa8 c0105d27 c0324ea0 c02df2a0 c02b7710 c143ffb4
       c0204b6f c02b77c0 c143ffc0 c02019eb c02fb920 c143ffcc c02f25a7 c02b77c0
Call trace: [<c0105bab>] [<c0105d27>] [<c0204b6f>][c02019eb>][c010503b>]
            [<c0105636>] [<c0105000>] [<c0105030>]
Code: 89 0b 56 9d 5b 5e 5d c3 8d b4 26 00 00 00 00 8d bc 27 00 00
<0>Kernel panic: Attempted to kill init!


Thanks
Duncan

