Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265710AbUBJHlG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 02:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265736AbUBJHlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 02:41:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:16025 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265710AbUBJHlC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 02:41:02 -0500
Date: Mon, 9 Feb 2004 23:43:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] packet_sendmsg_spkt incorrectly truncates an interface
 name
Message-Id: <20040209234341.0075159b.akpm@osdl.org>
In-Reply-To: <20040210.163023.112606425.maeda@jp.fujitsu.com>
References: <20040210.163023.112606425.maeda@jp.fujitsu.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com> wrote:
>
> Hi,
> 
> When I renamed a network interface name with long name such as heartbeat.eth1,
> DHCP client failed to assign an IP address to the interface. 
> 
> Problem is that packet_sendmsg_spkt() truncates an interface name 
> by 12 characters. That is why the following dev_get_by_name() fails to find
> the corresponding net_device structure.

You need to use a shorter name, I think.

> Obviously, max name length of a network interface name is IFNAMESIZ-1, 
> which is 15.

Yes, but sockaddr_pkt.spkt_device[] is only 14 bytes for some reason.

> I can not come up with any reasonable reason that
> packet_sendmsg_spkt() should truncate the interface name by 12.
> I guess it is just a trivial bug.

These objects are shared with userspace applications, I believe.  We're
stuck with it.


> diff -Naur linux-2.6.2.org/net/packet/af_packet.c linux-2.6.2/net/packet/af_packet.c
> --- linux-2.6.2.org/net/packet/af_packet.c	2004-02-10 15:29:14.160320269 +0900
> +++ linux-2.6.2/net/packet/af_packet.c	2004-02-10 15:29:52.656413548 +0900
> @@ -311,7 +311,7 @@
>  	 *	Find the device first to size check it 
>  	 */
>  
> -	saddr->spkt_device[13] = 0;
> +	saddr->spkt_device[IFNAMSIZ-1] = 0;
>  	dev = dev_get_by_name(saddr->spkt_device);
>  	err = -ENODEV;
>  	if (dev == NULL)

This scribbles on sockaddr_pkt.spkt_protocol.

Probably what we need to do here is to put a bit of range-checking into the
userspace tool.  Is it nameif?

