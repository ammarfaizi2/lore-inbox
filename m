Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWDPCrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWDPCrc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 22:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWDPCrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 22:47:31 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:58750 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932196AbWDPCra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 22:47:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=0Y0ORF1oarZ8AXm1g7Pizo0yBb+ji4fqmn0ipmML1auVaaYFtidM2OXa+tJRz02rr56cdfJ5I9Mw0ZoXbxwr38/WwDPN9eshOTe8q/u06tvAtk2U6+rh69sp0ptLAC2ERqxB27SWYwmn7qyXppBsQBpjVYyXuDnhaP+mpt3Po3U=  ;
Message-ID: <4441B02D.4000405@yahoo.com.au>
Date: Sun, 16 Apr 2006 12:47:09 +1000
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
References: <1145049535.1336.128.camel@localhost.localdomain> <4440855A.7040203@yahoo.com.au> <Pine.LNX.4.58.0604151609340.11302@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0604151609340.11302@gandalf.stny.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Sat, 15 Apr 2006, Nick Piggin wrote:
> 
> 
>>Steven Rostedt wrote:
>>
>>
>>> would now create a variable called per_cpu_offset__myint in
>>>the .data.percpu_offset section.  This variable will point to the (if
>>>defined in the kernel) __per_cpu_offset[] array.  If this was a module
>>>variable, it would point to the module per_cpu_offset[] array which is
>>>created when the modules is loaded.
>>
>>If I'm following you correctly, this adds another dependent load
>>to a per-CPU data access, and from memory that isn't node-affine.
>>
>>If so, I think people with SMP and NUMA kernels would care more
>>about performance and scalability than the few k of memory this
>>saves.
> 
> 
> It's not just about saving memory, but also to make it more robust. But
> that's another story.

But making it slower isn't going to be popular.

Why is your module using so much per-cpu memory, anyway?

> 
> Since both the offset array, and the variables are mainly read only (only
> written on boot up), added the fact that the added variables are in their
> own section.  Couldn't something be done to help pre load this in a local
> cache, or something similar?

It it would still add to the dependent loads on the critical path, so
it now prevents the compiler/programmer/oooe engine from speculatively
loading the __per_cpu_offset.

And it does increase cache footprint of per-cpu accesses, which are
supposed to be really light and substitute for [NR_CPUS] arrays.

I don't think it would have been hard for the original author to make
it robust... just not both fast and robust. PERCPU_ENOUGH_ROOM seems
like an ugly hack at first glance, but I'm fairly sure it was a result
of design choices.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
