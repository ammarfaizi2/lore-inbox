Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268110AbUHFJlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268110AbUHFJlz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 05:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268112AbUHFJlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 05:41:55 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:16374 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S268110AbUHFJlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 05:41:32 -0400
Date: Fri, 6 Aug 2004 11:40:37 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-mm@vger.kernel.org, wli@holomorphy.com
Subject: Re: [proc.txt] Fix /proc/pid/statm documentation
Message-ID: <20040806094037.GB11358@k3.hellgate.ch>
Mail-Followup-To: Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-mm@vger.kernel.org, wli@holomorphy.com
References: <1091754711.1231.2388.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091754711.1231.2388.camel@cube>
X-Operating-System: Linux 2.6.8-rc3 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Aug 2004 21:11:52 -0400, Albert Cahalan wrote:
> Roger Luethi writes:
> 
> > I really wanted /proc/pid/statm to die [1] and I still believe the
> > reasoning is valid. As it doesn't look like that is going to happen,
> 
> It would be awful to lose statm,

Hardly. All I was asking this time was to have a documentation fix
merged, though.

> especially since WLI has fixes for some of the problems.

I discussed this very issue with wli on linux-mm about a year ago. proc
file and documentation are still broken. So what's wrong with doing
something about it?

> Just why do you want to kill statm?

* Almost everything in there is redundant. IMO the kernel should provide
  information once and leave the rest to userspace. To make things worse,
  statm does not simply mirror information from somewhere else in the
  proc tree, it has its own (broken) routine to calculate redundant
  information.

* statm is broken. It was broken in 2.4 as well, but _differently_. Every
  application that relies on statm forwards wrong information, or at
  the very least needs special casing because the information provided
  in various fields differs between kernel versions.

* Nobody can really tell exactly how broken statm is because there is
  no canonical documentation of what it is supposed to do. That implies
  that it is kinda hard to properly fix statm.

* I hate the format. I like my proc files human readable. An important
  reason that statm could linger around in a broken state for so long
  is the lack of labels. It's hard to find bugs if there's nothing to
  indicate what the values are supposed to be. (and yes, /proc/pid/stat
  is awful, too, but it has the excuse of providing valuable information)

  (others may disagree, but you asked me why _I_ want to kill statm)

The only reason I could see for keeping statm around is that it
is cheaper than status for parsers in top & Co. Having written one
of them myself, I have spent quite some time thinking about better
alternatives. If you want to talk about that, count me in.

> Now quoting from your patch...
> 
> + size     total program size (pages)  (same as VmSize in status)
> + resident size of memory portions (pages) (same as VmRSS in status)
> 
> There was a distinction here that has been lost. One of these
> included memory-mapped hardware. You could see this with the
> X server video memory.

You can definitely not rely on that distinction being there. Feel free to
add a comment "may or may not include memory-mapped hardware, depending
on the kernel". This makes statm even worse, because even the seemingly
well-defined, redundant fields aren't.

If the memory-mapped hardware is valuable information, I suggest you
add a properly labeled field to /proc/pid/status.

> For "top" running on a 2.2.xx or 2.4.xx kernel, the statm values
> are better. Jim Warner determined this after careful examination,
> and I have no desire to re-analyse the matter. Remember that user

I didn't ask you to re-analyse anything. I didn't ask to change anything
about 2.2 or 2.4, either. But I found 2.4 statm (partially) broken a
year ago.

> tools are expected to run on both old and new kernels, while the
> kernel is expected to support old apps. We call this an ABI...

Newsflash: Your "ABI" has been broken a long time ago. statm output is
not what it used to be. If statm is so important, how come its behavior
is nowhere documented? The code does what it does, but it fails to
explain what it's meant to calculate. The proc.txt documentation has
been broken forever (fields switched!) and nobody noticed.

Besides, as you very well know it's not unheard of that contents of
files in proc change.

> + shared   number of pages that are shared (i.e. backed by a file)
> 
> This isn't in the status file. It's shown in top's default output.
> Since top must read this value from statm, it might as well use    
> other parts of statm as well.                                    

I agree that it's not in the status file. I agree that it would be
useful.

Too bad that column in statm does not really contain the amount of
shared memory, either. So you got a field labeled "shared" in top which
contains some other data.

Again, I suggest you add a field to status and make sure the calculation
is correct.

> + trs      number of pages that are 'code' (not including libs; broken,
> +       includes data segment)
> 
> Perhaps this works OK with the NX bit or on an Alpha? On a regular
> i386 box, code and read-only data are pretty much the same.

I didn't say read-only data. Let me illustrate:

$ cat /proc/23357/maps
08048000-0804c000 r-xp 00000000 03:42 9875928    /bin/cat (RL: 16 KB)
0804c000-0804d000 rw-p 00003000 03:42 9875928    /bin/cat (RL:  4 KB)
0804d000-0806e000 rw-p 0804d000 00:00 0 
40000000-40001000 rw-p 40000000 00:00 0 
40001000-40201000 r--p 00000000 03:42 9461381    /usr/lib/locale/locale-archive
422c4000-422d7000 r-xp 00000000 03:42 9290970    /lib/ld-2.3.3.so
422d7000-422d8000 rw-p 00012000 03:42 9290970    /lib/ld-2.3.3.so
422da000-423e4000 r-xp 00000000 03:42 9290974    /lib/libc-2.3.3.so
423e4000-423e8000 rw-p 00109000 03:42 9290974    /lib/libc-2.3.3.so
423e8000-423ea000 rw-p 423e8000 00:00 0 
bfffe000-c0000000 rw-p bfffe000 00:00 0 
ffffe000-fffff000 ---p 00000000 00:00 0

$ cat /proc/23357/status|grep VmExe
VmExe:        16 kB

$ cat /proc/23357/statm
845 105 807 5 0 840 0
            ^---- 5 pages == 20 KB

In other words: In this case, the trs/text field in statm counts one
page too many (4 pages text + 1 page data).

> Note: trs means "text RESIDENT set".

Your point being?

That name is only mentioned in proc.txt, it's not used anywhere in the
code (it's called "text" there). If you want to replace trs with a
better fitting name, that's great.

> + lrs      number of pages of library  (always 0 on 2.6)
> 
> This worked for a.out executables. (that 0x60000000 value is an
> a.out constant) Oh well, trs will do.
> 
> + drs      number of pages of data/stack  (including libs; broken,
> +       includes library text)
> 
> Note: trs means "data RESIDENT set".
> 
> + dt       number of dirty pages   (always 0 on 2.6)
> 
> This one would be useful.

Agreed. It would be nice to have it somewhere else.

> These would be really useful too:
> 1. swap space used
> 2. swap space that would be used if fully paged out

There are many values that could be interesting or useful. But that
has nothing to do with the abomination that is statm.

> For the pmap command, it would be nice to have per-mapping
> values in the /proc/*/maps files. (resident, locked,
> dirty, C-O-W, swapped...) 

Hey, I am all _for_ improving proc. But rather than adding more values,
I'd like to address some design problems first: For example, I'd
like to have a reserved value for N/A (currently, kernels just set
obsolete fields to 0 and parsers must guess whether it's truly 0 or not
available). And then there is the trade-off between human readable and
easy to parse. ISTR there have been occasional discussions, but maybe
it's time to revisit the issue because the current mess is a problem.

Roger
