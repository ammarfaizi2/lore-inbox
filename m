Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUB0B5l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 20:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbUB0B5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 20:57:41 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:52726 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261421AbUB0B5g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 20:57:36 -0500
Message-ID: <403EA407.1010405@mvista.com>
Date: Thu, 26 Feb 2004 17:57:27 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: "Amit S. Kale" <amitkale@emsyssoft.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [PATCH][3/3] Update CVS KGDB's wrt connect /
 detach
References: <20040225213626.GF1052@smtp.west.cox.net> <20040225214343.GG1052@smtp.west.cox.net> <20040225215309.GI1052@smtp.west.cox.net> <200402261344.49261.amitkale@emsyssoft.com> <403E8180.1060008@mvista.com> <20040226235915.GV1052@smtp.west.cox.net>
In-Reply-To: <20040226235915.GV1052@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Thu, Feb 26, 2004 at 03:30:08PM -0800, George Anzinger wrote:
> 
>>Amit S. Kale wrote:
>>
>>>On Thursday 26 Feb 2004 3:23 am, Tom Rini wrote:
>>>
>>>
>>>>The following patch fixes a number of little issues here and there, and
>>>>ends up making things more robust.
>>>>- We don't need kgdb_might_be_resumed or kgdb_killed_or_detached.
>>>>GDB attaching is GDB attaching, we haven't preserved any of the
>>>>previous context anyhow.
>>>
>>>
>>>If gdb is restarted, kgdb has to remove all breakpoints. Present kgdb does 
>>>that in the code this patch removes:
>>>
>>>-		if (remcom_in_buffer[0] == 'H' && remcom_in_buffer[1] == 
>>>'c') {
>>>-			remove_all_break();
>>>-			atomic_set(&kgdb_killed_or_detached, 0);
>>>-			ok_packet(remcom_out_buffer);
>>>
>>>If we don't remove breakpoints, they stay in kgdb without gdb not knowing 
>>>it and causes consistency problems.
>>
>>I wonder if this is worth the trouble.  Does kgdb need to know about 
>>breakpoints at all?  Is there some other reason it needs to track them?
> 
> 
> I don't know if it's strictly needed, but it's not the hard part of this
> particular issue (as I suggested in another thread, remove_all_break()
> on a ? packet works).
> 
> 
>>>>- Don't try and look for a connection in put_packet, after we've tried
>>>>to put a packet.  Instead, when we receive a packet, GDB has
>>>>connected.
>>>
>>>
>>>We have to check for gdb connection in putpacket or else following problem 
>>>occurs.
>>>
>>>1. kgdb console messages are to be put.
>>>2. gdb dies
>>>3. putpacket writes the packet and waits for a '+'
>>
>>Oops!  Tom, this '+' will be sent under interrupt and while kgdb is not 
>>connected.  Looks like it needs to be passed through without causing a 
>>breakpoint.  Possible salvation if we disable interrupts while waiting for 
>>the '+' but I don't think that is a good idea.
> 
> 
> I don't think this is that hard of a problem anymore.  I haven't enabled
> console messages, but I've got the following being happy now:
console pass through is the hard one as it is done outside of kgdb under 
interrupt control.  Thus the '+' will come to the interrupt handler.

There is a bit of a problem here WRT hiting a breakpoint while waiting for this 
'+'.  Should only happen on SMP systems, but still....


> - Connect to a waiting kernel, continue/^C/disconnect/reconnect.
> - Connect to a running kernel, continue/^C/disconnect/reconnect.
> - Once connected and running, ^C/hit breakpoint and
>   disconnect/reconnect.
> - Once connected, set a breakpoint, kill gdb and hit the breakpoint and
>   reconnect.
> - Once connected and running, kill gdb and reconnect.
> 
> The last two aren't as "fast" as I might like, but they're the "gdb went
> away in an ungraceful manner" situations, so I think it's OK.  In the
> first (breakpoint hit, no gdb) I end up having to issue a few continues
> to get moving again, but it's a one-time event.  

What are you referring to as "continues".  How is this different from connect to 
a waiting kernel?   Usually this would be the end of the session.  If you are 
going to continue from here something needs to be done with the breakpoint that 
gdb does not know about.  If kgdb can remove them, well fine, except your 
stopped on one.  If you remove it, there could be some confusion as to why you 
are in the debugger.  This would be a fine time for a note to the user from 
kgdb.  It is too bad that the interface does not admit to such a thing.

To overcome, to some extent, this limitation I invented the struct kgdb_info 
which contains bits of information on kgdb's internal state, some of which can 
be modified to control kgdb.  It also contains information on the "other" cpus 
and where we found them.  Also flags on what to do with them when single 
stepping and continuing.

For the last one, there's
> 2 packet instead of ACKs, then a NAK, but I believe this is acceptable.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

