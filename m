Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWFMVZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWFMVZx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 17:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWFMVZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 17:25:53 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:33960
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932180AbWFMVZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 17:25:52 -0400
Date: Tue, 13 Jun 2006 14:26:03 -0700 (PDT)
Message-Id: <20060613.142603.48825062.davem@davemloft.net>
To: lkml@rtr.ca
Cc: jheffner@psc.edu, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: 2.6.17: networking bug??
From: David Miller <davem@davemloft.net>
In-Reply-To: <448F0D4B.30201@rtr.ca>
References: <Pine.LNX.4.64.0606131048550.5498@g5.osdl.org>
	<448F0344.9000008@rtr.ca>
	<448F0D4B.30201@rtr.ca>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Lord <lkml@rtr.ca>
Date: Tue, 13 Jun 2006 15:08:59 -0400

> Err.. no, the networking stack simply decided to become incompatible
> with certain sites, as a result of the user adding more RAM to their
> machine.

Let's discuss some facts.

First, you are getting window scaling by default with the older
kernel too.  It's just a smaller window scale, using a shift
value of say 1 or 2.

What these broken middle boxes do is ignore the window scale
entirely.

So they don't apply a window scale to the advertised windows in each
packet.  Therefore, they think a smaller amount of window space is
being advertised than really is.  So they will silently drop packets
they think is outside of this bogus window they've calculated.

Now, when the window scale is smaller, the connection can still limp
along, albeit slowly, making forward progress even in the face of such
broken devices because half or a quarter of the window is still
available.  It will retransmit a lot, and the congestion window won't
grow at all.

When the window scale is larger, this middle box bug makes it such
that not even one packet can fit into the miscalculated window and
things wedge.  The box thinks that your window is "94" instead of
"94 << WINDOW_SCALE".

I think OpenBSD's claim (they did have the bug and probably still do
for all that I know) was that they wanted to make their firewalling
"stateless".  This is a bogus argument because by definition you
cannot interpret the TCP window without having seen the initial
connection startup where the parameters are negotiated, and in
particular the window scale which will be used.

And you want to say we should try to work around systems designed
by people who think this is ok? :-)

It is impossible to fill a cross-continental connection without using
window scaling.  A 64K window is all you get without scaling.  Big
buffers are absolutely necessary, and as John Heffner showed this need
is growing exponentially and not slowing down.  6 megabit downlink is
pretty commonplace in the US, and the standard is much higher in well
connected countries such as South Korea.

Also, as John Heffner mentioned, even if we could detect the broken
boxes you can't just "turn off window scaling" after it's been
negotiated.  It's immutably active for the entire connection once
enabled.

Window scaling has been standardized and around for 14 years, RFC1323
was published in May of 1992.  How much longer can we wait for it
to be deployed properly? :-)

So the broken boxes, which to be honest are few and far between these
days, need to go, they really do.
