Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWIKORa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWIKORa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 10:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWIKORa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 10:17:30 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:46764 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751201AbWIKOR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 10:17:29 -0400
In-Reply-To: <20060911.062144.74719116.davem@davemloft.net>
References: <20060909.030854.78720744.davem@davemloft.net> <200609101018.06930.jbarnes@virtuousgeek.org> <D680AFCF-11EC-48AD-BBC2-B92521DF442A@kernel.crashing.org> <20060911.062144.74719116.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8DA3BCBF-0F19-4CF0-B22E-91E57E7CB033@kernel.crashing.org>
Cc: jbarnes@virtuousgeek.org, jeff@garzik.org, paulus@samba.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org, akpm@osdl.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Opinion on ordering of writel vs. stores to RAM
Date: Mon, 11 Sep 2006 16:17:18 +0200
To: David Miller <davem@davemloft.net>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Why not just keep writel() etc. for *both* purposes; the address  
>> cookie
>> it gets as input can distinguish between the required behaviours for
>> different kinds of I/Os; it will have to be setup by the arch- 
>> specific
>> __ioremap() or similar.
>
> This doesn't work when the I/O semantics are encoded into the
> instruction, not some virual mapping PTE bits.  We'll have to use
> a conditional or whatever in that case, which is silly.

Why is this "silly"?  Slowing down I/O accessors by a tiny little
bit isn't expensive, certainly not when compared to the cost of
having to do big-hammer synchronisation all over the place all the
time, like we need to do in the "all busses are strongly ordered
wrt to every other agent in the system" case.

Archs that _do_ implement only one set of ordering rules for every
bus, i.e. use the lowest common denominator on everything, do not
need such a conditional either of course -- only archs that want to
_gain_ performance.

There's plenty of other scenario's where such a conditional is
needed already btw, for example when some host bridges don't implement
PCI memory space as memory-mapped, but via an address+data register
(and yeah you can call such hardware "silly", and I certainly won't
disagree, but...)


Segher

