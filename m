Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318325AbSG3OvO>; Tue, 30 Jul 2002 10:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318326AbSG3OvO>; Tue, 30 Jul 2002 10:51:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64523 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318325AbSG3OvN>;
	Tue, 30 Jul 2002 10:51:13 -0400
Message-ID: <3D46A8AB.4030308@mandrakesoft.com>
Date: Tue, 30 Jul 2002 10:54:35 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Abraham vd Merwe <abraham@2d3d.co.za>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: questions about network device drivers
References: <20020730161505.A23281@crystal.2d3d.co.za> <1028044126.6726.35.camel@irongate.swansea.linux.org.uk>
X-Enigmail-Version: 0.65.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Tue, 2002-07-30 at 15:15, Abraham vd Merwe wrote:
> 
>>hard_start_xmit() method
>>========================
>>
>>when should this function return 0 and when should it return 1 and in which
>>cases should it do netif_stop_queue() and/or free the dev_kfree_skb() ?
> 
> 
> 0 - OK
> 1 - I am busy, give me it later.
> 
> If you return 1 be sure to netif_stop_queue. The netif_wake_queue will
> continue transmission

I was recently corrected in this...  for modern drivers it's really a 
bug (see drivers/net/tg3.c::tg3_start_xmit).  The queue should be 
managed such that it is awake only when there is room for more packets.

For example, one code path (not the default one) in dev_queue_xmit will 
just drop the skb, not requeue it for later.


>>tx_timeout() method
>>=================
>>
>>there is no way to return an error in the tx_timeout method. what should I
>>do when an error occurs in that function (e.g. I'm unable to reset the
>>controller)? panic? that seems a bit excessive...
> 
> 
> Try again ? If that fails I guess you initiate the self destruct
> sequence for just that driver.


The typical method is to reset the NIC hardware, and either requeue 
waiting packets or drop all the packets you have waiting on the floor. 
tx_timeout is a generic catch-all that normally happens when the NIC is 
wedged.

	Jeff


