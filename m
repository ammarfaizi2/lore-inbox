Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbUCaALI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 19:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbUCaALI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 19:11:08 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:872 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262205AbUCaAK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 19:10:57 -0500
Message-ID: <406A0DED.8090906@sgi.com>
Date: Tue, 30 Mar 2004 18:16:45 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Jesse Barnes <jbarnes@sgi.com>, John Hawkes <hawkes@sgi.com>
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
References: <20040329041253.5cd281a5.pj@sgi.com> <1080606618.6742.89.camel@arrakis> <20040330012744.GZ791@holomorphy.com> <20040329172725.255e4829.pj@sgi.com> <20040330063805.GI791@holomorphy.com> <20040330004540.0144215d.pj@sgi.com> <20040330101952.GN791@holomorphy.com>
In-Reply-To: <20040330101952.GN791@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wli,

I do apologize for not following this discussion until now.  Mu mailer was happily filing these 
messages away for me in a folder and I hadn't noticed the subject line.  Paul Jackson called me to 
discuss this and we've run a few test cases to understand the impact of call by value versus call by 
reference implementations.  We've discovered a couple interesting things:

(1)  As near as we can tell, there are only 3 routines that appear to have cpumask_t arguments in 
the Linux 2.6.4 kernel that are also called often enough that it might matter.  All of these 
routines live in sched.c:  load_balance(), find_busiest_queue(), and set_cpus_allowed().  The first 
two of these routines are called on the order of once every few 10s of milliseconds, at least on our 
machines, so they don't really represent a huge load on the system even if they do impose some extra 
instructions due to call by value instead of call by reference.  The last one is probably called 
even less often, so from the standpoint of these routines we can't make a case for requring call by 
reference.

(2)  The base routines that actually do the bit manipulation appear all to be call by reference in 
any case.  So that is a good thing.  It would be silly to copy an 8 word (or larger??) mask into 
registers just to set a single bit.

(3)  The current compilers appear to be somewhat better at managing these call by value structures 
than the ones I was experimenting with last summer.

As I recall our discussion on this of last summer, I think the notion was to get the call by 
reference stuff into 2.6 and then evaluate later what the break even point was (i. e. at how many 
words of cpumask does it become more efficient to use call by reference).  I think our thinking at 
the present time is that there is no cross over point, that the call by value stuff is good enough 
for all sizes of bitmasks.

Also, since then, Jesse Barnes has become the official maintainer for 2.6-sn.  So all such decisions 
need to be blessed by him.  That will, in part, reduce the inherent noise level of having several 
different SGI folks broadcasting requirements out into the community.

Paul's point to me was that while the transparency of the call by value versus call by reference 
approach was virtually transparent (perhaps translucent?) at the source code level, it did introduce 
some complexity that could be confusing.  Perhaps a better approach might be to explicitly code the 
3 routines mentioned above to take a pointer to bitmask argument, and then we would be done. 
(Certainly on a UP machine this makes little difference, and I would be surprised if we could 
measure the difference on a 32 way IA32 box.)

So, assuming all of the above is correct, I guess I am willing to remove the call by reference 
requirement that I was harping on so much last summer.

Jesse do you agree?

William Lee Irwin III wrote:

> 
> Maybe so. The requirements were actually three competing/conflicting
> requirements: one from Ray Bryant/SGI for call-by-reference semantics
> available to core API's, one from davem for call-by-value on arithmetic
> types in core API's. There was another imposed for zero indirection on
> small SMP systems you're probably going to have to work harder to get
> an ack on since I don't remember where it came from apart from "on high".
> But it sounds like at least one of the requirement competitors may be
> backing out here. If Ray or other vaguely independent SGI ppl (yes, this
> does need to look like it's more than unilateral) could speak up
> regarding the call-by-reference semantics requirement that would lift a
> third of it. The unwrapped structures was basically davem and tinyboxen,
> and I saw the bit where he lifted the sparc(64) side of that requirement.
> 
> As I see it we have:
> (a) pester more ppl at SGI to get cpumask_const_t requirements dropped
> (b) davem's already backed off cpumask_arith for sparc(32|64) ABI bits
> (c) some kind of high-level ack is needed for indirection on tinyboxen
> 	to kill off the second requirement for cpumask_arith
> (d) run this past arch maintainers for acks wrt. compiler versions vs.
> 	the costructs you're using in inlines
> 
> (a) should be very easy for you, (b) is fait accompli, (c) akpm could
> chime in on at any moment. One hopeful thing here for you is that it's
> a question of asking the right ppl; the code itself is largely a non-
> issue, apart from whether higher-level maintainers regard it as
> excessive code churn or too cleanup-heavy.
> 
> I'll send a private reply about how to get a hold of arch maintainers,
> which should take care of (d).
> 
> (davem please don't shoot me -- this stuff could break things otherwise
> similar to how i386 hit bad codegen in earlier revisions pre-merge)
> 
> 
> -- wli
> 

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

