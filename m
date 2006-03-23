Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWCWT2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWCWT2Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 14:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWCWT2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 14:28:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22197 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751446AbWCWT2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 14:28:24 -0500
Date: Thu, 23 Mar 2006 11:28:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: paulmck@us.ibm.com, davem@redhat.com, akpm@osdl.org,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #5] 
In-Reply-To: <895.1143138867@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0603231121110.26286@g5.osdl.org>
References: <20060316231723.GB1323@us.ibm.com>  <16835.1141936162@warthog.cambridge.redhat.com>
 <18351.1142432599@warthog.cambridge.redhat.com>  <895.1143138867@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Mar 2006, David Howells wrote:
> 
> > Some architectures have more expansive definition of data dependency,
> > including then- and else-clauses being data-dependent on the if-condition,
> > but this is probably too much detail.
> 
> Linus calls that a "control dependency" and doesn't seem to think that's a
> problem as it's sorted out by branch prediction.  What you said makes me
> wonder about conditional instructions (such as conditional move).

I'd put it the other way: a control dependency is not "sorted out" by 
branch prediction, it is effectively _nullified_ by branch prediction.

Basically, control dependencies aren't dependencies at all. There is 
absolutely _zero_ dependency between the following two loads:

	if (load a)
		load b;

because the "load b" can happen before the "load a" because of control 
prediction.

So if you need a read barrier where there is a _control_ dependency in 
between loading a and loading b, you need to make it a full "smp_rmb()". 
It is _not_ sufficient to make this a "read_barrier_depends", because the 
load of b really doesn't depend on the load of a at all.

So data dependencies that result in control dependencies aren't 
dependencies at all. Not even if the address depends on the control 
dependency.

So

	int *address_of_b;

	address_of_b = load(&a);
	smp_read_barrier_depends();
	b = load(address_of_b);

is correct, but

	int *address_of_b = default_address_of_b;

	if (load(&a))
		address_of_b = another_address_of_b;
	smp_read_barrier_depends();
	b = load(address_of_b);

is NOT correct, because there is no data dependency on the load of b, just 
a control dependency that the CPU may short-circuit with prediction, and 
that second case thus needs a real smp_rmb().

And yes, if we ever hit a CPU that does actual data prediction, not just 
control prediction, that will force smp_read_barrier_depends() to be the 
same as smp_rmb() on such an architecture.

		Linus
