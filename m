Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310220AbSB1XGc>; Thu, 28 Feb 2002 18:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310151AbSB1XEM>; Thu, 28 Feb 2002 18:04:12 -0500
Received: from pizda.ninka.net ([216.101.162.242]:21394 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S310196AbSB1W7h>;
	Thu, 28 Feb 2002 17:59:37 -0500
Date: Thu, 28 Feb 2002 14:57:18 -0800 (PST)
Message-Id: <20020228.145718.120901435.davem@redhat.com>
To: christopher.leech@intel.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [BETA-0.92] Third test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <BD9B60A108C4D511AAA10002A50708F22C144F@orsmsx118.jf.intel.com>
In-Reply-To: <BD9B60A108C4D511AAA10002A50708F22C144F@orsmsx118.jf.intel.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Leech, Christopher" <christopher.leech@intel.com>
   Date: Thu, 28 Feb 2002 13:57:07 -0800

   > e1000 has a VLAN filter type on-chip, which complicates things a tiny bit.
   
   The filtering is separate from the tagging.  Filtering lets the hardware
   ignore tagged packets for VLANs that it's not a member of.  The vlan_group
   structure isn't well laid out for this, but it would be possible to search
   for non-NULL values in the vlan_devices array to get the VLAN IDs for
   filtering.  The driver would need to know when new VLAN IDs were added to
   the group.
   
This is exactly the kind of thing I wanted people to discover
and discuss.  Thanks for bringing this up.

It would be quite simple to hook back into your driver for this
purpose, proposed API:

/* For netdev->features */
#define NETIF_F_HW_VLAN_FILTER		1024

/* For NETIF_F_VLAN_RX_FILTER devices */
	void (*vlan_rx_new_vid)(struct net_device *dev,
				unsigned short vid);

We call dev->vlan_rx_kill_vid() in all cases because it has to
deal with interlocking, as described in an earlier email.

But if NETIF_F_HW_VLAN_FILTER is set, when new VLAN devices are
registered that go through your card, you will get a
dev->vlan_rx_new_vid() call.

I do not think you would need any more informatin than the
VID itself.  If this is wrong, tell me now :-)
