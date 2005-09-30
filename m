Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbVI3A1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbVI3A1n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbVI3A1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:27:43 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:46861 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932406AbVI3A1n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:27:43 -0400
Date: Fri, 30 Sep 2005 10:27:19 +1000
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Suzanne Wood <suzannew@cs.pdx.edu>, Robert.Olsson@data.slu.se,
       davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Message-ID: <20050930002719.GC21062@gondor.apana.org.au>
References: <200509292330.j8TNUSmH019572@rastaban.cs.pdx.edu> <20050930002346.GP8177@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930002346.GP8177@us.ibm.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 05:23:46PM -0700, Paul E. McKenney wrote:
> 
> Is there any case where __in_dev_get() might be called without
> needing to be wrapped with rcu_dereference()?  If so, then I
> agree (FWIW, given my meagre knowledge of Linux networking).

Yes.  All paths that call __in_dev_get() under the rtnl do not
need rcu_dereference (or any RCU at all) since the rtnl prevents
any ip_ptr modification from occuring.

> However, rcu_dereference() only generates a memory barrier on DEC
> Alpha, so there is normally no penalty for using it in the NULL-pointer
> case.  So, when using rcu_dereference() unconditionally simplifies
> the code, it may make sense to "just do it".

Here is what the code would look like:

	rcu_read_lock();
	in_dev = dev->ip_ptr;
	if (in_dev) {
		in_dev = rcu_dereference(in_dev);
		atomic_inc(&in_dev->refcnt);
	}
	rcu_read_unlock();
	return in_dev;

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
