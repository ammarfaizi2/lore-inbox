Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVFQSXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVFQSXN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 14:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVFQSXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 14:23:13 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:43451 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262045AbVFQSXG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 14:23:06 -0400
Date: Fri, 17 Jun 2005 20:22:12 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Cc: Juha Laiho <Juha.Laiho@iki.fi>, Andrew Hutchings <info@a-wing.co.uk>,
       linux-kernel@vger.kernel.org, vinay kumar <b4uvin@yahoo.co.in>,
       jgarzik@pobox.com
Subject: Re: sis190
Message-ID: <20050617182211.GA14778@electric-eye.fr.zoreil.com>
References: <28331967.1119006849927.JavaMail.www@wwinf1101>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28331967.1119006849927.JavaMail.www@wwinf1101>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal CHAPPERON <pascal.chapperon@wanadoo.fr> :
[...]
> I noticed that you remove NET_IP_ALIGN in sis190_alloc_rx_skb(), 
> but not in sis190_try_rx_copy(); though the driver "worked" like
> yesterday...

NET_IP_ALIGN should be fine in sis190_alloc_rx_skb() as it only
applies to the skb where the driver memcopies (i.e. it is not
limited by the alignement requirement of the asic).

[...]
>    PSize    status   addr     size     PSize    status   addr     size
> 00:00000000 c0000000 13381010 00000600 00000000 c0000000 13847010 00000600
> 01:00000000 c0000000 1edcb810 00000600 00000000 c0000000 1b694810 00000600
> 02:00000000 c0000000 1b697010 00000600 00000000 c0000000 077c4810 00000600
> 03:00000000 c0000000 07e15010 00000600 00000000 c0000000 06e3e810 00000600
> 04:00000000 c0000000 1719e810 00000600 00000000 c0000000 1b69b810 00000600
> 05:00000000 c0000000 1b694010 00000600 00000000 c0000000 07741010 00000600
> 06:00000000 c0000000 065d8010 00000600 00000000 c0000000 07a84010 00000600
> 07:010100a6 76040040 13381810 00000600 00000000 c0000000 1f7c1010 00000600
                                                                    ^ -> bug
[...]
> So i removed the test "if (pkt_size < rx_copybreak) {" in sis190_try_rx_copy.
> 
> The driver now works "correctly" (ping, ssh, scp) as long as i want,
> but probably not in the way you want...

It should be fixed now. Please try the patch of the day:
http://www.fr.zoreil.com/people/francois/misc/20050617-2.6.12-rc-sis190-test.patch

> I don't understand how the Rx packets are managed when  pkt_size is
> greater than rx_copybreak...

They are directly given to the upper layer. The driver tags a hole in the
Rx ring.

[...]
> I also tried to force 10H, 10F, 100H, 100F autoneg off on the other card.
> All modes were working, but obviously something was wrong :
> - 10H  0,4Mo/s both directions
> - 10F  1,2Mo/s  "     "
> - 100H   5Mo/s  "     "
> - 100F 1,2Mo/s and 0,3Mo/s 
> 
> For 100F, sis190 reported "100 Mbps Half Duplex" and the other card 100 Full.

Did the sis190 driver report a link change event ?

--
Ueimor
