Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265872AbUHAQzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265872AbUHAQzi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 12:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUHAQzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 12:55:37 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:63184 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S265872AbUHAQz3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 12:55:29 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: 2.6.8-rc2 crash(s)?
Date: Sun, 1 Aug 2004 12:55:26 -0400
User-Agent: KMail/1.6.82
References: <200407242156.40726.gene.heskett@verizon.net> <200408010809.28311.gene.heskett@verizon.net> <200408011858.13610.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200408011858.13610.vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408011255.27018.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [141.153.91.21] at Sun, 1 Aug 2004 11:55:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 August 2004 11:58, Denis Vlasenko wrote:
>On Sunday 01 August 2004 15:09, Gene Heskett wrote:
>> >But I digress. OOPS happened in dentry_iput(), which is
>> > (surprise!) an inline function:
>
This looks as if its as far as we can get Denis, so I'm
just going to post the whole thing to lkml, after snipping
the last Opps out of what is now last weeks log (its
sunday, and so far this log is clean) and inserting it also.

Many thanks for all your help, Denis.  I've learned a bit
about troubleshooting things like this.

To the lkml:  I can supply the dcache.txt objdumps, and the
dcache-w-nops.s files to whomever requests them so that they
can draw their own conclusions.  My uptimes here are generally
less than 24 hours because of this Oops.

>> >You need to do more of asm()ing.

