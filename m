Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752045AbWISUAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbWISUAu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 16:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbWISUAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 16:00:50 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:48020 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752045AbWISUAs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 16:00:48 -0400
Date: Tue, 19 Sep 2006 15:00:57 +0530
From: "S. P. Prasanna" <prasanna@in.ibm.com>
To: Martin Bligh <mbligh@google.com>
Cc: Vara Prasad <prasadav@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
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
Message-ID: <20060919093056.GA21618@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com> <4510413F.2030200@us.ibm.com> <45104468.50106@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45104468.50106@google.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2006 at 12:26:32PM -0700, Martin Bligh wrote:
> Vara Prasad wrote:
> >Martin Bligh wrote:
> >
> >>[...]
> >>Depends what we're trying to fix. I was trying to fix two things:
> >>
> >>1. Flexibility - kprobes seem unable to access all local variables etc
> >>easily, and go anywhere inside the function. Plus keeping low overhead
> >>for doing things like keeping counters in a function (see previous
> >>example I mentioned for counting pages in shrink_list).
> >>
> >Using tools like systemtap on can consult DWARF information and put 
> >probes in the middle of the function and access local variables as well, 
> >that is not the real problem. The issue here is compiler doesn't seem to 
> >generate required DWARF information in some cases due to optimizations.  
> 
> It seems difficult to seperate those two from each other. If the
> subsystem you're relying on doesn't work, then ....
> 
> >The other related problem is when there exists debug information, the 
> >way to specify the breakpoint location is using line number which is not 
> >maintainable, having a marker solves this problem as well. Your proposal 
> >still doesn't solve the need for markers if i understood correctly.
> 
> It could, but I think we're better off with the markers, yes.
> 
> >>2. Overhead of the int3, which was allegedly 1000 cycles or so, though
> >>faster after Ingo had played with it, it's still significant.
> >
> >The reason Kprobes use breakpoint instruction as pointed out by Prasanna 
> >is, it is atomic on most platforms. We are already working on an 
> >improved idea using jump instruction with which overhead is less than 
> >100 cycles on modern CPU's but it has some limitations and issues 
> >related to preemption and SMP.
> >
> >You can get a glimpse of some of the issues here
> >http://sourceware.org/ml/systemtap/2006-q3/msg00507.html
> >http://sourceware.org/ml/systemtap/2005-q4/msg00117.html
> >For more details do a search for djprobe in the systemtap mailing list 
> >(sorry i am not able to find few threads to summarize all the issues).
> 
> "This djprobe is NOT a replacement of kprobes. Djprobe and kprobes
> have complementary qualities. (ex: djprobe's overhead is low, and
> kprobes can be inserted in anywhere.)". Hmm. that seems problematic.
> 
> From what I was describing for function replacement, we could do an NMI
> IPI to everyone, and lock them in there whilst we insert the probe, but
> it's a bit sucky.

We can do batch processing here. Send one IPI to everyone 
and then insert bunch of jump instructions. This will reduce number
of IPI required here.

> 
> >Here is the algorithm djprobes uses to
> >
> >       IA
> >        | [-2][-1][0][1][2][3][4][5][6][7]
> >       [ins1][ins2][  ins3 ]
> >       [<-     DCR       ->]
> >          [<- JTPR ->]
> >
> >ins1: 1st Instruction
> >ins2: 2nd Instruction
> >ins3: 3rd Instruction
> >IA:  Insertion Address
> >JTPR: Jump Target Prohibition Region
> >DCR: Detoured Code Region
> >
> >
> >The replacement procedure of djpopbes is the following (i have 
> >simplified for readability the actual steps djprobes uses)
> >
> >(1) copying instruction(s) in DCR
> >(2) putting break point instruction at IA
> >(3) make sure no cpu's have replacing instructions in the cache to avoid 
> >jump to the middle of jmp instruction
> >(4) replacing original instruction(s) with jump instruction
> >
> >As you can see from the above your suggestion is very similar to the 
> >djprobes hence i believe all the issues related to djprobes will be 
> >valid for yours as well.
> 
> The hooking seems very similar, yes, perhaps I can be lazy and just
> steal djprobes for this. The difference is that if we just replace the
> whole function, we can just shove arbitrary changes into functions, and
> do whatever we please. Plus we don't have to worry about locating
> internal variables, etc.
> 

Some more coplicated method.
How about inserting a (instruction size) number of breakpoints and
wait untill all the threads gets scheduled atleast once (so that
threads would hit the breakpoint, if their IPs are in the middle of
instruction we want to replace with jump) and then replace with
jump instruction.

Thanks
Prasanna

-- 
Prasanna S.P.
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-41776329
