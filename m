Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUGBKVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUGBKVX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 06:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUGBKVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 06:21:22 -0400
Received: from aun.it.uu.se ([130.238.12.36]:64251 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261426AbUGBKVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 06:21:19 -0400
Date: Fri, 2 Jul 2004 12:21:11 +0200 (MEST)
Message-Id: <200407021021.i62ALBD9015819@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ahu@ds9a.nl
Subject: Re: perfctr questions
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jul 2004 00:04:48 +0200, bert hubert <ahu@ds9a.nl> wrote:
>I'm trying to test your performance counters stuff, but I can't get it to do
>anything remotely useful! Probably just me.
>
>I have a very hard time understanding things like:
>
> *      perfex -e 0x00039000/0x04000204@0x8000000C some_program
> *
> *      Explanation: Program IQ_CCCR0 with required flags, ESCR select 4
> *      (== CRU_ESCR0), and Enable. Program CRU_ESCR0 with event 2
> *      (instr_retired), NBOGUSNTAG, CPL>0. Map this event to IQ_COUNTER0
> *      (0xC) with fast RDPMC enabled.
>
>I'd love to author a small perfctr howto for people like me who just want to
>know if their code is thrashing the cache. 
>
>Do you have a pointer to tools that do this, or, how to calculate these
>0x00039000 numbers for perfex? I can't find anything relevant. The best
>information I found is in the 'hardmeter' sources.

Unfortunately, the corresponding hardware both varies
quite a lot between processor families and manufacturers,
and in some cases (P4) is highly complex to begin with.

perfctr provides the low-level interface to these things,
and therefore you must be familiar with the hardware in
order to use it. So reading the Intel "IA32 Volume 3"
and AMD "kernel & bios" manuals is a prerequisite.

I rely on others to provide user-friendly tools and libraries.
For libraries, you should use PAPI. For tools, there are
a few, including Bryan's modifications to my (raw) perfex.

Should the kernel driver directly support some user-friendly
model of the counters? No it should not, for several reasons:
- The complexity and variability of the hardware means that
  any model would be inaccurate. You'd both lose a lot of
  functionality, and have a lot of functionality which isn't
  supportable on any given processor. User-space stuff that
  tries this approach tends to also include a direct-access
  backdoor, which brings us back to the present situation.
- The implementation of such a model would be large and complex.
  It's better to do the complex stuff in user-space, allowing
  the kernel drivers to only validate control data and drive
  the hardware.
- The model is purely a user-convenience thing. The drivers
  don't need it.

>I tried one very basic thing, perfex -e 0x00410005 ./null which I hoped
>would measure unaligned memory accesses, but I can't get this counter raised
>from 0. null.c:
>
>int main(int argc, char **argv)
>{
>        char room[12];
>        int i, n;
>
>        for(n=0;n<1000000;++n) {
>                i=*((int*)(room+n%4));  
>        }
>        
>        printf("%d\n", i);
>}
>
>I'm on a Pentium M, 2.6.7-mm5. Not even sure if an Pentium M will measure
>cache misses though.

I get '2' on a Pentium-II. It may be that the event only
counts actual external memory references, in which case
the processor's internal caches will cancel most of them.

I've had similar questions before, where it turned out
that gcc had optimised away the code that was to be measured.
Synthetic benchmarks are tricky...

/Mikael
