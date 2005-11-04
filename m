Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVKDRXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVKDRXQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 12:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVKDRXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 12:23:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50401 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750743AbVKDRXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 12:23:14 -0500
Date: Fri, 4 Nov 2005 09:22:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andy Nelson <andy@thermo.lanl.gov>, akpm@osdl.org, arjan@infradead.org,
       arjanv@infradead.org, haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie,
       nickpiggin@yahoo.com.au, pj@sgi.com
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <20051104164020.GA9028@elte.hu>
Message-ID: <Pine.LNX.4.64.0511040900160.27915@g5.osdl.org>
References: <20051104153903.E5D561845FF@thermo.lanl.gov>
 <Pine.LNX.4.64.0511040801450.27915@g5.osdl.org> <20051104164020.GA9028@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andy,
 let's just take Ingo's numbers, measured on modern hardware.

On Fri, 4 Nov 2005, Ingo Molnar wrote:
> 
>   32768 randomly accessed pages, 13 cycles avg, 73.751831% TLB misses.
>   32768 linearly accessed pages,  0 cycles avg,  0.259399% TLB misses.
>  131072 randomly accessed pages, 75 cycles avg, 94.162750% TLB misses.

NOTE! It's hard to decide what OoO does - Ingo's load doesn't allow for a 
whole lot of overlapping stuff, so Ingo's numbers are fairly close to 
worst case, but on the other hand, that serialization can probably be 
honestly said to hide a couple of cycles, so let's say that _real_ worst 
case is five more cycles than the ones quoted. It doesn't change the math, 
and quite frankly, that way we're really anal about it.

In real life, under real load (especially with Fp operations going on at 
the same time), OoO might make the cost a few cycles _less_, not more, but 
hey, lt's not count that.

So in the absolute worst case, with 95% TLB miss ratio, the TLB cost was 
an average 75 cycles. Let's be _really_ nice to MIPS, and say that this is 
only five times faster than the MIPS case you tested (in reality, it's 
probably over ten).

That's the WORST CASE. Realize that MIPS doesn't get better: it will 
_always_ have a latency of several hundred cycles when the TLB misses. It 
has absolutely zero OoO activity to hide a TLB miss (a software miss 
totally serializes the pipeline), and it has zero "code caching", so even 
with a perfect I$ (which it certainly didn't have), the cost of actually 
running the TLB miss handler doesn't go down.

In contrast, the x86 hw miss gets better when there is some more locality 
and the page tables are cached. Much better. Ingo's worst-case example is 
not realistic (no locality at all in half a gigabyte or totally random 
examples), yet even for that worst case, modern CPU's beat the MIPS by 
that big factor. 

So let's say that the 75% miss ratio was more likely (that's still a high 
TLB miss ratio). So in the _likely_ case, a P4 did the miss in an average 
of 13 cycles. The MIPS miss cost won't have come down at all - in fact, it 
possibly went _up_, since the miss handler now might be getting more I$ 
misses since it's not called all the time (I don't know if the MIPS miss 
handler used non-caching loads or not - the positive D$ effects on the 
page tables from slightly denser TLB behaviour might help some to offset 
this factor).

That's a likely factor of fifty speedup. But let's be pessimistic again, 
and say that the P4 number beat the MIPS TLB miss by "only" a factor of 
twenty. That means that your worst case totally untuned argument (30 times 
slowdown from TLB misses) on a P4 is only a 120% slowdown. Not a factor of 
three.

But clearly you could tune your code too, and did. To the point that you 
had a factor of 3.4 on MIPS. Now, let's say that the tuning didn't work as 
well on P4 (remember, we're still being pessimistic), and you'd only get 
half of that.

End result? If the slowdown was entirely due to TLB miss costs, your 
likely slowdown is in the 20-40% range. Pessimistically.

Now, switching to x86 may have _other_ issues. Maybe other things might 
get slower. [ Mmwwhahahahhahaaa. I crack myself up. x86 slower than MIPS? 
I'm such a joker. ]

Anyway. The point stands. This is something where hardware really rules, 
and software can't do a lot of sane stuff. 20-40% may sound like a big 
number, and it is, but this is all stuff where Moore's Law says that 
we shouldn't spend software effort.

We'll likely be better off with a smaller, simpler kernel in the future. I 
hope. And the numbers above back me up. Software complexity for something 
like this just kills.

		Linus
