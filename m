Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbUDKI53 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 04:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbUDKI53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 04:57:29 -0400
Received: from omr2.netsolmail.com ([216.168.230.163]:54517 "EHLO
	omr2.netsolmail.com") by vger.kernel.org with ESMTP id S262304AbUDKI5Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 04:57:25 -0400
From: <shai@ftcon.com>
Message-Id: <200404110857.BIS60109@ms6.netsolmail.com>
Reply-To: <shai@ftcon.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Darren Hart'" <dvhltc@us.ibm.com>
Cc: "'lkml'" <linux-kernel@vger.kernel.org>, <ak@suse.de>,
       "'Martin J Bligh'" <mjbligh@us.ibm.com>,
       "'Rick Lindsley'" <ricklind@us.ibm.com>, <akpm@osdl.org>,
       "'Ingo Molnar'" <mingo@elte.hu>
Subject: RE: 2.6.5-rc3-mm4 x86_64 sched domains patch
Date: Sun, 11 Apr 2004 01:57:10 -0700
Organization: FT Consulting
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <4075E34A.4000909@yahoo.com.au>
Thread-Index: AcQdw5gMrfB1aFkXSBScFDGbELoGdwB3xyuQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can SLIT/SRAT be used here to define topology for the generic case?

SRAT is being used by i386 to build zonelists, but not for the scheduler -
any good reason why?

 

--Shai


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Nick Piggin
Sent: Thursday, April 08, 2004 16:42
To: Darren Hart
Cc: lkml; ak@suse.de; Martin J Bligh; Rick Lindsley; akpm@osdl.org; Ingo
Molnar
Subject: Re: 2.6.5-rc3-mm4 x86_64 sched domains patch



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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

