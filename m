Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWFMWWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWFMWWs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 18:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWFMWWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 18:22:48 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:4062
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964779AbWFMWWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 18:22:47 -0400
Date: Tue, 13 Jun 2006 15:23:01 -0700 (PDT)
Message-Id: <20060613.152301.26928146.davem@davemloft.net>
To: lkml@rtr.ca
Cc: jheffner@psc.edu, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: 2.6.17: networking bug??
From: David Miller <davem@davemloft.net>
In-Reply-To: <448F32E1.8080002@rtr.ca>
References: <448F0D4B.30201@rtr.ca>
	<20060613.142603.48825062.davem@davemloft.net>
	<448F32E1.8080002@rtr.ca>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Lord <lkml@rtr.ca>
Date: Tue, 13 Jun 2006 17:49:21 -0400

> I suppose the most important objection to our current behaviour
> is that this behaviour *changes* when something totally unrelated
> (to Joe User) happens:  adding or removing a stick of RAM.

We are pretty much required to choose the TCP memory parameters
based upon how much physical memory is in the machine, and these
parameters in-turn are inextricably linked to what kind of window
scale we try to use for connections.

The behavior is unfortunate, but more unfortunate are the boxes that
create these problems in the first place.  I believe their lifespan is
quite limited.

> We should perhaps just have a fixed upper memory setting, as we
> currently do in 2.6.16, so that the behaviour is predictable.

The change in 2.6.17 was exactly that we needed to increase this
upper limit to ~4MB.

> On a related note.. I wonder if we can choose better values for
> the window size, so that if the scale factor is ignored, we still
> end up with reasonably sized packets?  So that the other box
> will not think our window is a mere "94" when the scale factor
> is lost?

We have an algorithm that tries to pick something based upon the
set of the values we might need to represent in the window field.

If the scale is too high, you lose accuracy, since the lower bits
get chopped off when the TCP header is being built and the computed
window size is shifted down.

So we try to pick the smallest scale necessary to represent the
largest window size we might end up needing to advertise.

A complication here is that we dynamically size both receive and send
buffers in response to our growing knowledge of the connection's
characteristics over time.  So at the beginning we'll use a small
buffer size, and as the congestion window grows we'll increase our
buffer sizes to fill the pipe.

This adds even more considerations for window scale selection, as you
can imagine.

One final word about window sizes.  If you have a connection whose
bandwidth-delay-product needs an N byte buffer to fill, you actually
have to have an "N * 2" sized buffer available in order for fast
retransmit to work.
