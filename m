Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317454AbSFLH2m>; Wed, 12 Jun 2002 03:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317664AbSFLH2l>; Wed, 12 Jun 2002 03:28:41 -0400
Received: from poplar.cs.washington.edu ([128.95.2.24]:63247 "EHLO
	poplar.cs.washington.edu") by vger.kernel.org with ESMTP
	id <S317454AbSFLH2k>; Wed, 12 Jun 2002 03:28:40 -0400
Date: Wed, 12 Jun 2002 00:28:41 -0700
From: Neil Spring <nspring@cs.washington.edu>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Cc: raul@pleyades.net
Subject: Re: bandwidth 'depredation'
Message-ID: <20020612072840.GB29843@cs.washington.edu>
In-Reply-To: <Pine.LNX.4.44.0206111628280.17534-100000@Megathlon.ESI> <E17I2FN-0006y7-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 08:08:49AM +0100, Alan Cox wrote:
>> But so how is QoS going to change things? It's the output queue of
>> the router on the other side of the ADLS link that needs management
>> (and maybe you need to speak some protocol like RSVP), or am I missing
>> something? How can you control the rate of *incoming* packets per
>> connection / protocol? 

> For  tcp it works fine. You drop stuff late but it still triggers
> backoffs as needed

Some queues (like my dialup access queue once upon a time)
are pathologically overprovisioned, making for too much
delay and poor sharing, before drops bring the tcp flow in
line.

Since nobody runs TCP Vegas, my personal favorite trick is
to play with the receiver's advertised window size.  With a
256kbps downstream rate DSL line, one could assert "I'll
never talk to anyone more than 0.2 seconds round trip away"
and decide that 256,000/8/5 = 6400 bytes is as large a
window as TCP needs, and that the default of 64K is
excessive.  So, "echo 16636 >
/proc/sys/net/core/rmem_default" and experience lower
latency, higher-fairness networking.  The bandwidth
available to the remote server is the same (limited by the
access link) but the extra packets it can queue in flight
are limited.  Note that there may be a better way to set the
receive buffer space, and I forget if there's a halving in
there, which is part of why I said 'echo 16k', so you may
want to play around with some different values.

Or, do ugly things to the kernel to automatically tune the
advertised window based on the traffic mix and round trip
times to get a sort of managed receiver-side Vegas as in
http://www.ieee-infocom.org/2000/papers/600.ps (shameless
plug, but a fun little project when you want to read mail
and update Debian at the same time over a poorly managed
modem).

It's just an idea; people forget that the receiver does have
a way to limit the sender's rate in TCP without waiting for
a loss.

enjoy,
-neil


