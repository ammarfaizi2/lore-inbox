Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262994AbTEBQjO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 12:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbTEBQjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 12:39:14 -0400
Received: from palrel12.hp.com ([156.153.255.237]:56724 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262994AbTEBQjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 12:39:12 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16050.41490.798865.517036@napali.hpl.hp.com>
Date: Fri, 2 May 2003 09:51:30 -0700
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: David Mosberger-Tang <davidm@hpl.hp.com>, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-cpu change
In-Reply-To: <20030502084610.0C8AC2C0BF@lists.samba.org>
References: <20030502084610.0C8AC2C0BF@lists.samba.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 02 May 2003 18:28:34 +1000, Rusty Russell <rusty@rustcorp.com.au> said:

  Rusty> Hi David, To implement kmalloc_percpu to use the same
  Rusty> primitives that normal (static) per-cpu vars use, I have made
  Rusty> some changes.  This is required for sane per-cpu variable
  Rusty> support in modules, but the implementation also makes
  Rusty> allocation v. efficient.  I've had to make more assumptions
  Rusty> about the per-cpu layout though.

  Rusty> 	IA64 is the only arch which doesn't use the generic
  Rusty> struct (x86-64 seems to be partway 8), so I wanted to check
  Rusty> with you.  Basically, we over-allocate up front, and pass out
  Rusty> the rest through the __alloc_percpu interface.  I've made the
  Rusty> setup_per_cpu_areas() idempotent, so you should simply be
  Rusty> able to call that from your cpu_init() (the later generic
  Rusty> call will do nothing).

  Rusty> 	Please tell me if this is too restrictive for IA64.
  Rusty> Ideally it should be a simplification: you just need to
  Rusty> override __get_cpu_var(var) and __get_cpu_ptr(var) for SMP in
  Rusty> asm/percpu.h.  You might want to set PERCPU_POOL_SIZE (16k
  Rusty> would be plenty for my machine, but you currently do 64k).

We pin the per-CPU area into the TLB, so the size of this area is
limited to one of the supported page sizes (yes, we _could_ pin
multiple TLB entries, but I do not think that would be economical).
At the moment, we use a 64KB page size.  So as long as the per-CPU
area is guaranteed never to be bigger than that, we should be fine.

Two other comments:

 - On NUMA, you want to allocate the per-CPU areas in node-local memory.
 - It's important to initialize the per-CPU area early enough.  We
   currently do it in cpu_init().  Anything later would probably break
   things.

I am a little concerned with supporting per-CPU storage in modules.
What happens if the per-CPU area fills up?  With the normal kernel,
you'll get a link-time error, but with modules, you won't know until
you try to insert a module.  But the alternative of using something
similar to the user-level TLS model doesn't look exactly attractive
either.

	--david
