Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWJTP0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWJTP0i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 11:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWJTP0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 11:26:35 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:10837 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932242AbWJTP0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 11:26:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=CDF8d1NXk8tTwVLlHGCu8fP51m+yYpKKVBQj4AIr6u4eHNHRLFJQypiK7MHug2DX5bQ/WkM7n1BeHGfWAK71Yo4hsPEg4kkvM4R8HXrUxl3sq3RXOBYDf5lFz7QGKdGNEGMxt8LR+kFNQrAxoONn93UilsFlwgElkLDR7RkFgiE=  ;
Message-ID: <4538EAA6.6010606@yahoo.com.au>
Date: Sat, 21 Oct 2006 01:26:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Julien Kirmaier <julien.kirmaier@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at mm/swap.c:340
References: <20061020095456.GA24360@thabor.lan.ah2d.fr>
In-Reply-To: <20061020095456.GA24360@thabor.lan.ah2d.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Julien Kirmaier wrote:
> Dear kernel maintainers,
> 
>   while processing with gs rather large postscript files (~1Go) the kernel 
> pulled this message in the console:
> 
> <<<<<
> kernel BUG at mm/swap.c:340!


So it found PageLRU set when it should not have been.

> invalid opcode: 0000 [#1]
> Modules linked in: parport_serial bsd_comp ppp_deflate zlib_deflate 
> ppp_synctty ppp_generic slhc via_rhine nfs lockd sunrpc smbfs ntfs vfat fat 
> genrtc
> CPU:    0
> EIP:    0060:[<c01367b2>]    Not tainted VLI
> EFLAGS: 00010202   (2.6.18 #2) 
> EIP is at __pagevec_release_nonlru+0x26/0x71
> eax: ffffffff   ebx: c1ad7e24   ecx: 00000007   edx: c158f848
> esi: f1d57ca0   edi: f1d57ca0   ebp: c1ad7f2c   esp: c1ad7dc0
> ds: 007b   es: 007b   ss: 0068
> Process kswapd0 (pid: 79, ti=c1ad6000 task=c19e8570 task.ti=c1ad6000)
> Stack: 00000007 00000001 c148c1e0 c15a5c80 c1691b80 c134a800 c1336120 c117c340 
>        c10a5600 00018a8e c10f3040 c10f3040 c0137389 c10f3040 c10f3040 c10f3040 
>        c10f3040 c013764c c1ad7e24 00000001 00000001 0000001c 00000000 c1ad7e1c 
> Call Trace:
>  [<c0137389>] remove_mapping+0x4a/0x5c
>  [<c013764c>] shrink_page_list+0x2b1/0x33d
>  [<c013780c>] shrink_inactive_list+0x78/0x1bb
>  [<c0137071>] shrink_slab+0x61/0x18c
>  [<c013718d>] shrink_slab+0x17d/0x18c
>  [<c0137d37>] shrink_zone+0xa9/0xc6
>  [<c01380f4>] balance_pgdat+0x1b5/0x2c0
>  [<c01382f4>] kswapd+0xf5/0xf9

Looks like either the isolated list of pages got messed up, or the page
flag flipped from !PageLRU when we isolated it, to PageLRU when we check
it again here.

If I'm not mistaken, page->flags should be in eax, which which may point
to the list being messed up rather than a flags bitflip.

Either way I'd say you have some memory corruption problems, whether it
is bad memory or a device/driver problem. Hard to help.

You could try running a 2.6.19-rc2 kernel with CONFIG_DEBUG_LIST and
CONFIG_DEBUG_VM turned on and see if that catches anything.

>   The machine did not halt after this message as it did two weeks ago. I 
> thought at the time that bad RAM was involved so I replaced it; memtest86 
> did not return anything wrong with the new 1Go RAM module.
> 
>   I'm running 2.6.18 vanilla kernel on Debian Sarge, raid-1 software, the 
> swap space is also on raid1.
> 
>   Tell me if you need more informations (or to whom I should address this
> message if linux.kernel is not relevant).

linux.kernel is the right place. Thanks.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
