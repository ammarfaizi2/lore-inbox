Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269557AbTGJRkn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 13:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269561AbTGJRkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 13:40:43 -0400
Received: from palrel12.hp.com ([156.153.255.237]:2432 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S269557AbTGJRkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 13:40:31 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16141.43130.657025.952793@napali.hpl.hp.com>
Date: Thu, 10 Jul 2003 10:55:06 -0700
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       ak@suse.de
Subject: Re: per_cpu fixes 
In-Reply-To: <20030710015208.1E7A22C44B@lists.samba.org>
References: <200307092120.h69LKTBH002759@napali.hpl.hp.com>
	<20030710015208.1E7A22C44B@lists.samba.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 10 Jul 2003 11:41:07 +1000, Rusty Russell <rusty@rustcorp.com.au> said:

  Rusty> A compromise is possible.  I believe that the address of a
  Rusty> per-cpu variable *must* be the same everywhere, but we can
  Rusty> provide get & set macros which never expose an lvalue, and on
  Rusty> IA64 could use the pinned TLB thing:

  Rusty> /* Usage: set_cpu_local(myint, = 1), or set_cpu_local(mystruct,.member = 1) */
  Rusty> #define set_cpu_local(var, assign) ...

  Rusty> /* Usage: get_cpu_local(myint), or get_cpu_local(mystruct).member */
  Rusty> #define get_cpu_local(var)
  Rusty> ...

You mean there would be three primitives:

 (1) get value from a per-CPU variable
 (2) set value of a per-CPU variable
 (3) get the (canonical) address of a per-CPU variable

?

If so, I could live with that.

I don't like the proposed syntax for (2) very much, but I don't have a
better suggestion and it may not matter much: for extremely
performance-critical stuff (2) can be used and if you really hate the
syntax, you can use (3) to get a pointer to the variable and then do
the normal thing.

On ia64, we should be able to implement (3) via a CPU-local variable
which stores the per-CPU offset for a CPU.  Ideally, calculating the
canonical address of CPU-local variable FOO would boil down to:

 movl ADDR = local_per_cpu_offset;;
 load ADDR = [ADDR];;				// read the per-CPU offset
 addl ADDR = (FOO - local_per_cpu_offset), ADDR	// calculate local addr of FOO

I'm not sure we can coax gcc to generate exactly this code, but we
should be able to get close and should definitely be able to avoid an
array lookup and accessing remote memory (in the NUMA case).

I suspect Andi could do something similar?

	--david
