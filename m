Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266479AbUGPFxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266479AbUGPFxN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 01:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUGPFxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 01:53:13 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:64645 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266479AbUGPFxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 01:53:07 -0400
Message-ID: <40F76D3F.8050309@yahoo.com.au>
Date: Fri, 16 Jul 2004 15:53:03 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       John Hawkes <hawkes@sgi.com>
Subject: Re: [PATCH] reduce inter-node balancing frequency
References: <200407151829.20069.jbarnes@engr.sgi.com> <200407152038.32755.jbarnes@engr.sgi.com> <40F733D2.2000309@yahoo.com.au> <200407152158.17605.jbarnes@engr.sgi.com> <2700000.1089956404@[10.10.2.4]>
In-Reply-To: <2700000.1089956404@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> --Jesse Barnes <jbarnes@engr.sgi.com> wrote (on Thursday, July 15, 2004 21:58:17 -0400):
> 
> 
>>On Thursday, July 15, 2004 9:48 pm, Nick Piggin wrote:
>>
>>>Yeah, these numbers actually used to be a lot higher, but someone
>>>at Intel (I forget who it was right now) found them to be too high
>>>on even a 32 way SMT system. They could probably be raised a *little*
>>>bit in the generic code.
>>
>>Ok, but I wouldn't want to hurt the performance of small machines at all.  If 
>>possible, I'd rather just add another level to the hierarchy if MAX_NUMNODES 
>>
>>>some value.
> 
> 
> Arch code. Arch code. Arch code ;-) Or at least base it of nr_cpus or 
> numnodes. Seriously ... a 2x or 4x opteron obviously needs different
> parameters from a 16x x440 or a 512x SGI box ... why we have a flexible
> infrastructure that can stand on its head and do backflips, and then
> we don't use it at all is a mystery to me ;-)
> 
> I'd even go so far as to suggest there should be NO default settings for
> NUMA, only in arch code - that'd make people actually think about it.
> If there are, they should be based off the topo infrastructure, not static
> values.
>  

I'm going to cut a patch to consolidate the arch setup code in a
bit. It would be easy to just not define SD_NODE_INIT at all in
generic code. I expect that won't go down too well at this stage
though ;)

> 
>>>>We may have enough information to do that already... I'll look.
>>>
>>>The plan is to allow arch overridable SD_CPU/NODE_INIT macros for
>>>those architectures that just look like a regular SMT+SMP+NUMA, and
>>>have the generic code set them up.
>>
>>Would simply creating a 'supernode' scheduling domain work with the existing 
>>scheduler?  My thought was that in the ia64 code we'd create them for every N 
>>regular nodes; its children would be the regular nodes with the existing 
>>defaults.
> 
> 
> Nick would know better than I, but I think so ... it seems to cope with
> arbitrary levels, groupings, ... gravitational dimensions, etc ;-)
> 

Well I think the main thing is that you do not want a global domain
with 512 CPUs in it, even if it is very rarely balanced.

Apart from having to pull hot cachelines off 511 CPUs while in interrupt
context, it just doesn't make sense: It could easily move a task to a
node that is  x (=large) hops away.

It is probably way too much complexity to try to model your topology in
any amount of detail at this stage, but it could be made smarter.

Instead of a top level domain spanning all CPUs, have each CPU's top level
domain just span all CPUs within a couple of hops (enough to get, say 16 to
64 CPUs into each top level domain). I could give you a hand with this if
you need.

