Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWIVMMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWIVMMr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 08:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWIVMMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 08:12:47 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:25516 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932352AbWIVMMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 08:12:46 -0400
Date: Fri, 22 Sep 2006 16:12:28 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-net <linux-net@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: 2.6.1[78] page allocation failure. order:3, mode:0x20
Message-ID: <20060922121228.GA25849@2ka.mipt.ru>
References: <Pine.LNX.4.64.0609220655550.13396@diagnostix.dwd.de> <20060922004253.2e2e2612.akpm@osdl.org> <Pine.LNX.4.64.0609221149560.13396@diagnostix.dwd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609221149560.13396@diagnostix.dwd.de>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 22 Sep 2006 16:12:32 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 12:03:11PM +0000, Holger Kiehl (Holger.Kiehl@dwd.de) wrote:
> >This is going to cause an 9000-byte MTU to use a 16384-byte allocation.
> >e1000_alloc_rx_buffers() adds two bytes to that, so we do kmalloc(16386),
> >which causes the slab allocator to request 32768 bytes.  All for a 9kbyte 
> >skb.
> >
> I searched the list, which I should have done before asking (I was not sure
> if this was due to the e1000) and found this
> 
>    http://www.ussg.iu.edu/hypermail/linux/kernel/0608.0/0942.html
> 
> discusion from 3rd August. As a summary I read that people are trying to 
> find
> a solution, in the meantime one should set /proc/sys/vm/min_free_kbytes to
> 65000 or higher, to ensure that the driver gets enough unfragmented memory.

There is no solution (although e1000 memory management problem is one of
the reasons I created memory tree allocator) yet, only workarounds, one
of which you described above.

e1000 hardware does not support setting of the maximum transfer size, it
only allows power of two (and about 1500), so it does require 16k of
memory for 9k frame (plus network skb allocation path adds a little which
is transformed into 32k request due to power of two problem).

Intel folks were suggested to either use fragments in one skb (or wait
until network developers invent something new), but there are no patches
from them (hopefully yet).

It is not e1000 only problem - expect even 8k-12k allocation not on
startup is definitely a wrong way.

> Holger

-- 
	Evgeniy Polyakov
