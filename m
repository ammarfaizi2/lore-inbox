Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267974AbTBSEYb>; Tue, 18 Feb 2003 23:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267975AbTBSEYb>; Tue, 18 Feb 2003 23:24:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3593 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267974AbTBSEYa>;
	Tue, 18 Feb 2003 23:24:30 -0500
Message-ID: <3E53093F.5050502@pobox.com>
Date: Tue, 18 Feb 2003 23:34:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: netdevices.txt update
Content-Type: multipart/mixed;
 boundary="------------040403030109020202050704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040403030109020202050704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Just made a minor update to Documentation/networking/netdevices.txt, and 
thought I would take the opportunity to pass it around once again.

Even though this doc has existed for quite a while now, I still come 
across code that loves to violate these locking rules in various ways.

Comments and additions welcome

	Jeff



--------------040403030109020202050704
Content-Type: text/plain;
 name="netdevices.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netdevices.txt"


Network Devices, the Kernel, and You!


Introduction
============
The following is a random collection of documentation regarding
network devices.



struct net_device synchronization rules
=======================================
dev->open:
	Synchronization: rtnl_lock() semaphore.
	Context: process

dev->stop:
	Synchronization: rtnl_lock() semaphore.
	Context: process
	Note1: netif_running() is guaranteed false
	Note2: dev->poll() is guaranteed to be stopped

dev->do_ioctl:
	Synchronization: rtnl_lock() semaphore.
	Context: process

dev->get_stats:
	Synchronization: dev_base_lock rwlock.
	Context: nominally process, but don't sleep inside an rwlock

dev->hard_start_xmit:
	Synchronization: dev->xmit_lock spinlock.
	Context: BHs disabled
	Notes: netif_queue_stopped() is guaranteed false

dev->tx_timeout:
	Synchronization: dev->xmit_lock spinlock.
	Context: BHs disabled
	Notes: netif_queue_stopped() is guaranteed true

dev->set_multicast_list:
	Synchronization: dev->xmit_lock spinlock.
	Context: BHs disabled

dev->poll:
	Synchronization: __LINK_STATE_RX_SCHED bit in dev->state.  See
		dev_close code and comments in net/core/dev.c for more info.
	Context: softirq


--------------040403030109020202050704--

