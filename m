Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270118AbRHSGZL>; Sun, 19 Aug 2001 02:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270131AbRHSGZC>; Sun, 19 Aug 2001 02:25:02 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:24594 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S270118AbRHSGY5>;
	Sun, 19 Aug 2001 02:24:57 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200108190624.f7J6Owg174702@saturn.cs.uml.edu>
Subject: Re: [PATCH] processes with shared vm
To: te@scali.no (Terje Eggestad)
Date: Sun, 19 Aug 2001 02:24:58 -0400 (EDT)
Cc: michael@optusnet.com.au, terje.eggestad@scali.no (Terje Eggestad),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0108181530030.6444-100000@elin.scali.no> from "Terje Eggestad" at Aug 18, 2001 04:15:17 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terje Eggestad writes:
> On 17 Aug 2001 michael@optusnet.com.au wrote:

>> Why not just print out the address of the 'mm_struct'?
>>
>> That lets 'ps' treat the address as a cookie, and
>> thus count the number of occurences of each vm.

No, I won't make 'ps' do that. Ever wonder why 'ps' doesn't
sort processes by default? It isn't OK to suck up lots of
memory or reparse the files. This is bad for performance and
causes extra trouble when a kernel bug causes /proc/42/status to
freeze the 'ps' process.

Also your proposal would require 'ps' to _always_ read the
data for _every_ process in the system.

> Not a bad idea, One reason is that I've an inate distrust of using
> addresses as anything remotely useful. BTW, do you want the tag in hex
> or dec??

Either... hex is nice I guess.

> keep in mind 32 and  64 bit machines, it must actually be a 64 bit!

Nah, this gets you enough:   (unsigned)(ptr_to_mm>>sizeof(long))

> What I really wanted was a list of pids of the clones.
> ps/top/gtop could then use it as an exclude list for futher processing...

Nope. This is not enough for sane thread support in 'ps'.
Information is lost across the kernel-user boundry. It would
be relatively easy for the kernel to provide a /proc directory
listing that groups processes by mm_struct. Without this, 'ps'
would have to regenerate the lost information in an inefficient
way.

BTW, 'ps' is now here:  http://procps.sourceforge.net/

> Trouble is that returning more than 4kb in a file in proc is a pain,
> and there is no guarantee that someone make will not a 1000 clones.
> ref the recent problem with maps exceeding 4kb.
> 
> (I might be paranoid, you get ~170 (1024/6) pids in 1kb, assuming 16bit
> pid.

Yes, one has to assume that some cracker or sicko will do that.

> using the lowest pid seems a good compromise.

The PID may wrap.

> I still think the overhead is neglible.
> What's the upper practial limit of procs ~64k? (more like 4k.)

On an SSI cluster, way more I'd guess.

> How many instructions to tranvers the task list and test mm_struct
> pointer for equality? O(10) per task.? assuming all clones we're talking
> about ~650k instructions, and with 100mips machines (with 64k task, that's
> slow1) thats 1/200 second overhead every time you do cat
> /proc/[0-9]*/status. I can live with that.

You also dirty the cache and suffer load misses.
