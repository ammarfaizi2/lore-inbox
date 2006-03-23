Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWCWW0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWCWW0i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 17:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbWCWW0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 17:26:38 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:24457 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932488AbWCWW0h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 17:26:37 -0500
Date: Thu, 23 Mar 2006 14:26:45 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: davem@redhat.com, torvalds@osdl.org, akpm@osdl.org,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #5]
Message-ID: <20060323222645.GA1298@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060316231723.GB1323@us.ibm.com> <16835.1141936162@warthog.cambridge.redhat.com> <18351.1142432599@warthog.cambridge.redhat.com> <895.1143138867@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <895.1143138867@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 06:34:27PM +0000, David Howells wrote:
> Paul E. McKenney <paulmck@us.ibm.com> wrote:
> 
> > smp_mb__before_atomic_dec() and friends as well?
> 
> These seem to be something Sparc64 related; or, at least, Sparc64 seems to do
> something weird with them.
> 
> What are these meant to achieve anyway? They seems to just be barrier() on a
> lot of systems, even SMP ones.

On architectures such as x86 where atomic_dec() implies an smp_mb(),
they do nothing.  On other architectures, they supply whatever memory
barrier is required.

So, on x86:

	smp_mb();
	atomic_dec(&my_atomic_counter);

would result in -two- atomic instructions, but the smp_mb() would be
absolutely required on CPUs with weaker memory-consistency models.
So your choice is to (1) be inefficient on x86 or (2) be unsafe on
weak-memory-consistency systems.  What we can do instead is:

	smp_mb__before_atomic_dec();
	atomic_dec(&my_atomic_counter);

This allows x86 to generate efficient code -and- allows weak-memory
machines (e.g., Alpha, MIPS, PA-RISC(!), ppc, s390, SPARC64) to generate
safe code.

						Thanx, Paul
