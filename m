Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVEXOcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVEXOcm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 10:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVEXOcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 10:32:42 -0400
Received: from opersys.com ([64.40.108.71]:53513 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261474AbVEXOce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 10:32:34 -0400
Message-ID: <42933D71.8060706@opersys.com>
Date: Tue, 24 May 2005 10:42:57 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Esben Nielsen <simlo@phys.au.dk>
CC: Christoph Hellwig <hch@infradead.org>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org,
       sdietrich@mvista.com, Philippe Gerum <rpm@xenomai.org>
Subject: Re: RT patch acceptance
References: <Pine.OSF.4.05.10505241532040.29908-100000@da410.phys.au.dk>
In-Reply-To: <Pine.OSF.4.05.10505241532040.29908-100000@da410.phys.au.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have no intent of prosecuting either methods. I was simply pointing out
a fact. FWIW, both approachs can be used together, they are not (as I may
have mistakenly stated in previous debates) in contradiction.

Here are some random comments to be taken very lightly:

Esben Nielsen wrote:
> The tests I have read (I can't remember the links, but it was on lwn.net)
> states that the worst case latency is even worse than for a standeard 2.6
> kernel! 

Sorry, I'm an avid LWN reader and haven't come accross something like this.
There are A LOT of benchmarks thrown left and right, mostly by embedded
distros wishing to push their own agenda. If what you assert is to hold,
then please at least provide us with a URL.

> If you gonna make usefull deterministic real-time in userspace you got to
> change stuff in kernel space and implement stuff like priority
> inheritance, priority ceiling or similar.  It can only turn up to be an
> ugly hack which will end up being as intruesive into the kernel as Ingo's
> approach. If you don't do anything like that you can not use _any_ Linux
> kernel resources from your RT processes even though you have reimplemented
> the pthread library to know about the "super RT" priorities.

I've visited these issues before. It all boils down to a simple question:
is it worth making the kernel so much more complicated for such a minority
when 90% of the problems encountered in the field revolve around the
necessity of responding to an interrupt in a deterministic fashion?

And for those 90% of cases, a simple hyper-visor/nanokernel layer is
good enough. For the remaining 10% of cases, that's where something like
the rt-preempt or RTAI become necessary.

> But I give you: You will gain better interrupt latencies because
> interrupts are executed below the Linux proper. I.e. when the Linux
> kernel runs with interrupt disabled, they are really enabled in the RTAI
> subsystem.

For most cases, as I said, there's no need for either rtai or rt-preempt,
all you need is direct access to the interrupt source, something a
hypervisor/nanokernel can easily provide you with. At its simplest, you
need two things:
- turning the core of the interrupt disabling defines into function pointers
- turning the core IRQ handler (do_IRQ) into a function pointer
Using this, a driver needing hard-rt can just tap into the interrupt flow
and get deterministic behavior WITHOUT either rtai, rt-preempt, or even
adeos. Of course, you can look for a clean implementation of this scheme,
and adeos does this quite well. Philippe can correct me if I'm wrong,
but with just the above hooks, much of adeos can be made to be a loadable
module.

Sure, tapping into the interrupt flow isn't as featured as having true
hard-rt in user-space (either with rt-preempt or rtai), but it's a got
a very nice cost/benefit ratio.

> My estimate is that RTAI is good when you have a very small subsystem you
> need to run RT with very low latencies. Forinstance, controlling a fast
> device with limiting hardware resources to buffer events. 
> For large control systems I don't think it is the proper way to do it.
> There it is much better to run the control tasks as normal Linux
> user-space processes with RT-priority. I can see Ingo's kernel doing that,
> I can't see RTAI doing it except for very special situations where you
> don't make _any_ Linux system calls at all! You can't even use a
> normal Linux network device or character device from your RT application!

You are certainly entitled to your preferences, but if you're interested
in hearing about large-scale/industrial deployments of RTAI (and there
are plenty I assure you), I would suggest a visit to the rtai-users mailing
list.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
