Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262889AbUB0Pwm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 10:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263030AbUB0Pwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 10:52:41 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:33276 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262889AbUB0PwV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 10:52:21 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: MP M <mageshmp2003@yahoo.com>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: help in TCP checksum offload , TSO and zero copy
Date: Fri, 27 Feb 2004 09:46:11 -0600
X-Mailer: KMail [version 1.2]
References: <20040226185219.70474.qmail@web21407.mail.yahoo.com>
In-Reply-To: <20040226185219.70474.qmail@web21407.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <04022709461100.11154@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 February 2004 12:52, MP M wrote:
> Hello ,
>
> I am working on TCP checksum offload , TSO and zero
> copy with linux 2.6.1 kernel .
>
> IMHO I find that the code for TCP checksum offload and
> TSO are already supported by the linux 2.6 kernel . I
> arrived at this conclusion on seeing the presence of
> flag CHECKSUM_HW and the #defines for NETIF_F_IP_CSUM
> , NETIF_F_NO_CSUM and
> NETIF_F_HW_CSUM . By default , it seems that
> CHECKSUM_HW is enabled by default so that the TSO
> supported driver will do the processing on the
> ethernet card.
>
> Please correct me if I am wrong .
>
> In the driver for e1000 and tg3 , support for TSO is
> already seen .
>
> But when I was testing the performance using ttcp
> utility , I found some weird results.
> I just want to share to obtain some feedback from some
> experienced guys in this area who has already worked
> in TSO ,TCP checksum offload .
>
> On the server machine I had my linux 2.6 kernel
> running and it had e1000 Intel pro ethercard
> support.Initially with ethtool utility I ensured that
> the Tx and Rx checksum setting on e1000 is set to on .
> I started ttcp utiltity in receive mode on the server
> machine listening on my specified port .
>
> Next I pumped in data from my client machine using
> ttcp utility in transmit mode to the server .
>
> I measured the time duration for data transfer to
> happen . say x milliseconds.
>
> Next I set the tx and rx checksum on e1000 card using
> ethtool , and repeated the above test with ttcp
> utility .Since the content size is same and with tx/rx
> checksum off on e1000 , I expected the time duaration
> of data transfer from server to client to be x+some
> delta . But surprisingly I am noticing the data
> transfer at lesser time than x .(ie faster than before
> with tx/rx checksum off on e1000 ) .
>
> I would appreciate if anyone could shed some light on
> this odd behaviour .

Not that odd - the local CPU is better at computing checksums
than the interface.

Note - there are some optimizations in the network stack
that reduce the effort of actually computing checksums. In
some cases, all that is done is to subtract/add those values
that are changed in making replies/ACKs. This eliminates
having to make a complete checksum evaluation. In others,
the checksum is done during some other operation that requires
a pass through the packet - making the checksum cost negligable.

I'm not the person for a detailed, low level explaination, but
I think this is what you are seeing. The hardware cannot take
advantage of global optimizations - and what you are seeing is
that difference.
