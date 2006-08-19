Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751728AbWHSLZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbWHSLZr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 07:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbWHSLZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 07:25:47 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:44782 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751723AbWHSLZq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 07:25:46 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [RFC] HOWTO use NAPI to reduce TX interrupts
Date: Sat, 19 Aug 2006 13:25:18 +0200
User-Agent: KMail/1.9.1
Cc: linuxppc-dev@ozlabs.org, akpm@osdl.org, James K Lewis <jklewis@us.ibm.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>,
       Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
       David Miller <davem@davemloft.net>
References: <20060818220700.GG26889@austin.ibm.com> <200608190256.26373.arnd@arndb.de> <44E7BB7F.7030204@osdl.org>
In-Reply-To: <44E7BB7F.7030204@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608191325.19557.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 August 2006 03:31, Stephen Hemminger wrote:
> 
> The reason reclaim via poll() is efficient is because it avoid causing a 
> softirq that is
> necessary when skb_free_irq() is done. Instead it reuses the softirq 
> from the poll() routine. 

Ok, I completely missed this point so far, thanks for the info.

> Like all Rx NAPI, using poll() for reclaim means: 
>     + aggregating multiple frames in one irq
>     - increased overhead of twiddling with the IRQ mask
>     - more ways to get driver stuck

What is the best way to treat the IRQ mask for TX interrupts?
I guess it should be roughly:

- off when we expect ->poll() to be called, i.e. after calling
  netif_rx_schedule() or returning after a partial rx from poll().
- off when there are no packets left in the TX queue
- on while RX interrupts are on and we're waiting for packets
  to be transmitted.

> Some drivers do all their irq work in the poll() routine (including PHY 
> handling).
> This is good if reading the IRQ status does an auto mask operation.
> 
> The whole NAPI documentation area is a mess and needs a good writer
> to do some major restructuring. It should also be split into reference 
> information,
> tutorial and guide sections.

I won't be able to do that work, I'm neither a good writer nor a networking
person.

Do you think we should still merge a section like the text I wrote up, even
if it makes the text even less well structured? Should I maybe add it
somewhere else than the appendix?

	Arnd <><
