Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUHGQAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUHGQAo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 12:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUHGQAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 12:00:44 -0400
Received: from nacho.alt.net ([207.14.113.18]:57256 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S263117AbUHGQAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 12:00:35 -0400
Date: Sat, 7 Aug 2004 09:00:30 -0700 (PDT)
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
In-Reply-To: <20040805225549.GA18420@logos.cnet>
Message-ID: <Pine.LNX.4.44.0408070828240.7317-100000@nacho.alt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Delivery-Agent: TMDA/1.0.2 (Bold Forbes)
From: Chris Caputo <ccaputo@alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2004, Marcelo Tosatti wrote:
> On Wed, Aug 04, 2004 at 02:55:38PM -0700, Chris Caputo wrote:
> > Right now the 3 tests I have running are:
> > 
> >  Intel SDS2 mb / dual-PIII / 3ware / 2.4.26 / irqbalance --oneshot
> >  Intel SDS2 mb / dual-PIII / 3ware / 2.4.27-rc5 / irqbalance ongoing
> >  Intel STL2 mb / dual-PIII / DAC960 / 2.4.26 / irqbalance ongoing

Well, I ended up getting the same crash (report below) with the non-3ware
(STL2 based) server, so I think I can rule the 3ware driver out as being
an instigator.  The STL2 based server took 2 days 14.5 hours to get a
corrupted inode_unused list.

This makes the list of motherboards I have seen the problem on be:

   Intel SE7501HG2 with dual-PIV's, 4 gig of ram
   Intel SDS2 with dual-PIII's, 4 gig of ram
   Intel STL2 with dual-PIII's, 2 gig of ram

At present the 2.4.26 with oneshot irqbalance and the 2.4.27-rc5 with
normal irqbalance are continuing to run without problems.  Coming up on 3
days without issues...  I'll keep them running.

Also, I'll start running 2.4.27-rc5 on a second server (the STL2) with a
normal irqbalance.

> Hum perhaps CONFIG_DEBUG_STACKOVERFLOW? And CONFIG_DEBUG_SLAB? 
> 
> I recall you said you had CONFIG_DEBUG_SLAB set already?

I have been running kernels with both DEBUG_SLAB and DEBUG_STACKOVERFLOW
set.

Marcelo, I take it the 8-proc server is still running fine?

Anyone else out there got a spare P3 or P4 dual-proc machine they can have
run the following repro scenario with 2.4.26 for a week?

Chris

---

Steps to repro:

0) irqbalance running on boot
1) watch -n 1 'cat /proc/sys/fs/inode-nr ; head -n 11 /proc/interrupts ; 
   head /proc/irq/*/*'
3) loop_dbench

started Wed Aug  4 18:56 GMT.
crashed Sat Aug  7 09:25:49 GMT.

---

AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
ALTNET(forward): cur->p == NULL, i=0, inode=0xc6f59004, i_size=0
ALTNET: cur=0xc6f5900c, cur->next=0x00000000, cur->prev=0x00000000
ALTNET: i_hash=0xc6f59004, i_hash->next=0xc2918cd0, 
i_hash->next->prev=0xc6f5900
4, i_hash->prev=0xc2918cd0, i_hash->prev->next=0xc6f59004
ALTNET: inode_lock.lock = 0
kernel BUG at inode.c:154!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0165d3f>]    Not tainted
EFLAGS: 00010282
eax: 0000001c   ebx: c6f5900c   ecx: c031e4f8   edx: 0000001f
esi: c6f59004   edi: 00000000   ebp: f76fff14   esp: f76ffef0
ds: 0018   es: 0018   ss: 0018
Process irqbalance (pid: 1124, stackpage=f76ff000)
Stack: c02e569d 00000000 c2918cd0 c6f59004 c2918cd0 c6f59004 c6f5900c c6f59004
       c283b800 f76fff44 c0168e9e 00000002 c0320a80 f76fff4c c6f59030 c0320e60
       40015000 00000216 f767556c c6f59004 c6f59004 f76fff5c c01637ed c6f59004
Call Trace:    [<c0168e9e>] [<c01637ed>] [<c014c3e7>] [<c0177417>] [<c014a12f>]
  [<c014a208>] [<c0107a5b>]

Code: 0f 0b 9a 00 95 56 2e c0 8b 43 04 e9 ac fa ff ff c7 04 24 37

---

>>EIP; c0165d3f <ALTNET_verify_unused_list+5ef/620>   <=====

>>ecx; c031e4f8 <console_sem+0/18>

Trace; c0168e9e <iput+36e/4d0>
Trace; c01637ed <dput+ed/210>
Trace; c014c3e7 <fput+137/190>
Trace; c0177417 <proc_file_write+37/50>
Trace; c014a12f <filp_close+bf/120>
Trace; c014a208 <sys_close+78/90>
Trace; c0107a5b <system_call+33/38>

Code;  c0165d3f <ALTNET_verify_unused_list+5ef/620>
00000000 <_EIP>:
Code;  c0165d3f <ALTNET_verify_unused_list+5ef/620>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0165d41 <ALTNET_verify_unused_list+5f1/620>
   2:   9a 00 95 56 2e c0 8b      lcall  $0x8bc0,$0x2e569500
Code;  c0165d48 <ALTNET_verify_unused_list+5f8/620>
   9:   43                        inc    %ebx
Code;  c0165d49 <ALTNET_verify_unused_list+5f9/620>
   a:   04 e9                     add    $0xe9,%al
Code;  c0165d4b <ALTNET_verify_unused_list+5fb/620>
   c:   ac                        lods   %ds:(%esi),%al
Code;  c0165d4c <ALTNET_verify_unused_list+5fc/620>
   d:   fa                        cli
Code;  c0165d4d <ALTNET_verify_unused_list+5fd/620>
   e:   ff                        (bad)
Code;  c0165d4e <ALTNET_verify_unused_list+5fe/620>
   f:   ff c7                     inc    %edi
Code;  c0165d50 <ALTNET_verify_unused_list+600/620>
  11:   04 24                     add    $0x24,%al
Code;  c0165d52 <ALTNET_verify_unused_list+602/620>
  13:   37                        aaa

---

Sat Aug  7 09:25:38 GMT 2004
2 clients started
   0     62477  185.37 MB/sec
Throughput 185.368 MB/sec 2 procs
Sat Aug  7 09:25:43 GMT 2004
2 clients started
   0     62477  191.27 MB/sec
Throughput 191.266 MB/sec 2 procs
Sat Aug  7 09:25:48 GMT 2004
2 clients started

---

Every 1s: cat /proc/sys/fs/inode-nr ; head -n 11 /p...  Sat Aug  7 
09:25:49 2004

/proc/sys/fs/inode-nr: 113480  113303

           CPU0       CPU1
  0:   11261584   11262640    IO-APIC-edge  timer
  1:          3         11    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:          6          1    IO-APIC-edge  serial
  8:          2          0    IO-APIC-edge  rtc
 18:    3019678         26   IO-APIC-level  eth0
 20:     607652     716283   IO-APIC-level  Mylex eXtremeRAID 2000
NMI:          0          0
LOC:   22526983   22526974
ERR:          0

==> /proc/irq/0/smp_affinity <==
00000001

==> /proc/irq/1/smp_affinity <==
00000002

==> /proc/irq/10/smp_affinity <==
ffffffff

==> /proc/irq/11/smp_affinity <==
ffffffff

==> /proc/irq/12/smp_affinity <==
ffffffff

==> /proc/irq/13/smp_affinity <==
ffffffff

==> /proc/irq/14/smp_affinity <==
ffffffff

==> /proc/irq/15/smp_affinity <==
ffffffff

==> /proc/irq/18/smp_affinity <==
00000001

==> /proc/irq/2/smp_affinity <==
ffffffff

==> /proc/irq/20/smp_affinity <==
00000002

==> /proc/irq/21/smp_affinity <==
ffffffff

==> /proc/irq/3/smp_affinity <==
ffffffff

==> /proc/irq/4/smp_affinity <==
00000001

==> /proc/irq/5/smp_affinity <==
ffffffff

==> /proc/irq/6/smp_affinity <==
ffffffff

==> /proc/irq/7/smp_affinity <==
ffffffff

==> /proc/irq/8/smp_affinity <==
00000002

==> /proc/irq/9/smp_affinity <==
ffffffff



