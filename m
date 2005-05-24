Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVEXR0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVEXR0S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 13:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVEXR0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 13:26:17 -0400
Received: from soufre.accelance.net ([213.162.48.15]:57086 "EHLO
	soufre.accelance.net") by vger.kernel.org with ESMTP
	id S261654AbVEXRWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 13:22:15 -0400
Message-ID: <429362BC.7060909@xenomai.org>
Date: Tue, 24 May 2005 19:22:04 +0200
From: Philippe Gerum <rpm@xenomai.org>
Organization: Xenomai
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Karim Yaghmour <karim@opersys.com>, Christoph Hellwig <hch@infradead.org>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, akpm@osdl.org, sdietrich@mvista.com
Subject: Re: RT patch acceptance
References: <Pine.OSF.4.05.10505241532040.29908-100000@da410.phys.au.dk>
In-Reply-To: <Pine.OSF.4.05.10505241532040.29908-100000@da410.phys.au.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Esben Nielsen wrote:
> On Tue, 24 May 2005, Karim Yaghmour wrote:
> 
> 
>>Esben Nielsen wrote:
>>
>>>I find that a bad approach:
>>>1) You don't have RT in userspace.
>>>2) You can't use Linux drivers for standeard hardware when you want it to
>>>be part of your deterministic RT application.
>>
>>Please have a look at RTAI/fusion. For the record, RTAI has been providing
>>hard-rt in standard Linux user-space for over 5 years now. With RTAI/Fusion
>>this gets even better as there isn't even a special API ...
>>
> 
> The tests I have read (I can't remember the links, but it was on lwn.net)
> states that the worst case latency is even worse than for a standeard 2.6
> kernel! 

You are likely talking about a benchmark conducted by Peter Laurich and 
published by Linuxdevices, I guess. In fact, the benchmark code was 
wrong, and has been amended by the author himself in a follow-up to the 
initial article:

http://www.linuxdevices.com/articles/AT3479098230.html

The figures obtained with RTAI's LXRT extension are now correct, and not 
surprisingly, LXRT is the best performer among the solutions aimed at 
providing RT support in user-space in this study, with 48 us worst-case 
scheduling latency under high load on a SBC based on a Celeron running 
at 650 MHz, and populated with 512 MB SDRAM. PREEMPT_RT was not tested 
by the benchmark, though.

> 
> If you gonna make usefull deterministic real-time in userspace you got to
> change stuff in kernel space and implement stuff like priority
> inheritance, priority ceiling or similar.  It can only turn up to be an
> ugly hack which will end up being as intruesive into the kernel as Ingo's
> approach. If you don't do anything like that you can not use _any_ Linux
> kernel resources from your RT processes even though you have reimplemented
> the pthread library to know about the "super RT" priorities.
> 

Indeed, this is why the RTAI project has an experimental branch called 
"fusion", distinct from the classic LXRT one, which aims at a better 
integration of the real-time services it provides into the common kernel 
framework. The idea is to allow RTAI applications to be alternatively 
controlled by the Linux kernel and the real-time nucleus, while keeping 
the RT priority scheme intact across seamless and automatic transitions 
between both.

If you think that PREEMPT_RT will be able to give you real-time 
guarantees that are as stringent as those already exhibited by 
additional nucleus/co-schedulers on any kind of hardware including the 
embedded ones, then you will likely conclude that we are currently 
chasing wild gooses (and that we owe you one of them for Xmas). If not, 
well, maybe considering a symbiotic approach between a fully preemptable 
Linux kernel providing regular services and a specialized co-scheduler 
providing extreme predictability should make some sense, given that both 
co-operate to control a single set of real-time tasks in user-space.

> But I give you: You will gain better interrupt latencies because
> interrupts are executed below the Linux proper. I.e. when the Linux
> kernel runs with interrupt disabled, they are really enabled in the RTAI
> subsystem.
>

IIRC, interrupt latency has never been the toughest problem with the 
vanilla Linux kernel with respect to predictability, but the scheduling 
latency still is. Hence Ingo's work, not to speak of previous efforts 
regarding preemptability, I guess.

> My estimate is that RTAI is good when you have a very small subsystem you
> need to run RT with very low latencies. Forinstance, controlling a fast
> device with limiting hardware resources to buffer events. 
> For large control systems I don't think it is the proper way to do it.
> There it is much better to run the control tasks as normal Linux
> user-space processes with RT-priority. I can see Ingo's kernel doing that,
> I can't see RTAI doing it except for very special situations where you
> don't make _any_ Linux system calls at all! You can't even use a
> normal Linux network device or character device from your RT application!
> 
> 

It happens that many if not most among the complex real-time 
applications have varying requirements with respect to determinism, 
depending on the task or execution context you consider from them. This 
is why the split application model, involving some kernel modules which 
implement the demanding RT stuff and some user-space programs connected 
to them, has been used for years.

What the RTAI project is trying to do now with its fusion branch, is to 
make compatible a larger spectrum of RT requirements without killing the 
design of your RT application as above. E.g. some tasks need to run on a 
10Khz period, whilst others can deal with ~100 us jitter under high load 
, just for the purpose of being able to call regular Linux services; but 
you want all of them running embodied in a single regular user-space 
process, and being able to use GDB for chasing the gremlins in there.

For us, this implies to make the most preemptable Linux kernel we can 
find and the fusion nucleus share the same semantics and co-operate, 
instead of blindly running side-by-side, so that RTAI eventually appears 
as a native support provided by the Linux kernel to the real-time 
application designers. Sometimes, this requires RTAI to impersonate some 
vanilla system calls such as nanosleep(), so that you really have 
micro-second level wakeups, with a little help of RTAI's integrated 
oneshot timer. This also requires a bunch of headaches, coffee, and 
machines going south, but that's nothing worth documenting in a README, 
I guess.

-- 

Philippe.
