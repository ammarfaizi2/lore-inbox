Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422673AbWHSBb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422673AbWHSBb6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 21:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbWHSBb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 21:31:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3476 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751267AbWHSBb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 21:31:56 -0400
Message-ID: <44E7BB7F.7030204@osdl.org>
Date: Sat, 19 Aug 2006 18:31:43 -0700
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linuxppc-dev@ozlabs.org, akpm@osdl.org, James K Lewis <jklewis@us.ibm.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>,
       Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
       David Miller <davem@davemloft.net>
Subject: Re: [RFC] HOWTO use NAPI to reduce TX interrupts
References: <20060818220700.GG26889@austin.ibm.com> <20060818222657.GL26889@austin.ibm.com> <200608190103.05649.arnd@arndb.de> <200608190256.26373.arnd@arndb.de>
In-Reply-To: <200608190256.26373.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Saturday 19 August 2006 01:03, Arnd Bergmann wrote:
>   
>> Someone should probably document that in 
>> Documentation/networking/NAPI_HOWTO.txt, I might end up doing that
>> once we get it right for spidernet
>>     

The reason reclaim via poll() is efficient is because it avoid causing a 
softirq that is
necessary when skb_free_irq() is done. Instead it reuses the softirq 
from the poll()
routine. Like all Rx NAPI, using poll() for reclaim means:
    + aggregating multiple frames in one irq
    - increased overhead of twiddling with the IRQ mask
    - more ways to get driver stuck
   
Some drivers do all their irq work in the poll() routine (including PHY 
handling).
This is good if reading the IRQ status does an auto mask operation.

The whole NAPI documentation area is a mess and needs a good writer
to do some major restructuring. It should also be split into reference 
information,
tutorial and guide sections.

