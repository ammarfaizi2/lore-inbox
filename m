Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311430AbSCMWzF>; Wed, 13 Mar 2002 17:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311429AbSCMWyq>; Wed, 13 Mar 2002 17:54:46 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:16995 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S311427AbSCMWyn> convert rfc822-to-8bit; Wed, 13 Mar 2002 17:54:43 -0500
Date: Wed, 13 Mar 2002 22:57:05 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: =?iso-8859-1?Q?Fran=E7ois_Baligant_=28Wanadoo=29?= 
	<francois.baligant@be.wanadoo.com>
cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: RE: [OOPS] In 2.4.17 __free_pages_ok
In-Reply-To: <92D340F1F4235A4EBC8A872482AE5372403F5D@exchange.lan.wanadoo.be>
Message-ID: <Pine.LNX.4.21.0203132233030.1693-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002, François Baligant (Wanadoo) wrote:
> 
> 	After a closer look, Benjamin's pglru patch which is included
> 	in rawhide 2.4.17-0.8 include a removal
> 	of the patch below which is included in rawhide 2.4.7-0.8,
> 	so I don't think it will be a solution at all.

I'm confused!  But I don't think any of that is relevant anyway.

> 	I just noticed I have this just before the Oops message,
> 	maybe I can help to pinpoint where the problem lies.
> 
> memory.c:100: bad pmd 00200000.
> memory.c:100: bad pmd 00100000.
> [ more of the same ]

Interesting, but I don't recognize that corruption myself.

> This is 2.4.17-0.18 from RedHat Rawhide on a very busy UP Intel Web server.
> 
> I have done quite a bit of search and found a thread about something
> that look similar here:
> 
> From: Hugh Dickins (hugh@veritas.com)
> Subject: Re: [PATCH] __free_pages_ok oops
> 
> I checked in 2.4.18 and 2.4.19pre3, this particular patch didn't make it in.

Yes, I ought to resubmit, but the pressure for it went down.

> My question is:
> 
> - Am I hit by the same bug ? If yes, Can I go with that particular patch ?

No.

It was for PageLRU in __free_pages_ok at interrupt time.  But if I've
correctly reconstructed your RawHide version of page_alloc.c, the BUG
on line 131 would be the check on page->pte_chain in __free_pages_ok,
which suggests an rmap problem (or a problem caught by rmap); as does
the "page_remove_rmap" line in your trace below, return address left
behind on the stack though it's not itself a user of __free_pages_ok.

Rik would be the best person to comment on this, perhaps he recognizes
your "bad pmd" corruption.  Or he may refer you instead to RedHat.

Hugh

> kernel BUG at page_alloc.c:131!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c012f92a>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010282
> eax: 00000020   ebx: c152fcf8   ecx: 00000001   edx: 00002183
> esi: 00000000   edi: c1000030   ebp: 00000000   esp: c7f8fde8
> ds: 0018   es: 0018   ss: 0018
> Process httpd (pid: 22189, stackpage=c7f8f000)
> Stack: c02987bb 00000083 c11545c0 c11545f8 c1038030 c02c3408 c1528d30
> c013445d
>        d6149890 00100000 c9f4d4f4 0000f000 17b5f005 c0122e8f c152fcf8
> 00000010
>        00000000 4022e000 d48b5400 4012e000 00000000 4022e000 d48b5400
> 00000000
> Call Trace: [<c013445d>] page_remove_rmap [kernel] 0x5d
> [<c0122e8f>] do_zap_page_range [kernel] 0x18f
> [<c012feac>] __alloc_pages_limit [kernel] 0x7c
> [<c0123370>] zap_page_range [kernel] 0x50
> [<c0125a9d>] exit_mmap [kernel] 0xbd
> [<c0114796>] mmput [kernel] 0x26
> [<c01189a3>] do_exit [kernel] 0xb3
> [<c011dcb3>] collect_signal [kernel] 0x93
> [<c011dd6d>] dequeue_signal [kernel] 0x6d
> [<c0106da4>] do_signal [kernel] 0x234
> [<c0106275>] restore_sigcontext [kernel] 0x115
> [<c0106359>] sys_sigreturn [kernel] 0xb9
> [<c0106f2c>] signal_return [kernel] 0x14
> Code: 0f 0b 5f 5d 0f b6 43 25 89 f1 c6 43 24 05 89 dd 83 63 18 eb
> 
> >>EIP; c012f92a <__free_pages_ok+11a/310>   <=====
> Trace; c013445d <page_remove_rmap+5d/70>
> Trace; c0122e8f <do_zap_page_range+18f/250>
> Trace; c012feac <__alloc_pages_limit+7c/b0>
> Trace; c0123370 <zap_page_range+50/80>
> Trace; c0125a9d <exit_mmap+bd/130>
> Trace; c0114796 <mmput+26/50>
> Trace; c01189a3 <do_exit+b3/1f0>
> Trace; c011dcb3 <collect_signal+93/e0>
> Trace; c011dd6d <dequeue_signal+6d/b0>
> Trace; c0106da4 <do_signal+234/2a0>
> Trace; c0106275 <restore_sigcontext+115/140>
> Trace; c0106359 <sys_sigreturn+b9/f0>
> Trace; c0106f2c <signal_return+14/18>
> Code;  c012f92a <__free_pages_ok+11a/310>
> 00000000 <_EIP>:
> Code;  c012f92a <__free_pages_ok+11a/310>   <=====
>    0:   0f 0b                     ud2a      <=====
> Code;  c012f92c <__free_pages_ok+11c/310>
>    2:   5f                        pop    %edi
> Code;  c012f92d <__free_pages_ok+11d/310>
>    3:   5d                        pop    %ebp
> Code;  c012f92e <__free_pages_ok+11e/310>
>    4:   0f b6 43 25               movzbl 0x25(%ebx),%eax
> Code;  c012f932 <__free_pages_ok+122/310>
>    8:   89 f1                     mov    %esi,%ecx
> Code;  c012f934 <__free_pages_ok+124/310>
>    a:   c6 43 24 05               movb   $0x5,0x24(%ebx)
> Code;  c012f938 <__free_pages_ok+128/310>
>    e:   89 dd                     mov    %ebx,%ebp
> Code;  c012f93a <__free_pages_ok+12a/310>
>   10:   83 63 18 eb               andl   $0xffffffeb,0x18(%ebx)

