Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbTIWQnU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 12:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbTIWQnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 12:43:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:54169 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261641AbTIWQnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 12:43:15 -0400
Date: Tue, 23 Sep 2003 09:36:07 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Sebastian Piecha" <spi@gmxpro.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to understand an oops?
Message-Id: <20030923093607.54335f4c.rddunlap@osdl.org>
In-Reply-To: <3F703FAE.32215.13B8E21F@localhost>
References: <3F703FAE.32215.13B8E21F@localhost>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003 12:42:22 +0200 "Sebastian Piecha" <spi@gmxpro.de> wrote:

| Hello,
| 
| using samba 2.2.8a with kernel 2.4.20 or 2.4.23pre1 ends in an oops. 
| In several mailings to the lkml I tried to get help but unfortunately 
| nobody did answer me.

You would probably get more linux-networking help on
linux-net@vger.kernel.org or
netdev@oss.sgi.com

| I'm trying to interpret all the oopses myself. I reproduced the 
| kernel panic in different configurations - with or without LVM or 
| RAID. What all oopses do have common is the "Code" section. 
| skb_drop_fraglist is listed herein. skb_drop_fraglist is defined in 
| net/core/skbuff.c.

Yes, and that's the only source file where it is used.

| Does the code section mean that the kernel panic occurred during 
| execution of this code?

Yes.
Are there a few informative lines missing before the Oops: line below?

| How likely is it that a bug in net/core/skbuff.c is causing the 
| kernel panic?

Dunno.  It's trying to access memory at (%ebx) == 00200000.
That could be a single-bit error in memory which was supposed to be
0, which would have terminated the while loop in skb_drop_fraglist().

The common suggestion based on this would be to run memtest86
(or memtst86 ?) overnight to check for memory errors.

| How can I find other code/modules from which skb_drop_fraglist is 
| called and used?

Use grep (or cscope, but that would be overkill in this case).
I found it only in net/core/skbuff.c.

| What is the best way interpreting such an oops?
| 
| ################## oops #####################
| Oops: 0000
| CPU:    0
| EIP:    0010:[<c0219cd7>]    Not tainted
| Using defaults from ksymoops -t elf32-i386 -a i386
| EFLAGS: 00010206
| eax: c40866a0   ebx: 00200000   ecx: c40866a0   edx: 00200000
| esi: cec57360   edi: fffffff9   ebp: 00000046   esp: c0303f2c
| ds: 0018   es: 0018   ss: 0018
| Process swapper (pid: 0, stackpage=c0303000)
| Stack: cec57360 c0219d6e cec57360 cec57360 cec57360 c0219dab cec57360 
| cec57360
|        c0219efc cec57360 cf49cb20 c021e173 cec57360 00000003 c032c568 
| c0120629
|        c032c568 00000006 0000000e c0303f98 d3e02e40 c010a091 c0106f40 
| c0302000
| Call Trace:    [<c0219d6e>] [<c0219dab>] [<c0219efc>] [<c021e173>] 
| [<c0120629>]
|   [<c010a091>] [<c0106f40>] [<c010c4e8>] [<c0106f40>] [<c0106f64>] 
| [<c0106fd2>]
|   [<c0105000>]
| Code: 8b 1b 8b 42 74 48 74 0a ff 4a 74 0f 94 c0 84 c0 74 07 52 e8
| 
| 
| >>EIP; c0219cd7 <skb_drop_fraglist+17/40>   <=====
                   ^^^^^^^^^^^^^^^^^^^^^^^
This is the faulting code location.

| >>eax; c40866a0 <_end+3cf81fc/14e64bbc>
| >>ecx; c40866a0 <_end+3cf81fc/14e64bbc>
| >>esi; cec57360 <_end+e8c8ebc/14e64bbc>
| >>esp; c0303f2c <init_task_union+1f2c/2000>

This is the call stack.  skb_drop_fraglist() was called from here:
                   vvvvvvvvvvvvvvvvvvvvvv
| Trace; c0219d6e <skb_release_data+4e/80>
| Trace; c0219dab <kfree_skbmem+b/70>
| Trace; c0219efc <__kfree_skb+ec/150>
| Trace; c021e173 <net_tx_action+33/a0>
| Trace; c0120629 <do_softirq+99/a0>
| Trace; c010a091 <do_IRQ+a1/b0>
| Trace; c0106f40 <default_idle+0/30>
| Trace; c010c4e8 <call_do_IRQ+5/d>
| Trace; c0106f40 <default_idle+0/30>
| Trace; c0106f64 <default_idle+24/30>
| Trace; c0106fd2 <cpu_idle+42/60>
| Trace; c0105000 <_stext+0/0>
| 
| Code;  c0219cd7 <skb_drop_fraglist+17/40>
| 00000000 <_EIP>:
| Code;  c0219cd7 <skb_drop_fraglist+17/40>   <=====
|    0:   8b 1b                     mov    (%ebx),%ebx   <=====
                                    ^^^^^^^^^^^^^^^^^^
This is the faulting instruction.  Accessing memory at (%ebx) == 00200000.

| Code;  c0219cd9 <skb_drop_fraglist+19/40>
|    2:   8b 42 74                  mov    0x74(%edx),%eax
| Code;  c0219cdc <skb_drop_fraglist+1c/40>
|    5:   48                        dec    %eax
| Code;  c0219cdd <skb_drop_fraglist+1d/40>
|    6:   74 0a                     je     12 <_EIP+0x12>
| Code;  c0219cdf <skb_drop_fraglist+1f/40>
|    8:   ff 4a 74                  decl   0x74(%edx)
| Code;  c0219ce2 <skb_drop_fraglist+22/40>
|    b:   0f 94 c0                  sete   %al
| Code;  c0219ce5 <skb_drop_fraglist+25/40>
|    e:   84 c0                     test   %al,%al
| Code;  c0219ce7 <skb_drop_fraglist+27/40>
|   10:   74 07                     je     19 <_EIP+0x19>
| Code;  c0219ce9 <skb_drop_fraglist+29/40>
|   12:   52                        push   %edx
| Code;  c0219cea <skb_drop_fraglist+2a/40>
|   13:   e8 00 00 00 00            call   18 <_EIP+0x18>
| 
|  <0>Kernel panic: Aiee, killing interrupt handler!
| #################################

HTH.
--
~Randy
