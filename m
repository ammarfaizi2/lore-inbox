Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVG1S6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVG1S6z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 14:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVG1S6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 14:58:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19692 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261497AbVG1S5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 14:57:06 -0400
Date: Thu, 28 Jul 2005 11:56:39 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
       Mitchell Blank Jr <mitch@sfgoth.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] speed up on find_first_bit for i386 (let compiler do
 the work)
In-Reply-To: <1122575140.29823.258.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0507281146290.3307@g5.osdl.org>
References: <1122473595.29823.60.camel@localhost.localdomain> 
 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net> 
 <1122513928.29823.150.camel@localhost.localdomain> 
 <1122519999.29823.165.camel@localhost.localdomain> 
 <1122521538.29823.177.camel@localhost.localdomain> 
 <1122522328.29823.186.camel@localhost.localdomain>  <42E8564B.9070407@yahoo.com.au>
  <1122551014.29823.205.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0507280823210.3227@g5.osdl.org>  <1122565640.29823.242.camel@localhost.localdomain>
  <Pine.LNX.4.61L.0507281725010.31805@blysk.ds.pg.gda.pl>
 <1122575140.29823.258.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Jul 2005, Steven Rostedt wrote:
> 
> OK, I guess when I get some time, I'll start testing all the i386 bitop
> functions, comparing the asm with the gcc versions.  Now could someone
> explain to me what's wrong with testing hot cache code. Can one
> instruction retrieve from memory better than others?

There's a few issues:

 - trivially: code/data size. Being smaller automatically means faster if
   you're cold-cache. If you do cycle tweaking of something that is 
   possibly commonly in the L2 cache or further away, you migt as well
   consider one byte of code-space to be equivalent to one cycle (a L1 I$ 
   miss can easily take 50+ cycles - the L1 fill cost may be just a small 
   part of that, but the pipeline problem it causes can be deadly).

 - branch prediction: cold-cache is _different_ from hot-cache. hit-cache 
   predicts the stuff dynamically, cold-cache has different rules (and it 
   is _usually_ "forward predicts not-taken, backwards predicts taken", 
   although you can add static hints if you want to on most architectures).

   So hot-cache may look very different indeed - the "normal" case might 
   be that you mispredict all the time because the static prediction is 
   wrong, but then a hot-cache benchmark will predict perfectly.

 - access patterns. This only matters if you look at algorithmic changes. 
   Hashes have atrocious locality, but on the other hand, if you know that 
   the access pattern is cold, a hash will often have a minimum number of 
   accesses. 

but no, you don't have "some instructions are better at reading from 
memory" for regular integer code (FP often has other issues, like reading 
directly from L2 without polluting L1, and then there are obviously 
prefetch hints).

Now, in the case of your "rep scas" conversion, the reason I applied it
was that it was obviously a clear win (rep scas is known bad, and has
register allocation issues too), so I'm _not_ claiming that the above
issues were true in that case. I just wanted to say that in general it's 
nice (but often quite hard) if you can give cold-cache numbers too (for 
example, using the cycle counter and being clever can actually give that).

		Linus
