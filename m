Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbTIFWA7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 18:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbTIFWA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 18:00:59 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:46343
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S262080AbTIFWA6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 18:00:58 -0400
Subject: 2.6.0-test4-mm6: locking imbalance with rtnl_lock/unlock?
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>
Content-Type: text/plain
Message-Id: <1062885603.24475.7.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 06 Sep 2003 15:00:03 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been playing with Bryan O'Sullivan's netplug daemon
(http://www.red-bean.com/~bos/).  It uses netlink to look at carrier
state changes on network interfaces.

I'm seeing a problem however: after a while, all ifconfig commands just
block uninterruptably in __down().  From strace, it seems to be in:

ioctl(4, 0x8915...

which is SIOCGIFADDR.  It seems to me the down() is actually the
rtnl_lock() called at net/ipv4/devinet.c:536 in devinet_ioctl.  This
happens even when netplugd is no longer running.  It looks like someone
isn't releasing the lock.

I'm going over all the uses of rtnl_lock() to see if I can find a
problem, but no sign yet.  I wonder if someone might have broken this
recently: I'm running 2.6.0-test4-mm6, but I think Bryan is running an
older kernel (2.6.0-test4?), and hasn't seen any problems.

	J

