Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWISTNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWISTNW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 15:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbWISTNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 15:13:22 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:63718 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750962AbWISTNV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 15:13:21 -0400
Message-ID: <4510413F.2030200@us.ibm.com>
Date: Tue, 19 Sep 2006 12:13:03 -0700
From: Vara Prasad <prasadav@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: prasanna@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       "Frank Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com>
In-Reply-To: <45102641.7000101@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:

> [...]
> Depends what we're trying to fix. I was trying to fix two things:
>
> 1. Flexibility - kprobes seem unable to access all local variables etc
> easily, and go anywhere inside the function. Plus keeping low overhead
> for doing things like keeping counters in a function (see previous
> example I mentioned for counting pages in shrink_list).
>
Using tools like systemtap on can consult DWARF information and put 
probes in the middle of the function and access local variables as well, 
that is not the real problem. The issue here is compiler doesn't seem to 
generate required DWARF information in some cases due to optimizations.  
The other related problem is when there exists debug information, the 
way to specify the breakpoint location is using line number which is not 
maintainable, having a marker solves this problem as well. Your proposal 
still doesn't solve the need for markers if i understood correctly.

> 2. Overhead of the int3, which was allegedly 1000 cycles or so, though
> faster after Ingo had played with it, it's still significant.

The reason Kprobes use breakpoint instruction as pointed out by Prasanna 
is, it is atomic on most platforms. We are already working on an 
improved idea using jump instruction with which overhead is less than 
100 cycles on modern CPU's but it has some limitations and issues 
related to preemption and SMP.

You can get a glimpse of some of the issues here
http://sourceware.org/ml/systemtap/2006-q3/msg00507.html
http://sourceware.org/ml/systemtap/2005-q4/msg00117.html
For more details do a search for djprobe in the systemtap mailing list 
(sorry i am not able to find few threads to summarize all the issues).

Here is the algorithm djprobes uses to

        IA
         | 
[-2][-1][0][1][2][3][4][5][6][7]
        [ins1][ins2][  ins3 ]
        [<-     DCR       ->]
           [<- JTPR ->]

ins1: 1st Instruction
ins2: 2nd Instruction
ins3: 3rd Instruction
IA:  Insertion Address
JTPR: Jump Target Prohibition Region
DCR: Detoured Code Region


The replacement procedure of djpopbes is the following (i have simplified for readability the actual steps djprobes uses)

(1) copying instruction(s) in DCR
(2) putting break point instruction at IA
(3) make sure no cpu's have replacing instructions in the cache to avoid jump to the middle of jmp instruction
(4) replacing original instruction(s) with jump instruction 


As you can see from the above your suggestion is very similar to the 
djprobes hence i believe all the issues related to djprobes will be 
valid for yours as well.

> M.



