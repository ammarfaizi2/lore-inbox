Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268137AbUHFPkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268137AbUHFPkP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268139AbUHFPkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:40:14 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:39375 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268137AbUHFPaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:30:02 -0400
Subject: Re: [proc.txt] Fix /proc/pid/statm documentation
From: Albert Cahalan <albert@users.sf.net>
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, wli@holomorphy.com
In-Reply-To: <20040806094037.GB11358@k3.hellgate.ch>
References: <1091754711.1231.2388.camel@cube>
	 <20040806094037.GB11358@k3.hellgate.ch>
Content-Type: text/plain
Organization: 
Message-Id: <1091797122.1231.2452.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Aug 2004 08:58:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-06 at 05:40, Roger Luethi wrote:
> On Thu, 05 Aug 2004 21:11:52 -0400, Albert Cahalan wrote:
>> Roger Luethi writes:
>>
>>> I really wanted /proc/pid/statm to die [1] and I still believe the
>>> reasoning is valid. As it doesn't look like that is going to happen,
>>
>> It would be awful to lose statm,
>
> Hardly. All I was asking this time was to have a documentation fix
> merged, though.

Just delete the documentation. I certainly never use it.
Since you need the kernel source to get the documentation
anyway, you might as well examine the fs/proc/*.c files.

>> Just why do you want to kill statm?
>
> * Almost everything in there is redundant. IMO the kernel should provide
>   information once and leave the rest to userspace. To make things worse,
>   statm does not simply mirror information from somewhere else in the
>   proc tree, it has its own (broken) routine to calculate redundant
>   information.
>
> * statm is broken. It was broken in 2.4 as well, but _differently_. Every
>   application that relies on statm forwards wrong information, or at
>   the very least needs special casing because the information provided
>   in various fields differs between kernel versions.

The kernel has multiple stat() syscalls. At times, they have been
broken when dealing with UID values that overflow. Should these
system calls have been eliminated? If not, how is this different?

> * Nobody can really tell exactly how broken statm is because there is
>   no canonical documentation of what it is supposed to do. That implies
>   that it is kinda hard to properly fix statm.

Nah. Just look at the 2.2.xx and 2.4.xx kernels.

> * I hate the format. I like my proc files human readable. An important
>   reason that statm could linger around in a broken state for so long
>   is the lack of labels. It's hard to find bugs if there's nothing to
>   indicate what the values are supposed to be. (and yes, /proc/pid/stat
>   is awful, too, but it has the excuse of providing valuable information)

Nobody has been screwing with the statm formatting. There is
no temptation. The same can not be said of the "readable" files.

Is is SigCgt or SigCat? That would depend on kernel version.
What about /proc/cpuinfo? An old file gets parsed on whitespace.
A recent one has ':' characters that you must use.

> The only reason I could see for keeping statm around is that it
> is cheaper than status for parsers in top & Co. Having written one
> of them myself, I have spent quite some time thinking about better
> alternatives. If you want to talk about that, count me in.

The statm format rules, assuming you don't go binary.

>> Now quoting from your patch...
>>
>> + size     total program size (pages)  (same as VmSize in status)
>> + resident size of memory portions (pages) (same as VmRSS in status)
>>
>> There was a distinction here that has been lost. One of these
>> included memory-mapped hardware. You could see this with the
>> X server video memory.
>
> You can definitely not rely on that distinction being there. Feel free to
> add a comment "may or may not include memory-mapped hardware, depending
> on the kernel". This makes statm even worse, because even the seemingly
> well-defined, redundant fields aren't.

This is merely a kernel bug. Hey, bugs happen.

>> tools are expected to run on both old and new kernels, while the
>> kernel is expected to support old apps. We call this an ABI...
>
> Newsflash: Your "ABI" has been broken a long time ago. statm output is
> not what it used to be. If statm is so important, how come its behavior
> is nowhere documented? The code does what it does, but it fails to
> explain what it's meant to calculate. The proc.txt documentation has
> been broken forever (fields switched!) and nobody noticed.

Nobody uses proc.txt, right? The source is documentation.
Old source code is available.

>> + shared   number of pages that are shared (i.e. backed by a file)
>>
>> This isn't in the status file. It's shown in top's default output.
>> Since top must read this value from statm, it might as well use    
>> other parts of statm as well.                                    
>
> I agree that it's not in the status file. I agree that it would be
> useful.
>
> Too bad that column in statm does not really contain the amount of
> shared memory, either. So you got a field labeled "shared" in top which
> contains some other data.
>
> Again, I suggest you add a field to status and make sure the calculation
> is correct.

Why? If statm is broken, it should be fixed. Putting the statm
data into the status file was dumb, but it's too late now.

>> Note: trs means "text RESIDENT set".
>
> Your point being?
>
> That name is only mentioned in proc.txt, it's not used anywhere in the
> code (it's called "text" there). If you want to replace trs with a
> better fitting name, that's great.

The name is correct, though the code might not be. The name is common
to other UNIX-like systems.

On AIX:  ps -eo trs
On BSD:  ps axo trss

Text size is "tsiz". We have that in the stat file, as the difference
between end_code and start_code. We don't need second copy of tsiz.

>> + dt       number of dirty pages   (always 0 on 2.6)
>>
>> This one would be useful.
>
> Agreed. It would be nice to have it somewhere else.

No, it's not nice to go moving things around. How about you go
renumber all the syscalls? The x86-64 arch ordered them to avoid
cache misses. That would be great for i386 too, hmmm?

>> These would be really useful too:
>> 1. swap space used
>> 2. swap space that would be used if fully paged out
>
> There are many values that could be interesting or useful. But that
> has nothing to do with the abomination that is statm.

These values belong in statm.

>> For the pmap command, it would be nice to have per-mapping
>> values in the /proc/*/maps files. (resident, locked,
>> dirty, C-O-W, swapped...) 
>
> Hey, I am all _for_ improving proc. But rather than adding more values,
> I'd like to address some design problems first: For example, I'd
> like to have a reserved value for N/A (currently, kernels just set
> obsolete fields to 0 and parsers must guess whether it's truly 0 or not
> available).

