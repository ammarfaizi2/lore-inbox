Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269333AbUJKXTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269333AbUJKXTE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 19:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269320AbUJKXTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 19:19:04 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:49018 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269340AbUJKXNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 19:13:25 -0400
Message-ID: <416B12A4.7060806@yahoo.com.au>
Date: Tue, 12 Oct 2004 09:09:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: colpatch@us.ibm.com
CC: Paul Jackson <pj@sgi.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Simon.Derr@bull.net, pwil3058@bigpond.net.au, frankeh@watson.ibm.com,
       dipankar@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       LSE Tech <lse-tech@lists.sourceforge.net>, hch@infradead.org,
       steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>	 <20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com>	 <20041001164118.45b75e17.akpm@osdl.org>	 <20041001230644.39b551af.pj@sgi.com> <20041002145521.GA8868@in.ibm.com>	 <415ED3E3.6050008@watson.ibm.com> <415F37F9.6060002@bigpond.net.au>	 <821020000.1096814205@[10.10.2.4]> <20041003083936.7c844ec3.pj@sgi.com>	 <834330000.1096847619@[10.10.2.4]> <835810000.1096848156@[10.10.2.4]>	 <20041003175309.6b02b5c6.pj@sgi.com> <838090000.1096862199@[10.10.2.4]>	 <20041003212452.1a15a49a.pj@sgi.com> <843670000.1096902220@[10.10.2.4]>	 <Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr>	 <58780000.1097004886@flay> <20041005172808.64d3cc2b.pj@sgi.com>	 <1193270000.1097025361@[10.10.2.4]> <20041005190852.7b1fd5b5.pj@sgi.com>	 <1097103580.4907.84.camel@arrakis>  <20041007015107.53d191d4.pj@sgi.com>	 <1097279293.6470.106.camel@arraki! s>  <41672E42.9000104@yahoo.com.au> <1097535614.4038.82.camel@arrakis>
In-Reply-To: <1097535614.4038.82.camel@arrakis>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson wrote:
> On Fri, 2004-10-08 at 17:18, Nick Piggin wrote:
> 
>>Matthew Dobson wrote:
>>
>>>I think this example is easily achievable with the sched_domains
>>>modifications I am proposing.  You can still create your 128 CPU
>>>exclusive domain, called big_domain (due to my lack of naming
>>>creativity), and further divide big_domain into smaller, non-exclusive
>>>sched_domains.  We do this all the time, albeit statically at boot time,
>>>with the current sched_domains code.  When we create a 4-node domain on
>>>IA64, and underneath it we create 4 1-node domains.  We've now
>>>partitioned the system into 4 sched_domains, each containing 4 cpus. 
>>>Balancing between these 4 node-level sched_domains is allowed, but can
>>>be disallowed by not setting the SD_LOAD_BALANCE flag.  Your example
>>>does show that it can be more than just a convenient way to group tasks,
>>>but your example can be done with what I'm proposing.
>>
>>You wouldn't be able to do this just with sched domains, because
>>it doesn't know anything about individual tasks. As soon as you
>>have some overlap, all your tasks can escape out of your domain.
>>
>>I don't think there is a really nice way to do overlapping sets.
>>Those that want them need to just use cpu affinity for now.
> 
> 
> Well, the tasks can escape out of the domain iff you have the 
> SD_LOAD_BALANCE flag set on that domain.  If SD_LOAD_BALANCE isn't set,
> then when the scheduler tick goes off, and the code looks at the domain,
> it will see the lack of the flag and will not attempt to balance the
> domain, correct?  This is what we currently do with the 'isolated'
> domains, right?
> 

Yeah that's right. Well you have to remove some of the other SD_
flags as well (eg. SD_BALANCE_EXEC, SD_WAKE_BALANCE).

But I don't think there is much point in overlapping sets which
don't do any balancing. They might as well not exist at all.

> You're right that you can get some of the more obscure semantics of the
> various flavors of cpusets by leveraging sched_domains AND
> cpus_allowed.  I don't have any desire to remove that ability, just keep
> it as the exception.
> 

I think at this stage, overlapping cpu sets are the exception. It
is pretty logical that they're going to require some per-task info,
because the balancer can't otherwise differentiate between two tasks
on the same runqueue but in different cpu sets.

sched-domains gives you a nice clean way to do exclusive partitioning,
and I can't imagine it would be too common to want to do overlapping
partitioning.
