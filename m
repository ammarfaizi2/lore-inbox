Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWIVQDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWIVQDm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 12:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWIVQDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 12:03:42 -0400
Received: from opersys.com ([64.40.108.71]:33291 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S932296AbWIVQDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 12:03:41 -0400
Message-ID: <45140E33.9030509@opersys.com>
Date: Fri, 22 Sep 2006 12:24:19 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
CC: Ingo Molnar <mingo@elte.hu>, Martin Bligh <mbligh@google.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers 0.5 for Linux 2.6.17 (with probe
 management)
References: <20060921160009.GA30115@Krystal> <20060921160656.GA24774@elte.hu> <20060921214248.GA10097@Krystal> <20060922070714.GB4167@elte.hu> <20060922150810.GB20839@Krystal>
In-Reply-To: <20060922150810.GB20839@Krystal>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Funny, I never thought I'd be defending djprobes ...

Mathieu Desnoyers wrote:
> 2 bytes jump + 3 bytes nops.. Yes, it should modify it without causing an
> illegal instruction, but how ? Are you aware that their approach has to :
> - put an int3
> - wait for _all_ the CPUs to execute this int3
> - then change the 5 bytes instruction
> 
> I can think of a lot of cases where the CPUs will never execute this int3.
> Probably that sending an IPI or launching a kernel thread on each CPU to make
> sure that this int3 is executed could give more guarantees there. But my point
> is not even there : I have seen very skillful teams work hard on those
> hardware-caused problems for years and the result is still not usable. It looks
> to me like a race between software developers and hardware manufacturers, where
> the software guy is always one step behind. This kind of scenario happens when
> you want to use an architecture in a way it was not designed and tested for.
> 
> As long as CPU manufacturers won't design for live instruction patching (and why
> should they do that ? the in3 breakpoint is all what is needed from their
> perspective), this will be a race where software developers will lose.

I'm with you all the way if we're talking about patching instructions
which are less than 5 bytes. And I must fault djprobes backers
for their insistence on trying to get it to work for all possible
instruction lengths. But in the specific case discussed between
Hiramatsu-san and myself (5 byte short jmp + nops) I have no reason
to believe it doesn't work. Continuing to try to get it to work on
any instruction length can be argued to be a waste of time, but not
what has been talked of of late.

With regards to all CPUs executing the int3, here's a rather savage,
but effective way of making this work:
- launch one thread per cpu (as you explained)
- have each thread make a direct jump to the location of the int3
- catch the int3 and kill active thread if this is a forced jump
This is deterministic.

So if your proposal is to amend the markup to use the short-jmp+nops
at every marker site instead of my earlier suggestion for the bprobes
thing, I'm all with you.

And I agree, 5 NOPs is *not* the right thing. 1 short jmp + 3 nops,
this works.

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