Don't even think of changing this.

> And then there is the trade-off between human readable and
> easy to parse. ISTR there have been occasional discussions, but maybe
> it's time to revisit the issue because the current mess is a problem.

The current bugs are a problem.

Quoting your other email now:

> [ fixed linux-mm address ]

This should have been on linux-kernel in the first place.
The linux-mm list is kind of obscure, and doubly so because
it isn't on vger.kernel.org.

> - Document statm content somewhere. I posted a patch to document
>   the current state. It could be complemented with a description of
>   what it is supposed to do.

Put this in the code as comments if you like.
The proc.txt file isn't used.

> - Come to some agreement on what the proper values should be and
>   change kernels accordingly. I'm inclined to favor keeping the first two
>   (albeit redundant) fields and setting the rest to 0, simply because for
>   them too many different de-facto semantics live in exisiting kernels.
>
>   A year ago, the first field was broken in 2.4 as well (not sure if/when
>   it got fixed), but I can see why it is useful to keep around until top
>   has found a better source. Same for the second field, the only one that
>   has always been correct AFAIK.
>
> - Provide additional information in proc files other than statm.

No, statm is the proper and only place for this data.
I certainly don't claim that statm is bug-free code.
That's not a reason to discard the whole statm concept.

IMHO, the status file should never have been introduced.
It's redundant, wordy, slow to parse, and too tempting to
people who want to rename the keywords. In spite of this,
I don't suggest ripping out the status file. It's in the
ABI now.

>   The problems with undocumented records are evident, but
>   /proc/pid/status may be getting too heavy for frequent parsing. It's
>   not realistic to redesign proc at this point, but it would be nice
>   to have some documented understanding about the direction of proc
>   evolution.

The status file was too heavy from the beginning. I'm now using
a pre-computed hash table to parse the damn thing.

Say, how's this?

$ cat "/proc/SELECT pid,tty,time,cmd FROM proc WHERE user='rl'"
 PID TTY          TIME CMD
5139 ttypf    00:00:00 bash
5158 ttypf    00:00:00 cat
$

It's a standard. :-)



