Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWGDNAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWGDNAI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 09:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWGDNAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 09:00:08 -0400
Received: from oker.escape.de ([194.120.234.254]:54410 "EHLO oker.escape.de")
	by vger.kernel.org with ESMTP id S1750965AbWGDNAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 09:00:06 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Q: locking mechanisms
References: <m2odw9g937.fsf@janus.isnogud.escape.de>
	<1151746571.25491.850.camel@localhost.localdomain>
From: Urs Thuermann <urs@isnogud.escape.de>
Date: 04 Jul 2006 14:58:42 +0200
In-Reply-To: <1151746571.25491.850.camel@localhost.localdomain>; from Thomas Gleixner on Sat, 01 Jul 2006 11:36:11 +0200
Message-ID: <m2mzbpcyrh.fsf@janus.isnogud.escape.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Does Documentation/listRCU.txt answer your questions ?

It doesn't answer my question.  I have code that receives network
packets by registering with dev_add_pack().  Each packet received is
then delivered to a list of receivers, where this list can contain quite
a lot of items:

	receive_function(struct sk_buff *skb, struct net_device *dev,
			struct packet_type *pt, struct net_device *orig_dev)
	{
		...
		rcu_read_lock();
                head = find_list(dev);
		hlist_for_each_entry_rcu(p, n, head, list) {
			deliver_packet_to_receiver(skb, p);
		}
		rcu_read_unlock();
	}

The deliver_packet_to_receiver() function finally ends up in a call to
sock_queue_rcv_skb().

My questions was, wether I should worry to "hold" the rcu_read_lock for
the time of the list traversal since the list can be quite long and
preemption is disabled between rcu_read_lock() and rcu_read_unlock().


urs
