Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313384AbSC2IDS>; Fri, 29 Mar 2002 03:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313386AbSC2IDJ>; Fri, 29 Mar 2002 03:03:09 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:12792 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S313384AbSC2ICy>; Fri, 29 Mar 2002 03:02:54 -0500
Message-ID: <3CA41FA0.8090800@drugphish.ch>
Date: Fri, 29 Mar 2002 09:02:40 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020306
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Irwan Hadi <irwanhadi@phxby.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Having too many access lists in Linux
In-Reply-To: <20020328191705.C17277@phxby.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry for the length of this email but we just did tests on that topic 
and I'd like to share some results with you (and whoever might read this).

> I just curious (since I haven't tried this), what happened to linux (the
> kernel especially), when a Linux Box has for example 100 access lists,
> 500 access lists, 1000 access lists, etc ?

I assume you mean rules (with regard to your text below)? With ACL in a 
Linux environment I mean filesystem ACLs or TE in B+ security systems.

> Will I see a process consuming 100% of CPU Resources, or people will
> feeling much slower when they are accessing my server, or the box starts
> dropping some packets ?

This is indeed a very interesting topic and depends on a huge amount of 
parameters as thinking and tests in our lab have shown. I wrote a paper 
about it. This paper however had been stripped down since it contained 
company specific information but the interesting graphs are still in 
there. You can find it at [1]. It's called "Packetfilters and their 
Behavior under high Network Load:The impact of extreme (real) conditions 
analyzed on Linux, Solaris and OpenBSD". It had been done under strict 
time constraints since we're not a testing lab but a security company. I 
can summarize what we've done for people that don't want to read it:

Problem:
--------
Coming from ipfwadm, used to having 3 chains only, our company had 
written a firewall suite (mostly userspace) on top of that. Eventually 
the transition to ipchains came and we startet migrating the codebase to 
the new framework. This old legacy (addressing 3 chains only) was not 
redesigned because at that time there was no need to and boxes weren't 
as fast anyway to have a box filter 100Mbit/s. Plus not a lot of 
e-commerce projects really had more then 10Mbit/s of traffic.

Now in the meantime we started building packetfilters with 16-24 NIC's 
on a box depending on the overall filtering needs. This worked fine 
until we reached the limits of ipchains (when used in the legacy 
framework). The worst case chain traversing had always been suspect to 
be inefficient when no active rule reordering had been taken place. I 
once started implementing active rule reordering by having a kernel 
thread parsing the chain tables and account the bytes and packets. But 
since this would lead to a change of semantics of the firewall itself I 
dropped that idea.

Action:
-------
So we started some primitive tests which actually turned out to reflect 
the 'real world' you're facing when doing 'high speed' packetfiltering. 
First thing it showed us was that you can filter extremely efficient and 
with a lot more rules loaded into the kernel when your L2 cache is big. 
The bigger the better. Don't take a Celeron to do serious packet 
filtering. We've done tests on Tualatins and I've talked to some guy 
that did tests on Xeon's. With a 500MHz Celeron raw TCP throughput 
(payload ~ MTU) dropped down to 8Mbit/s when having more than 500 rule 
entries in the input chain (which is not a lot) and having the matching 
rule at the end of the chain. With a Tualatin we were able to sustain a 
  92Mbit/s throughput until we hit the 2000 rule limit. Starting from 
there performance goes down linearly first and then quadratic. It seems 
to have to do with L1-L2 cache transitions or ineffective cache 
reloading because not all rules can be hold in the hot cache anymore.

Well, we've been stuck with 5000 and more unordered rules in one chain. 
This can happen if you have legacy software and as everyone with 
software engineering skills knows it is not feasable to rewrite a big 
software suite when the overall needed men programming power can't be 
raised without risking important market losses during the development 
phase. [We've done it, we've ported the whole stuff from an architecture 
of the 3-chain approach to a multiple chain architecture and preliminary 
support for iptables. And we have no CPU/kernel related problems anymore 
  ever since. ;)]

Solutions:
----------
Another very interesting way of doing high speed packetfiltering is by 
policy routing achieved with iproute2. Add rules for every net entity 
you'd like to address and put blackhole routes to the reference routing 
tables to block specific net entities and use bounce table walking to 
realize the inter-chaining jumps you have with the '-j' target. This is 
extremely fast (think CISCO IOS) but a little complex to setup and I 
haven't yet found a meta definition language to map a network onto a 
routing policy in a way that you only allow traffic you'd like to 
(policy: DENY/DROP).

Active rule reordering: It should be possible to reorder rules according 
to their usage so the most used rules have an early match. This is not 
such an issue anymore with stateful packetfiltering where we have 
matches with the '-state' directive.

Buy decent hardware and use 2.4.x kernels for network related task!

Use QoS to rate limit stuff or give administrational 'tasks' (ssh) high 
priority. Mark packets with iproute2 and set up a CBQ scheduler.

Do packet filtering in user space so the kernel doesn't use up all 
available CPU time for the filtering process. A user space filter 
wouldn't simply get that much processing time.

> (what I meant access lists is the TCP filtering managed thru ipchains,
> iptables, etc.)

Conclusion:
-----------
As a fast conclusion but also reflecting the truth in 99% of the time I 
need to tell you that in all our tests we've seen that TCP filtering 
under 2.4.x and iptables is _much_ more efficient than with 2.2.x and 
ipchains when it comes to a lot of rules and a lot of NICs. This can be 
due to the softnet framework and/or the improved dequeuing mechanism 
(which will yet be improved in 2.5.x by Hadi/Kuznetsov), the more 
efficient target/chain handling, reduced CPU overhead for NICs with 
integrated TX/RX zerocopy functionality and definitely because with a 
stateful packetfilter you tend not to have as many rules for the same 
kind of "security" as you would have with ipchains.

And to come back to your question: Depending on the amount of rules in a 
chain and the L2 cache size of your CPU and on the NIC you're having you 
might encounter everything, from random early packet drops in the rx 
queue to late drops in the packet filter engine due to inefficiency of 
matching packets. This is _very_ annoying if you need to do machine 
maintainance via ssh and a login takes you 40 Minutes (been there done 
that). And the bigger annoyance is that you can't log the packets 
anymore and as everybody in the security business knows, not having 
logfiles is about the worst thing that can happen to you besides getting 
hacked :). Customers tend to care and know the difference.

[1] http://www.terreactive.ch/home/archive/pdf/pf-speed-test.pdf

HTH. Best regards,
Roberto Nibali, ratz

