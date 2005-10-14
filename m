Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbVJNWgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbVJNWgo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 18:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbVJNWgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 18:36:44 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:22288 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750989AbVJNWgn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 18:36:43 -0400
Date: Sat, 15 Oct 2005 08:36:13 +1000
To: Suzanne Wood <suzannew@cs.pdx.edu>
Cc: linux-kernel@vger.kernel.org, g4klx@g4klx.demon.co.uk, hch@infradead.org,
       jreuter@yaina.de, paulmck@us.ibm.com, walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] rcu in drivers/net/hamradio
Message-ID: <20051014223613.GA28103@gondor.apana.org.au>
References: <200510141638.j9EGcsJa000437@rastaban.cs.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510141638.j9EGcsJa000437@rastaban.cs.pdx.edu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2005 at 09:38:54AM -0700, Suzanne Wood wrote:
> 
> ChangeLog:
> Because bpq_new_device() calls list_add_rcu()
> and bpq_free_device() calls list_del_rcu(),
> substitute list_for_each_entry_rcu() for 
> list_for_each_entry() in bpq_get_ax25_dev().
> This requires the insertion of rcu_read_lock()/unlock().

The rcu_read_lock/unlock is unnecessary because the only caller that
doesn't hold RTNL (bpq_rcv) already takes that lock.  In fact it's
better to take it there since you need to hold the lock for the duration
of the use of the device.

> A consequence of list_for_each_entry_rcu(bpq, &bpq_devices, bpq_list)
> is that the future dereference of the pointer to the bpqdev 
> struct bpq is rcu-protected.  But bpq_get_ax25_dev() 
> returns bpq->axdev, a pointer to a net_device struct.  The 
> rcu_read_lock() in bpq_rcv() likely implies that is another 
> pointer to receive rcu-protected dereference.

The rcu_dereference should be provided by list_for_each_entry_rcu.
In fact there is a bug in the list_*_rcu macros where the first
element is not put through rcu_dereference.  I'll fix that up.

> The rcu_read_lock()/unlock() in bpq_device_event() 
> are removed due to the following found by considering 
> the cases of the switch statement: 

Agreed.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
