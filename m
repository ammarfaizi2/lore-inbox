Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273261AbRJYMsd>; Thu, 25 Oct 2001 08:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273358AbRJYMsY>; Thu, 25 Oct 2001 08:48:24 -0400
Received: from inje.iskon.hr ([213.191.128.16]:9123 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S273261AbRJYMsS>;
	Thu, 25 Oct 2001 08:48:18 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
In-Reply-To: <Pine.LNX.4.33.0110242140350.9147-100000@penguin.transmeta.com>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 25 Oct 2001 14:48:38 +0200
In-Reply-To: <Pine.LNX.4.33.0110242140350.9147-100000@penguin.transmeta.com> (Linus Torvalds's message of "Wed, 24 Oct 2001 21:57:18 -0700 (PDT)")
Message-ID: <dnvgh351i1.fsf@magla.zg.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> I wonder if you're getting screwed by bdflush().. You do have a lot of
> context switching going on, and you do have a clear pattern: once the
> write-out gets going, you're filling new cached pages at about the same
> pace that you're writing them out, which definitely means that the dirty
> buffer balancing is nice and active.
>

Yes, but things are similar when I finally allocate whole memory, and
kswapd kicks in. Everything is behaving in the same way, so it is
definitely not the VM, as you pointed out.

> So the problem is that you're obviously not actually getting the
> throughput you should - it's not the VM, as the page cache grows nicely at
> the same rate you're writing.
>

Yes.

> Try something for me: in fs/buffer.c make "balance_dirty_state()" never
> return > 0, ie make the "return 1" be a "return 0" instead.
>

Sure. I recompiled fresh 2.4.13 at the work an rerun tests. This time
on different setup, so numbers are even smaller (tests were performed
at the last partition of the disk, where disk is capable of ~ 13MB/s)


   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0      0   6308    600 441592   0   0     0  7788  159   132   0   7  93
 0  1  0      0   3692    580 444272   0   0     0  5748  169   197   1   4  95
 0  1  0      0   3180    556 444804   0   0     0  5632  228   408   1   5  94
 0  1  0      0   3720    556 444284   0   0     0  7672  226   418   3   4  93
 0  1  0      0   3836    556 444148   0   0     0  5928  249   509   0   8  92
 0  1  0      0   3204    388 444952   0   0     0  7828  156   139   0   6  94
 1  1  0      0   3456    392 444692   0   0     0  5952  157   139   0   5  95
 0  1  0      0   3728    400 444428   0   0     0  7840  312   750   0   7  93
 0  1  0      0   3968    404 444168   0   0     0  5952  216   364   0   5  95


> That will cause us to not wake up bdflush at all, and if you're just on
> the "border" of 40% dirty buffer usage you'll have bdflush work in
> lock-step with you, alternately writing out buffers and waiting for them.
> 
> Quite frankly, just the act of doing the "write_some_buffers()" in
> balance_dirty() should cause us to block much better than the synchronous
> waiting anyway, because then we will block when the request queue fills
> up, not at random points.
> 
> Even so, considering that you have such a steady 9-10MB/s, please double-
> check that it's not something even simpler and embarrassing, like just
> having forgotten to enable auto-DMA in the kernel config ;)
> 

Yes, I definitely have DMA turned ON. All parameters are OK. :)

# hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1650/255/63, sectors = 26520480, start = 0

-- 
Zlatko
