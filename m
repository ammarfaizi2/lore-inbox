Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312134AbSDXNY4>; Wed, 24 Apr 2002 09:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312194AbSDXNYz>; Wed, 24 Apr 2002 09:24:55 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:28126 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S312134AbSDXNYy>; Wed, 24 Apr 2002 09:24:54 -0400
Date: Wed, 24 Apr 2002 09:30:21 -0400
To: dalecki@evision-ventures.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.9 -- OOPS in IDE code (symbolic dump and boot log included)
Message-ID: <20020424093021.A21652@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Oops on 2.5.9 at boot time.

> Could you please introduce two printk("BANG\n") printk("BOOM\n")
> aroung the ata_ar_get() in ide-cd? Just to see whatever the
> command queue is already up and initialized.

This may not be what you wanted:

	printk("BANG\n");
        ar = ata_ar_get(drive);
        printk("BOOM\n");

If it is, neither BANG nor BOOM printed before oops.

I see Melchior may have narrowed down the code path in 
this thread.  

2.5.10 gives very similar oops to 2.5.9:

Unable to handle kernel NULL pointer dereference at virtual address 00000004
c01bf7f6
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01bf7f6>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000004   ebx: d7f61eb4   ecx: 00000001   edx: 00000000
esi: d7f61e30   edi: c02c8b6c   ebp: 00000292   esp: c026bedc
ds: 0018   es: 0018   ss: 0018
Stack: d7f61e30 00000001 c02c8b6c 00000003 00000001 c01c311b c02c8b6c 00000001
       00000000 c01c9c52 c02c8b6c 00000001 00000018 d7f61eb4 d7f61e30 c01ca983
       c02c8b6c 00000001 00000000 c02c8b6c d7f622c0 c02c8840 c02c8f0c d7f62380
Call Trace: [<c01c311b>] [<c01c9c52>] [<c01ca983>] [<c01c13ba>] [<c01ca8bc>]
   [<c01080fc>] [<c0108262>] [<c0105000>] [<c0106eff>] [<c0105240>] [<c0105000>]
   [<c0105263>] [<c01052d4>] [<c0105019>]
Code: c7 04 02 00 00 00 00 8b 53 0c 8b 87 34 02 00 00 0f b3 10 8b


>>EIP; c01bf7f6 <__ide_end_request+fe/140>   <=====

>>ebx; d7f61eb4 <END_OF_CODE+17c930f8/????>
>>esi; d7f61e30 <END_OF_CODE+17c93074/????>
>>edi; c02c8b6c <ide_hwifs+32c/3a70>
>>esp; c026bedc <init_thread_union+1edc/2000>

Trace; c01c311b <ide_end_request+f/14>
Trace; c01c9c52 <cdrom_end_request+42/4c>
Trace; c01ca983 <cdrom_pc_intr+c7/1d0>
Trace; c01c13ba <ide_intr+c6/13c>
Trace; c01ca8bc <cdrom_pc_intr+0/1d0>
Trace; c01080fc <handle_IRQ_event+30/5c>
Trace; c0108262 <do_IRQ+6a/a8>
Trace; c0105000 <_stext+0/0>
Trace; c0106eff <common_interrupt+1f/30>
Trace; c0105240 <default_idle+0/28>
Trace; c0105000 <_stext+0/0>
Trace; c0105263 <default_idle+23/28>
Trace; c01052d4 <cpu_idle+28/38>
Trace; c0105019 <rest_init+19/1c>

Code;  c01bf7f6 <__ide_end_request+fe/140>
00000000 <_EIP>:
Code;  c01bf7f6 <__ide_end_request+fe/140>   <=====
   0:   c7 04 02 00 00 00 00      movl   $0x0,(%edx,%eax,1)   <=====
Code;  c01bf7fd <__ide_end_request+105/140>
   7:   8b 53 0c                  mov    0xc(%ebx),%edx
Code;  c01bf800 <__ide_end_request+108/140>
   a:   8b 87 34 02 00 00         mov    0x234(%edi),%eax
Code;  c01bf806 <__ide_end_request+10e/140>
  10:   0f b3 10                  btr    %edx,(%eax)
Code;  c01bf809 <__ide_end_request+111/140>
  13:   8b 00                     mov    (%eax),%eax

 <0>Kernel panic: Aiee, killing interrupt handler!


-- 
Randy Hron

