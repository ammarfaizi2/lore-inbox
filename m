Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266527AbUHXGv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266527AbUHXGv6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 02:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266569AbUHXGv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 02:51:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48527 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266527AbUHXGvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 02:51:41 -0400
Date: Mon, 23 Aug 2004 23:51:23 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: yoshfuji@linux-ipv6.org, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: IPv6 oops on ifup in latest BK
Message-Id: <20040823235123.71f18c04.davem@redhat.com>
In-Reply-To: <412ADB20.5000901@pobox.com>
References: <412ADB20.5000901@pobox.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004 02:07:28 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> Attached minicom.cap.txt gives the ksymoops output and dmesg output. 
> Appears to die in ipv6_get_hoplimit.

Yoshifuji-san, it is rt6i_dev changes.  The problem is that
ipv6_get_hoplimit() gets called with NULL dev.

I believe it is an error in the logic for RTCF_REJECT
processing.  If user does not specify a specific device
index, and this is RTCF_REJECT, then we will end up
with dev being NULL.

It is this piece of code in ip6_route_add():

		if (dev && dev != &loopback_dev) {

It does not handle the case where dev == NULL correctly.
Original code did do the right thing:

		if (dev)
			dev_put(dev);
		dev = &loopback_dev;
		dev_hold(dev);

Maybe new code should be something like:

		if (dev && dev != &loopback_dev) {
			dev_put(dev);
			in6_dev_put(idev);
		}
		dev = &loopback_dev;
		dev_hold(dev);
		idev = in6_dev_get(dev);
		if (!idev) {
			err = -ENODEV;
			goto out;
		}

What do you think?
