Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbTCEJMn>; Wed, 5 Mar 2003 04:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbTCEJMn>; Wed, 5 Mar 2003 04:12:43 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:44048 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S264938AbTCEJMl>; Wed, 5 Mar 2003 04:12:41 -0500
Date: Wed, 5 Mar 2003 20:22:58 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Jochen Hein <jochen@jochen.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>, <yoshfuji@linux-ipv6.org>
Subject: Re: [2.5.64, IPv6] sleeping function called from illegal context
In-Reply-To: <87k7fefc70.fsf@jupiter.jochen.org>
Message-ID: <Pine.LNX.4.44.0303052015370.21996-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Mar 2003, Jochen Hein wrote:
> 
> The console output is:
> 
> Debug: sleeping function called from illegal context at
> include/linux/rwsem.h:43
> Call Trace:
>  [<c0116478>] __might_sleep+0x54/0x5c
>  [<c01cab41>] crypto_alg_lookup+0x21/0xc8
>  [<c01cb971>] crypto_alg_mod_lookup+0xd/0x2c
>  [<c01cacfd>] crypto_alloc_tfm+0x11/0xc0
>  [<c02c1240>] __ipv6_regen_rndid+0xa0/0x1f4
>  [<c01149fd>] wake_up_process+0xd/0x14
>  [<c02c13c2>] ipv6_regen_rndid+0x2e/0xc4
>  [<c011eeb9>] run_timer_softirq+0xf1/0x144
>  [<c02c1394>] ipv6_regen_rndid+0x0/0xc4
>  [<c011b761>] do_softirq+0x51/0xb0
>  [<c010a230>] do_IRQ+0x114/0x130
>  [<c0106f54>] default_idle+0x0/0x34
>  [<c0106f54>] default_idle+0x0/0x34
>  [<c0108ea0>] common_interrupt+0x18/0x20
>  [<c0106f54>] default_idle+0x0/0x34
>  [<c0106f54>] default_idle+0x0/0x34
>  [<c0106f7a>] default_idle+0x26/0x34
>  [<c0107009>] cpu_idle+0x35/0x44
>  [<c0105000>] rest_init+0x0/0x5c
>  [<c0105055>] rest_init+0x55/0x5c
> 
> __ipv6_regen_rndid(): too short regeneration interval; timer diabled
> for eth0.

Crypto transforms cannot be allocated in interrupt context or while
holding a spinlock.  It seems that at least the latter is happening in
ipv6_regen_rndid().

The transform needs to be allocated prior to use in this case.


- James
-- 
James Morris
<jmorris@intercode.com.au>


