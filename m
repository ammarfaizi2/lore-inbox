Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbVLTWUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVLTWUo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 17:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVLTWUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 17:20:44 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:24982 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S932182AbVLTWUn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 17:20:43 -0500
Date: Tue, 20 Dec 2005 23:19:06 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Eric Lemoine <eric.lemoine@gmail.com>
Subject: Re: sungem hangs in atomic if netconsole enabled but no carrier
Message-ID: <20051220221906.GB2525@electric-eye.fr.zoreil.com>
References: <1135080538.3937.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135080538.3937.3.camel@localhost>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> :
[...]
> think it should not hang the system completely. So far I haven't been
> able to figure out where it actually hangs and don't even know how to do
> so -- I'm open for suggestions on how to find out why/where it hangs or
> even fixes.

See the thread "Netconsole violates dev->hard_start_xmit synch rules"
started the 06/09/2005 on netdev@vger.kernel.org for some interesting
background.

(the innocent hero slowly fades into the swamps of netpolling...)

Still with us ?

Were you using sundance.c, you would probably bug on the first timeout:

[net/sched/sch_generic.c]
static void dev_watchdog(unsigned long arg)
{
        struct net_device *dev = (struct net_device *)arg;

        spin_lock(&dev->xmit_lock);
        ^^^^^^^^^
        if (dev->qdisc != &noop_qdisc) {
                if (netif_device_present(dev) &&
                    netif_running(dev) &&
                    netif_carrier_ok(dev)) {
                        if (netif_queue_stopped(dev) &&
                            (jiffies - dev->trans_start) > dev->watchdog_timeo) {
                                printk(KERN_INFO "NETDEV WATCHDOG: %s: transmit timed out\n", dev->name);
                                dev->tx_timeout(dev);
                                ^^^^^^^^^^^^^^^
[net/core/netpoll.c]
static void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
{
        int status;
        struct netpoll_info *npinfo;

        if (!np || !np->dev || !netif_running(np->dev)) {
                __kfree_skb(skb);
                return;
        }

        npinfo = np->dev->npinfo;

        /* avoid recursion */
        if (npinfo->poll_owner == smp_processor_id() ||
            np->dev->xmit_lock_owner == smp_processor_id()) {
                if (np->drop)
                        np->drop(skb);
                else
                        __kfree_skb(skb);
                return;
        }

        do {
                npinfo->tries--;
                spin_lock(&np->dev->xmit_lock);
                ^^^^^^^^^

A quick glance shows no netif_carrier_{on/off} in the sundance driver.
It would be a good candidate.

However you are using sungem.c and despite the fact that I should really
have something for dinner *now*, you are protected by netif_carrier_off.

But (drums roll):

[drivers/net/sungem.c]
#define DEFAULT_MSG     (NETIF_MSG_DRV          | \
                         NETIF_MSG_PROBE        | \
                         NETIF_MSG_LINK)

Thus gem_link_timer() will periodically complain that the link is down.

So gem_start_xmit() is issued.

Repeat until the TX ring is full: netif_stop_queue() is called.

gem_link_timer() printks.

net/core/netpoll.c::netpoll_send_skb() notices that the queue is stopped
and decides to try the usual NAPI poll(). A few function calls later, the
driver ends in drivers/net/sungem.c::gem_poll() where it takes so many
(irq-)locks that I do not even want to verify that it has a chance
to play nice with the pending gem_link_timer().

--
Ueimor
