Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319368AbSIKW2I>; Wed, 11 Sep 2002 18:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319369AbSIKW2I>; Wed, 11 Sep 2002 18:28:08 -0400
Received: from h24-87-160-169.vn.shawcable.net ([24.87.160.169]:21655 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S319368AbSIKW2H>;
	Wed, 11 Sep 2002 18:28:07 -0400
Date: Wed, 11 Sep 2002 15:32:52 -0700
From: Simon Kirby <sim@erik.ca>
To: Ben Greear <greearb@candelatech.com>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: 802.1q + device removal causing hang
Message-ID: <20020911223252.GA12517@erik.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In 2.4.20-pre6, 2.4.20-pre4, 2.4.19, and 2.4.18 at least, I have been
having problems with vlan shutdown when removing tg3.o.  rmmod hangs on
rtnl_sem, call trace:

	rtnetlink_event
	unregister_netdev
	vlan_device_event
	notifier_call_chain
	unregister_netdevice
	unregister_netdev
	[tg3 module]
	[tg3 module]
	pci_unregister_driver
	...

The hang is happening at rmmod time.  All other operation appears to be
fine.  If I manually make sure all vlans are removed first, everything
works, so it's probably something to do with the NETDEV_UNREGISTER case
in vlan_device_event() in vlan.c.

Steps to reproduce:

modprobe tg3
ifconfig eth0 up
vconfig add eth0 10
ifconfig eth0.10 1.2.3.4
ifconfig eth0.10 down
ifconfig eth0 down
rmmod tg3

Note that the IP address stays assigned even with eth0.10 set down. 
Everything works if the IP assignment is not made.  Tested on
2.4.20-pre6.

Does anybody see what would be causing this (perhaps unregister_netdev
reentering)?

(Also, why is the "ifconfig eth0 up" necessary for vconfig?  It allows
"ifconfig eth0 down" _after_ the vlan is created, and vlans can still be
removed (but not created) at that point.)

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
