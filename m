Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265368AbUAAKSU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 05:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265370AbUAAKSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 05:18:20 -0500
Received: from dp.samba.org ([66.70.73.150]:34480 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265368AbUAAKSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 05:18:12 -0500
Date: Thu, 1 Jan 2004 21:15:41 +1100
From: Anton Blanchard <anton@samba.org>
To: Joonas Kortesalmi <joneskoo@derbian.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: swapper: page allocation failure. order:3, mode:0x20
Message-ID: <20040101101541.GJ28023@krispykreme>
References: <20040101093553.GA24788@derbian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040101093553.GA24788@derbian.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> After running 2.6.0 on a server for a few days, I met an interesting and
> annoying problem. I was playing with NFS over gigabit ethernet (e1000) and
> it was a bit slow. I tried to find out why by running top and I saw syslog-ng
> eating almost 10% of the 1,3GHz Duron. Looked at the log and there was a huge
> flood of these messages:
> 
> swapper: page allocation failure. order:3, mode:0x20
> irssi: page allocation failure. order:3, mode:0x20
> swapper: page allocation failure. order:3, mode:0x20
> vim: page allocation failure. order:3, mode:0x20
> swapper: page allocation failure. order:3, mode:0x20

Its sounds like you are using either a large MTU (9k?) or TSO. TSO
causes the networking stack to think it has a massive MTU and the e1000
card busts it up into proper MTU sized packets. The problem is that
it places much more stress on the allocator by asking for these large
chunks of memory in interrupt context.

Now e1000 uses TSO (and can regularly ask for 32kB+ kmallocs in
interrupt context) perhaps we should look moving the rx buffer refill code
into a context that can sleep. Then again its not like we can tolerate
much latency in this code path, your rx ring will run out quite quickly :)

BTW We have found increasing /proc/sys/vm/min_free_kbytes can help the
situation a bit. Bumping the slab limits for the larger kmallocs (via
echo X Y Z > /proc/slab) might be useful too.

We should probably rate limit that printk. Andrew: I was thinking of
stealing net_ratelimit and calling it core_ratelimit or whatever. Then
wrap these non critical things with it. Overkill?

Anton
