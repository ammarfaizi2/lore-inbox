Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270919AbRHSX0E>; Sun, 19 Aug 2001 19:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270930AbRHSXZy>; Sun, 19 Aug 2001 19:25:54 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:14602 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S270919AbRHSXZp>;
	Sun, 19 Aug 2001 19:25:45 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200108192325.f7JNPn2217954@saturn.cs.uml.edu>
Subject: Re: [PATCH] processes with shared vm
To: te@scali.no (Terje Eggestad)
Date: Sun, 19 Aug 2001 19:25:48 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), michael@optusnet.com.au,
        terje.eggestad@scali.no (Terje Eggestad), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0108191329290.6444-100000@elin.scali.no> from "Terje Eggestad" at Aug 19, 2001 02:23:28 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terje Eggestad writes:
> On Sun, 19 Aug 2001, Albert D. Cahalan wrote:
>> Terje Eggestad writes:
>>> On 17 Aug 2001 michael@optusnet.com.au wrote:

>>>> Why not just print out the address of the 'mm_struct'?
>>>>
>>>> That lets 'ps' treat the address as a cookie, and
>>>> thus count the number of occurences of each vm.
>>
>> No, I won't make 'ps' do that. Ever wonder why 'ps' doesn't
>> sort processes by default? It isn't OK to suck up lots of
>> memory or reparse the files. This is bad for performance and
>> causes extra trouble when a kernel bug causes /proc/42/status to
>> freeze the 'ps' process.
>>
>> Also your proposal would require 'ps' to _always_ read the
>> data for _every_ process in the system.
>
> BTW, Why is ps reading the status file at all????
> what info is there that is not in cmndline/stat/statm??

all 4 UIDs
all 64 signals
misc. VM stats (maybe)

>>> Not a bad idea, One reason is that I've an inate distrust of using
>>> addresses as anything remotely useful. BTW, do you want the tag in hex
>>> or dec??
>>
>> Either... hex is nice I guess.
>>
>>> keep in mind 32 and  64 bit machines, it must actually be a 64 bit!
>>
>> Nah, this gets you enough:   (unsigned)(ptr_to_mm>>sizeof(long))
>
> hmmmmm, the MSB 32 bit??? that would almost always be the same for all
> kernel pointers, surely you mean (unsigned) (ptr_to_mm & 0xffffffff) ??
>
> A point though, guess the kernel is never going to use > 4Gb of VM.

sizeof(long) is 4 or 8

the struct is several hundred bytes on 64-bit hardware

shifting by 8 would allow for a terabyte of kernel memory

>>> What I really wanted was a list of pids of the clones.
>>> ps/top/gtop could then use it as an exclude list for futher processing...
>>
>> Nope. This is not enough for sane thread support in 'ps'.
>> Information is lost across the kernel-user boundry. It would
>> be relatively easy for the kernel to provide a /proc directory
>> listing that groups processes by mm_struct. Without this, 'ps'
>> would have to regenerate the lost information in an inefficient
>> way.
>
> Not sure what you're getting at if you use the address of mm_struct
> as a clone tag,  you *do* have to keep track of all read clone tags,
> right?

There wouldn't be a need to keep track of all read clone tags if the
kernel would group processes by clone tag. Then 'ps' would only need
to remember the current clone tag and the accumulated info.

> What DO you need for sane thread support.....

Avoiding the "thread" and "process" terms here:

The above would do. When 'ps' looks at a task, 'ps' must be able to
determine if the task should be grouped with the previous or next one.
That, and the partial ordering implied, would be enough to collect
tasks into groups. I don't expect much trouble selecting the leader,
since I have the "PPid" (parent TASK identifier!) value.

>>> I still think the overhead is neglible.
>>> What's the upper practial limit of procs ~64k? (more like 4k.)
>>
>> On an SSI cluster, way more I'd guess.
>>
>>> How many instructions to tranvers the task list and test mm_struct
>>> pointer for equality? O(10) per task.? assuming all clones we're talking
>>> about ~650k instructions, and with 100mips machines (with 64k task, that's
>>> slow1) thats 1/200 second overhead every time you do cat
>>> /proc/[0-9]*/status. I can live with that.
>>
>> You also dirty the cache and suffer load misses.
>
> hmmm, put it like that I also prevent future cache misses, ps is likely to
> travers the entire task_struct list anyway...
> But, sure, fine, 1/20 of a second, prefetching algo's is getting pretty
> good.
> 64k tasks....  aren't we both getting slightly farfetched here...

I don't know. Ask on the linux-cluster list.
