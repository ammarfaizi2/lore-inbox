Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129249AbRBAOOh>; Thu, 1 Feb 2001 09:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129415AbRBAOO1>; Thu, 1 Feb 2001 09:14:27 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.138.204]:43021 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S129249AbRBAOOP>; Thu, 1 Feb 2001 09:14:15 -0500
Date: Thu, 1 Feb 2001 14:14:09 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: <linux-kernel@vger.kernel.org>
Subject: Serious reproducible 2.4.x kernel hang
Message-ID: <Pine.LNX.4.30.0102011406210.14706-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've just managed to reproduce this personally on 2.4.0. I've had a report
that 2.4.1 is also affected. Both myself and the other person who
reproduced this have SMP i686 machines, which may or may not be relevant.

To reproduce, all you need to do is get my vsftpd ftp server:
ftp://ferret.lmh.ox.ac.uk/pub/linux/vsftpd-0.0.9.tar.gz

It runs from inetd. Connect using the Linux command line ftp client, to
localhost, and simply press CTRL-C. If it matters, I'm using RH7.0
software.

After the first iteration of this, I'm left with:
[chris@localhost chris]$ ps auwx | grep ftp
root       713 99.9  0.4  1416  592 ?        SN   22:01  38:17 vsftpd
/etc/vsftpd.conf
nobody     715  0.0  0.0     0    0 ?        ZN   22:01   0:00 [vsftpd
<defunct>]

As you can see, the root process is burning 100% of one of my CPUs. It
_cannot_ be killed with kill -9!

>From Alt-Sysrq-T:
Jan 30 22:01:52 localhost kernel: vsftpd    S 00000000   860   713    670
715
 (NOTLB)
Jan 30 22:01:52 localhost kernel: Call Trace:
[smp_apic_timer_interrupt+240/272] [smp_apic_timer_interrupt+240/272]
[update_process_times+32/160] [smp_apic_timer_interrupt+240/272]
[remove_wait_queue+6/48] [wait_for_packet+273/288]
[skb_recv_datagram+205/240]
Jan 30 22:01:52 localhost kernel:        [unix_dgram_recvmsg+69/256]
[sock_recvmsg+53/176] [sock_read+134/144] [sys_read+150/208]
[system_call+51/56]
Jan 30 22:01:52 localhost kernel: vsftpd    Z C5E07040  1408   715    713
 (L-TLB)
Jan 30 22:01:52 localhost kernel: Call Trace: [do_exit+628/672]
[system_call+51/56]

As we can see, the 100% CPU broken process has got stuck in a blocking
read() on a unix socket.

If I repeat the ftp connect/CTRL-C process again, I get a totally dead
machine.

Hope this is sufficient info. I'll try and write a minimal test case.

Cheers
Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
