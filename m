Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbUDDAxT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 19:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUDDAxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 19:53:19 -0500
Received: from mail020.syd.optusnet.com.au ([211.29.132.131]:12699 "EHLO
	mail020.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262070AbUDDAxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 19:53:17 -0500
Date: Sun, 4 Apr 2004 10:55:58 +1000
From: Malvineous <malvineous@optushome.com.au>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, a.nielsen@optushome.com.au
Subject: Re: [PATCH] Fix kernel lockup in RTL-8169 gigabit ethernet driver
Message-Id: <20040404105558.2bffd4f0.malvineous@optushome.com.au>
In-Reply-To: <406EA054.2020401@colorfullife.com>
References: <406EA054.2020401@colorfullife.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Adam: did you see deadlocks that disappeared after applying your
> patch? It shouldn't deadlock - it should loop until the nic sends the
> packet to the wire. It might take a few msecs, but then it should
> continue. Perhaps gcc optimized away the reload from memory and loops
> on a register. Or there is another bug that is hidden by your patch.

Yes, it used to deadlock within a second after starting a large transfer
across the network (e.g. copying a 1GB+ file over NFS) however smaller
transfers (e.g. background gkrellmd traffic, web browsing, etc.) was
less likely to cause problems (I could go for a few hours before it
would deadlock.)

I initially tried to move the counters outside the loop, as I thought it
was just the one entry in the array causing the problem, however this
slowed network traffic down to approx 5kB/sec.  Upon looking at the
RTL8139 code it looked like "else break" was the correct action, and
this brought network traffic back up to full speed and it's now been 4.5
days since I booted the kernel with the patch and it's all working
perfectly.

When it did deadlock it was more or less permanent, as any programs
accessing the NIC (or indeed the hard drive) would immediately deadlock
- so no program could send network data, thus it would loop forever
waiting for more traffic.

I did add a 'printk' line in to see what the variables were just to make
sure this was the location of the bug, and as I expected none of
the values changed at all.

Cheers,
Adam.
