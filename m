Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263467AbUGFUPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbUGFUPu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 16:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUGFUPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 16:15:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25261 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263062AbUGFUPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 16:15:45 -0400
Date: Tue, 6 Jul 2004 13:12:35 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: shemminger@osdl.org, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix tcp_default_win_scale.
Message-Id: <20040706131235.10b5afa8.davem@redhat.com>
In-Reply-To: <20040706194034.GA11021@mail.shareable.org>
References: <32886.63.170.215.71.1088564087.squirrel@www.osdl.org>
	<20040629222751.392f0a82.davem@redhat.com>
	<20040630152750.2d01ca51@dell_ss3.pdx.osdl.net>
	<20040630153049.3ca25b76.davem@redhat.com>
	<20040701133738.301b9e46@dell_ss3.pdx.osdl.net>
	<20040701140406.62dfbc2a.davem@redhat.com>
	<20040702013225.GA24707@conectiva.com.br>
	<20040706093503.GA8147@outpost.ds9a.nl>
	<20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net>
	<20040706194034.GA11021@mail.shareable.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2004 20:40:34 +0100
Jamie Lokier <jamie@shareable.org> wrote:

> If a firewall strips the window scaling option in both directions,
> then window scaling is disabled (RFC 1323 section 2.2).
> 
> Are you saying there are broken firewalls which strip TCP options in
> one direction only?

It is this specific case:

1) SYN packet contains window scale option of ZERO.

   This says two things, that the system will use a window
   scale of ZERO and that it SUPPORTS send and receive window
   scaling.

   If the firewall were to delete this, we'd be OK, but it
   does not.  It leaves the option with zero in there.

2) SYN+ACK goes back out with non-zero window scale option.

   Note that because of #1, it is impossible for the system
   which sent the SYN packet to "refuse" the window scale
   option sent in the SYN+ACK.

   Here is where we have problems.  If the firewall patches
   the scale to zero, which is what some of these things
   are doing, it is then the firewall's responsibility to
   scale the window to make it appear to be zero-scaled.

   And this is not being done by these broken firewalls.

BTW, this is why it is so important to get tcpdump traces
at both ends of the connection to analyze problems like
this.  If you look at only one side with dumps, you might
not get the side that is getting packets edited by a
firewall or other device.

These machines are so broken that I absolutely refuse to change
how we behave to work around them.

If they want window scaling to be effectively disabled, they should
patch out the window scale option in the "SYN" packet, this prevents
the SYN+ACK sending system from advertising any window scaling support.

What these broken devices are doing is effectively making window
scaling unusable on the internet, and I refuse to swallow such
crap.
