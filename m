Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVANJUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVANJUq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 04:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVANJUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 04:20:46 -0500
Received: from opersys.com ([64.40.108.71]:20754 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261840AbVANJUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 04:20:24 -0500
Message-ID: <41E7908E.6090101@opersys.com>
Date: Fri, 14 Jan 2005 04:27:42 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Tom Zanussi <zanussi@us.ibm.com>, Larry Kessler <kessler@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de>
In-Reply-To: <m1zmzcpfca.fsf@muc.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen wrote:
> I think it would be better to have a standard set of kprobes instead
> of all the ugly LTT hooks. kprobes could then log to relayfs or another
> fast logging mechanism.
> 
> Advantage of this would be that it had no impact on fast paths 
> unless enabled (LTT slows down a kernel quite considerable just
> by compiling it in) 

There are different ways to look at this. For one thing, the current
ltt hooks aren't as fast as they should be (i.e. we check whether
the tracing is enabled for a certain event way too far in the code-path.)
This should be rather simple to fix. Whether it be by checking for the
event's logging as early as possible or by using one of the hooking
frameworks that generate noops which cost nothing until tracing is
enabled. None of this is really difficult. What is difficult is trying
to maintain the LTT patches outside the kernel while trying to add all
the bells-and-whistles that make such a thing lightweight and effective.

As far as kprobes go, then you still need to have some form or another
of marking the code for key events, unless you keep maintaining a set
of kprobes-able points separately, which really makes it unusable for
the rest of us, as the users of LTT have discovered over time (having
to create a new patch for every new kernel that comes out.) Yet I do
see the point of being able to add the stuff dynamically.

So lately I've been thinking that there may be a middle-ground here
where everyone could be happy. Define three states for the hooks:
disabled, static, marker. The third one just adds some info into
System.map for allowing the automation of the insertion of kprobes
hooks (though you would still need the debugging info to find the
values of the variables that you want to log.) Hence, you get to
choose which type of poison you prefer. For my part, I think the
noop/early-check should be sufficient to get better performance from
the existing hook-set.

> imho relayfs and netlink are for completely problem spaces.
> relayfs is for relaying a lot of data quickly (e.g. for kernel
> instrumentation). There it fills a niche that printk doesn't fill
> (since it's too slow). netlink is quite slow (allocates data for each
> event, does lots of other gunk), but an useful extensible format
> for low frequency events.
> 
> For the problems that relayfs solves netlink is totally unusable
> due to low efficiency (you could as well use printk, but that is
> also to slow). I think a low overhead logging mechanism is very
> much needed, because I find myself reinventing it quite often
> when I need to debug some timing sensitive problem. Trying to 
> tackle these with printk is hopeless because it changes timing too much.

This is a very positive review, thanks.

> The problem relayfs has IMHO is that it is too complicated. It 
> seems to either suffer from a overfull specification or second system
> effect. There are lots of different options to do everything,
> instead of a nice simple fast path that does one thing efficiently.
> IMHO before merging it should go through a diet and only keep
> the paths that are actually needed and dropping a lot of the current
> baggage.
> 
> Preferably that would be only the fastest options (extremly simple
> per CPU buffer with inlined fast path that drop data on buffer overflow), 
> with leaving out anything more complicated. My ideal is something
> like the old SGI ktrace which was an extremly simple mechanism
> to do lockless per CPU logging of binary data efficiently and
> reading that from a user daemon.

Certainly we are more than willing to accomodate any reasonable
changes. Some of the "overfeatures" you've noticed actually stem
from our trying to implement a number of things over relayfs. For
example, we've ported printk over to relayfs and have been able
to obtain lossless printk by implementing dynamically resizable
buffers. That doesn't mean there isn't room for improvement. If
there are any specific changes you think are required, we'd be
glad to take a look at them.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
