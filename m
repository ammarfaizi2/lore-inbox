Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVBWKoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVBWKoR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 05:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVBWKoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 05:44:17 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:57261 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261446AbVBWKoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 05:44:05 -0500
Date: Wed, 23 Feb 2005 14:08:18 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>, greg@kroah.com,
       linux-kernel@vger.kernel.org, elsa-devel@lists.sourceforge.net,
       gh@us.ibm.com, efocht@hpce.nec.com
Subject: Re: [PATCH 2.6.11-rc3-mm2] connector: Add a fork connector
Message-ID: <20050223140818.4261c4d0@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050223010747.0a572422.akpm@osdl.org>
References: <1108649153.8379.137.camel@frecb000711.frec.bull.fr>
	<1109148752.1738.105.camel@frecb000711.frec.bull.fr>
	<20050223010747.0a572422.akpm@osdl.org>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2005 01:07:47 -0800
Andrew Morton <akpm@osdl.org> wrote:

> Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
> >
> > Hello,
> > 
> >   This patch replaces the relay_fork module and it implements a fork
> > connector in the kernel/fork.c:do_fork() routine. The connector sends
> > information about parent PID and child PID over a netlink interface. It
> > allows to several user space applications to be informed when a fork
> > occurs in the kernel. The main drawback is that even if nobody listens,
> > message is send. I don't know how to avoid that.
> 
> We really should find a way to fix that.  Especially if we want all the
> distributors to enable the connector in their builds (we do).

Mesage is never reached anyone if there are no listeners, skb will be just freed,
even without any linking.
do_one_broadcast() in net/netlink/af_netlink.c takes care of it.
Unicast message also will be discarded in cn_rx_skb().

These operations are quite cheap - just link/unlink skb to/from appropriate
queues.

> What happened to the idea of sending an on/off message down the netlink
> socket?

?

> > +#ifdef CONFIG_FORK_CONNECTOR
> > +#define FORK_CN_INFO_SIZE	64 
> > +static inline void fork_connector(pid_t parent, pid_t child)
> > +{
> > +	struct cb_id fork_id = {CN_IDX_FORK, CN_VAL_FORK};
> 
> This can be static const, which will save some stack and cycles.
> 
> > +	static __u32 seq; /* used to test if we lost message */
> > +	
> > +	if (cn_already_initialized) {
> > +		struct cn_msg *msg;
> > +		size_t size;
> > +
> > +		size = sizeof(*msg) + FORK_CN_INFO_SIZE;
> > +		msg = kmalloc(size, GFP_KERNEL);
> > +		if (msg) {
> > +			memset(msg, '\0', size);
> 
> Do we really need to memset the whole thing?

Yes, to not leak kernel memory context.

> > +			memcpy(&msg->id, &fork_id, sizeof(msg->id));
> > +			msg->seq = seq++;
> 
> `seq' needs a lock to protect it.  Or use atomic_add_return(), maybe.

Not necessary, I doubt fork userspace listener uses protocol described in
connector.c and relies on seq field since it is not needed to have acks/replays.
Although it can be used as a flag that it is new fork, but message itself
is already such an event.

> > +			msg->ack = 0; /* not used */
> > +			/* 
> > +			 * size of data is the number of characters 
> > +			 * printed plus one for the trailing '\0'
> > +			 */
> > +			msg->len = snprintf(msg->data, FORK_CN_INFO_SIZE-1, 
> > +					    "%i %i", parent, child) + 1;
> 
> scnprintf() would be more appropriate here, even though it should be a "can't
> happen".
> 
> > +			cn_netlink_send(msg, CN_IDX_FORK);
> > +
> > +			kfree(msg);
> 
> `msg' is only 84 bytes and do_fork() has a shallow call graph.  Make `msg'
> a local?  

Yes it can be local.

	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
