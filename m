Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbUL0XAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbUL0XAU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 18:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbUL0XAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 18:00:19 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:33956
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262001AbUL0W7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 17:59:23 -0500
Date: Mon, 27 Dec 2004 14:58:07 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Valdis.Kletnieks@vt.edu
Cc: kaber@trash.net, alan@lxorguk.ukuu.org.uk, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: PATCH: kmalloc packet slab
Message-Id: <20041227145807.73803fa8.davem@davemloft.net>
In-Reply-To: <200412272250.iBRMo2Qb011114@turing-police.cc.vt.edu>
References: <1104156983.20944.25.camel@localhost.localdomain>
	<41D043AC.2070203@trash.net>
	<20041227142350.1cf444fe.davem@davemloft.net>
	<200412272250.iBRMo2Qb011114@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2004 17:50:01 -0500
Valdis.Kletnieks@vt.edu wrote:

> On Mon, 27 Dec 2004 14:23:50 PST, "David S. Miller" said:
> 
> > If we are really going to do something like this, it should
> > be calculated properly and be determined per-interface
> > type as netdevs are registered.
> 
> Would you prefer to see this done for all interface types if we do it
> at all, or would a special-case for 1 or 2 types that can use a slab
> without being wasteful be an acceptable solution? (Let's face it - if
> 3.95 objects fit in each slab, we may not want to do it...)

It's not even just device MTU based (which can change dynamically
at run time), it's also based upon the PMTU for various paths.

As for wastefulness, that's a good question.  Adding a mechanism
to do kmalloc slabs dynamically doesn't sound all that wise.  That
would undo all the inlining tricks.

Probably a better idea is to provide a way to attach a slab to
an SKB's data area so that we can have per-device SLABs for this
kind of stuff (and if all "ethernet" devices want to share the
same SLAB, that's fine too, but it won't help all ethernet drivers
for reasons outlined in my previous email).

We added something similar for the Xen folks, and it's in Linus's
BK tree right now.  It's named alloc_skb_from_cache().

What I'd really like to see is device based determination of the
correct slab to use.  Unfortunately, dev_alloc_skb() doesn't take
a netdev argument, which is truly offensive.  Otherwise we could
just stick the necessary logic there.
