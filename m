Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932708AbVIHPmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbVIHPmz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbVIHPmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:42:55 -0400
Received: from relay2.uni-heidelberg.de ([129.206.210.211]:4241 "EHLO
	relay2.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S932708AbVIHPmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:42:53 -0400
Date: Thu, 8 Sep 2005 17:42:42 +0200 (CEST)
From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
To: Tommy Christensen <tommy.christensen@tpack.net>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Netdev List <netdev@vger.kernel.org>
Subject: Re: [PATCH] 3c59x: read current link status from phy
In-Reply-To: <1126190554.4805.68.camel@tsc-6.cph.tpack.net>
Message-ID: <Pine.LNX.4.63.0509081713500.22954@dingo.iwr.uni-heidelberg.de>
References: <200509080125.j881PcL9015847@hera.kernel.org>  <431F9899.4060602@pobox.com>
  <Pine.LNX.4.63.0509081351160.21354@dingo.iwr.uni-heidelberg.de> 
 <1126184700.4805.32.camel@tsc-6.cph.tpack.net> 
 <Pine.LNX.4.63.0509081521140.21354@dingo.iwr.uni-heidelberg.de>
 <1126190554.4805.68.camel@tsc-6.cph.tpack.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2005, Tommy Christensen wrote:

> Besides, how long would you like to wait for network connectivity 
> after plugging in the cable?  It is now lowered from [60-120] to 
> [0-60] seconds.

I now understood what the problem was, so I'll put it in words for 
posterity: the Link Status bit of the MII Status register needs to be 
read twice to first clear the error state (link bit=0) after which the 
bit reports the actual value of the link. From the manual:

 	This bit has a latching function. A link failure causes the
 	bit to clear and remain clear until it has been read through
 	the management interface.

I tested this on a Tornado chip and it works as advertised (after link 
is back up, first read gives 0x7829, the second 0x782d).

But I still don't agree with your solution: you are reading the Status 
register twice in all cases, which is wrong. What you want is to read 
it a second time only after the link was marked as down: a simple 
check if bit 2 of the Status register is 0, in which case you issue 
the second read. This still means that there will be 2 reads if the 
link remains down, but at least there is only 1 read for the case 
where the link is up and remains up.

> Personally, I'd prefer the delay to be < 10 seconds.

If you sample every 60 seconds ? Teach Shannon how to do it ;-)

If you mean to reduce the sampling period, there is a very good reason 
not to do it: these MDIO operations are expensive - it's a serial 
protocol. vortex_timer() might do 2 (and with the discussed change - 
3) of them - there are better things to do for the CPU than wait for 
these I/O operations. Plus, vortex_timer() also disables the 
interrupt...

The Tornado and at least some Cyclone chips support generating an 
interrupt whenever the link changes, which can be used instead of 
polling for link state. This feature is not used in the 3c59x driver 
and could give you much less than 10 seconds accuracy - but you have 
to code it. ;-)

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De
