Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVF1ROZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVF1ROZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 13:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbVF1RN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 13:13:26 -0400
Received: from fsmlabs.com ([168.103.115.128]:4050 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262165AbVF1RMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 13:12:07 -0400
Date: Tue, 28 Jun 2005 11:15:55 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, dipankar@in.ibm.com,
       ak@suse.de, akpm@osdl.org, maneesh@in.ibm.com
Subject: Re: [RFC,PATCH] RCU: clean up a few remaining synchronize_kernel()
 calls
In-Reply-To: <20050628153257.GD1294@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0506281055260.9135@montezuma.fsmlabs.com>
References: <20050618002021.GA2892@us.ibm.com>
 <Pine.LNX.4.61.0506191150300.26045@montezuma.fsmlabs.com>
 <20050627050206.GA2139@us.ibm.com> <Pine.LNX.4.61.0506271305290.12042@montezuma.fsmlabs.com>
 <20050628153257.GD1294@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2005, Paul E. McKenney wrote:

> On i386, writes are ordered.  So if CPU1 sees the callback, it is
> guaranteed to also see the data.

Yes indeed, i was certain that i missed something ;)

> However, you do have a good point -- weakly ordered CPUs would need to
> have an explicit memory barrier.  This might well already be taken care
> of by the memory barriers in the locking primitives used by the up()
> operation invoked at the end of oprofile_start(), but I did not check
> all the possible ways that these functions can be called.

I agree, that usage looks safe.

> Given that set_nmi_callback isn't invoked all that often, seems like
> it might be preferable to insert an smp_wmb() at the beginning of
> set_nmi_callback(), so that it reads as follows:
> 
> 	void set_nmi_callback(nmi_callback_t callback)
> 	{
> 		smp_wmb();
> 		nmi_callback = callback;
> 	}
> 
> Thoughts?

Andrew (rightly) tends to howls whenever someone adds a memory barrier 
without a comment ;) So if we were to make that change, how about the 
following accompanying comment;

"smp_wmb ensures that all data dependencies for the callback are posted 
and callback is ready for execution"

Thanks for elaborating, the examples certainly do help clarify usage.
	Zwane
