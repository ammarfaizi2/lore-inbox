Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266304AbUFZQeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUFZQeD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 12:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUFZQeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 12:34:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:53893 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266304AbUFZQdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 12:33:46 -0400
Date: Sat, 26 Jun 2004 09:32:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       PARISC list <parisc-linux@lists.parisc-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix the cpumask rewrite
In-Reply-To: <1088266111.1943.15.camel@mulgrave>
Message-ID: <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
References: <1088266111.1943.15.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Jun 2004, James Bottomley wrote:
>  
> This might be correct for x86 and itanium, but it isn't for parisc where
> our bitmap operators don't take volatile pointers.

Why not? The thing is, the bitmap operators are supposed to work on 
volatile data, ie people are literally using them for things like

	while (test_bit(TASKLET_STATE_SCHED, &t->state));

and the thing is supposed to work.

Now, I personally am not a big believer in the "volatile" keyword itself, 
since I believe that anybody who expects the compiler to generate 
different code for volatiles and non-volatiles is pretty much waiting for 
a bug to happen, but there are two cases where I think it's ok:

 - in function prototypes to show that the function can take volatile data 
   (and not complain).

 - as an arch-specific low-level implementation detail to avoid having to 
   use inline assembly just to load a value. Ie a _data_structure_ should 
   never be volatile, but it's ok to use a volatile pointer for a single 
   access.

I believe the bitop functions fall under #1 - the function is clearly
supposed to handle the case of a volatile pointer, and if it is inlined,
the above endless while-loop must not just load the bit once and turn it 
into an endless loop - it needs to re-load the thing every iteration.

> Since whether the bitmap operators are volatile or not is within the
> province of the architecture to decide,

I disagree. Why wouldn't they be volatile?

		Linus
