Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314339AbSECPjV>; Fri, 3 May 2002 11:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314450AbSECPjU>; Fri, 3 May 2002 11:39:20 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:56475 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314339AbSECPjN>; Fri, 3 May 2002 11:39:13 -0400
Date: Fri, 3 May 2002 17:38:59 +0200
From: Andi Kleen <ak@muc.de>
To: dalecki@evision-ventures.com
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: 2.5.13 IDE and preemptible kernel problems
Message-ID: <20020503173859.A1016@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

When booting an preemptible kernel 2.5.13 kernel on x86-64 I get 
very quickly an scheduling in interrupt BUG. It looks like the 
preempt_count becomes 0 inside the ATA interrupt handler. This 
could happen when save_flags/restore_flags and friends are unmatched
and you have too many flags restores in IDE. 

-Andi


No ksyms, skipping lsmod
Kernel BUG at sched.c:759
invalid operand: 0000
CPU 0 
Pid: 0, comm: swapper Not tainted
RIP: 0010:[<ffffffff80118643>]
Using defaults from ksymoops -t elf64-x86-64 -a i386:x86-64
RSP: ffffffff803688d8  EFLAGS: 00010002
RAX: 0000000000000001 RBX: ffffffff8036dfd8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff80368a78 RDI: 0000000000000000
RBP: ffffffff80368908 R08: 000001000197fe98 R09: 000000000000000e
R10: 00000000ffffffff R11: 000000000000000a R12: ffffffff8022c6b0
R13: ffffffff80357590 R14: ffffffff8036df08 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff803649c0(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006a0
Process swapper (pid: 0, stackpage=ffffffff802ece80)
Stack: ffffffff803688d8 0000000000000000 000001000197fd48 000001000197fd90 
       000001000197fd48 ffffffff80368918 ffffffff8036dfd8 ffffffff8022c6b0 
       ffffffff80357590 ffffffff80368928 
Call Trace: [<ffffffff8022c6b0>] [<ffffffff80118a9e>] [<ffffffff8022dc58>] 
       [<ffffffff8022c709>] [<ffffffff8022f0d4>] [<ffffffff80110fef>] 
       [<ffffffff80111255>] [<ffffffff8010ce60>] [<ffffffff8010ce60>] 
       [<ffffffff8010f44e>]  <EOI> [<ffffffff8010ce60>] [<ffffffff8010ce60>] 
       [<ffffffff8010f580>] [<ffffffff8010ce85>] [<ffffffff8010cf1f>] 
Code: 0f 0b 80 56 2a 80 ff ff ff ff f7 02 90 65 48 8b 04 25 08 00 


>>RIP; ffffffff80118643 <schedule+23/450>   <=====

>>RBX; ffffffff8036dfd8 <init_thread_union+1fd8/4000>
>>RSI; ffffffff80368a78 <runqueues+38/1240>
>>RBP; ffffffff80368908 <boot_cpu_stack+3ec8/4000>
>>R08; 000001000197fe98 Before first symbol
>>R10; 00000000ffffffff Before first symbol
>>R12; ffffffff8022c6b0 <task_no_data_intr+0/60>
>>R13; ffffffff80357590 <ide_hwifs+150/5690>
>>R14; ffffffff8036df08 <init_thread_union+1f08/4000>

Trace; ffffffff8022c6b0 <task_no_data_intr+0/60>
Trace; ffffffff80118a9e <preempt_schedule+2e/40>
Trace; ffffffff8022dc58 <ide_end_drive_cmd+1d8/1f0>
Trace; ffffffff8022c709 <task_no_data_intr+59/60>
Trace; ffffffff8022f0d4 <ata_irq_request+f4/190>
Trace; ffffffff80110fef <handle_IRQ_event+3f/80>
Trace; ffffffff80111255 <do_IRQ+c5/160>
Trace; ffffffff8010ce60 <default_idle+0/30>
Trace; ffffffff8010ce60 <default_idle+0/30>
Trace; ffffffff8010f44e <ret_from_intr+0/f>
Trace; ffffffff8010f580 <retint_kernel+38/50>
Trace; ffffffff8010ce85 <default_idle+25/30>
Trace; ffffffff8010cf1f <cpu_idle+1f/40>

Code;  ffffffff80118643 <schedule+23/450>
0000000000000000 <_RIP>:
Code;  ffffffff80118643 <schedule+23/450>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  ffffffff80118645 <schedule+25/450>
   2:   80 56 2a 80               adcb   $0x80,0x2a(%rsi)
Code;  ffffffff80118649 <schedule+29/450>
   6:   ff                        (bad)  
Code;  ffffffff8011864a <schedule+2a/450>
   7:   ff                        (bad)  
Code;  ffffffff8011864b <schedule+2b/450>
   8:   ff                        (bad)  
Code;  ffffffff8011864c <schedule+2c/450>
   9:   ff f7                     pushq  %edi
Code;  ffffffff8011864e <schedule+2e/450>
   b:   02 90 65 48 8b 04         add    0x48b4865(%rax),%dl
Code;  ffffffff80118654 <schedule+34/450>
  11:   25 08 00 00 00            and    $0x8,%eax

 <0>Kernel panic: Aiee, killing interrupt handler!

