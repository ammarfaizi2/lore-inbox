Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbUC3IVU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 03:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbUC3IUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 03:20:21 -0500
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:65458 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263204AbUC3ITs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 03:19:48 -0500
Message-ID: <40692D95.8030605@yahoo.com.au>
Date: Tue, 30 Mar 2004 18:19:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Andi Kleen <ak@suse.de>,
       jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
References: <20040329084531.GB29458@wotan.suse.de> <4068066C.507@yahoo.com.au> <20040329080150.4b8fd8ef.ak@suse.de> <20040329114635.GA30093@elte.hu> <20040329221434.4602e062.ak@suse.de> <4068B692.9020307@yahoo.com.au> <20040330083450.368eafc6.ak@suse.de> <40691BCE.2010302@yahoo.com.au> <205870000.1080630837@[10.10.2.4]> <4069223E.9060609@yahoo.com.au> <20040330080530.GA22195@elte.hu>
In-Reply-To: <20040330080530.GA22195@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>Maybe balance on clone would be beneficial if we only balance onto
>>CPUs which are idle or very very imbalanced. Basically, if you are
>>very sure that it is going to be balanced off anyway, it is probably
>>better to do it at clone.
> 
> 
> balancing threads/processes is not a problem, as long as it happens
> within the rules of normal balancing.
> 
> ie. 'new context created' (on exec, fork or clone) is just an event that
> impacts the load scenario, and which might trigger rebalancing.
> 
> _if_ the sharing between various contexts is very high and it's actually
> faster to run them all single-threaded, then the application writer can
> bind them to one CPU, via the affinity syscalls. But the scheduler
> cannot know this advance.
> 
> so the cleanest assumption, from the POV of the scheduler, is that
> there's no sharing between contexts. Things become really simple once
> this assumption is made.
> 
> and frankly, it's much easier to argue with application developers whose
> application scales badly and thus the scheduler over-distributes it,
> than with application developers who's application scales badly due to
> the scheduler.
> 

You're probably mostly right, but I really don't know if I'd
start with the assumption that threads don't share anything.
I think they're very likely to share memory and cache.

Also, these additional system wide balance points don't come
for free if you attach them to common operations (as opposed
to the slow periodic balancing).

find_best_cpu needs to pull down NR_CPUs remote (and probably
hot&dirty) cachelines, which can get expensive, for an
operation that you are very likely to be better off *without*
if your threads do share any memory.
