Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263733AbUHNPdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUHNPdu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 11:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUHNPdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 11:33:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34468 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263733AbUHNPdl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 11:33:41 -0400
Date: Sat, 14 Aug 2004 11:06:42 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, gene.heskett@verizon.net
Subject: Re: [RFC] HOWTO find oops location
Message-ID: <20040814140642.GB32755@logos.cnet>
References: <200408141153.06625.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408141153.06625.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 11:53:06AM +0300, Denis Vlasenko wrote:
> Hi folks,
> 
> Is this draft HOWTO useful? Comments?
> 
> --- cut here --- --- cut here --- --- cut here --- --- cut here --- 
> 
> Okay, so you've got an oops and want to find out what happened?
> 
> In this HOWTO, I presume you did not delete and did not
> tamper with your kernel build tree. Also, I recommend you
> to enable these options in the .config:
> 
> CONFIG_DEBUG_SLAB=y
> CONFIG_FRAME_POINTER=y
> 
> First one makes use-after-free bug hunt easy, second gives
> you much more reliable stacktraces.
> 
> Ok, let's take a look at example OOPS. ^^^^ marks are mine.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000e14
>  printing eip:
> c0162887
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT
> Modules linked in: eeprom snd_seq_oss snd_seq_midi_event..........
> CPU:    0
> EIP:    0060:[<c0162887>]    Not tainted
> EFLAGS: 00010206   (2.6.7-nf2)
> EIP is at prune_dcache+0x147/0x1c0
>           ^^^^^^^^^^^^^^^^^^^^^^^^
> eax: 00000e00   ebx: d1bde050   ecx: f1b3c050   edx: f1b3ac50
> esi: f1b3ac40   edi: c1973000   ebp: 00000036   esp: c1973ef8
> ds: 007b   es: 007b   ss: 0068
> Process kswapd0 (pid: 65, threadinfo=c1973000 task=c1986050)
> Stack: d7721178 c1973ef8 0000007a 00000000 c1973000 f7ffea48 c0162d1f 0000007a
>        c0139a2b 0000007a 000000d0 00025528 049dbb00 00000000 000001fa 00000000
>        c0364564 00000001 0000000a c0364440 c013add1 00000080 000000d0 00000000
> Call Trace:
>  [<c0162d1f>] shrink_dcache_memory+0x1f/0x30
>  [<c0139a2b>] shrink_slab+0x14b/0x190
>  [<c013add1>] balance_pgdat+0x1b1/0x200
>  [<c013aee7>] kswapd+0xc7/0xe0
>  [<c0114270>] autoremove_wake_function+0x0/0x60
>  [<c0103e9e>] ret_from_fork+0x6/0x14
>  [<c0114270>] autoremove_wake_function+0x0/0x60
>  [<c013ae20>] kswapd+0x0/0xe0
>  [<c01021d1>] kernel_thread_helper+0x5/0x14
> Code: 8b 50 14 85 d2 75 27 89 34 24 e8 4a 2b 00 00 8b 73 0c 89 1c
> 
> Let's try to find out where did that exactly happened.
> Grep in your kernel tree for prune_dcache. Aha, it is defined in
> fs/dcache.c! Ok, execute these two commands:
> 
> # objdump -d fs/dcache.o > fs/dcache.disasm
> # make fs/cache.s
> 
> Now in fs/ you should have:
> 
> dcache.c - source code
> dcache.o - compiled object file
> dcache.s - assembler output of C compiler ('half-compiled' code)
> dcache.disasm - disasembled object file
> 
> Open dcache.disasm and find "prune_dcache":
> 
> 00000540 <prune_dcache>:
>      540:       55                      push   %ebp
> 
> We need to find prune_dcache+0x147. Using shell,
> 
> # printf "0x%x\n" $((0x540+0x147))
> 0x687
> 
> and in dcache.disasm:
> 
>      683:       85 c0                   test   %eax,%eax
>      685:       74 07                   je     68e <prune_dcache+0x14e>
>      687:       8b 50 14                mov    0x14(%eax),%edx    <======== OOPS
>      68a:       85 d2                   test   %edx,%edx
>      68c:       75 27                   jne    6b5 <prune_dcache+0x175>
>      68e:       89 34 24                mov    %esi,(%esp)
>      691:       e8 fc ff ff ff          call   692 <prune_dcache+0x152>
>      696:       8b 73 0c                mov    0xc(%ebx),%esi
>      699:       89 1c 24                mov    %ebx,(%esp)
>      69c:       e8 9f f9 ff ff          call   40 <d_free>
> 
> Comparing with "Code: 8b 50 14 85 d2 75 27 " - match!
> 
> We need to find matching line in dcache.s and, eventually, in dcache.c.
> It's easy to find prune_dcache in dcache.s:
> 
> prune_dcache:
>         pushl   %ebp
> 
> but even though it is not too hard to find matching instruction:
> 
>         movl    8(%edi), %eax
>         decl    20(%edi)
>         testb   $8, %al
>         jne     .L593
> .L517:
>         movl    68(%ebx), %eax
>         testl   %eax, %eax
>         je      .L532
>         movl    20(%eax), %edx  <========= OOPS
>         testl   %edx, %edx
>         jne     .L594
> .L532:
>         movl    %esi, (%esp)
>         call    iput
> .L565:
>         movl    12(%ebx), %esi
>         movl    %ebx, (%esp)
>         call    d_free
> 
> it is unclear to which part of .c code it belongs:
> 
> static void prune_dcache(int count)
> {
>         spin_lock(&dcache_lock);
>         for (; count ; count--) {
>                 struct dentry *dentry;
>                 struct list_head *tmp;
>                 tmp = dentry_unused.prev;
>                 if (tmp == &dentry_unused)
>                         break;
>                 list_del_init(tmp);
>                 prefetch(dentry_unused.prev);
>                 dentry_stat.nr_unused--;
>                 dentry = list_entry(tmp, struct dentry, d_lru);
>                 spin_lock(&dentry->d_lock);
>                 /*
>                  * We found an inuse dentry which was not removed from
>                  * dentry_unused because of laziness during lookup.  Do not free
>                  * it - just keep it off the dentry_unused list.
>                  */
>                 if (atomic_read(&dentry->d_count)) {
>                         spin_unlock(&dentry->d_lock);
>                         continue;
>                 }
>                 /* If the dentry was recently referenced, don't free it. */
>                 if (dentry->d_flags & DCACHE_REFERENCED) {
>                         dentry->d_flags &= ~DCACHE_REFERENCED;
>                         list_add(&dentry->d_lru, &dentry_unused);
>                         dentry_stat.nr_unused++;
>                         spin_unlock(&dentry->d_lock);
>                         continue;
>                 }
>                 prune_one_dentry(dentry);
>         }
>         spin_unlock(&dcache_lock);
> }
> 
> What now?! Well, I have a silly method which helps to find
> C code line corresponding to that asm one. Edit your
> prune_dcache in dcache.c like this:
> 
> static void prune_dcache(int count)
> {
>         spin_lock(&dcache_lock);
>         for (; count ; count--) {
>                 struct dentry *dentry;
>                 struct list_head *tmp;
> asm("#1");
>                 tmp = dentry_unused.prev;
> asm("#2");
>                 if (tmp == &dentry_unused)
>                         break;
> asm("#3");
>                 list_del_init(tmp);
> asm("#4");
>                 prefetch(dentry_unused.prev);
> asm("#5");
>                 dentry_stat.nr_unused--;
> asm("#6");
> ...
> ...
> asm("#e");
>                 prune_one_dentry(dentry);
>         }
> asm("#f");
>         spin_unlock(&dcache_lock);
> }

Might be also worth mentioning "gcc -c file.c -g -Wa,-a,-ad  > file.s"
which makes gcc output C code mixed with asm output. 

Sometimes its not as effective as the comment method you describe, 
but it will be less work for sure :)

The document looks great, but could go deeper into things 
like like hardware-flaky bitflips, stack junk (explain why
the stack can be "unreliable"), etc. to be even more
useful. 

Hosting it somewhere would be nice also.
