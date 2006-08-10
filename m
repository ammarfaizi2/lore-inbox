Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161355AbWHJPid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161355AbWHJPid (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 11:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161360AbWHJPid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 11:38:33 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:48293 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161361AbWHJPic
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 11:38:32 -0400
Date: Thu, 10 Aug 2006 08:39:15 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Stelian Pop <stelian@popies.net>
Cc: Mike Christie <michaelc@cs.wisc.edu>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, paulus@au1.ibm.com, anton@au1.ibm.com,
       open-iscsi@googlegroups.com, pradeep@us.ibm.com, mashirle@us.ibm.com
Subject: Re: [PATCH] memory ordering in __kfifo primitives
Message-ID: <20060810153915.GE1298@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060810001823.GA3026@us.ibm.com> <20060810003310.GA3071@us.ibm.com> <44DAC892.7000100@cs.wisc.edu> <20060810134135.GB1298@us.ibm.com> <1155220013.1108.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1155220013.1108.4.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 04:26:53PM +0200, Stelian Pop wrote:
> Le jeudi 10 août 2006 à 06:41 -0700, Paul E. McKenney a écrit :
> 
> > I am happy to go either way -- the patch with the memory barriers
> > (which does have the side-effect of slowing down kfifo_get() and
> > kfifo_put(), by the way), or a patch removing the comments saying
> > that it is OK to invoke __kfifo_get() and __kfifo_put() without
> > locking.
> > 
> > Any other thoughts on which is better?  (1) the memory barriers or
> > (2) requiring the caller hold appropriate locks across calls to
> > __kfifo_get() and __kfifo_put()?
> 
> If someone wants to use explicit locking, he/she can go with kfifo_get()
> instead of the __ version.

However, the kfifo_get()/kfifo_put() interfaces use the internal lock,
which cannot be used by the caller to protect other code surrounding
the call to kfifo_get()/kfifo_put().  See for example the ISCSI use,
where they have a session->lock that, among other things, protects their
__kfifo_get()/__kfifo_put() calls.

> I'd rather keep the __kfifo_get() and __kfifo_put() functions lockless,
> so I say go for (1) even if there is a tiny price to pay for corectness.

If we require the caller to supply the locks for __kfifo_get() and
__kfifo_put(), then we have -both- correctness -and- better performance.
And the only current user of __kfifo_get()/__kfifo_put() stated that
they could easily expand their session->lock to cover all such calls,
and that doing so would not hurt their performance.

So, are you sure?  And if so, why?

						Thanx, Paul
