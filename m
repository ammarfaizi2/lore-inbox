Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267445AbUGNQcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267445AbUGNQcv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 12:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267447AbUGNQcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 12:32:51 -0400
Received: from core.ece.northwestern.edu ([129.105.5.1]:30864 "EHLO
	core.ece.northwestern.edu") by vger.kernel.org with ESMTP
	id S267445AbUGNQcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 12:32:45 -0400
Message-ID: <1089822621.40f55f9dd4278@core.ece.northwestern.edu>
Date: Wed, 14 Jul 2004 11:30:21 -0500
From: lya755@ece.northwestern.edu
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: question about ramdisk
References: <1089651469.40f2c30d44364@core.ece.northwestern.edu>  <ccugqu$tun$1@terminus.zytor.com>  <1089727279.40f3eb2f82a6c@core.ece.northwestern.edu>  <1089749203.22026.17.camel@mindpipe>  <1089753034.40f44fca074c2@core.ece.northwestern.edu> <1089753955.22175.8.camel@mindpipe> <1089817172.40f54a540e0c1@core.ece.northwestern.edu> <Pine.LNX.4.53.0407141154120.16363@chaos>
In-Reply-To: <Pine.LNX.4.53.0407141154120.16363@chaos>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 138.15.107.179
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks so much for the hint! Really appreciate it. I'll try out your 
suggestions.

I am still a bit confused, though. If the code is in ramdisk, then it will be 
mapped to the process address space, which as I understand, does not involve 
any actual data copy and transfer. This sounds very reasonable. But what if 
the code is in hard disk? Would the kernel copy it to memory (somewhere 
allocated) then map this region as the text section for the address space, and 
then run the instructions from ram? That's the way I understand it, but I 
don't know whether that is correct.

Thanks!
Lei

Quoting "Richard B. Johnson" <root@chaos.analogic.com>:

> On Wed, 14 Jul 2004 lya755@ece.northwestern.edu wrote:
> 
> > Hello,
> >
> > I am now thinking of a way to verify what H. Peter Anvin says about the
> > ramdisk, so that I can watch what is going on when the executable is
> running.
> > Is there any way to achieve that besides kernel debugging? I don't really
> want
> > to debug the kernel for now.
> >
> > Can I get the physical address of the text section with it's virtual
> address?
> > If I can know the physical address of the code in ramdisk and can know the
> > physical address of the text section of process address space, maybe this
> can
> > be done.
> >
> > Any suggestions?
> >
> > Lei
> >
> 
> The physical address will do you no good because your process
> uses the virtual address to access everything.
> 
> Do `cat /proc/PID/maps` where PID is a process ID number. You
> will see the virtual address of the executable and runtime
> shared libraries that the task is using. These are memory-mapped
> into the tasks address-space.
> 
> If your code is ANYWHERE, including on a RAM-Disk, it will
> be memory-mapped into your address-space just like what you
> see. This allows everybody to share all the executables and
> all the run-time libraries so they don't need separate copies.
> 
> For instance, here's somebody running the `bash` shell:
> 
> 08048000-0808c000 r-xp 00000000 08:11 1440929    /usr/bin/bash
> 0808c000-08092000 rw-p 00043000 08:11 1440929    /usr/bin/bash
> 08092000-080a2000 rwxp 00000000 00:00 0
> 40000000-4000a000 r-xp 00000000 08:11 475506     /usr/lib/ld-2.0.5.so
> 4000a000-4000b000 rw-p 00009000 08:11 475506     /usr/lib/ld-2.0.5.so
> 4000b000-4000c000 rwxp 00000000 00:00 0
> 4000c000-40010000 r--p 00000000 08:11 163651     /etc/ld.so.cache
> 40010000-40012000 rwxp 00000000 08:11 1030227    /lib/libtermcap.so.2.0.8
> 40012000-40014000 rw-p 00001000 08:11 1030227    /lib/libtermcap.so.2.0.8
> 40014000-4009f000 r-xp 00000000 08:11 475508     /usr/lib/libc-2.0.6.so
> 4009f000-400a5000 rw-p 0008b000 08:11 475508     /usr/lib/libc-2.0.6.so
> [SNIPPED...]
> 
> You can see the virtual address of your own stuff by compiling
> and executing this:
> 
> #include <stdio.h>
> extern char _start;
> extern char _end;
> char dat;
> const char x[]="x";
> 
> int main()
> {
>     char foo;
>     printf("start = %p\n", &_start);
>     printf(" main = %p\n", main);
>     printf(" data = %p\n", &dat);
>     printf("const = %p\n", x);
>     printf("stack = %p\n", &foo);
>     printf("  end = %p\n", &_end);
>     return 0;
> }
> 
> The physical address in RAM could be anywhere. The kernel takes
> pages of RAM from anywhere and makes them look contiguous for
> each task. So what looks like linear address-space is made up
> of (on ix86 0x1000 byte) pages of RAM.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
>             Note 96.31% of all statistics are fiction.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



_________________________________________________________
This message was sent through the NU ECE webmail gateway.