>> Ok, I now have them attached.  I did add a pair of curlies to
>> contain another example of the H syndrome.
[...]
>asm("nop #O");
>                if (dentry->d_op && dentry->d_op->d_iput)
>                    ^^^^^^^^^^^^    ^^^^^^^^^^^^^^^^^^^^
>{
>asm("nop #P");
>                        dentry->d_op->d_iput(dentry, inode);
>                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>}
>                else
>{
>asm("nop #Q");
>                        iput(inode);
>asm("nop #R");
>
[... to the objdump]
>
>        nop #O
>        movl    68(%ebx), %eax
>        testl   %eax, %eax <--- this is dentry->d_op. %eax ==
> 00000e00 here. this is bad. pointer can't have such a value
>        je      .L532
>        movl    20(%eax), %edx   <=== it tries to fetch
>				dentry->d_op->d_iput
>				at 00000e20, which is bogus address. OOPS
>        testl   %edx, %edx
>        jne     .L594      <--*
>.L532:
>        nop #Q
>        movl    %esi, (%esp)
>        call    iput
>        nop #R
>.L565:
>        nop #E
>        movl    12(%ebx), %esi
>        nop #F
>        movl    %ebx, (%esp)
>        call    d_free
>        nop #G
>        cmpl    %ebx, %esi
>        je      .L566
>        movl    %esi, (%esp)
>        call    dput
>.L566:
>        nop #I
>        incl    20(%edi)
>        nop #J
>        jmp     .L445
>.L594:                     <--*
>        nop #P
>        movl    %ebx, (%esp)
>        movl    %esi, 4(%esp)
>        call    *20(%eax)   <---- calls dentry->d_op->d_iput(dentry,
> inode) (just checking that I indeed properly matched C to asm) jmp 
>    .L565
>.L593:
>
>Where that dentry came from?
>
>void prune_dcache(int count)
>{
>        for (; count ; count--) {
>                struct dentry *dentry;
>                struct list_head *tmp;
>                tmp = dentry_unused.prev;
>                if (tmp == &dentry_unused) break;
>                list_del_init(tmp);
>                dentry_stat.nr_unused--;
>                dentry = list_entry(tmp, struct dentry, d_lru);
>                /*
>                 * We found an inuse dentry which was not removed
> from * dentry_unused because of laziness during lookup.  Do not
> free * it - just keep it off the dentry_unused list. */
>                if (atomic_read(&dentry->d_count)) continue;
>                }
>                /* If the dentry was recently referenced, don't free
> it. */ if (dentry->d_flags & DCACHE_REFERENCED) {
>			...
>                        continue;
>                }
>                prune_one_dentry(dentry);
>		...
>
>prune_one_dentry(dentry) {
>	...
>        dentry_iput(dentry)
>	...
>}
>
>Heh. I don't know where to go now. At least we can post complete
>bug report on lkml.
>
>You can trace other oopses in a similar way. Maybe there is some
>patterm in them.

This 'pattern' has been pretty consistent, and even attacks kernels
as late as 2.6.8-rc2, with the difference being that from 2.6.7-mm1
on, the Oops is 99% fatal to the machine, as in a total lockup,
reset or power switch to recover.  With 2.6.7, the worst its done
(generally, there have been exceptions) is to screw up the reboot,
eventually needing the reset switch about 5% of the time to get
back to post & get rebooting under way.

Without further prattle, The Oops, from yesterday afternoon:
-------------
Jul 31 13:55:12 coyote kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000e14
Jul 31 13:55:12 coyote kernel:  printing eip:
Jul 31 13:55:12 coyote kernel: c0162887
Jul 31 13:55:12 coyote kernel: *pde = 00000000
Jul 31 13:55:12 coyote kernel: Oops: 0000 [#1]
Jul 31 13:55:12 coyote kernel: PREEMPT
Jul 31 13:55:12 coyote kernel: Modules linked in: eeprom snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd
_bt87x snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd forcedeth
sg
Jul 31 13:55:12 coyote kernel: CPU:    0
Jul 31 13:55:12 coyote kernel: EIP:    0060:[<c0162887>]    Not tainted
Jul 31 13:55:12 coyote kernel: EFLAGS: 00010206   (2.6.7-nf2)
Jul 31 13:55:12 coyote kernel: EIP is at prune_dcache+0x147/0x1c0
Jul 31 13:55:12 coyote kernel: eax: 00000e00   ebx: d1bde050   ecx: f1b3c050   edx: f1b3ac50
Jul 31 13:55:12 coyote kernel: esi: f1b3ac40   edi: c1973000   ebp: 00000036   esp: c1973ef8
Jul 31 13:55:12 coyote kernel: ds: 007b   es: 007b   ss: 0068
Jul 31 13:55:12 coyote kernel: Process kswapd0 (pid: 65, threadinfo=c1973000 task=c1986050)
Jul 31 13:55:12 coyote kernel: Stack: d7721178 c1973ef8 0000007a 00000000 c1973000 f7ffea48 c0162d1f 0000007a
Jul 31 13:55:12 coyote kernel:        c0139a2b 0000007a 000000d0 00025528 049dbb00 00000000 000001fa 00000000
Jul 31 13:55:12 coyote kernel:        c0364564 00000001 0000000a c0364440 c013add1 00000080 000000d0 00000000
Jul 31 13:55:12 coyote kernel: Call Trace:
Jul 31 13:55:12 coyote kernel:  [<c0162d1f>] shrink_dcache_memory+0x1f/0x30
Jul 31 13:55:12 coyote kernel:  [<c0139a2b>] shrink_slab+0x14b/0x190
Jul 31 13:55:12 coyote kernel:  [<c013add1>] balance_pgdat+0x1b1/0x200
Jul 31 13:55:12 coyote kernel:  [<c013aee7>] kswapd+0xc7/0xe0
Jul 31 13:55:12 coyote kernel:  [<c0114270>] autoremove_wake_function+0x0/0x60
Jul 31 13:55:12 coyote kernel:  [<c0103e9e>] ret_from_fork+0x6/0x14
Jul 31 13:55:12 coyote kernel:  [<c0114270>] autoremove_wake_function+0x0/0x60
Jul 31 13:55:12 coyote kernel:  [<c013ae20>] kswapd+0x0/0xe0
Jul 31 13:55:12 coyote kernel:  [<c01021d1>] kernel_thread_helper+0x5/0x14
Jul 31 13:55:12 coyote kernel:
Jul 31 13:55:12 coyote kernel: Code: 8b 50 14 85 d2 75 27 89 34 24 e8 4a 2b 00 00 8b 73 0c 89 1c
------------------------

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
