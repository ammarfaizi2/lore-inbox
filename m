Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbUB0WBq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 17:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUB0WAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 17:00:24 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:54768 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263150AbUB0Vzk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 16:55:40 -0500
Message-ID: <403FBCD2.4050005@mvista.com>
Date: Fri, 27 Feb 2004 13:55:30 -0800
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
References: <20040225213626.GF1052@smtp.west.cox.net> <20040225214343.GG1052@smtp.west.cox.net> <20040225215309.GI1052@smtp.west.cox.net> <200402261344.49261.amitkale@emsyssoft.com> <403E8180.1060008@mvista.com> <20040226235915.GV1052@smtp.west.cox.net> <403EA407.1010405@mvista.com> <20040227171339.GA1052@smtp.west.cox.net>
In-Reply-To: <20040227171339.GA1052@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Thu, Feb 26, 2004 at 05:57:27PM -0800, George Anzinger wrote:
> 
>>Tom Rini wrote:
>>
>>>- Connect to a waiting kernel, continue/^C/disconnect/reconnect.
>>>- Connect to a running kernel, continue/^C/disconnect/reconnect.
>>>- Once connected and running, ^C/hit breakpoint and
>>> disconnect/reconnect.
>>>- Once connected, set a breakpoint, kill gdb and hit the breakpoint and
>>> reconnect.
>>>- Once connected and running, kill gdb and reconnect.
>>>
>>>The last two aren't as "fast" as I might like, but they're the "gdb went
>>>away in an ungraceful manner" situations, so I think it's OK.  In the
>>>first (breakpoint hit, no gdb) I end up having to issue a few continues
>>>to get moving again, but it's a one-time event.  
>>
>>What are you referring to as "continues".  How is this different from 
>>connect to a waiting kernel?   Usually this would be the end of the 
>>session.  If you are going to continue from here something needs to be done 
>>with the breakpoint that gdb does not know about.  If kgdb can remove them, 
>>well fine, except your stopped on one.  If you remove it, there could be 
>>some confusion as to why you are in the debugger.  This would be a fine 
>>time for a note to the user from kgdb.  It is too bad that the interface 
>>does not admit to such a thing.
> 
> 
> OK, I've rechecked the senarios, and the only time gdb/kgdb seems a bit
> confused is when gdb sets a bpt / dies / bpt is triggered.  It looks
> like this (on gdb reattaching to the now stuck host, gdb 6.0):
> Remote debugging using /dev/ttyS0
> Sending packet: $qPassSignals:0e;10;14;17;1a;1b;1c;21;24;25;4c;#df...Ack
> Packet received: 
> Packet qPassSignals (pass-signals) is NOT supported
> Sending packet: $Hc-1#09...Ack
> Packet received: OK
> Sending packet: $qC#b4...Ack
> Packet received: QC00000000000000d0
> Sending packet: $qOffsets#4b...Ack
> Packet received: 
> Sending packet: $?#3f...Ack
> 
> <- At this point, kgdb calls remove_all_break() ->
I don't know this code, but if the current PC is at a given BP+1 you may need to 
back up the PC to point to the, now replaced, instruction.  You could verify 
this by looking, at this point, at what gdb has for the PC.  Odds are that it is 
either mid instruction or after the instruction that was replaced by the BP 
(depends on the relative length of the BP instruction and the replaced 
instruction).

-g
> 
> Packet received: S05
> Sending packet: $Hgd0#43...Ack
> Packet received: OK
> Sending packet: $g#67...Ack
> Packet received: 27000000ff0100007b000000c0feffbf703f55d6bc3f55d6c0feffbfd4fdffbf8a4815c08202000060000000680000007b0069d77b000000ffff0000ffff0000
> 0xc015488a in sys_mkdir (Sending packet: $m27,8#3a...Ack
> Packet received: E22
> Sending packet: $m27,8#3a...Ack
> Packet received: E22
> Sending packet: $m27,1#33...Ack
> Packet received: E22
> Sending packet: $m27,1#33...Ack
> Packet received: E22
> Sending packet: $m27,1#33...Ack
> Packet received: E22
> Sending packet: $m27,1#33...Ack
> Packet received: E22
> pathname=0x27 <Address 0x27 out of bounds>, 
>     mode=-1073742144) at fs/namei.c:1533
> 1533		tmp = getname(pathname);
> Sending packet: $qSymbol::#5b...Ack
> Packet received: 
> Packet qSymbol (symbol-lookup) is NOT supported
> 
> <- continue ->
> 
> Continuing.
> Sending packet: $Hsd0#4f...Ack
> Packet received: 
> Sending packet: $Hc0#db...Ack
> Packet received: OK
> Sending packet: $c#63...Ack
> Packet received: T0bthread:00000000000000d0;
> [New Thread 208]
> Sending packet: $g#67...Ack
> Packet received: 27000000ff0100007b000000c0feffbf703f55d6bd3f55d6c0feffbfd4fdffbf8b4815c08602010060000000680000007b0069d77b000000ffff0000ffff0000
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0xc015488b in sys_mkdir (Sending packet: $m27,8#3a...Ack
> Packet received: E22
> Sending packet: $m27,8#3a...Ack
> Packet received: E22
> Sending packet: $m27,1#33...Ack
> Packet received: E22
> Sending packet: $m27,1#33...Ack
> Packet received: E22
> Sending packet: $m27,1#33...Ack
> Packet received: E22
> Sending packet: $m27,1#33...Ack
> Packet received: E22
> pathname=0x27 <Address 0x27 out of bounds>, 
>     mode=-1073742144) at fs/namei.c:1533
> 1533		tmp = getname(pathname);
> 
> <- continue ->
> 
> Continuing.
> Sending packet: $C0b#d5...Ack
> Packet received: 
> Can't send signals to this remote system.  SIGSEGV not sent.
> Sending packet: $c#63...Ack
> Packet received: T05thread:00000000000000d0;
> Sending packet: $g#67...Ack
> Packet received: 27000000ff0100007b000000c0feffbf703f55d6bd3f55d6c0feffbfd4fdffbf8b4815c08602010060000000680000007b0069d77b000000ffff0000ffff0000
> 
> Program received signal SIGTRAP, Trace/breakpoint trap.
> 0xc015488b in sys_mkdir (Sending packet: $m27,8#3a...Ack
> Packet received: E22
> Sending packet: $m27,8#3a...Ack
> Packet received: E22
> Sending packet: $m27,1#33...Ack
> Packet received: E22
> Sending packet: $m27,1#33...Ack
> Packet received: E22
> Sending packet: $m27,1#33...Ack
> Packet received: E22
> Sending packet: $m27,1#33...Ack
> Packet received: E22
> pathname=0x27 <Address 0x27 out of bounds>, 
>     mode=-1073742144) at fs/namei.c:1533
> 1533		tmp = getname(pathname);
> 
> <- continue ->
> 
> Continuing.
> Sending packet: $c#63...Ack
> 
> <- From here, the system is OK again ->
> 
> remote_interrupt called
> remote_stop called
> Packet received: T05thread:0000000000008000;
> [New Thread 32768]
> Sending packet: $g#67...Ack
> Packet received: 0100000004000000000000000400000068df28c06cdf28c080000000809a28c05afd12c00200000060000000680000007b0010c07b000000ffff0000ffff0000
> 
> Program received signal SIGTRAP, Trace/breakpoint trap.
> [Switching to Thread 32768]
> breakpoint () at kernel/kgdb.c:1088
> 1088		atomic_set(&kgdb_setting_breakpoint, 0);
> Sending packet: $D#44...Ack
> Packet received: OK
> Ending remote debugging.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

