Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWCTXED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWCTXED (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 18:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWCTXEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 18:04:02 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:38045
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932173AbWCTXEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 18:04:00 -0500
Date: Mon, 20 Mar 2006 15:00:29 -0800 (PST)
Message-Id: <20060320.150029.109814021.davem@davemloft.net>
To: bcrl@kvack.org
Cc: mst@mellanox.co.il, buytenh@wantstofly.org, arjan@infradead.org,
       rick.jones2@hp.com, netdev@vger.kernel.org, rdreier@cisco.com,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: TSO and IPoIB performance degradation
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060320150941.GD16108@kvack.org>
References: <20060320114933.GA3058@xi.wantstofly.org>
	<20060320120407.GY29929@mellanox.co.il>
	<20060320150941.GD16108@kvack.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin LaHaise <bcrl@kvack.org>
Date: Mon, 20 Mar 2006 10:09:42 -0500

> Wouldn't it make sense to strech the ACK when the previous ACK is still in 
> the TX queue of the device?  I know that sort of behaviour was always an 
> issue on modem links where you don't want to send out redundant ACKs.

I thought about doing some similar trick with TSO, wherein we would
not defer a TSO send if all the previous packets sent are out of the
device transmit queue.  The idea was the prevent the pipe from ever
emptying which is the danger of deferring too much for TSO.

This has several problems.  It's hard to implement.  You have to
decide if you want precise state, thereby checking the TX descriptors.
Or you go for imprecise but easier to implement, which is very
imprecise and therefore not very useful state, by just checking the
SKB refcount or similar which means that you find out it's left the TX
queue after the TX purge interrupt which can be a long time after the
event and by then the pipe has empties which is what you were trying
to prevent.

Lastly, you don't want to touch remote cpu state which is what such
a hack is going to end up doing much of the time.
