Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129993AbQKIR2d>; Thu, 9 Nov 2000 12:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129954AbQKIR2Y>; Thu, 9 Nov 2000 12:28:24 -0500
Received: from ganymede.or.intel.com ([134.134.248.3]:44305 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S129949AbQKIR2N>; Thu, 9 Nov 2000 12:28:13 -0500
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B2708C@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "'Keith Owens'" <kaos@ocs.com.au>,
        "'Andrew Morton[andrewm@uow.edu.au]'"
	 <Andrew.Morton[andrewm@uow.edu.au]>,
        "'Jeff Garzik[jgarzik@mandrakesoft.com]'"
	 <Jeff.Garzik[jgarzik@mandrakesoft.com]>,
        "'Paul Gortmaker[p_gortmaker@yahoo.com]'"
	 <Paul.Gortmaker[p_gortmaker@yahoo.com]>,
        "'Andi Kleen'" <ak@suse.de>, "Dunlap, Randy" <randy.dunlap@intel.com>,
        davem@redhat.com, "'jamal'"
	 <hadi@cyberus.ca>, becker@scyld.com
Cc: "'LNML'" <linux-net@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: catch 22 - porting net driver from 2.2 to 2.4
Date: Thu, 9 Nov 2000 09:26:03 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a bit long and I apologize (since there are kdb captures in it).

We are developing an advanced networking services driver (loadable module)
and are having problems porting it to work on 2.4.x kernel.
The driver is supposed to provide services such as fault tolerance, load
balancing, link aggregation and VLAN. It does that by creating a group of
"virtual" adapters that are bound on top of a team of network adapters. This
works great on 2.2 kernels but demonstrated a few problems on 2.4.0-test9

The only problem we have left now has to do with insmod/rmmod. for good
reasons, we cant just call init_etherdev() like base drivers do, so we
created our own version that handles memory and name allocations and calls
register_netdevice() on it's own the same as init_etherdev(). since we've
got several "virtual" adapters that are part of a topology being built
progressively, we can't perform their registrations during module_init() but
rather through an IOCTL and here is our problem:

if we call register_netdevice(), we get the following message:

	RTNL: assertion failed at devinet.c(775):inetdev_event

we figured this is because we neglected rtnl_lock() so instead we try using
register_netdev() to handle this for us but then we get:

	Scheduling in interrupt
	kernel BUG at sched.c:696!
	Entering kdb (current=0xc51a8000, pid 1075) on processor 1 Panic:
invalid operand
	due to panic @ 0xc011aa71

	eax = 0x0000001b ebx = 0x00000020 ecx = 0xc030d80c edx = 0xffffffff 
	esi = 0xc030b5b4 edi = 0xffffffff esp = 0xc51a9d34 eip = 0xc011aa71 
	ebp = 0xc51a9d8c  ss = 0x00000018  cs = 0x00000010 eflags =
0x00010246 
	 ds = 0x00000018  es = 0x00000018 origeax = 0xffffffff &regs =
0xc51a9d00

	[1]kdb> bt
	    EBP       EIP         Function(args)
	0xc51a9d8c 0xc011aa71 schedule+0x935 (0xc2c9e000, 0xc4482520,
0xc51a9e10)
	                               kernel .text 0xc0100000 0xc011a13c
0xc011aa80
	0xc51a9db8 0xc0107b8d __down+0xf5
	                               kernel .text 0xc0100000 0xc0107a98
0xc0107c68
	0xc51a9dcc 0xc0107f43 __down_failed+0xb (0xc51a9de4, 0xd082de5c,
0xc2c9e000, 0xc60a8320, 0xc51a9dfc)
	                               kernel .text 0xc0100000 0xc0107f38
0xc0107f4c
	           0xc023a7a9 stext_lock+0x4919
	                               kernel .text.lock 0xc0235e90
0xc0235e90 0xc023bd80
	0xc51a9dd4 0xc01f2e81 rtnl_lock+0x11 (0xc2c9e000)
	                               kernel .text 0xc0100000 0xc01f2e70
0xc01f2e88
	0xc51a9de4 0xd082de5c [ians]iansInitEtherdev+0x20 (0xc4482520)
	                               ians .text 0xd082d060 0xd082de3c
0xd082de78
		.
		. (boring chain of calls)
		.
	0xc51a9ec4 0xd082dbcd [ians]doControlIoctl+0x15d (0xc2c9e200,
0xc51a9f20, 0x89f0)
	                               ians .text 0xd082d060 0xd082da70
0xd082dc40
	0xc51a9ee4 0xc01ef09f dev_ifsioc+0x33f (0xc51a9f20, 0x89f0,
0xc51a9f20)
	                               kernel .text 0xc0100000 0xc01eed60
0xc01ef0b0
	0xc51a9f40 0xc01ef29d dev_ioctl+0x1ed (0x89f0, 0xbffffa58)
	                               kernel .text 0xc0100000 0xc01ef0b0
0xc01ef300
	0xc51a9f64 0xc021a70c inet_ioctl+0x18c (0xc339d13c, 0x89f0,
0xbffffa58)
	                               kernel .text 0xc0100000 0xc021a580
0xc021a720
	0xc51a9f84 0xc01e8f06 sock_ioctl+0x9e (0xc339d040, 0xc38e0900,
0x89f0, 0xbffffa58)
	                               kernel .text 0xc0100000 0xc01e8e68
0xc01e8f6c
	0xc51a9fbc 0xc014f5fd sys_ioctl+0x26d (0x3, 0x89f0, 0xbffffa58,
0x4000ae60, 0xbffffba4)
	                               kernel .text 0xc0100000 0xc014f390
0xc014f6a0
	           0xc010965f system_call+0x33
	                               kernel .text 0xc0100000 0xc010962c
0xc0109664

We figured that since we are in user context (do_ioctl) and use
spin_lock_bh() to protect us from other concurrent threads, it might
interfere with rtnl_lock() so we remove our lock just before calling
register_netdev() and lock again upon return but then the whole process just
stopped and didn't return to the prompt. from within kdb, we could see that
all CPU's are running in idle but if we try to return to the prompt the
whole system hangs. sometimes it hangs if we try to run ifconfig -a to see
if the virtual adapters appear.

I can't use it without locks, I can't use it with locks and I can't complete
the operation if I remove my own locks - catch 22.


The other problem has to do with rmmod - here we get called in our
cleanup_module function and from it we try to call unregister_netdev() for
each registered virtual adapter.
in this case, we get:

	Scheduling in interrupt
	kernel BUG at sched.c:696!

	Entering kdb (current=0xc38c8000, pid 1602) on processor 0 Panic:
invalid operand
	due to panic @ 0xc011aa71
	eax = 0x0000001b ebx = 0x00000000 ecx = 0xc030d80c edx = 0x00000000
	esi = 0x007ae686 edi = 0xffffffff esp = 0xc38c9e54 eip = 0xc011aa71
	ebp = 0xc38c9eac  ss = 0x00000018  cs = 0x00000010 eflags =
0x00010246
	 ds = 0x00000018  es = 0x00000018 origeax = 0xffffffff &regs =
0xc38c9e20

	[0]kdb> bt
	    EBP       EIP         Function(args)
	0xc38c9eac 0xc011aa71 schedule+0x935 (0xc38c9ec0)
	                               kernel .text 0xc0100000 0xc011a13c
0xc011aa80
	0xc38c9ed4 0xc011a02a schedule_timeout+0x76
	                               kernel .text 0xc0100000 0xc0119fb4
0xc011a04c
	0xc38c9eec 0xc01ef80f unregister_netdevice+0x1c7 (0xc38f9600)
	                               kernel .text 0xc0100000 0xc01ef648
0xc01ef880
	0xc38c9efc 0xc01b834e unregister_netdev+0x12 (0xc38f9600)
	                               kernel .text 0xc0100000 0xc01b833c
0xc01b8360
	0xc38c9f18 0xd082f3b9 [ians]iansUnregisterDev+0xcd (0xc154a4a0, 0x0)
	                               ians .text 0xd082d060 0xd082f2ec
0xd082f458
		.
		. (boring chain of calls)
		.
	0xc38c9f7c 0xd082e29d [ians]cleanup_module+0x69
	                               ians .text 0xd082d060 0xd082e234
0xd082e3cc
	0xc38c9f90 0xc0120620 free_module+0x1c (0xd082d000, 0x0, 0xc38c8000,
0x80563cc)
	                               kernel .text 0xc0100000 0xc0120604
0xc01206a0
	0xc38c9fbc 0xc011f70f sys_delete_module+0x1fb (0xbffffcad, 0x28,
0x6, 0x80563cc, 0x1)
	                               kernel .text 0xc0100000 0xc011f514
0xc011f9e8
	           0xc010965f system_call+0x33
	                               kernel .text 0xc0100000 0xc010962c
0xc0109664

If we replace it with a direct call to unregister_netdevice(), we get stuck
in an infinite loop that says something like:

	waiting for <device> to become free. usage count = 2
	waiting for <device> to become free. usage count = 2
	waiting for <device> to become free. usage count = 2

Trying to debug this I could see that dev->refcnt is involved, so I print
it's value before and after register_netdevice() and again before and after
unregister_netdevice(). oddly I get 0 first and then 1, but before
unregister_netdevice() I get 2 !!!

So again, if I use locks I get stuck and if I don't use locks I get stuck -
catch 22.

Please advise.

	Thanks in advance.

	Shmulik Hen,
      	Software Engineer
	Linux Advanced Networking Services
	Network Communications Group, Israel (NCGj)
	Intel Corporation Ltd.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
