Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270373AbRHSMXn>; Sun, 19 Aug 2001 08:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270374AbRHSMXd>; Sun, 19 Aug 2001 08:23:33 -0400
Received: from [62.70.89.10] ([62.70.89.10]:62726 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S270373AbRHSMXW>;
	Sun, 19 Aug 2001 08:23:22 -0400
Date: Sun, 19 Aug 2001 14:23:28 +0200 (CEST)
From: Terje Eggestad <te@scali.no>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: <michael@optusnet.com.au>, Terje Eggestad <terje.eggestad@scali.no>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] processes with shared vm
In-Reply-To: <200108190624.f7J6Owg174702@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.30.0108191329290.6444-100000@elin.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Aug 2001, Albert D. Cahalan wrote:

> Terje Eggestad writes:
> > On 17 Aug 2001 michael@optusnet.com.au wrote:
>
> >> Why not just print out the address of the 'mm_struct'?
> >>
> >> That lets 'ps' treat the address as a cookie, and
> >> thus count the number of occurences of each vm.
>
> No, I won't make 'ps' do that. Ever wonder why 'ps' doesn't
> sort processes by default? It isn't OK to suck up lots of
> memory or reparse the files. This is bad for performance and
> causes extra trouble when a kernel bug causes /proc/42/status to
> freeze the 'ps' process.
>
> Also your proposal would require 'ps' to _always_ read the
> data for _every_ process in the system.
>

BTW, Why is ps reading the status file at all????
what info is there that is not in cmndline/stat/statm??



> > Not a bad idea, One reason is that I've an inate distrust of using
> > addresses as anything remotely useful. BTW, do you want the tag in hex
> > or dec??
>
> Either... hex is nice I guess.
>
> > keep in mind 32 and  64 bit machines, it must actually be a 64 bit!
>
> Nah, this gets you enough:   (unsigned)(ptr_to_mm>>sizeof(long))
>

hmmmmm, the MSB 32 bit??? that would almost always be the same for all
kernel pointers, surely you mean (unsigned) (ptr_to_mm & 0xffffffff) ??

A point though, guess the kernel is never going to use > 4Gb of VM.

> > What I really wanted was a list of pids of the clones.
> > ps/top/gtop could then use it as an exclude list for futher processing...
>
> Nope. This is not enough for sane thread support in 'ps'.
> Information is lost across the kernel-user boundry. It would
> be relatively easy for the kernel to provide a /proc directory
> listing that groups processes by mm_struct. Without this, 'ps'
> would have to regenerate the lost information in an inefficient
> way.

Not sure what you're getting at if you use the address of mm_struct as
a clone tag,  you *do* have to keep track of all read clone tags, right?

What DO you need for sane thread support.....

> BTW, 'ps' is now here:  http://procps.sourceforge.net/
>
> > Trouble is that returning more than 4kb in a file in proc is a pain,
> > and there is no guarantee that someone make will not a 1000 clones.
> > ref the recent problem with maps exceeding 4kb.
> >
> > (I might be paranoid, you get ~170 (1024/6) pids in 1kb, assuming 16bit
> > pid.
>
> Yes, one has to assume that some cracker or sicko will do that.
>
> > using the lowest pid seems a good compromise.
>
> The PID may wrap.
>

kept thinking that the first clone is unlikely to ever die, but
you're right, new clones may very well have a lower pid, which will
of course throw of ps and likes. (damn)


> > I still think the overhead is neglible.
> > What's the upper practial limit of procs ~64k? (more like 4k.)
>
> On an SSI cluster, way more I'd guess.
>
> > How many instructions to tranvers the task list and test mm_struct
> > pointer for equality? O(10) per task.? assuming all clones we're talking
> > about ~650k instructions, and with 100mips machines (with 64k task, that's
> > slow1) thats 1/200 second overhead every time you do cat
> > /proc/[0-9]*/status. I can live with that.
>
> You also dirty the cache and suffer load misses.

hmmm, put it like that I also prevent future cache misses, ps is likely to
travers the entire task_struct list anyway...
But, sure, fine, 1/20 of a second, prefetching algo's is getting pretty
good.
64k tasks....  aren't we both getting slightly farfetched here...

TJ


-- 
_________________________________________________________________________

Terje Eggestad                  terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 70 Bogerud                      +47 975 31 574  (MOBILE)
N-0621 Oslo                     fax:    +47 22 62 89 51
NORWAY
_________________________________________________________________________

