Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbUDHXmN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 19:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbUDHXmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 19:42:13 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:55118 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261821AbUDHXmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 19:42:08 -0400
Message-ID: <4075E34A.4000909@yahoo.com.au>
Date: Fri, 09 Apr 2004 09:42:02 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Darren Hart <dvhltc@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, ak@suse.de,
       Martin J Bligh <mjbligh@us.ibm.com>,
       Rick Lindsley <ricklind@us.ibm.com>, akpm@osdl.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.5-rc3-mm4 x86_64 sched domains patch
References: <1081466480.10774.0.camel@farah>
In-Reply-To: <1081466480.10774.0.camel@farah>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Darren Hart wrote:

>The current default implementations of arch_init_sched_domains
>constructs either a flat or two level topolology.  The two level
>topology is built if CONFIG_NUMA is set.  It seems that CONFIG_NUMA is
>not the appropriate flag to use for constructing a two level topology
>since some architectures which define CONFIG_NUMA would be better served
>with a flat topology.  x86_64 for example will construct a two level
>topology with one CPU per node, causing performance problems because
>balancing within nodes is pointless and balancing across nodes doesn't
>occur as often.
>
>

This is correct, although I don't know why there would be
performance problems. The rebalance in the degenerate node-local
domain should be basically unmeasurable. It would be nice to
get rid of it at some time. I have code to prune off degenerate
domains, which I will submit soonish.

The NUMA rebalance should occur more often than the old numasched
did, but perhaps with some recent Altix-centric changes to the
generic setup, this is no longer the case.

The STREAM performance problem is due mainly to the more
conservative nature of balancing, which is otherwise a good thing.
I think we can fix this in the short term by having x86_64 balance
between nodes more often. In the long term, we can merge Ingo's
balance on clone stuff, and the interested people can play with
that.

>This patch introduces a new CONFIG_SCHED_NUMA flag and uses it to decide
>between a flat or two level topology of sched_domains.  The patch is
>minimally invasive as it primarily modifies Kconfig files and sets the
>appropriate default (off for x86_64, on for everything that used to
>export CONFIG_NUMA) and should only change the sched_domains topology
>constructed on x86_64 systems.  I have verified this on a 4 node x86
>NUMAQ, but need someone to test x86_64.
>
>

I guess I can't see a big problem with this, other than more
complexity. In the long run, we should obviously have the arch
code set up optimal domains depending on the machine and config.

>This patch is intended as a quick fix for the x86_64 problem, and
>doesn't solve the problem of how to build generic sched domain
>topologies.  We can certainly conceive of various topologies for x86
>systems, so even arch specific topologies may not be sufficient.  Would
>sub-arch (ie NUMAQ) be the right way to handle different topologies, or
>will we be able to autodiscover the appropriate topology?  I will be
>looking into this more, but thought some might benefit from an immediate
>x86_64 fix.  I am very interested in hearing your ideas on this.
>
>

SGI want to do sub arch domains so they can do specific things
with their systems. I don't really care what the arch code does
with them, but it would be wise to only specialise it when there
is a genuine need. I'm glad you'll be looking into it, thanks.

Nick

