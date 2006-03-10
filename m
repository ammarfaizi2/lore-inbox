Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751987AbWCJSus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbWCJSus (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 13:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbWCJSus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 13:50:48 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:65193 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1751987AbWCJSur
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 13:50:47 -0500
Subject: Re: [Alsa-devel] Re: 2.6.15-rt20, "bad page state", jackd
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: nando@ccrma.Stanford.EDU, alsa-devel@lists.sourceforge.net,
       Ingo Molnar <mingo@elte.hu>, Heiko Carstens <heiko.carstens@de.ibm.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <441109BC.9070705@yahoo.com.au>
References: <1141846564.5262.20.camel@cmn3.stanford.edu>
	 <20060309084746.GB9408@osiris.boeblingen.de.ibm.com>
	 <1141938488.22708.28.camel@cmn3.stanford.edu>
	 <4410B2D7.4090806@yahoo.com.au>
	 <1141958866.22708.69.camel@cmn3.stanford.edu>
	 <441109BC.9070705@yahoo.com.au>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 10:50:27 -0800
Message-Id: <1142016627.6124.33.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 16:08 +1100, Nick Piggin wrote:
> Fernando Lopez-Lezcano wrote:
> > On Fri, 2006-03-10 at 09:57 +1100, Nick Piggin wrote:
> >>Fernando Lopez-Lezcano wrote:
> >>Can you test with the latest mainline -git snapshot, or is it only
> >>the -rt tree that causes the warnings?
> > 
> > I found something strange although I don't know why it happens yet:
> > 
> >   Fedora Core 4 kernel (2.6.15 + patches) works fine.
> >   Fedora Core 4 kernel + -rt21, [ahem... sorry], works fine.
> >   Fedora Core 4 kernel + -rt21 + alsa kernel modules from 1.0.10 or
> >      1.0.11rc3, fails[*]
> >   Plain vanilla 2.6.15 + -rt21, works fine
> >   Plain vanilla 2.6.15 + -rt21 + alsa kernel modules from 1.0.10 or
> >      1.0.11rc3, fails[*]
> > 
> > So, it looks like it is some weird interaction between kernel modules
> > that were not compiled as part of the kernel and the kernel itself. The
> > "updated" modules are installed in a separate location (not on top of
> > the built in kernel modules) and are found before the ones in the kernel
> > tree.
> > 
> > I have been building this combination for a long long time with no
> > problems, I don't know what might have happened that changed things.
> > 
> > Could be:
> > - configuration problems?
> 
> No. It shouldn't do this even if there is a configuration problem.
> 
> > - the alsa tree is somehow incompatible with the kernel alsa tree, is
> >   that even possible?
>
> Yes. Most likely this. It should be fixed before the new ALSA code is
> pushed upstream.
> 
> It is probably not so much a matter of somebody breaking the ALSA code
> as that it hasn't been updated for the new kernel refcounting rules.

Takashi and other gurus in alsa-devel, any comments on this? The
original problem - not quoted in this email - is that when I stop jackd
in the affected configurations I get errors similar to this one:

> Bad page state at __free_pages_ok (in process 'jackd', page c1013ce0)
> flags:0x00000414 mapping:00000000 mapcount:0 count:0
> Backtrace:
>  [<c015947d>] bad_page+0x7d/0xc0 (8)
>  [<c01598fd>] __free_pages_ok+0x9d/0x180 (36)
>  [<c015a5ac>] __pagevec_free+0x3c/0x50 (40)
>  [<c015db47>] release_pages+0x127/0x1a0 (16)
>  [<c016c93d>] free_pages_and_swap_cache+0x7d/0xc0 (80)
>  [<c01681ae>] unmap_region+0x13e/0x160 (28)
>  [<c0168461>] do_munmap+0xe1/0x120 (48)
>  [<c01684df>] sys_munmap+0x3f/0x60 (32)
>  [<c01034a1>] syscall_call+0x7/0xb (16)
> Trying to fix it up, but a reboot is needed

One other thing occurred to me (not tested yet)

- userspace regression in the module load code (so that in the end
modules from the in kernel tree get mixed with modules coming from the
externally compiled alsa tree). Very unlikely, I think, I could test for
this by removing the in kernel modules temporarily. 

I have problems in both:
  snd-ice1712 (midiman delta 66)
  snd-hdsp (rme hdsp)
but this seems to work fine:
  snd-echo3g (gina3g)

The interesting thing is that the one that works (snd-echo3g) has no
counterpat in the in kernel alsa tree - that is, only exists in the
add-on modules compiled externally. Coincidence?

-- Fernando


