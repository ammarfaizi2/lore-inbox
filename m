Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268130AbUI2Aw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268130AbUI2Aw0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 20:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268131AbUI2AvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 20:51:23 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:6917 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S268127AbUI2Ath (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 20:49:37 -0400
Date: Wed, 29 Sep 2004 02:49:32 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas Habets <thomas@habets.pp.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
Message-ID: <20040929004932.GA2701@pclin040.win.tue.nl>
References: <200409230123.30858.thomas@habets.pp.se> <20040923234520.GA7303@pclin040.win.tue.nl> <1096031971.9791.26.camel@localhost.localdomain> <200409242158.40054.thomas@habets.pp.se> <1096060549.10797.10.camel@localhost.localdomain> <20040927104120.GA30364@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040927104120.GA30364@logos.cnet>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 07:41:20AM -0300, Marcelo Tosatti wrote:

> BTW,I think a lot of applications do not gracefully handle -ENOMEM?
> 
> I suppose most of them just fail and bailout with -ENOMEM.
> 
> No?

Ha Marcelo - Maybe you didnt want to suggest it, but the
argument "It doesnt matter if the default kernel is crap,
because most of userspace is crap as well" doesnt fly.
Some of userspace is well-written and does meaningful things
upon ENOMEM.

Most common: print error message and exit.
Sometimes: clean up, remove lock files, exit.
Sometimes: adapt the algorithm chosen to the amount of memory
 that is available, and do the computation. Possibly use
 more frequent garbage collections.

Concerning OOM - I tried Solaris, and it behaved well
on my testcases.

---

I think our first goal here must be to have a Linux kernel
that is reliable in the sense that an application will never
get a segfault or be OOM-killed upon access of memory that
malloc() returned.

That is a weaker goal than our current mode 2, but of course
much stronger than modes 1 and 0.

---

I run 2.6.8.1 with /proc/sys/vm/overcommit_memory 2
and /proc/sys/vm/overcommit_ratio 50, and that works
satisfactorily for me (with 256MB physical memory
and 512MB swap). However, without swap the 50 is too low
- I can do work with /proc/sys/vm/overcommit_ratio 80.

I wonder: are there people for whom overcommit_memory
mode 2 is bad even when there is plenty of swap?

If not then we might experiment setting mode 2
by default when lots of swap is available.
If that works we can guarantee that the kernel
is oom-safe at least with a minimum amount of swap.

---

When there is no, or only little, swap, then for me
mode 2 is too strict. I conjecture that a mode
between 0 and 2 is possible, let us call it 2a,
with the property that it works just as well as mode 0,
and is malloc-safe just like mode 2. The idea would
be that memory the user asked for with malloc() is more
likely needed than the memory that has to be reserved
in case COW shared memory is written to and must be duplicated.
This kind of memory could perhaps get a lower weight.

[Have people already tried this?]

Andries


PS - I hope for malloc safety: when malloc returns memory
it is really there. I see other people discuss automatic
extension of swap areas. That can never produce malloc
safety. The program that is eating memory just grows
a bit more and is oom-killed after all.
No, malloc() must return NULL.

