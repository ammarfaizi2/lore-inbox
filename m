Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbUDEVHF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbUDEVHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:07:05 -0400
Received: from mail.cyclades.com ([64.186.161.6]:40837 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263205AbUDEVGq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:06:46 -0400
Date: Mon, 5 Apr 2004 17:43:17 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de, akpm@osdl.org
Subject: Re: [2.4] NMI WD detected lockup during page alloc
Message-ID: <20040405204317.GA13528@logos.cnet>
References: <20040404121756.GA8854@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040404121756.GA8854@linuxhacker.ru>
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2004 at 03:17:56PM +0300, Oleg Drokin wrote:
> Hello!
> 
>    One of my servers started to experience mystic hangs after upgrade to
>    dual P4 Xeon (before that it was running on UP kernel) (HT enabled now).
>    So I enabled NMI watchdog and finally it triggered recently.
>    The kernel is 2.4.25+ (pulled from 2.4 bitkeeper tree on XX/XX, but
>    it seems related files in mm/ have not changed since at least January 2004
>    anyway). 
>    So the HW is Duap P4-Xeon on some Intel-branded server (E7501-based or
>    something), 2G E?? RAM (highmem enabled).
> 
>    That's what I got on the serial console:
> NMI Watchdog detected LOCKUP on CPU2, eip c013b527, registers:
> CPU:    2
> EIP:    0010:[<c013b527>]    Not tainted
> EFLAGS: 00000086
> eax: 00000000   ebx: c02dca38   ecx: 000048ce   edx: c02dca38
> esi: c02dca74   edi: 00000000   ebp: d34b1e5c   esp: d34b1e30
> ds: 0018   es: 0018   ss: 0018
> Process mrtg (pid: 14663, stackpage=d34b1000)
> Stack: 00038000 00000282 00000000 00015006 00015006 00000286 00000000 c02dca38
>        c02dca38 c02dcb38 00000002 d34b1ea0 c013adfa c0139395 d34b1ea0 00000202
>        c02dcaec 32353530 d34b1e7c c02dca38 c02dca38 c02dcb34 00000000 000001d2
> Call Trace:    [<c013adfa>] [<c0139395>] [<c012dc0d>] [<c012e6d7>] [<c0119330>
> ]
>   [<c014bca5>] [<c0159301>] [<c014ee56>] [<c014bd1b>] [<c0153b3b>] [<c0118f70>
> ]
>   [<c01076b0>]
> Code: f3 90 7e f9 e9 11 f4 ff ff 80 3f 00 f3 90 7e f9 e9 8e fd ff
> >>EIP; c013b527 <.text.lock.page_alloc+f/28>   <=====
> Trace; c013adfa <__alloc_pages+6a/270>
> Trace; c0139395 <lru_cache_del+15/20>
> Trace; c012dc0d <do_wp_page+6d/2e0>
> Trace; c012e6d7 <handle_mm_fault+f7/110>
> Trace; c0119330 <do_page_fault+3c0/586>
> Trace; c014bca5 <cp_new_stat64+e5/110>
> Trace; c0159301 <dput+31/190>
> Trace; c014ee56 <path_release+16/40>
> Trace; c014bd1b <sys_stat64+4b/80>
> Trace; c0153b3b <sys_fcntl64+5b/c0>
> Trace; c0118f70 <do_page_fault+0/586>
> Trace; c01076b0 <error_code+34/3c>
> 
> 
> So it seems it was blocked trying to take zone->lock in
> mm/page_alloc.c::rmqueue()
> The actual calltrace seems to be (lots of stale entries seems to be on
> actual stack).
> 
> rmqueue
> __alloc_pages+6a
> do_wp_page+6d
> handle_mm_fault+f7 (this is in fact handle_pte_fault())
> do_page_fault+3c0
> error_code+34
> 
> I fail to see a path where we can take lock on the same zone twice on same
> CPU, so may be the zone structure was somehow corrupted (I do not have
> spinlock debugging enabled yet). I do not think there are problems with
> memory in that box that might explain this as well.

I also fail to see how zone->lock could be left locked. The only users of it are
rmqueue and __free_pages_ok() and the codepaths which lock them are not prone to
problems.

> Probability of hangs vary over time, I got the first one on the next day after
> upgrade (not even sure if it was the same as this one since I had no traces
> from it), but this second one happened after 2-3 weeks of uptime.
> 
> May be it will help someone to find out what happens.

Can you send me your config file and description of workload? I have a similar E7501
around (with MPT fusion). 

What drivers are you using, btw?
