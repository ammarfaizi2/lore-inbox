Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVF1Rju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVF1Rju (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 13:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbVF1Rju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 13:39:50 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:53993 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261508AbVF1Rjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 13:39:35 -0400
Date: Tue, 28 Jun 2005 10:40:07 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, dipankar@in.ibm.com,
       ak@suse.de, akpm@osdl.org, maneesh@in.ibm.com
Subject: Re: [RFC,PATCH] RCU: clean up a few remaining synchronize_kernel() calls
Message-ID: <20050628174007.GH1294@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050618002021.GA2892@us.ibm.com> <Pine.LNX.4.61.0506191150300.26045@montezuma.fsmlabs.com> <20050627050206.GA2139@us.ibm.com> <Pine.LNX.4.61.0506271305290.12042@montezuma.fsmlabs.com> <20050628153257.GD1294@us.ibm.com> <Pine.LNX.4.61.0506281055260.9135@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506281055260.9135@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 11:15:55AM -0600, Zwane Mwaikambo wrote:
> On Tue, 28 Jun 2005, Paul E. McKenney wrote:
> > However, you do have a good point -- weakly ordered CPUs would need to
> > have an explicit memory barrier.  This might well already be taken care
> > of by the memory barriers in the locking primitives used by the up()
> > operation invoked at the end of oprofile_start(), but I did not check
> > all the possible ways that these functions can be called.
> 
> I agree, that usage looks safe.

Cool!

> > Given that set_nmi_callback isn't invoked all that often, seems like
> > it might be preferable to insert an smp_wmb() at the beginning of
> > set_nmi_callback(), so that it reads as follows:
> > 
> > 	void set_nmi_callback(nmi_callback_t callback)
> > 	{
> > 		smp_wmb();
> > 		nmi_callback = callback;
> > 	}
> > 
> > Thoughts?
> 
> Andrew (rightly) tends to howls whenever someone adds a memory barrier 
> without a comment ;) So if we were to make that change, how about the 
> following accompanying comment;
> 
> "smp_wmb ensures that all data dependencies for the callback are posted 
> and callback is ready for execution"

Actually, I was guilty of posting email to LKML before being fully
awake...  How about the following instead?

	void set_nmi_callback(nmi_callback_t callback)
	{
		rcu_assign_pointer(nmi_callback, callback);
	}

Similarly:

	void unset_nmi_callback(void)
	{
		rcu_assign_pointer(nmi_callback, dummy_nmi_callback);
	}

This, combined with the rcu_dereference() in do_nmi() seem to me to
make the usage a lot more clear.  If you agree, would you like to
submit the patches, or should I?

> Thanks for elaborating, the examples certainly do help clarify usage.

Glad they help, will clean them up (so that the examples use
rcu_dereference() and rcu_assign_pointer()) and submit them!

							Thanx, Paul
