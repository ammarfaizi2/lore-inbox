Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbTI0Ewy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 00:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbTI0Ewy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 00:52:54 -0400
Received: from palrel10.hp.com ([156.153.255.245]:41636 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262117AbTI0Eww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 00:52:52 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16245.6050.374620.671683@napali.hpl.hp.com>
Date: Fri, 26 Sep 2003 21:52:50 -0700
To: Andi Kleen <ak@colin2.muc.de>
Cc: davidm@hpl.hp.com, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
In-Reply-To: <20030927043631.GA75212@colin2.muc.de>
References: <A2yd.64p.31@gated-at.bofh.it>
	<A2yd.64p.29@gated-at.bofh.it>
	<A317.6GH.7@gated-at.bofh.it>
	<m37k3viiqp.fsf@averell.firstfloor.org>
	<16244.31648.766419.56901@napali.hpl.hp.com>
	<20030927043631.GA75212@colin2.muc.de>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 27 Sep 2003 06:36:31 +0200, Andi Kleen <ak@colin2.muc.de> said:

  Andi> Use one receive descriptor for the MAC header and another for
  Andi> the rest (IP/TCP/payload) In the rest everything is aligned
  Andi> and there are no problems with misaligned data types (ignoring
  Andi> exceptional cases like broken timestamp options which can be
  Andi> handled slowly).

  >>  That's what I proposed.

  Andi> Hmm, must have missed that sorry. I saw it in Ivan's post
  Andi> only.

Hmmh, I wonder whether I accidentally replied via the newsgroup.  I
see my post in the newsgroup, but not on the linux-kernel archive.
Anyhow, I attached the original mail below.

  Andi> Fixing the stack to hadle separate MAC headers should not be
  Andi> that much work, the code is fairly limited. Drawback is that
  Andi> it requires bigger changes to the network drivers and maybe
  Andi> some special case code for non standard MAC headers.

  >>  I suspect you'd be better off just copying the 14 bytes of the
  >> Ethernet header so that the entire packet is contiguous.

  Andi> Good point. So it can be even handled transparently in drivers
  Andi> without any core stack changes.

  Andi> Only drawback is that more RX descriptors also usually require
  Andi> more PCI writes, which can be also very slow. Needs to be
  Andi> benchmarked carefully if it's a worthy trade-off.

Yes, I totally agree on this one.  Descriptor fetching is usually
quite expensive, though depending on how smart the PCI controller is,
some of the cost could be hidden.

	--david

---------------------------------------------------------------------
From: David Mosberger <davidm@napali.hpl.hp.com>
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Newsgroups: linux.kernel
Date: Fri, 26 Sep 2003 08:50:09 +0200
Reply-To: davidm@hpl.hp.com
Organization: linux.* mail to news gateway

>>>>> On Thu, 25 Sep 2003 23:07:02 -0700, "David S. Miller" <davem@redhat.com> said:

  David> On Fri, 26 Sep 2003 08:16:36 +0200 Manfred Spraul
  David> <manfred@colorfullife.com> wrote:

  >> Is that really the right solution? Add a full-packet copy to
  >> every driver?

  David> In the short term, yes it is.

I know nothing about the ns83820, but page 22 of the data sheet
(http://www.national.com/pf/DP/DP83820.html) suggests that it would be
possible to setup _two_ descriptors for each incoming packet: the
first one would cover the Ethernet header (14 bytes), the second the
rest.  That way, IP-header would be 8-byte aligned (since the
ns83820's DMA engine seems to require 8-byte alignment for incoming
data).

If so, this would let you get the IP-header and on aligned at the cost
of extra descriptor fetching.  The cost of fetching the extra
descriptor will be big enough that you'd only want to do this when
unaligned accesses are expensive, but hopefully it would be cheaper
than copying the entire packet.

	--david
