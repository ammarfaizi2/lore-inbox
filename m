Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbUDLQnq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 12:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbUDLQnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 12:43:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64747 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262974AbUDLQnn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 12:43:43 -0400
Message-ID: <407AC732.1090000@pobox.com>
Date: Mon, 12 Apr 2004 12:43:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeremy Martin <martinjd@csc.uvic.ca>
CC: "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix tuntap oversight
References: <20040412065947.GC18810@net-ronin.org> <20040412001551.05476658.davem@redhat.com> <20040412162916.GA5046@net-ronin.org>
In-Reply-To: <20040412162916.GA5046@net-ronin.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Martin wrote:
> On Mon, Apr 12, 2004 at 12:15:51AM -0700, David S. Miller wrote:
> 
>>This netif_running() check is not necessary, and in fact
>>wrong.
>>
>>In fact, if ethernet drivers erroneously do this, this causes
>>them to fail to support the ALB bonding driver modes which
>>require on-the-fly MAC address changes while the interface is
>>up.
>>
> 
> 
> I just took a look in drivers/net/
> and 
> 	acenic.c
> 	atarilance.c
> 	b44.c
> 	cs89x0.c
> 	net_init.c
> 	typhoon.c
> 
> all use that netif_running() check when setting the MAC.  I actually just pulled
> the function from net_init.c for the tun change.  Are these broken?
> (I'm asking in total ignorance so be gentle :).

It's different for a driver that drives real hardware.

struct net_device::set_mac_address() is called inside rtnl_lock().  The 
safe thing to do is
1) read MAC address from eeprom on probe
2) write MAC address to hardware upon each dev->open()
3) use default eth_mac_addr() from net_init.c

And the netif_running() check in eth_mac_addr() is correct, because it 
does not update the hardware MAC address (which in this API would be 
impossible).

Normally the netif_running() check is for hardware that cannot update 
its MAC address safely during operation.

	Jeff



