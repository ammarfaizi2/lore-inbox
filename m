Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267303AbUHDPjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267303AbUHDPjQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 11:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267311AbUHDPjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 11:39:16 -0400
Received: from nacho.alt.net ([207.14.113.18]:14980 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S267303AbUHDPi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 11:38:58 -0400
Date: Wed, 4 Aug 2004 08:38:53 -0700 (PDT)
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Arjan van de Ven <arjanv@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
In-Reply-To: <20040729162354.GA26891@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0408040805180.1636-100000@nacho.alt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Delivery-Agent: TMDA/1.0.2 (Bold Forbes)
From: Chris Caputo <ccaputo@alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2004, Arjan van de Ven wrote:
> On Thu, Jul 29, 2004 at 09:22:40AM -0700, Chris Caputo wrote:
> > Should I try the run-once/oneshot feature of irqbalance on boot, and then
> > leave it off and see if anything happens?
> 
> that sounds like a good test
> 
> it really smells that a certain distribution of irq's is causing you grief
> more than the actual changing...

Here is my latest repro.  Turns out writer2 is not needed Marcelo, so feel
free to skip those.

I'll now try to get a crash with just a one-shot irqbalance.  The below
was with the unmodified 0.08 irqbalance (affinity changes possible once
every 10 seconds).

Arjan, the irq affinities and /proc/interrupts output near the time of the
crash are at the bottom of this email.  It is unknown whether these were
the exact affinities when the list corruption happened or not, since the
watch command was only running once per second.

One thing to note below is that even though dbench was doing a ton of
filesystem activity at the time of the crash, the process which invoked
the system call which resulted in the iput() was irqbalance.  I don't
always see irqbalance in the call trace when these crashes happen, but it
is pretty common, like about 75% of the time.

Repro method:

-1) 2.4.26 kernel
0) start irqbalance
1) watch -n 1 'cat /proc/sys/fs/inode-nr ; head -n 11 /proc/interrupts ;
   head /proc/irq/*/*'
2) run loop_dbench, which is the following dbench script which uses 
   client_plain.txt:

   #!/bin/sh

   while [ 1 ]
   do
        date
        dbench 2
   done

3) Wait.

Results:

started 1:04am on Sunday August 1st
crashed 4:28am on Tuesday August 3rd

(If anyone else has spare SMP machines they can try the above with on
2.4.26, that would be great.)

---

Here is the crash dump.  The ALTNET lines are from extra code in inode.c
which scans the inode_unused list up to 10 items in each direction to
determine if the list is valid.  It is called before and after
list_del/list_add pairs in inode.c.  (If you would like the patch for
this, let me know.)

The i=0 below indicates this is the first item tested off from the head of
the inode_unused list.  Basically inode_unused->next points to an item 
whose next and prev pointers are NULL.

AAAAAAAAAAAAAAAAAAAAAA
ALTNET(forward): cur->p == NULL, i=0, inode=0xecc83804, i_size=0
ALTNET: cur=0xecc8380c, cur->next=0x00000000, cur->prev=0x00000000
ALTNET: i_hash=0xecc83804,
i_hash->next=0xf7de8188, i_hash->next->prev=0xecc83804,
i_hash->prev=0xf7de8188, i_hash->prev->next=0xecc83804
ALTNET: inode_lock.lock = 0
kernel BUG at inode.c:154!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c016657f>]    Not tainted
EFLAGS: 00010282
eax: 0000001c   ebx: ecc8380c   ecx: c03393f8   edx: 0000001f
esi: ecc83804   edi: 00000000   ebp: e72abf14   esp: e72abef0
ds: 0018   es: 0018   ss: 0018
Process irqbalance (pid: 9177, stackpage=e72ab000)
Stack: c02f00a1 00000000 f7de8188 ecc83804 f7de8188 ecc83804 ecc8380c ecc83804
       c3f7b800 e72abf44 c01696de 00000002 c033b980 e72abf4c ecc83830 c033bd60
       40015000 00000216 c625d3ec ecc83804 ecc83804 e72abf5c c0163e91 ecc83804
Call Trace:    [<c01696de>] [<c0163e91>] [<c014c957>] [<c0177db7>] [<c014a66f>]
  [<c014a748>] [<c0107a9f>]

Code: 0f 0b 9a 00 99 00 2f c0 8b 43 04 e9 ac fa ff ff c7 04 24 67

---

>>EIP; c016657f <ALTNET_verify_unused_list+5ef/620>   <=====

>>ebx; ecc8380c <_end+2c8a9540/38618d94>
>>ecx; c03393f8 <console_sem+0/18>
>>esi; ecc83804 <_end+2c8a9538/38618d94>
>>ebp; e72abf14 <_end+26ed1c48/38618d94>
>>esp; e72abef0 <_end+26ed1c24/38618d94>

Trace; c01696de <iput+36e/4d0>
Trace; c0163e91 <dput+f1/230>
Trace; c014c957 <fput+137/190>
Trace; c0177db7 <proc_file_write+37/50>
Trace; c014a66f <filp_close+bf/120>
Trace; c014a748 <sys_close+78/90>
Trace; c0107a9f <system_call+33/38>

Code;  c016657f <ALTNET_verify_unused_list+5ef/620>
00000000 <_EIP>:
Code;  c016657f <ALTNET_verify_unused_list+5ef/620>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0166581 <ALTNET_verify_unused_list+5f1/620>
   2:   9a 00 99 00 2f c0 8b      lcall  $0x8bc0,$0x2f009900
Code;  c0166588 <ALTNET_verify_unused_list+5f8/620>
   9:   43                        inc    %ebx
Code;  c0166589 <ALTNET_verify_unused_list+5f9/620>
   a:   04 e9                     add    $0xe9,%al
Code;  c016658b <ALTNET_verify_unused_list+5fb/620>
   c:   ac                        lods   %ds:(%esi),%al
Code;  c016658c <ALTNET_verify_unused_list+5fc/620>
   d:   fa                        cli
Code;  c016658d <ALTNET_verify_unused_list+5fd/620>
   e:   ff                        (bad)
Code;  c016658e <ALTNET_verify_unused_list+5fe/620>
   f:   ff c7                     inc    %edi
Code;  c0166590 <ALTNET_verify_unused_list+600/620>
  11:   04 24                     add    $0x24,%al
Code;  c0166592 <ALTNET_verify_unused_list+602/620>
  13:   67 00 00                  addr16 add %al,(%bx,%si)

---

Current output of the loop_dbench script at the time of the crash:

Tue Aug  3 04:27:03 GMT 2004
2 clients started
   0     62477  41.81 MB/secc
Throughput 41.8089 MB/sec 2 procs
Tue Aug  3 04:27:21 GMT 2004
2 clients started
   0     62477  9.35 MB/secc
Throughput 9.35182 MB/sec 2 procs
Tue Aug  3 04:28:36 GMT 2004
2 clients started
   0     62477  61.05 MB/secc
Throughput 61.0461 MB/sec 2 procs
Tue Aug  3 04:28:48 GMT 2004

---

Current output of the "watch" command at the time of the crash:

Every 1s: cat /proc/sys/fs/inode-nr ; head -n 11 /p...  Tue Aug  3 
04:28:49 2004

/proc/sys/fs/inode-nr: 122465  105275

           CPU0       CPU1
  0:   47299923   50226384    IO-APIC-edge  timer
  1:         11          7    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:          1          6    IO-APIC-edge  serial
  8:          0          2    IO-APIC-edge  rtc
 14:          1          4    IO-APIC-edge  ide0
 18:    1801274     370200   IO-APIC-level  eth0
 19:     938177    1120685   IO-APIC-level  eth1
 21:   10833570   10778863   IO-APIC-level  3ware Storage Controller
 25:    2677989    3054823   IO-APIC-level  3ware Storage Controller

==> /proc/irq/0/smp_affinity <==
00000002

==> /proc/irq/1/smp_affinity <==
00000001

==> /proc/irq/10/smp_affinity <==
ffffffff

==> /proc/irq/11/smp_affinity <==
ffffffff

==> /proc/irq/12/smp_affinity <==
ffffffff

==> /proc/irq/13/smp_affinity <==
ffffffff

==> /proc/irq/14/smp_affinity <==
00000001

==> /proc/irq/15/smp_affinity <==
ffffffff

==> /proc/irq/18/smp_affinity <==
00000001

==> /proc/irq/19/smp_affinity <==
00000002

==> /proc/irq/2/smp_affinity <==
ffffffff

==> /proc/irq/21/smp_affinity <==
00000001

==> /proc/irq/24/smp_affinity <==
ffffffff

==> /proc/irq/25/smp_affinity <==
00000001

==> /proc/irq/3/smp_affinity <==
ffffffff

==> /proc/irq/4/smp_affinity <==
00000002

==> /proc/irq/5/smp_affinity <==
ffffffff

==> /proc/irq/6/smp_affinity <==
ffffffff

==> /proc/irq/7/smp_affinity <==
ffffffff

==> /proc/irq/8/smp_affinity <==
00000001

==> /proc/irq/9/smp_affinity <==
ffffffff

Chris

