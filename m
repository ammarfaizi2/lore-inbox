Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWDPPUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWDPPUE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 11:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWDPPUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 11:20:04 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:12928 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750733AbWDPPUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 11:20:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=AkxLklQ1LObOQDRp/1ndJxXEyQ5GXfujUAbBkFbBjePWaiGfbI0T1+Kh5rkcONEp/8RtoBgHFxkZSeBGRzC6w2K0OjAMspUouG9Oi1OpHg0C15x/DdhM0vGZUYUnK3QmFqaUgEwv2lWpFgAkFSqto49aVWaeYe6k90iuo/QlvRA=  ;
Message-ID: <4441ECE6.5010709@yahoo.com.au>
Date: Sun, 16 Apr 2006 17:06:14 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Martin Mares <mj@atrey.karlin.mff.cuni.cz>, bjornw@axis.com,
       schwidefsky@de.ibm.com, benedict.gaster@superh.com, lethal@linux-sh.org,
       Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>,
       Joe Taylor <joe@tensilica.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>, rth@twiddle.net,
       spyro@f2s.com, starvik@axis.com, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, ralf@linux-mips.org,
       linux-mips@linux-mips.org, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       paulus@samba.org, linux390@de.ibm.com, davem@davemloft.net
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
References: <1145049535.1336.128.camel@localhost.localdomain> <4440855A.7040203@yahoo.com.au> <Pine.LNX.4.58.0604151609340.11302@gandalf.stny.rr.com> <4441B02D.4000405@yahoo.com.au> <Pine.LNX.4.58.0604152323560.16853@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0604152323560.16853@gandalf.stny.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Sun, 16 Apr 2006, Nick Piggin wrote:

>>Why is your module using so much per-cpu memory, anyway?
> 
> 
> Wasn't my module anyway. The problem appeared in the -rt patch set, when
> tracing was turned on.  Some module was affected, and grew it's per_cpu
> size by quite a bit. In fact we had to increase PERCPU_ENOUGH_ROOM by up
> to something like 300K.

Well that's easy then, just configure PERCPU_ENOUGH_ROOM to be larger
when tracing is on in the -rt patchset? Or use alloc_percpu for the
tracing data?

>>I don't think it would have been hard for the original author to make
>>it robust... just not both fast and robust. PERCPU_ENOUGH_ROOM seems
>>like an ugly hack at first glance, but I'm fairly sure it was a result
>>of design choices.
> 
> Yeah, and I discovered the reasons for those choices as I worked on this.
> I've put a little more thought into this and still think there's a
> solution to not slow things down.
> 
> Since the per_cpu_offset section is still smaller than the
> PERCPU_ENOUGH_ROOM and robust, I could still copy it into a per cpu memory
> field, and even add the __per_cpu_offset to it.  This would still save
> quite a bit of space.

Well I don't think making it per-cpu would help much (presumably it
is not going to be written to very frequently) -- I guess it would
be a small advantage on NUMA. The main problem is the extra load in
the fastpath.

You can't start the next load until the results of the first come
back.

> So now I'm asking for advice on some ideas that can be a work around to
> keep the robustness and speed.
> 
> Is there a way (for archs that support it) to allocate memory in a per cpu
> manner. So each CPU would have its own variable table in the memory that
> is best of it.  Then have a field (like the pda in x86_64) to point to
> this section, and use the linker offsets to index and find the per_cpu
> variables.
> 
> So this solution still has one more redirection than the current solution
> (per_cpu_offset__##var -> __per_cpu_offset -> actual_var where as the
> current solution is __per_cpu_offset -> actual_var), but all the loads
> would be done from memory that would only be specified for a particular
> CPU.
> 
> The generic case would still be the same as the patches I already sent,
> but the archs that can support it, can have something like the above.
> 
> Would something like that be acceptible?

I still don't understand what the justification is for slowing down
this critical bit of infrastructure for something that is only a
problem in the -rt patchset, and even then only a problem when tracing
is enabled.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
