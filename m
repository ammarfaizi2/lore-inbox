Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWC2MQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWC2MQw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 07:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWC2MQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 07:16:52 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:56500 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750846AbWC2MQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 07:16:51 -0500
Message-ID: <442A7AA6.7080206@bull.net>
Date: Wed, 29 Mar 2006 14:16:38 +0200
From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en, fr, hu
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Christoph Lameter'" <clameter@sgi.com>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       Zoltan Menyhart <Zoltan.Menyhart@free.fr>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Fix unlock_buffer() to work the same way as bit_unlock()
References: <200603290139.k2T1d1g00702@unix-os.sc.intel.com>
In-Reply-To: <200603290139.k2T1d1g00702@unix-os.sc.intel.com>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/03/2006 14:18:54,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/03/2006 14:18:56,
	Serialize complete at 29/03/2006 14:18:56
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 2.
There are a couple of different ways of using / implementing bit-op-s.
I try to summarize them:


1. "Stand alone" bit operations:

By "stand alone" I mean that a modification to a bit field member is
independent of any other operation before / after the bit operation
in question. There is no ordering with respect to the other operations.

They do not provide any SMP synch. semantics, there is no need to
implement them as some atomic operations.


2. Atomic bit operations:

As Linux turned to SMP safe, a couple of bit operations have been
re-implemented by use of some atomic operations.
An early implementation on PCs determined the basic semantics of
these operations, including their fencing behavior.

atomic_ops.txt:

"      obj->dead = 1;
      if (test_and_set_bit(0, &obj->flags))
              /* ... */;
      obj->killed = 1;

   The implementation of test_and_set_bit() must guarentee that
   "obj->dead = 1;" is visible to cpus before the atomic memory operation
   done by test_and_set_bit() becomes visible.  Likewise, the atomic
   memory operation done by test_and_set_bit() must become visible before
   "obj->killed = 1;" is visible."

I am not convenienced that this is a good sync. strategy.
Unfortunately, the acquisition / release semantics were not defined
in Linux via some architecture independent and explicit way.
People simply abused the fact that the bidirectional fencing is
implicitly provided by some architectures for free.

Theoretically, the code fragments like above have to be cleared up
to use explicit ordering primitives. The description in atomic_ops.txt
should state that this is not the way to do... (see the Fencing bit
operations below).
There can be ~20 "test_and_set_bit()" here or there.


The atomic bit operation with requirements to order the preceding /
following operations are mainly used for locking(-like) purposes:


3. Fencing bit operations:

Should someone still insist on using the atomic bit operations as today,
s/he should change to use e.g.:

   obj->dead = 1;
   if (test_and_set_bit_N_fence(0, &obj->flags))
         /* ... */;
   obj->killed = 1;


4. Bit-lock operations:

I summarized the ordering requirements here:
http://marc.theaimsgroup.com/?l=linux-ia64&m=114362989421046&w=2

In order to let the architectures implement these bit-lock
operations efficiently, the usage has to indicate the _minimal_
required ordering semantics, e.g.:

     test_and_set_bit_N_acquire()
or   ordered_test_and_set_bit(acquire, ...)
     release_N_clear_bit()
etc.

The style like:

	do_some_ordering_before()
	bit_op()
	do_some_ordering_after()

is quite correct, however, the compiler is not sufficiently
intelligent to let the architecture dependent part to merge e.g. into
a single machine instruction (if it exists).


Regards,

Zoltan 

