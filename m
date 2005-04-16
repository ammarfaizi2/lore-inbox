Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbVDPLGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbVDPLGY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 07:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVDPLGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 07:06:24 -0400
Received: from postel.suug.ch ([195.134.158.23]:58089 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S261990AbVDPLGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 07:06:18 -0400
Date: Sat, 16 Apr 2005 13:06:39 +0200
From: Thomas Graf <tgraf@suug.ch>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steven Rostedt <rostedt@goodmis.org>, hadi@cyberus.ca,
       netdev <netdev@oss.sgi.com>, Tarhon-Onu Victor <mituc@iasi.rdsnet.ro>,
       kuznet@ms2.inr.ac.ru, devik@cdi.cz, linux-kernel@vger.kernel.org,
       Patrick McHardy <kaber@trash.net>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: ACPI/HT or Packet Scheduler BUG?
Message-ID: <20050416110639.GI4114@postel.suug.ch>
References: <Pine.LNX.4.61.0504081225510.27991@blackblue.iasi.rdsnet.ro> <Pine.LNX.4.61.0504121526550.4822@blackblue.iasi.rdsnet.ro> <Pine.LNX.4.61.0504141840420.13546@blackblue.iasi.rdsnet.ro> <1113601029.4294.80.camel@localhost.localdomain> <1113601446.17859.36.camel@localhost.localdomain> <1113602052.4294.89.camel@localhost.localdomain> <20050415225422.GF4114@postel.suug.ch> <20050416014906.GA3291@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050416014906.GA3291@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Herbert Xu <20050416014906.GA3291@gondor.apana.org.au> 2005-04-16 11:49
> On Fri, Apr 15, 2005 at 10:54:22PM +0000, Thomas Graf wrote:
> >
> > Another case were it's not locked is upon a deletion of a class where
> > the class deletes its inner qdisc, although there is only one case
> > how this can happen and that's under rtnl semaphore so there is no
> > way we can have a dumper at the same time.
> 
> Sorry, that's where tc went astray :)
> 
> The assumption that the rtnl is held during dumping is false.  It is
> only true for the initial dump call.  All subsequent dumps are not
> protected by the rtnl.

Ahh.. it's the unlocked subsequent dump calls that are _still_ running
when the destroy is invoked. That's where Patrick and I went wrong
when we tried to fix this issue. We set our t0 to qdisc_destroy and
didn't really consider any prior unlocked tasks still running.

> In fact the whole qdisc locking is a mess.  It's a cross-breed
> between locking with ad-hoc reference counting and RCU.  What's
> more, the RCU is completely useless too because for the case
> where we actually have a queue we still end up taking the spin
> lock on each transmit! I think someone's been benchmarking the
> loopback device again :)

It's not completely useless, it speeds up the deletion classful
qdiscs having some depth. However, it's not worth the locking
troubles I guess.

> Here is a quick'n'dirty fix to the problem at hand.

I think it's pretty clean but it doesn't solve the problem completely,
see below.

> This patch tries to ensure that all top-level calls to qdisc_destroy
> come under the tree lock.  As Thomas correctedly pointed out, most
> of the other qdisc_destroy calls occur after the top qdisc has been
> unlinked from the device qdisc_list.  However, someone should go
> through each one of the remaining ones (they're all in the individual
> sch_* implementations) and make sure that this assumption is really
> true.

qdisc_destroy can still be invoked without qdisc_tree_lock via the
deletion of a class when it calls qdisc_destroy to destroy its
leaf qdisc.

> If anyone has cycles to spare and a stomach strong enough for
> this stuff, here is your chance :)

I will look into this.
