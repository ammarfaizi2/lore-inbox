Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282882AbRLGQiX>; Fri, 7 Dec 2001 11:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282880AbRLGQiO>; Fri, 7 Dec 2001 11:38:14 -0500
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:50326 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S282902AbRLGQhy>; Fri, 7 Dec 2001 11:37:54 -0500
Date: Fri, 7 Dec 2001 11:40:46 -0500
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Oops on 2.5.1-pre6 doing mkreiserfs on loop device
Message-ID: <20011207114046.A152@earthlink.net>
In-Reply-To: <20011206233759.A173@earthlink.net> <20011207144836.GF12017@suse.de> <20011207145431.GI12017@suse.de> <20011207150058.GJ12017@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011207150058.GJ12017@suse.de>; from axboe@suse.de on Fri, Dec 07, 2001 at 04:00:58PM +0100
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 04:00:58PM +0100, Jens Axboe wrote:
> > argh, that should read 'i' and not '0' of course.
> 
> Updated patch follows.

I got a very similar oops during mkreiserfs /dev/loop0 on this
HIGHMEM machine.

Unable to handle kernel NULL pointer dereference at virtual address 00000018
c012b422
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012b422>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: f7e7241c   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00000000   ebp: f7eaf280   esp: f7631f98
ds: 0018   es: 0018   ss: 0018
Process loop0 (pid: 131, stackpage=f7631000)
Stack: c012e5e5 f7630000 f7eaf2c0 f7651000 00000001 0000000c 00000286 00000000 
00000286 f7eaf280 c0134553 f7eaf2c0 00000008 fac2ec19 f7eaf2c0 00000001 
00000008 f7651000 f7eaf2c0 00000f00 f764ff2c f7651000 c01054e8 f7651000 
Call Trace: [<c012e5e5>] [<c0134553>] [<fac2ec19>] [<c01054e8>] 
Code: 8b 41 18 f6 c4 40 75 11 ff 49 14 0f 94 c0 84 c0 74 07 89 c8 

>>EIP; c012b422 <__free_pages+2/20>   <=====
Trace; c012e5e4 <bounce_end_io_read+144/1a0>
Trace; c0134552 <bio_endio+22/30>
Trace; fac2ec18 <[loop]loop_thread+c8/150>
Trace; c01054e8 <kernel_thread+28/40>
Code;  c012b422 <__free_pages+2/20>
00000000 <_EIP>:
Code;  c012b422 <__free_pages+2/20>   <=====
   0:   8b 41 18                  mov    0x18(%ecx),%eax   <=====
Code;  c012b424 <__free_pages+4/20>
   3:   f6 c4 40                  test   $0x40,%ah
Code;  c012b428 <__free_pages+8/20>
   6:   75 11                     jne    19 <_EIP+0x19> c012b43a <__free_pages+1a/20>
Code;  c012b42a <__free_pages+a/20>
   8:   ff 49 14                  decl   0x14(%ecx)
Code;  c012b42c <__free_pages+c/20>
   b:   0f 94 c0                  sete   %al
Code;  c012b430 <__free_pages+10/20>
   e:   84 c0                     test   %al,%al
Code;  c012b432 <__free_pages+12/20>
  10:   74 07                     je     19 <_EIP+0x19> c012b43a <__free_pages+1a/20>
Code;  c012b434 <__free_pages+14/20>
  12:   89 c8                     mov    %ecx,%eax

I eyeballed the patched source to verify it applied.  I noticed some of the 
lines in the patch have a \ at the end of line.  That may be irrelevant.

> +#define __bio_for_each_segment(bvl, bio, i, start_idx)			\
> +	for (bvl = bio_iovec((bio)), i = (start_idx);			\

Hope this helps.
-- 
Randy Hron

