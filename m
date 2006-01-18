Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWARF4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWARF4p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 00:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWARF4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 00:56:45 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:45257 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1751309AbWARF4p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 00:56:45 -0500
Message-ID: <43CDD892.6090605@cosmosbay.com>
Date: Wed, 18 Jan 2006 06:56:34 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       jeffrey.t.kirsher@intel.com
Subject: Re: [PATCH 11/17] fuse: add number of waiting requests attribute
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu>	<20060114004114.241169000@dorka.pomaz.szeredi.hu> <20060113172846.3ea49670.akpm@osdl.org>
In-Reply-To: <20060113172846.3ea49670.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>> +	/** The number of requests waiting for completion */
>> +	atomic_t num_waiting;
> 
> This doesn't get initialised anywhere.
> 
> Presumably you're relying on a memset somewhere.  That might work on all
> architectures, AFAIK.  But in theory it's wrong.  If, for example, the
> architecture implements atomic_t via a spinlock-plus-integer, and that
> spinlock's unlocked state is not all-bits-zero, we're dead.
> 
> So we should initialise it with
> 
> 	foo->num_waiting = ATOMIC_INIT(0);
> 
> 
> 
> nb: it is not correct to initialise an atomic_t with
> 
> 	atomic_set(a, 0);
> 
> because in the above theoretical case case where the arch uses a spinlock
> in the atomic_t, that spinlock doesn't get initialised.  I bet we've got code
> in there which does this.

Hum... I tracked one missing atomic_set() or ATOMIC_INIT in e1000 driver then.

e1000_alloc_queues() does :

#ifdef CONFIG_E1000_NAPI
         size = sizeof(struct net_device) * adapter->num_queues;
         adapter->polling_netdev = kmalloc(size, GFP_KERNEL);
         if (!adapter->polling_netdev) {
                 kfree(adapter->tx_ring);
                 kfree(adapter->rx_ring);
                 return -ENOMEM;
         }
         memset(adapter->polling_netdev, 0, size);
#endif

So this driver clearly assumes a memset(... 0 ...) also initialize atomic_t to 
  0   ((struct net_device *)->refcnt for example)

Eric
