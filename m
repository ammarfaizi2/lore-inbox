Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWJAWJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWJAWJq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 18:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWJAWJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 18:09:46 -0400
Received: from khc.piap.pl ([195.187.100.11]:15552 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932435AbWJAWJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 18:09:45 -0400
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question on HDLC and raw access to T1/E1 serial streams.
References: <451DC75E.4070403@candelatech.com>
	<m3mz8hntqu.fsf@defiant.localdomain> <451EE973.10907@candelatech.com>
	<m3hcyo2qvs.fsf@defiant.localdomain>
	<45200BD7.6030509@candelatech.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 02 Oct 2006 00:09:41 +0200
In-Reply-To: <45200BD7.6030509@candelatech.com> (Ben Greear's message of "Sun, 01 Oct 2006 11:41:27 -0700")
Message-ID: <m3zmcf8z8a.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear <greearb@candelatech.com> writes:

> My assumption for bridging a bitstream is that timeslot sync is not
> absolutely critical.  However, IF
> you could be sure of time-slot sync, you'd  have a lot more power and
> be able to do some extra ticks
> in user-space I think...

Not sure what do you want to do with that, but it may be critical for
many things.

> The key for me is that if you ever miss a slot in bit-stream mode, you
> can never make it up because
> every bit is critical.

I think you'd have to perform some recover procedure then, that's similar
to DCE losing sync.

>  This leads to having to drop arbitrary data to
> keep from ever-increasing latency on your
> bridge.

If your clocks are synchronized (for example, if you get a "master"
clock from your public phone exchange and you propagate it downstream,
or your machine is the "master") then you never drop anything, the
input and output rates are equal and in sync.

>  With HDLC, you can skip the flags and make up time if you
> ever miss a timeslot (assuming the
> HDLC is not using the line at 100% capacity.)

Sure. Even at 100% you can just drop a frame, HDLC applications must
be prepared for it.

> I'd be happy with a software approach.  In fact, if I could get a
> framed packet (ie, I know that
> byte 0 is channel 1, byte 24 is channel 24, and byte 25 is channel 1
> again...) then I could even
> do the multiplexing in user space.

Well, with software framing it would look a bit different - there
is no such thing as "packet" as both TX and RX is continuous, not
aligned to anything etc. You would have to detect channel boundaries,
and bit-shift the data. Requires the sync serial controller (and FALC)
in transparent mode (I would have to look at some docs). I think
the kernel is a better place for things like that due to latency
issues.

> For write, I'd also need to be able to guarantee that byte 0 goes to
> channel 1, etc.  So, if the
> driver bit-stuffed, then it would need to do an entire time-slice at once.

BTW: An HDLC frame can use many slices. You can in fact have many
HDLC frames (from different streams) multiplexed. You just need
a multi-stream device or a multiplexer.

>>> *  Configure entire T1 as HDLC transport, bridge HDLC frames from one
>>> T1 to the other.
> Excellent.  I actually want to write the bridge logic myself in
> user-space..I just need the driver
> API and at least one driver that supports it and has support for
> readily available T1/E1 hardware.

If you want the userspace HDLC bridge... I'd use a pair of T1/E1 cards
with generic HDLC support, for example, Cyclades PC300 (never used them
and while I don't exactly like their driver, in case of problems I could
add T1/E1 to my own driver which currently supports PC300 X.21 and
V.24/V.35).

Once T1/E1s are working and the required slots are selected:
sethdlc hdlc0 hdlc (options)
sethdlc hdlc1 hdlc (options)
ifconfig hdlc0 up
ifconfig hdlc1 up
man PF_PACKET

A single HDLC stream is a simple thing because it's exactly what
the cards are designed for.
-- 
Krzysztof Halasa
