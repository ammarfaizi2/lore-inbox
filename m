Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289653AbSBNKrW>; Thu, 14 Feb 2002 05:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289055AbSBNKrP>; Thu, 14 Feb 2002 05:47:15 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:19517 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S291423AbSBNKq5>; Thu, 14 Feb 2002 05:46:57 -0500
Date: Thu, 14 Feb 2002 10:47:37 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>,
        Benjamin LaHaise <bcrl@redhat.com>, Gerd Knorr <kraxel@bytesex.org>,
        Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <Pine.LNX.4.21.0202131652050.20915-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0202141045250.1722-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Marcelo Tosatti wrote:
> 
> Hugh. Are you sure we can free a page from IRQ/BH context with _current_
> 2.4 ? 

I'll take it you mean "free a page _still on LRU_ from IRQ/BH ..."
Gerd's full ksymoops trace of 2.4.15-pre4 on 15 Nov 2001 shows it,
and he confirmed that was the case when I asked a few days ago:

> kernel BUG at page_alloc.c:84!
> ....
> >>EIP; c0129e5a <__free_pages_ok+aa/29c>   <=====
> Trace; c012a6f2 <__free_pages+1a/1c>
> Trace; c0121120 <unmap_kiobuf+34/48>
> Trace; f94cdfa0 <END_OF_CODE+156e2/????>
> Trace; f94bd6d8 <.bss.end+4e1a/????>
> Trace; f94c6b4e <END_OF_CODE+e290/????>
> Trace; f94cdfa0 <END_OF_CODE+156e2/????>
> Trace; f94c3b3c <END_OF_CODE+b27e/????>
> Trace; f94cdfa0 <END_OF_CODE+156e2/????>
> Trace; f94cdfa0 <END_OF_CODE+156e2/????>
> Trace; f94c3c7c <END_OF_CODE+b3be/????>
> Trace; f94cdfa0 <END_OF_CODE+156e2/????>
> Trace; c0107f9c <handle_IRQ_event+30/5c>
> Trace; f94cdfa0 <END_OF_CODE+156e2/????>
> Trace; c0108106 <do_IRQ+6a/a8>
> ....
>  <0>Kernel panic: Aiee, killing interrupt handler!

However: that is the only unambiguous example I've seen, and you
may argue that his bttv 0.8 driver is not in the current 2.4 tree,
is experimental, and even wrong in that area (we now know it also
vfrees there).  I would counter that doing unmap_kiobuf in IRQ/BH
context was safe until anonymous pages went on LRU in 2.4.14-pre5,
and both attempts at PageLRU BUG fixes which have gone in since
(mine in 2.4.15-pre and Ben's in 2.4.18-pre) have overlooked
the danger of spin_lock(&pagemap_lru_lock) in IRQ/BH context.

The ambiguous evidence is this collection of lkml oops reports:

> Date: 	Sun, 2 Dec 2001 20:16:13 -0500
> From: Andrew Ferguson <andrew@owsla.cjb.net>
> ksymoops 2.4.3 on i686 2.5.1-pre1.  Options used
> EIP:    0010:[shrink_cache+142/720]    Not tainted

> Date: 	Wed, 12 Dec 2001 16:40:33 -0800
> From: "Adam McKenna" <adam@flounder.net>
> I replaced the kernel with stock 2.4.14 and get similar errors.
> EIP:    0010:[rmqueue+405/472]    Not tainted

> Date: 	Tue, 1 Jan 2002 02:18:01 -0500
> From: Ed Tomlinson <tomlins@cam.org>
> ksymoops 2.4.3 on i586 2.4.17.  Options used
> kernel BUG at page_alloc.c:207!
> EIP:    0010:[rmqueue+474/544]    Tainted: P

> Date: 	Wed, 30 Jan 2002 21:44:27 +0100
> From: Luca Montecchiani <m.luca@iname.com>
> ksymoops 2.4.1 on i586 2.4.18-pre7.  Options used
> EIP; c012b819 <rmqueue+17d/1ac>   <=====

> Date: 	03 Feb 2002 14:05:03 +0100
> From: <francois-xavier.kowalski@club-internet.fr>
> I encounter the following kernel error using stock kernel.org 2.4.17:
> kernel BUG at vmscan.c:360!
> EIP:    0010:[shrink_cache+206/764]    Not tainted

I may be mistaken (hurriedly collected these to answer your mail,
don't think I studied the first two in depth), but I believe these
could be explained by LRU linkage corruption, such as would be seen
on UP if an IRQ/BH lru_cache_del interrupted at the wrong moment
(but on SMP would hang instead).  However, they might also be
explained by bad memory, or by more general corruption.  If we
knew what's causing all the prune_dcache crashes, very likely it
could explain these too (but I do not see any way lru_cache_del
at interrupt time could explain those crashes).

I haven't submitted my patch as a "this will solve our problems",
just as a "let's get this uncertainty out of the way".  Whether
for 2.4.18 or later, that's your judgment.  One thing that is
now certain, my simple original "if (in_interrupt()) BUG();"
is not good (for Gerd bttv) and will not be good (for Ben AIO).

Hugh

