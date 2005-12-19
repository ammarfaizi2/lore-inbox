Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVLSXy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVLSXy1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 18:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbVLSXy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 18:54:26 -0500
Received: from ozlabs.org ([203.10.76.45]:36773 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750700AbVLSXy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 18:54:26 -0500
Date: Tue, 20 Dec 2005 10:40:57 +1100
From: Anton Blanchard <anton@samba.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Sonny Rao <sonny@burdell.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, clameter@sgi.com, sonnyrao@us.ibm.com
Subject: Re: cpu hotplug oops on 2.6.15-rc5
Message-ID: <20051219234056.GA11792@krispykreme>
References: <20051219051659.GA6299@kevlar.burdell.org> <1134974518.10035.5.camel@gaston> <20051219070850.GA11956@kevlar.burdell.org> <43A72350.40909@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A72350.40909@colorfullife.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Manfred,

> Very odd call chain.
> Could you enable slab debugging?

Sonny and I had a look around, it seems to be in the
cpuup_callback() / CPU_DEAD case:

      if (!cpus_empty(mask)) {
              spin_unlock(&l3->list_lock);
              goto unlock_cache;
      }

      if (l3->shared) {
              free_block(cachep, l3->shared->entry,
                              l3->shared->avail, node);
              kfree(l3->shared);                <-------- HERE
              l3->shared = NULL;
      }

So we are removing the last cpu in a node, and tearing down the node
related structures. We looked at kfree() -> __cache_free() and we couldnt
convince ourselves that all the CONFIG_NUMA stuff in there wouldnt trip
over itself (since we would be doing the free on an alien node).

Anton
