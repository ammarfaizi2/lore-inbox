Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267659AbUG3JT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267659AbUG3JT1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 05:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267666AbUG3JT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 05:19:27 -0400
Received: from mail1.slu.se ([130.238.96.11]:50307 "EHLO mail1.slu.se")
	by vger.kernel.org with ESMTP id S267659AbUG3JTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 05:19:16 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16650.4736.456106.603065@robur.slu.se>
Date: Fri, 30 Jul 2004 11:18:56 +0200
To: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       Francois Romieu <romieu@fr.zoreil.com>,
       H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <netdev@oss.sgi.com>, <brad@brad-x.com>, <shemminger@osdl.org>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
In-Reply-To: <Pine.LNX.4.44.0407290315240.5763-100000@silmu.st.jyu.fi>
References: <16647.61953.158512.433946@robur.slu.se>
	<Pine.LNX.4.44.0407290315240.5763-100000@silmu.st.jyu.fi>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pasi Sjoholm writes:

You should monitor the the user app (gettimeofday()monitoring for starvation
this is the most important measure and what we are trying to improve.

We can hardly expect softirq's alone to give us the balance of load we wish. 
At overload something has to get less resources. Even we defer all softirq's 
to scheduler context there is no way making any distinguish between them 
unless we run them in separate processes i.e one RX_SOFIRQ, TX_SOFIRQ etc. 
This could solve some problem I just discussed with Jamal where the RX 
softirq overruns the TX softirq and causes drop at egress (qdisc) when bus 
BW is saturated. Running softirq's under schedules context's can cause other 
delays and other problems.

About tour test;
I dunno if the absolute values are comparable but we see a some change 
in behavior. I use your two last lines from your test assuming these
are the highest loaded 

                                    BH       KSOFT    IRQ-exit
--------------------------------------------------------------
00082ac4 00000000 0001180a 00000000 0000497c 00006f17 000f30fa
00082ac4 00000000 0001225a 00000000 00004a94 00007809 000f3140
280+2290+70 = 2640                        10       87        3 %


(Deffering to ksoftirqd after 2 sec patch)
0004c2fc 00000000 0000b626 00000000 0000182c 000011aa 000a14d2
0004c302 00000000 0000c03a 00000000 00001872 00001aec 000a155e
70+2370+140=2580                           3       92        5 %

So most ksoftirq's runs most softirq's which is good. Without this you would 
not be able to type any commands at all. Also we see some effects from the 
path. Can you monitor userland starvation here too?

> - When the ksoftirqd starts to eat cpu-time time_squeeze-value (3rd 
> column) starts growing (in both cases it's same thing). 

This OK as we have to throttle.

> - We are also getting more hits from SIRQ_FROM_KSOFTIRQD 
> immediately after that. (6th column)

Good. 

> - Total-column's value stops growing although network file transfers 
> are still on. (1st column)

Well ksoftirqd now runs RX softirq and competes heavily with other processes 
for your CPU you may have to adjust priorities to get your desired balance.
Can you experiment a bit?
 
> > And maybe we should take the experiment disussions off the list.

> I think that we should leave netdev as Francois requested it in first 
> place but we can drop the lkml if you want to.

Well it's not only a network issue.

Cheers.
						--ro




