Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129428AbQJ3OLS>; Mon, 30 Oct 2000 09:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129337AbQJ3OLJ>; Mon, 30 Oct 2000 09:11:09 -0500
Received: from ganymede.or.intel.com ([134.134.248.3]:49677 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S129408AbQJ3OKy>; Mon, 30 Oct 2000 09:10:54 -0500
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B27077@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: Locking Between User Context and Soft IRQs in 2.4.0
Date: Mon, 30 Oct 2000 06:10:44 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We are trying to port a network driver from 2.2.x to 2.4.x and have some
question regarding locks.
According to the kernel locking HOWTO, we have to take extra care when
locking between user context threads and BH/tasklet/softIRQ,
so we learned (the hard way ;-) that when running the ioctl system call from
an application we should use spin_lock/unlock_bh() and not
spin_lock/unlock() inside dev->do_ioctl().

*	What about the other entry points implemented in net_device ? 
*	We've got dev->get_stats, dev->set_mac_address,
dev->set_mutlicast_list and others that are all called from running
'ifconfig' which is an application. Are they considered user context too ?
*	What about dev->open and dev->stop ?
*	We figured that dev->hard_start_xmit() and timer callbacks are not
considered user context, but how can I find out if they are being run as
SoftIRQ or as tasklets or as Bottom Halves ? (their different definitions
require different types of protections)

Our driver is actually an intermediate driver bound on top of a regular net
driver. It behaves both as a network adapter driver and a protocol at the
same time. I can safely assume that it will have to handle both transmits
and receives simultaneously (no hardware interrupts are involved). We've
decided that for the first stage we are going to implement "wide" locks that
wrap entire operations from top to bottom. For example, our
dev->hard_start_xmit() will have a spin_lock() at the beginning and a
spin_unlock() at the end of the function.
*	Will it be safe to keep the lock until after the call to the base
driver's hard_start_xmit, or do I have to release the lock just before that
?
*	Or, in our receive function, will I have to release the lock before
or after the call to netif_rx() ?
*	What about other calls to the kernel ? can the running thread be
switched out of context when calling kernel entries and not be switched back
in when they finish ? should I beware of deadlocks in such case ?


	Thanks in advance,
	Shmulik Hen,
      	Software Engineer
	Linux Advanced Networking Services
	Network Communications Group, Israel (NCGj)
	Intel Corporation Ltd.




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
