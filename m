Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311570AbSCNJhu>; Thu, 14 Mar 2002 04:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311571AbSCNJhj>; Thu, 14 Mar 2002 04:37:39 -0500
Received: from are.twiddle.net ([64.81.246.98]:19845 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S311570AbSCNJh3>;
	Thu, 14 Mar 2002 04:37:29 -0500
Date: Thu, 14 Mar 2002 01:37:21 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas
Message-ID: <20020314013721.A23274@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>, davidm@hpl.hp.com,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <15504.7958.677592.908691@napali.hpl.hp.com> <E16lMzi-0002bb-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16lMzi-0002bb-00@wagner.rustcorp.com.au>; from rusty@rustcorp.com.au on Thu, Mar 14, 2002 at 03:37:38PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 03:37:38PM +1100, Rusty Russell wrote:
> > I am also a bit concerned however about aliasing that the compiler
> > might not detect.  For example, with this code:
> > 
> > 	this_cpu(foo) = 13;
> > 	per_cpu(foo, 0) = 15;
> > 	printf("foo=%d\n", this_cpu(foo);
> > 
> > might print the wrong value if gcc thinks that the first and second
> > assignment never alias each other.  Does HIDE_RELOC() take care of
> > this also?
> 
> I'd be pretty sure the compiler can't assume that.  Richard would
> know...

I can't think of a way your current code is invalid.  It's all
hidden behind an asm.  The compiler could guess the two addresses
are the same iff smp_processor_id() is the constant 0, aka UP.

> > On a side-note, would you mind moving __per_cpu_data from smp.h into
> > compiler.h?  I'd like to use it in processor.h and from that file, I
> > can't include smp.h due to a recursive dependency.

This definitely needs to be per-architecture.  On Alpha, I think I
can use the Thread Local Storage model to be added to binutils 2.13
(and potentially compiler support to gcc 3.[23]).  IA-64 may be able
to do the same.  It's certain that x86 can't, since the userland
model requires %gs:0 point to the thread base, and the kernel folk
would never cotton to the segment swapping that would be needed.



r~
