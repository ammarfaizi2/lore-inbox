Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965151AbVL2KKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbVL2KKY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 05:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbVL2KKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 05:10:24 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:60171 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S965151AbVL2KKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 05:10:23 -0500
Date: Thu, 29 Dec 2005 11:08:48 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
Message-ID: <20051229100848.GA24309@alpha.home.local>
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu> <20051228001047.GA3607@dmt.cnet> <Pine.LNX.4.64.0512281806450.10419@potato.cts.ucla.edu> <20051229051238.GU15993@alpha.home.local> <Pine.LNX.4.64.0512282322280.13624@potato.cts.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512282322280.13624@potato.cts.ucla.edu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 01:33:47AM -0800, Chris Stromsoe wrote:
> On Thu, 29 Dec 2005, Willy Tarreau wrote:
> >On Wed, Dec 28, 2005 at 06:52:06PM -0800, Chris Stromsoe wrote:
> >>
> >>Dec 27 09:28:19 filemap.c:2234: bad pmd 020001e3.
> >>Dec 27 09:28:19 filemap.c:2234: bad pmd 024001e3.
> >>
> >>The oops came in ata 09:28:20
> >>
> >>ksymoops 2.4.9 on i686 2.4.32.  Options used
> >>     -V (default)
> >>     -k /proc/ksyms (default)
> >>     -l /proc/modules (default)
> >>     -o /lib/modules/2.4.32/ (default)
> >>     -m /boot/System.map-2.4.32 (specified)
> >>
> >>Unable to handle kernel paging request at virtual address c22eee80
> >>c0259bb3
> >>*pde = 020001e3
> >>Oops: 0002
> >>CPU:    2
> >      ^^^^^
> >interesting, this machine is SMP.
> >memtest86 only involves CPU0 in tests. I've already had a great 
> >difficulty
> >trying to detect memory problems which occured only when more than one 
> >CPU
> >was accessing the RAM. Can your machine support its load with only one 
> >CPU ?
> >Maybe you observe more I/O than pure CPU. It would be interesting to 
> >restart
> >it with the 'nosmp' boot option.
> 
> The machine is a dual P4 Xeon with hyperthreading on.  It can probably 
> get by with only one cpu enabled.  If/when it goes down again, I'll boot 
> with nosmp.  For what it's worth, I ran a Dell memory tester ("MP 
> Memory") which claims to test all of the CPUs for a few hours and didn't 
> come up with anything.  The machine feeds usenet and is seeing a lot more 
> io than cpu.  (There are two Adaptec controllers, 4 channels, aic79xx, 5 
> drives on one channel, 3 unused, spool is on a 4 disk raid5, jfs 
> formatted.)

OK, I've found two old similar reports from people running news servers :
  http://www.ussg.iu.edu/hypermail/linux/kernel/0308.1/0807.html
  http://seclists.org/lists/linux-kernel/2004/Jan/5699.html

both were using an SMP server with an AIC7xxx adapter, and kernels varying
from 2.4.18 to 2.4.24. One of them used XFS and not JFS, so we will exclude
any potential JFS-related cause for now.

If you feel brave, you can try to switch the AIC7xxx driver to Justin Gibbs'
more recent version, but which has not evolved during last year, but which
I have running reliably on production servers :

   http://people.freebsd.org/~gibbs/linux/

I also have it rediffed for recent kernels if you prefer :

   http://w.ods.org/kernel/2.4-wt/2.4.32-wt2/patches-2.4.32-wt2/pool/aic79xx-20040522-linux-2.4.30-pre3.rediff


> >>EIP:  0010:[alloc_skb+275/480] Not tainted
> >
> >I'm somewhat surprized, because I've not found a direct nor indirect 
> >call path from alloc_skb() to filemap_sync_pte_range() in which the 
> >error is reported. I'm clearly missing something here.
> 
> If it helps, the oops with 2.4.30 had two "bad pmd" messages right before 
> it then:
> 
> Unable to handle kernel paging request at virtual address c13aef08
>  printing eip:
> c012d7b6
> *pde = 010001e3
> *pte = ce919a00
> Oops: 0000
> CPU:    1
> EIP:    0010:[mark_page_accessed+6/48]    Not tainted
> EFLAGS: 00010296
> eax: c13aeef0   ebx: c13aeef0   ecx: 0005d800   edx: ee030900
> esi: 0005d7a0   edi: 0005d8a9   ebp: f66b1c3c   esp: f66b1c38
> ds: 0018   es: 0018   ss: 0018
> Process innfeed (pid: 526, stackpage=f66b1000)
> Stack: c13aeef0 f66b1c70 c012ea08 ee030900 0005d7a0 0005d8a9 0005d8a9 
> f7fa1d60
>        f6628080 f6628144 f7628200 ee030900 c012e830 f77f4d80 f66b1cb8 
>        c012a18e
>        ee030900 63ca0000 00000000 f66b1ce4 c027404c 00000000 f77f4d80 
>        00000106
> Call Trace:    [filemap_nopage+472/544] 
> [filemap_nopage+0/544][do_no_page+126/608] [ip_queue_xmit+780/1424] 
> [handle_mm_fault+121/272]
>   [do_page_fault+1024/1472] [tcp_write_xmit+353/688] 
>   [tcp_new_space+137/160][tcp_rcv_established+716/2480] 
>   [memcpy_toiovec+67/112] [do_page_fault+0/1472]
>   [error_code+52/60] [csum_partial_copy_generic+61/260] 
>   [tcp_sendmsg+2367/4512] [inet_sendmsg+65/80] [sock_sendmsg+102/176] 
>   [sock_readv_writev+116/176]
>   [sock_writev+79/96] [do_readv_writev+567/608] [sys_writev+88/128] 
>   [system_call+51/56]
> 
> Code: 8b 40 18 a8 80 75 07 8b 43 18 a8 04 75 0c f0 0f ba 6b 18 02

Out of curiosity, it would be interesting to disable swap if you have it
enabled.

> -Chris

Willy

