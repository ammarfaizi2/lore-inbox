Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285303AbRLXURP>; Mon, 24 Dec 2001 15:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285304AbRLXURF>; Mon, 24 Dec 2001 15:17:05 -0500
Received: from colorfullife.com ([216.156.138.34]:28172 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S285303AbRLXUQy>;
	Mon, 24 Dec 2001 15:16:54 -0500
Message-ID: <002101c18cb7$f575b3c0$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Frank van Maarseveen" <F.vanMaarseveen@inter.NL.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: <=2.4.17 deadlock (RedHat 7.2, SMP, ext3 related?) (2)
Date: Mon, 24 Dec 2001 21:17:00 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank,
could you open your vmlinux file with gdb, and figure out where the 2
stext_lock references lead to?
stext_lock+1c82 just means that it spins trying to acquire a spinlock,
but which one?
IIRC
gdb vmlinux
    $x/30i 0xc03fe0a0
    $x/30i 0xc0403050
should be enough.

>>EIP; c03fe0ba <stext_lock+1c82/e9ac>   <=====
Trace; c0140134 <chrdev_open+28/124>
Trace; c013eba2 <dentry_open+e6/194>
Trace; c013eab2 <filp_open+52/5c>
Trace; c013ee23 <sys_open+4b/140>
Trace; c01076cb <system_call+33/38>

Probably this cpu is spinning in get_chrfops(), trying to acquire the big kernel
lock.

>>EIP; c0403068 <stext_lock+6c30/e9ac>   <=====
    Trace; c016d320 <ext3_delete_inode+0/270>
Trace; c028ee04 <ppp_ioctl+33c/d84>
    Trace; c0159e01 <iput+2c5/2f0>
    Trace; c0156e68 <d_delete+dc/20c>
    Trace; c013f063 <filp_close+133/140>
Trace; c0150bc6 <sys_ioctl+24a/2e4>
    Trace; c028eac8 <ppp_ioctl+0/d84>
Trace; c01076cb <system_call+33/38>

I think the call chain is
system_call
-> calls sys_ioctl.
    acquires the big kernel lock.
    puts ppp_ioctl on the stack (+0: it's a function pointer, not a return value.)
-> calls ppp_ioctl
    and that one locks up.
The references to close/iput/delete_inode are just stale stack values from a previous
syscall.

Please check where stext_lock+6c30 leads: I think the deadlock is somewhere within
ppp_ioctl, and then the system locks up because the big kernel lock is blocked.

--
    Manfred

