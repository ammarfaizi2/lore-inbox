Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311699AbSCNSEa>; Thu, 14 Mar 2002 13:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311665AbSCNSES>; Thu, 14 Mar 2002 13:04:18 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:27112 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S311699AbSCNSEI>;
	Thu, 14 Mar 2002 13:04:08 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15504.58901.82038.420706@napali.hpl.hp.com>
Date: Thu, 14 Mar 2002 10:04:05 -0800
To: Andi Kleen <ak@suse.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, davidm@hpl.hp.com,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com, rth@twiddle.net
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas
In-Reply-To: <p73bsdrsftu.fsf@oldwotan.suse.de>
In-Reply-To: <15504.7958.677592.908691@napali.hpl.hp.com.suse.lists.linux.kernel>
	<E16lMzi-0002bb-00@wagner.rustcorp.com.au.suse.lists.linux.kernel>
	<p73bsdrsftu.fsf@oldwotan.suse.de>
X-Mailer: VM 7.01 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 14 Mar 2002 09:39:57 +0100, Andi Kleen <ak@suse.de> said:

  Andi> Rusty Russell <rusty@rustcorp.com.au> writes:
  >> In message <15504.7958.677592.908691@napali.hpl.hp.com> you
  >> write: > OK, I see this.  Unfortunately, HIDE_RELOC() causes me
  >> problems > because it prevents me from taking the address of a
  >> per-CPU variable.  > This is useful when you have a per-CPU
  >> structure (e.g., cpu_info).  > Perhaps there should/could be a
  >> version of HIDE_RELOC() that doesn't > dereference the resulting
  >> address?
  >>
  >> Yep, valid point.  Patch below: please play.

  Andi> Please don't do that. I cannot easily take the address of a
  Andi> per CPU variable on x86-64, or rather only with additional
  Andi> overhead. If you need the address of one please use a
  Andi> different macro for that.

Actually, I'm somewhat sympathetic to Andi's point.  One issue I'm
concerned about is what the meaning is of:

	&this_cpu(foo)

Suppose CPU1 calculates this pointer and then passes it off to CPU2.
Now what version of "foo" will this pointer access on CPU2?  Depending
on implemenation, it might be either CPU1's local variable or CPU2's
local variable (the default per-CPU variable would do the former, an
implementation based on TLB remapping would do the latter).

How about the following proposal:

	- taking the address of this_cpu(var) is never allowed (can be
          enforced with RELOC_HIDE())

	- taking the address of per_cpu(var, n) is always legal and
	  will return a pointer which will access CPU n's version of
	  the variable, no matter what CPU dereferences the pointer

Andi, I think this would take care of the x86-64 problem as well, right?

	--david
