Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317817AbSGVUtx>; Mon, 22 Jul 2002 16:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317818AbSGVUtx>; Mon, 22 Jul 2002 16:49:53 -0400
Received: from rj.SGI.COM ([192.82.208.96]:38081 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S317817AbSGVUtv>;
	Mon, 22 Jul 2002 16:49:51 -0400
Message-ID: <3D3C6628.37AA6167@sgi.com>
Date: Mon, 22 Jul 2002 13:08:08 -0700
From: Aniket Malatpure <aniket@sgi.com>
Organization: Silicon Graphics Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.4-rtl i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Taavo Raykoff <traykoff@snet.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 IDE channels block each other under load?
References: <fa.e5te67v.1s3m1qr@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

In the IDE Protocol, only 1 DMA transfer can take place on the bus at
one time.
So if the IDE  bus is busy doing the DMA transfer for 1 drive, the other
drive cannot receive any commands.

I guess what does happen is that the IDE driver in the kernel doesnt
distribute commands in a "fair" manner between drive 0 & drive 1. If it
receives commands for drive 0, it keeps sending those commands to the
drive 0, one after the other, without checking if there is a command for
drive 1.

A driver distributing commands in a "fair" manner would send 1 command
to drive 0, check if there is a command for drive 1, if there is, it
would send a command to drive 1, then send the next command to drive 0
and so on...

The above is a guess...would anyone care to verify?

Thanks
Aniket







Taavo Raykoff wrote:
> 
> Can someone tell me what is going on here?
> 
> dd if=/dev/zero of=/dev/hda bs=1024 count=1000000
> 
> then in another vt:
> fdisk /dev/hdc, then immediately press "q".
> 
> fdisk "hangs" for a long, long time.
> ps -aux says state of dd and fdisk are both "D"
> strace says fdisk is hanging on the close()
> /proc/interrupts tell me that ide1 (/dev/hdc) is getting no
>  int activity for a long, long time. ide0 is very busy.
> 
> It is not just dd/fdisk.  Any intensive writes on one IDE
> channel (direct to the hd? device) seem to block any IO on
> the other device.
> 
> Intel SAI2 MB, ServerWorks IDE chipset, 2.4.18, two IDE
> hard drives /dev/hda and /dev/hdc, 1024MB RAM, RH73 kernel
> build.
> 
> Also seen on Promise PDCx IDE controllers hanging off the PCI.
> 
> hdparm settings appear to have no influence on this behavior.
> 
> Thanks,
> TR.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
