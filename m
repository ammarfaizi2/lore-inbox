Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266687AbUAWWT6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 17:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUAWWT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 17:19:58 -0500
Received: from smtp03.web.de ([217.72.192.158]:523 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S266667AbUAWWTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 17:19:51 -0500
Date: Fri, 23 Jan 2004 23:20:25 +0100
From: Arne Ahrend <aahrend@web.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: No hot_UN_plugging of PCMCIA network cards
Message-Id: <20040123232025.4a128ead.aahrend@web.de>
In-Reply-To: <20040122213757.H23535@flint.arm.linux.org.uk>
References: <20040122210501.40800ea7.aahrend@web.de>
	<20040122213757.H23535@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jan 2004 21:37:57 +0000
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> It works for me - with pcnet_cs.  Do you have ipv6 configured into the
> kernel?

No.

> Anyway, I'd be useful if you can reproduce the unkillable process, then
> dump the task state (sysrq-t) and send the trace for the hung ifconfig
> process.

I had to compile sysrq in first, so it is a different kernel now. At least 
the kernel data line in /proc/iomem has changed, so I include the new version:
/proc/iomem
===========
00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000cc000-000ccfff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-00263fae : Kernel code
  00263faf-002faebf : Kernel data
10000000-10000fff : 0000:00:0a.0
  10000000-10000fff : yenta_socket
10001000-10001fff : 0000:00:0a.1
  10001000-10001fff : yenta_socket
10400000-107fffff : PCI CardBus #01
10800000-10bfffff : PCI CardBus #01
10c00000-10ffffff : PCI CardBus #05
11000000-113fffff : PCI CardBus #05
a0000000-a0000fff : card services
c0000000-c3ffffff : 0000:00:08.0
  c0000000-c03fffff : vesafb


After unplugging the card without bringing the interface down manually first
I called /sbin/ifconfig which would not return. The trace shows two instances
of ifconfig, both with STAT 'D'. The first ifconfig originated from the system
attempting to bring the removed interface down:


from /var/log/kern.log
======================

Jan 23 22:16:50 westley kernel: ifconfig      D C0320BB0     0   944    935                     (NOTLB)
Jan 23 22:16:50 westley kernel: c46cfe5c 00000086 c02d417c c0320bb0 c46ce000 c46ce000 c46cfe5c c7d5ad80 
Jan 23 22:16:50 westley kernel:        c7d5ada0 0000aa02 78145672 000008e8 c7d5b560 c02d81a0 00000000 c46ce000 
Jan 23 22:16:50 westley kernel:        c7d5b3a0 c0107af9 c02d81a8 00000001 c7d5b3a0 c0114a80 c437befc c02d81a8 
Jan 23 22:16:50 westley kernel: Call Trace:
Jan 23 22:16:50 westley kernel:  [__down+153/288] __down+0x99/0x120
Jan 23 22:16:50 westley kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Jan 23 22:16:50 westley kernel:  [pcmcia_deregister_client+232/368] pcmcia_deregister_client+0xe8/0x170
Jan 23 22:16:50 westley kernel:  [__down_failed+8/12] __down_failed+0x8/0xc
Jan 23 22:16:50 westley kernel:  [.text.lock.rtnetlink+5/44] .text.lock.rtnetlink+0x5/0x2c
Jan 23 22:16:50 westley kernel:  [unregister_netdev+10/32] unregister_netdev+0xa/0x20
Jan 23 22:16:50 westley kernel:  [__crc_generic_cont_expand+1685282/3842928] pcnet_detach+0x4c/0x90 [pcnet_cs]
Jan 23 22:16:50 westley kernel:  [__crc_generic_cont_expand+1690335/3842928] pcnet_close+0x49/0x50 [pcnet_cs]
Jan 23 22:16:50 westley kernel:  [dev_close+125/128] dev_close+0x7d/0x80
Jan 23 22:16:50 westley kernel:  [dev_change_flags+81/288] dev_change_flags+0x51/0x120
Jan 23 22:16:50 westley kernel:  [devinet_ioctl+633/1488] devinet_ioctl+0x279/0x5d0
Jan 23 22:16:50 westley kernel:  [inet_ioctl+132/192] inet_ioctl+0x84/0xc0
Jan 23 22:16:50 westley kernel:  [sock_ioctl+222/640] sock_ioctl+0xde/0x280
Jan 23 22:16:50 westley kernel:  [sys_ioctl+234/608] sys_ioctl+0xea/0x260
Jan 23 22:16:50 westley kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan 23 22:16:50 westley kernel: 
Jan 23 22:16:50 westley kernel: ifconfig      D C50973D8    24   945    848                     (NOTLB)
Jan 23 22:16:50 westley kernel: c437bee4 00000086 c113b9b0 c50973d8 c013c2b3 c431a880 c031adc4 c7793340 
Jan 23 22:16:50 westley kernel:        c7793360 006eb391 c63e20cc 000008ec c430fb20 c02d81a0 00000000 c437a000 
Jan 23 22:16:50 westley kernel:        c430f960 c0107af9 c02d81a8 00000001 c430f960 c0114a80 c02d81a8 c46cfe74 
Jan 23 22:16:50 westley kernel: Call Trace:
Jan 23 22:16:50 westley kernel:  [do_no_page+499/928] do_no_page+0x1f3/0x3a0
Jan 23 22:16:50 westley kernel:  [__down+153/288] __down+0x99/0x120
Jan 23 22:16:50 westley kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Jan 23 22:16:50 westley kernel:  [do_page_fault+805/1308] do_page_fault+0x325/0x51c
Jan 23 22:16:50 westley kernel:  [__down_failed+8/12] __down_failed+0x8/0xc
Jan 23 22:16:50 westley kernel:  [.text.lock.dev+45/143] .text.lock.dev+0x2d/0x8f
Jan 23 22:16:50 westley kernel:  [unmap_region+128/208] unmap_region+0x80/0xd0
Jan 23 22:16:50 westley kernel:  [inet_ioctl+171/192] inet_ioctl+0xab/0xc0
Jan 23 22:16:50 westley kernel:  [sock_ioctl+222/640] sock_ioctl+0xde/0x280
Jan 23 22:16:50 westley kernel:  [sys_ioctl+234/608] sys_ioctl+0xea/0x260
Jan 23 22:16:50 westley kernel:  [syscall_call+7/11] syscall_call+0x7/0xb


Output of ps axuwww
===================

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.4  0.3  1460  496 ?        S    21:52   0:06 init [2]  
root         2  0.0  0.0     0    0 ?        SWN  21:52   0:00 [ksoftirqd/0]
root         3  0.1  0.0     0    0 ?        SW<  21:52   0:02 [events/0]
root         4  0.0  0.0     0    0 ?        SW<  21:52   0:00 [kblockd/0]
root         5  0.0  0.0     0    0 ?        SW   21:52   0:00 [kapmd]
root         6  0.0  0.0     0    0 ?        SW   21:52   0:00 [pdflush]
root         7  0.0  0.0     0    0 ?        SW   21:52   0:00 [pdflush]
root         8  0.0  0.0     0    0 ?        SW   21:52   0:00 [kswapd0]
root         9  0.0  0.0     0    0 ?        SW<  21:52   0:00 [aio/0]
root        10  0.0  0.0     0    0 ?        SW   21:53   0:00 [pccardd]
root        11  0.0  0.0     0    0 ?        SW   21:53   0:00 [pccardd]
root        12  0.0  0.0     0    0 ?        SW   21:53   0:00 [kseriod]
root        94  0.0  0.0     0    0 ?        SW   21:53   0:00 [khubd]
daemon     145  0.0  0.3  1572  424 ?        S    21:53   0:00 /sbin/portmap
root       233  0.0  0.6  2168  800 ?        S    21:53   0:00 /sbin/syslogd
root       239  0.0  1.0  2228 1344 ?        S    21:53   0:01 /sbin/klogd
root       244  0.0  0.4  1464  528 ?        S    21:53   0:00 /usr/sbin/apmd -P /etc/apm/apmd_proxy --proxy-timeout 30
root       252  0.0  0.5  2148  716 ?        S    21:53   0:00 /usr/sbin/inetd
daemon     285  0.0  1.0  4000 1352 ?        S    21:53   0:00 lpd Waiting  
root       319  0.0  0.5  1480  700 ?        S    21:53   0:00 /sbin/cardmgr -C config-2.4
root       326  0.0  1.1  2992 1404 ?        S    21:53   0:00 /usr/sbin/sshd
root       336  0.0  2.3  4232 2940 ?        S    21:53   0:00 /usr/bin/X11/xfs -daemon
root       390  0.0  0.4  1740  620 ?        S    21:53   0:00 /bin/ksh /etc/rc2.d/S20xprint posix_sh_forced start
root       392  0.0  1.6  4404 2044 ?        S    21:53   0:00 /usr/X11R6/bin/Xprt -ac -pn -nolisten tcp -audit 4 -fp /usr/X11R6/lib/X11/fonts/Type1,/usr/X11R6/lib/X11/fonts/100dpi,/usr/X11R6/lib/X11/fonts/75dpi,/usr/X11R6/lib/X11/fonts/misc :64
root       393  0.0  0.3  1456  408 ?        S    21:53   0:00 tee -a /dev/null
root       394  0.0  0.3  1448  392 ?        S    21:53   0:00 logger -p lpr.notice -t Xprt_64
root       405  0.0  0.7  2284  916 ?        S    21:53   0:00 /sbin/rpc.statd
root       409  0.0  0.6  2544  884 ?        S    21:53   0:00 /usr/sbin/rpc.nfsd
root       411  0.0  0.7  2548  900 ?        S    21:53   0:00 /usr/sbin/rpc.mountd
daemon     421  0.0  0.4  1648  628 ?        S    21:53   0:00 /usr/sbin/atd
root       424  0.0  0.5  1716  724 ?        S    21:53   0:00 /usr/sbin/cron
root       438  0.0  0.5  2420  672 ?        S    21:53   0:00 /usr/bin/kdm
root       445  0.7  7.5 15276 9576 ?        S<   21:53   0:11 /usr/X11R6/bin/X -dpi 75 -nolisten tcp vt7 -auth /var/lib/kdm/authfiles/A:0-Tqxjvk
root       469  0.0  1.2  2640 1556 tty2     S    21:53   0:00 -bash
root       470  0.0  0.3  1460  484 tty3     S    21:53   0:00 /sbin/getty 38400 tty3
root       471  0.0  0.3  1460  484 tty4     S    21:53   0:00 /sbin/getty 38400 tty4
root       472  0.0  0.3  1460  484 tty5     S    21:53   0:00 /sbin/getty 38400 tty5
root       473  0.0  0.3  1460  484 tty6     S    21:53   0:00 /sbin/getty 38400 tty6
root       829  0.0  0.6  2420  800 ?        S    22:09   0:00 -:0         
root       832  0.1  5.0 13316 6384 ?        S    22:09   0:00 /usr/bin/kdm_greet
root       848  0.5  1.2  2648 1608 tty1     S    22:09   0:02 -bash
root       934  0.0  0.9  2488 1148 ?        S    22:16   0:00 sh -c ./network stop eth0 2>&1
root       935  0.1  1.0  2620 1360 ?        S    22:16   0:00 /bin/sh ./network stop eth0
root       944  0.0  0.3  1488  416 ?        D    22:16   0:00 /sbin/ifconfig eth0 down
root       945  0.0  0.3  1488  484 tty1     D    22:16   0:00 ifconfig
root       951  0.0  0.6  2832  844 tty2     R    22:18   0:00 ps axuwww


--
Arne Ahrend
