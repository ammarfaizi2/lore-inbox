Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWCaDUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWCaDUt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 22:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWCaDUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 22:20:49 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:65234 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751206AbWCaDUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 22:20:48 -0500
Date: Thu, 30 Mar 2006 19:20:41 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: RE: Synchronizing Bit operations V2
In-Reply-To: <200603310314.k2V3E6g28521@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0603301914490.3145@schroedinger.engr.sgi.com>
References: <200603310314.k2V3E6g28521@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006, Chen, Kenneth W wrote:

> > What of it? Release semantics are not a full fence or memory barrier.
> 
> The API did not require a full fence.  It is defined as a one way fence.

Well that explains our misunderstanding.

The issue with all these hacky macros is that they all have their own 
semantics and do not work in a consistent way. More reason to make that 
explicit.

Where may I find that definition?

Documentation/atomic_ops.txt implies a complete barrier and gives
an example of the use of these macros in order to obtain release 
semantics. AFAIK that does not mean that this is the intended complete 
behavior of a "memory barrier":




If a caller requires memory barrier semantics around an atomic_t
operation which does not return a value, a set of interfaces are
defined which accomplish this:

        void smp_mb__before_atomic_dec(void);
        void smp_mb__after_atomic_dec(void);
        void smp_mb__before_atomic_inc(void);
        void smp_mb__after_atomic_dec(void);

For example, smp_mb__before_atomic_dec() can be used like so:

        obj->dead = 1;
        smp_mb__before_atomic_dec();
        atomic_dec(&obj->ref_count);

It makes sure that all memory operations preceeding the atomic_dec()
call are strongly ordered with respect to the atomic counter
operation.  In the above example, it guarentees that the assignment of
"1" to obj->dead will be globally visible to other cpus before the
atomic counter decrement.


