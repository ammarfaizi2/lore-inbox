Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267235AbTAPTnF>; Thu, 16 Jan 2003 14:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267233AbTAPTnF>; Thu, 16 Jan 2003 14:43:05 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:57225 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267235AbTAPTnD>;
	Thu, 16 Jan 2003 14:43:03 -0500
Message-ID: <004001c2bd98$3854dec0$645e2909@atheurer>
From: "Andrew Theurer" <habanero@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Linus Torvalds" <torvalds@transmeta.com>,
       "Ingo Molnar" <mingo@elte.hu>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <2050000.1042741643@flay>
Subject: Re: [PATCH] (0/3) NUMA aware scheduler
Date: Thu, 16 Jan 2003 13:48:19 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Following is a sequence of patches to add NUMA awareness to the scheduler.
> These have been submitted to you several times before, but in my opinion
> were structured in such a way to make them too invasive to non-NUMA
machines.
> I propsed a new scheme of working in "concentric circles" which this set
> follows (Erich did most of the hard work of restructuring), and is now
> completely non-invasive to non-NUMA systems. It has no effect whatsoever
> on standard machines. This can be seen by code inspection, and has been
> checked by benchmarking.

FYI, I have used a topology to map HT aware processors (in this case P4) to
a NUMA topology while using this scheduler.  This was done to help address
the same problems that Ingo's shared runqueue implementation fixed.  The
topology is quite simple. Sibling logical procs are members of a node.
Number of nodes = number of physical procs.

This primarily avoids sharing cpu cores (and avoiding resource contention)
on low loads.  In my case, 4 tasks on 8 logical proc system, we want to load
balance the tasks across nodes/cores for better performance.  For my test, I
did a make -j4 on a 2.4.18 kernel.  Results are:

stock sched, no numa:    56.523 elapsed  202.899 user,  18.266 sys,  390.6%
numa sched, ht topo:      53.088 elapsed  189.424 user,  18.36 sys,    391%

~6.5% better.  These results are the average of 10 kernel compiles.
* I did make one minor change to sched_best_cpu(). The first test case was
elimintaed, and that change is currently under discussion.

I did this mainly to demonstrate that a numa scheduler's policies may be
able to help HT systems and to capture a wider interest in numa scheduler.
By no means is P4 HT required to use this.  This is simply a numa topology
implemantation.  I would like some feedback on any interest in this.

One of the reasons we probably have not had much interest in numa patches is
that numa systems are not that prevailent.  However, numa-like qualites are
showing up in commonly available systems, and I believe we can take
advantage of policies that these patches, such as numa scheduler provide.
Does anyone have any other ideas where numa like qualities lie?  x86-64?

-Andrew Theurer

P.S. I am working on a topology patch to send out.  It's quite hackish right
now.


