Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262147AbSIZIym>; Thu, 26 Sep 2002 04:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262250AbSIZIyl>; Thu, 26 Sep 2002 04:54:41 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:15052 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S262147AbSIZIyj>; Thu, 26 Sep 2002 04:54:39 -0400
Message-ID: <3D92CCC5.5000206@drugphish.ch>
Date: Thu, 26 Sep 2002 11:00:53 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, niv@us.ibm.com, linux-kernel@vger.kernel.org,
       jamal <hadi@cyberus.ca>
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
References: <3D924F9D.C2DCF56A@us.ibm.com.suse.lists.linux.kernel>	<20020925.170336.77023245.davem@redhat.com.suse.lists.linux.kernel>	<p73n0q5sib2.fsf@oldwotan.suse.de> <20020925.172931.115908839.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello DaveM and others,

>    It sounds more like it would include the FIB too.
> 
> That's the second level cache, not the top level lookup which
> is what hits %99 of the time.

I've done extensive testing in this field trying to achive fast packet 
filtering with a huge set of not ordered rules loaded into the kernel.

According to my findings I had reason to believe that after around 1000 
rules for ipchains and around 4800 rules for iptables the L2 cache was 
the limiting factor (of course given the slowish iptables/conntrack 
table lookup).

Those are rule thresholds I achieved with a PIII Tualatin and 512KB L2 
cache. With a sluggish Celeron with I think 128KB L2 cache I achieved 
about 1/8 of the above treshold. That's why I thought the L2 cache plays 
a bigger role in this than the CPU FSB clock.

I concluded that if the ruleset to be matched would exceed the treshold 
of what can be loaded into the L2 cache we see cache trashing and that's 
why performance goes right to hell. I wanted to test this using oprofile 
but haven't found the correct cpu performance counter yet :).

> Also not necessary, only the top level cache really needs to be
> top performance.

I will do a new round of testing this weekend for a speech I'll be 
giving. This time I will include ipchains, iptables (of course I am 
willing to apply every interesting patch regarding hash table 
optimisation and whatnot you want me to test), nf-hipac, the OpenBSD pf 
and of course the work done by Jamal.

Dave, is the work done by Jamal (and I think Werner and others did some 
too) before, mostly during OLS, and probably now the one you're 
referring to? Hadi showed it to me at OLS and I saw a great potential in it.

I'm asking because the company I work for builds rather big packet 
filters (with up to 24 NICs per node) for special purpose networks which 
due to policies and automated ruleset generation by mapping a port 
matrix into a weighted graph and then extrapolating the ruleset with 
basic Algebra (Dijkstra and all this cruft) generate a huge set of 
rules. Two problems we're facing on a daily basis:

o we can't filter more than 13Mbit/s anymore after loading around 3000
   rules into the kernel (problem is gone with nf-hipac for example).
o we can't log all the messages we would like to because the user space
   log daemon (syslog-ng in our case, but we've tried others too) doesn't
   get enough CPU time anymore to read the buffer before it will be over-
   written by the printk's again. This leads to an almost proportial to
   N^2 log entry loss with increasing number of rules that do not match.
   This is the worst thing that can happen to you working in the
   security business: not having an appropriate log trace during a
   possible incident.

AFAICR Jamal did modify the routing and FIB code and hacked iproute2 to 
achieve that. We spoke about this at the OLS. Until I had seen his code 
my approach to test the speed was to (don't laugh):

o blackhole everything (POLICY DROP)
o generate routing rules (selectors) for matching packets
o add routes which would allow just that specific flow into the
   according routing tables
o '-j <CHAIN>' was implemented using bounce table walking

This was just a test to see the potential speed improvement of moving 
the most simplistic things from netfilter (like raw packetfiltering 
without conntrack and ports) a 'layer' down to the routing code. A lot 
of works has to be done in this field and the filtering code is just 
about the most simple one AFAICT, but conntrack and proper n:m NAPT 
incorporated into the routing code is IMHO a tricky thing.

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

