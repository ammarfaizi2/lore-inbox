Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTFYBZU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 21:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTFYBZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 21:25:19 -0400
Received: from dsl-gte-19434.linkline.com ([64.30.195.78]:11673 "EHLO server")
	by vger.kernel.org with ESMTP id S263295AbTFYBZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 21:25:06 -0400
Message-ID: <013101c33aba$8b50c400$3400a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Torsten Wolf" <t.wolf@tu-bs.de>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.53.0306221150320.6021@hades.internal.beyondhelp.co.nz> <20030623101648.GA1736@b147.apm.etc.tu-bs.de>
Subject: Re: kswapd 2.4.2? ext3
Date: Tue, 24 Jun 2003 18:38:56 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I figured out what my problem was, and Andrew was right(as usual). It ended
up being my raid 5 controller and the a few settings.

First I updated the raid driver from Megaraid 1.18f to 1.18i. Then changed
the cache from writeback to writethru and changed the write mode from
cachedIO to directIO and now I have been up for 2 days 8 hours without a
lockup like I was getting before.

----- Original Message ----- 
From: "Torsten Wolf" <t.wolf@tu-bs.de>
To: <linux-kernel@vger.kernel.org>
Sent: Monday, June 23, 2003 3:16 AM
Subject: Re: kswapd 2.4.2? ext3


> On Son, 22 Jun 2003, John Duthie wrote:
>
> >I don't think kswap should be doing this ....
>
> The same here; I posted this a few weeks ago but as I was advised to
> reproduce the error without the modules (that I need) loaded at that
> time, the issue wasn't further investigated.
>
> I also have 2.4.20 with several ext3 filesystems in use. Occasionally
> (and only since 2.4.20) I get the error attached below. Perhaps Andrew's
> suggestion (flaky hardware) aims in the right direction as I seldom
> encounter problems with bzip2; however, memtest never found an error on
> this machine.
>
>
> Jun 21 09:07:16 b147 kernel: kernel BUG at page_alloc.c:102!
> Jun 21 09:07:16 b147 kernel: invalid operand: 0000
> Jun 21 09:07:16 b147 kernel: CPU:    0
> Jun 21 09:07:16 b147 kernel: EIP:    0010:[<c0133bc3>]    Tainted: PF
> Using defaults from ksymoops -t elf32-i386 -a i386
> Jun 21 09:07:16 b147 kernel: EFLAGS: 00010286
> Jun 21 09:07:16 b147 kernel: eax: c13d854c   ebx: c1959240   ecx:
> 00000000   edx: f7ecdd24
> Jun 21 09:07:16 b147 kernel: esi: c1959240   edi: 00000000   ebp:
> c02c7f00   esp: f7ef5f0c
> Jun 21 09:07:16 b147 kernel: ds: 0018   es: 0018   ss: 0018
> Jun 21 09:07:16 b147 kernel: Process kswapd (pid: 4, stackpage=f7ef5000)
> Jun 21 09:07:16 b147 kernel: Stack: 00000282 00000003 f1e4d240 f1e4d240
> f1e4d240 c1959240 c013f312 f1e4d240
> Jun 21 09:07:16 b147 kernel: f7ecdd24 c1959240 00005a10 c02c7f00
> c0133009 c1959240 000001d0 f7ef4000
> Jun 21 09:07:16 b147 kernel: 00000200 000001d0 0000001e 00000020
> 000001d0 00000020 00000006 c01331e1
> Jun 21 09:07:16 b147 kernel: Call Trace:    [<c013f312>] [<c0133009>]
> [<c01331e1>] [<c0133256>] [<c0133384>]
> Jun 21 09:07:16 b147 kernel: [<c01333e9>] [<c013351d>] [<c0105000>]
> [<c01072be>] [<c0133480>]
> Jun 21 09:07:16 b147 kernel: Code: 0f 0b 66 00 db cc 28 c0 89 d8 2b 05
> 50 51 34 c0 c1 f8 04 69
>
>
> >>EIP; c0133bc3 <__free_pages_ok+43/290>   <=====
>
> >>eax; c13d854c <_end+106ad74/385858a8>
> >>ebx; c1959240 <_end+15eba68/385858a8>
> >>edx; f7ecdd24 <_end+37b6054c/385858a8>
> >>esi; c1959240 <_end+15eba68/385858a8>
> >>ebp; c02c7f00 <contig_page_data+160/340>
> >>esp; f7ef5f0c <_end+37b88734/385858a8>
>
> Trace; c013f312 <try_to_free_buffers+82/100>
> Trace; c0133009 <shrink_cache+279/300>
> Trace; c01331e1 <shrink_caches+61/a0>
> Trace; c0133256 <try_to_free_pages_zone+36/60>
> Trace; c0133384 <kswapd_balance_pgdat+54/a0>
> Trace; c01333e9 <kswapd_balance+19/30>
> Trace; c013351d <kswapd+9d/c0>
> Trace; c0105000 <_stext+0/0>
> Trace; c01072be <arch_kernel_thread+2e/40>
> Trace; c0133480 <kswapd+0/c0>
>
> Code;  c0133bc3 <__free_pages_ok+43/290>
> 00000000 <_EIP>:
> Code;  c0133bc3 <__free_pages_ok+43/290>   <=====
>    0:   0f 0b                     ud2a      <=====
> Code;  c0133bc5 <__free_pages_ok+45/290>
>    2:   66                        data16
> Code;  c0133bc6 <__free_pages_ok+46/290>
>    3:   00 db                     add    %bl,%bl
> Code;  c0133bc8 <__free_pages_ok+48/290>
>    5:   cc                        int3
> Code;  c0133bc9 <__free_pages_ok+49/290>
>    6:   28 c0                     sub    %al,%al
> Code;  c0133bcb <__free_pages_ok+4b/290>
>    8:   89 d8                     mov    %ebx,%eax
> Code;  c0133bcd <__free_pages_ok+4d/290>
>    a:   2b 05 50 51 34 c0         sub    0xc0345150,%eax
> Code;  c0133bd3 <__free_pages_ok+53/290>
>   10:   c1 f8 04                  sar    $0x4,%eax
> Code;  c0133bd6 <__free_pages_ok+56/290>
>     13:   69 00 00 00 00 00         imul $0x0,(%eax),%eax
>
> Best wishes,
> Torsten
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

