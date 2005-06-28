Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVF1PdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVF1PdI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 11:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVF1PdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 11:33:07 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:55468 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261793AbVF1Pcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 11:32:51 -0400
Date: Tue, 28 Jun 2005 08:32:58 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, dipankar@in.ibm.com,
       ak@suse.de, akpm@osdl.org, maneesh@in.ibm.com
Subject: Re: [RFC,PATCH] RCU: clean up a few remaining synchronize_kernel() calls
Message-ID: <20050628153257.GD1294@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050618002021.GA2892@us.ibm.com> <Pine.LNX.4.61.0506191150300.26045@montezuma.fsmlabs.com> <20050627050206.GA2139@us.ibm.com> <Pine.LNX.4.61.0506271305290.12042@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506271305290.12042@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 08:22:24AM -0600, Zwane Mwaikambo wrote:
> Hello Paul,
> 
> On Sun, 26 Jun 2005, Paul E. McKenney wrote:
> 
> > How does the following look for NMI-RCU documentation?
> 
> That looks good, there is just one bit i'm not entirely sure about and i'd 
> appreciate it if you could entertain me for a bit;

I will see what entertainment I can provide.  ;-)

> Answer to Quick Quiz
> 
>         Why might the rcu_dereference() be necessary on Alpha, given
>         that the code reference by the pointer is read-only?
> 
>         Answer: The caller to set_nmi_callback() might well have
>                 initialized some data that is to be used by the
>                 new NMI handler.  In this case, the rcu_dereference()
>                 would be needed, because otherwise a CPU that received
>                 an NMI just after the new handler was set might see
>                 the pointer to the new NMI handler, but the old
>                 pre-initialized version of the handler's data.
> 
> Reading that i would think the general programming model for this would 
> be;
> 
> setup data
> write barrier
> setup callback

Agreed!  I have updated the document to make this requirement clear.

> Isn't that still required considering the following scenario;
> 
> CPU0			CPU1
> setup data		<NMI>
> setup callback		...
> ...			call callback
> 
> on i386, interrupts are data synchronising events, however if we happen to 
> take an interrupt right when the data is being setup we won't synchronise 
> with respect to that data. This could be achieved via the explicit write 
> barrier after data setup or rcu_dereference in the NMI handler. Or perhaps 
> i'm missing something?

On i386, writes are ordered.  So if CPU1 sees the callback, it is
guaranteed to also see the data.

However, you do have a good point -- weakly ordered CPUs would need to
have an explicit memory barrier.  This might well already be taken care
of by the memory barriers in the locking primitives used by the up()
operation invoked at the end of oprofile_start(), but I did not check
all the possible ways that these functions can be called.

Given that set_nmi_callback isn't invoked all that often, seems like
it might be preferable to insert an smp_wmb() at the beginning of
set_nmi_callback(), so that it reads as follows:

	void set_nmi_callback(nmi_callback_t callback)
	{
		smp_wmb();
		nmi_callback = callback;
	}

Thoughts?

						Thanx, Paul
