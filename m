Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVBWK71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVBWK71 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 05:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVBWK71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 05:59:27 -0500
Received: from fire.osdl.org ([65.172.181.4]:50616 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261453AbVBWK7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 05:59:19 -0500
Date: Wed, 23 Feb 2005 02:58:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: johnpol@2ka.mipt.ru
Cc: guillaume.thouvenin@bull.net, greg@kroah.com, linux-kernel@vger.kernel.org,
       elsa-devel@lists.sourceforge.net, gh@us.ibm.com, efocht@hpce.nec.com
Subject: Re: [PATCH 2.6.11-rc3-mm2] connector: Add a fork connector
Message-Id: <20050223025806.5a39f8fb.akpm@osdl.org>
In-Reply-To: <20050223140818.4261c4d0@zanzibar.2ka.mipt.ru>
References: <1108649153.8379.137.camel@frecb000711.frec.bull.fr>
	<1109148752.1738.105.camel@frecb000711.frec.bull.fr>
	<20050223010747.0a572422.akpm@osdl.org>
	<20050223140818.4261c4d0@zanzibar.2ka.mipt.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
> On Wed, 23 Feb 2005 01:07:47 -0800
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
> > >
> > > Hello,
> > > 
> > >   This patch replaces the relay_fork module and it implements a fork
> > > connector in the kernel/fork.c:do_fork() routine. The connector sends
> > > information about parent PID and child PID over a netlink interface. It
> > > allows to several user space applications to be informed when a fork
> > > occurs in the kernel. The main drawback is that even if nobody listens,
> > > message is send. I don't know how to avoid that.
> > 
> > We really should find a way to fix that.  Especially if we want all the
> > distributors to enable the connector in their builds (we do).
> 
> Mesage is never reached anyone if there are no listeners, skb will be just freed,
> even without any linking.
> do_one_broadcast() in net/netlink/af_netlink.c takes care of it.
> Unicast message also will be discarded in cn_rx_skb().

We should assume that there will always be listeners.  (why was the
connector thing added anyway?  Its changelog is pathetic).

> These operations are quite cheap - just link/unlink skb to/from appropriate
> queues.

Please assume that <whatever secret application the connector stuff was
originally written for> will always be listening.

> > What happened to the idea of sending an on/off message down the netlink
> > socket?
> 
> ?

All those emails I sent last week.

Arrange for the userspace daemon to send a message to the fork_connector
subsystem turning it on or off.  So we can bypass all this code in the
common case where <secret application> is listening, but your daemon is
not.

> > > +		if (msg) {
> > > +			memset(msg, '\0', size);
> > 
> > Do we really need to memset the whole thing?
> 
> Yes, to not leak kernel memory context.

How would we do that?  There are no gaps in the payload and we tell netlink
the exact length.

> > > +			memcpy(&msg->id, &fork_id, sizeof(msg->id));
> > > +			msg->seq = seq++;
> > 
> > `seq' needs a lock to protect it.  Or use atomic_add_return(), maybe.
> 
> Not necessary, I doubt fork userspace listener uses protocol described in
> connector.c and relies on seq field since it is not needed to have acks/replays.
> Although it can be used as a flag that it is new fork, but message itself
> is already such an event.

Without a lock you can have two messages with the same sequence number. 
Even if the daemon which you're planning on implementing can handle that,
we shouldn't allow it.

