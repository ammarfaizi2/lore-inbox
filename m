Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136174AbRECHvT>; Thu, 3 May 2001 03:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136176AbRECHvK>; Thu, 3 May 2001 03:51:10 -0400
Received: from rhlx01.fht-esslingen.de ([134.108.34.10]:27065 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id <S136174AbRECHvD>; Thu, 3 May 2001 03:51:03 -0400
Date: Thu, 3 May 2001 09:51:01 +0200
From: Andreas Mohr <a.mohr@mailto.de>
To: linux-kernel@vger.kernel.org
Subject: OOPS: PPA ZIP 2.4.3 (semi-debugged)
Message-ID: <20010503095101.A23907@rhlx01.fht-esslingen.de>
Reply-To: andi@rhlx01.fht-esslingen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[resent because it didn't turn up in my mail *after* successfully
having subscribed to lk and another mail of mine already turned up in archive]

Hi,

I'm (still) getting a reproducible crash with PPA ZIP on my
Dell Inspiron 5000e notebook.
AFAIR I already noticed an OOPS upon module removal with disconnected
drive a looong time ago when using 2.2.x.

System: Debian Unstable, stock 2.4.3 kernel, gcc 2.95.3 (problem !!?)

Steps to reproduce:
1. mount zip
2. unmount zip
3. unplug zip with ppa module etc. still loaded
3. close the lid -> APM Suspend-To-RAM
4. resume -> printk("ppa: Parallel port cable is unplugged!!\n");
5. to get rid of this annoying message, I naively tried a rmmod ppa -> OOPS


Unable to handle kernel paging request at virtual address 0xd0a0f434
ip c018bc74 batch_entropy_store()+0x90
ax 00000046 bx 00000c47 cx 0000004e dx d0a0f434
si c027bd80 di b737a624 bp 0000009f sp c575bbd8

Process rmmod
Trace:
add_timer_randomness+0xcb
add_keyboard_randomness+0x22
handle_scancode+0x64
handle_kbd_event+0x111
keyboard_interrupt+0xf
handle_IRQ_event+0x2f
do_IRQ+0x6e
ret_from_intr
panic+0xd0
__switch_to+0xb
die+0x42
do_page_fault+0x323
do_page_fault
load_elf_binary+0x907
load_elf_binary
bread+0x18
do_signal+0xe0
d0a0f434
free_initmem+0x6c
__run_task_queue+0x12
do_timer+0x23
tqueue_bh+0x16
number+0x254
unmap_underlying_metadata+0x18
vsprintf+0x2e
d09c1310
.
.
.

(int handler killed)


Simple analysis of crashing function:

%esp+4 = a
%esp+8 = b
%esp+c = num
0xc027bd64 = batch_head
0xc027bd58 = batch_entropy_pool
0xc027bd5c = batch_entropy_credit
0xc027bd60 = batch_max


void batch_entropy_store(u32 a, u32 b, int num)
{
        int     new;

0xc018bbe4:
        if (!batch_max)
                return;

0xc018bbf1:
        batch_entropy_pool[2*batch_head] = a;

0xc018bc04:
        batch_entropy_pool[(2*batch_head) + 1] = b;

0xc018bc18:
        batch_entropy_credit[batch_head] = num;

0xc018bc2b:
        new = (batch_head+1) & (batch_max-1);

0xc018bc3a:
        if (new != batch_tail) {

0xc018bc42:
                queue_task(&batch_tqueue, &tq_timer);
                batch_head = new;
        } else {
#if 0
                printk(KERN_NOTICE "random: batch entropy buffer full\n");
#endif
        }
}

Complicated (i.e.: better) analysis of crashing function ;-) :

This contains the whole assembler dump, indented to reflect call depth,
comments with C code, etc.

Dump of assembler code for function batch_entropy_store:
if (!batch_max) return;:
0xc018bbe4 <batch_entropy_store>:       cmpl   $0x0,0xc027bd60
0xc018bbeb <batch_entropy_store+7>:
    je     0xc018bc86 <batch_entropy_store+162>

batch_entropy_pool[2*batch_head] = a;:
0xc018bbf1 <batch_entropy_store+13>:    mov    0xc027bd64,%ecx
0xc018bbf7 <batch_entropy_store+19>:    mov    0xc027bd58,%edx
0xc018bbfd <batch_entropy_store+25>:    mov    0x4(%esp,1),%eax
0xc018bc01 <batch_entropy_store+29>:    mov    %eax,(%edx,%ecx,8)

batch_entropy_pool[(2*batch_head) + 1] = b;:
0xc018bc04 <batch_entropy_store+32>:    mov    0xc027bd64,%ecx
0xc018bc0a <batch_entropy_store+38>:    mov    0xc027bd58,%edx
0xc018bc10 <batch_entropy_store+44>:    mov    0x8(%esp,1),%eax
0xc018bc14 <batch_entropy_store+48>:    mov    %eax,0x4(%edx,%ecx,8)

batch_entropy_credit[batch_head] = num;:
0xc018bc18 <batch_entropy_store+52>:    mov    0xc027bd64,%ecx
0xc018bc1e <batch_entropy_store+58>:    mov    0xc027bd5c,%edx
0xc018bc24 <batch_entropy_store+64>:    mov    0xc(%esp,1),%eax
0xc018bc28 <batch_entropy_store+68>:    mov    %eax,(%edx,%ecx,4)

new = (batch_head+1) & (batch_max-1);:
0xc018bc2b <batch_entropy_store+71>:    mov    0xc027bd64 [batch_head],%ecx
0xc018bc31 <batch_entropy_store+77>:    mov    0xc027bd60 [batch_max],%eax
0xc018bc36 <batch_entropy_store+82>:    inc    %ecx
0xc018bc37 <batch_entropy_store+83>:    dec    %eax
0xc018bc38 <batch_entropy_store+84>:    and    %eax,%ecx

if (new != batch_tail) {:
0xc018bc3a <batch_entropy_store+86>:    cmp    0xc027bd68 [batch_tail],%ecx
0xc018bc40 <batch_entropy_store+92>:
    je     0xc018bc86 <batch_entropy_store+162>

queue_task(&batch_tqueue, &tq_timer);:
 0xc018bc42 <batch_entropy_store+94>:    xor    %eax,%eax
 0xc018bc44 <batch_entropy_store+96>:    bts    %eax,0xc027bd74 [&batch_tqueue->sync]
 0xc018bc4b <batch_entropy_store+103>:   sbb    %eax,%eax
 0xc018bc4d <batch_entropy_store+105>:   test   %eax,%eax
 0xc018bc4f <batch_entropy_store+107>:
     jne    0xc018bc80 <batch_entropy_store+156>

 spin_lock_irqsave(&tqueue_lock, flags);:
  local_irq_save(flags);:
   0xc018bc51 <batch_entropy_store+109>:   pushf
   0xc018bc52 <batch_entropy_store+110>:   pop    %eax
   0xc018bc53 <batch_entropy_store+111>:   cli
  spin_lock(lock);:
   /* hmm, not much here, maybe because no SMP ?? */

 list_add_tail(&batch_tqueue->list, &tq_timer);:
  __list_add(&batch_tqueue->list, (&tq_timer)->prev, &tq_timer);:
   (&tq_timer)->prev = &batch_tqueue->list;
   (&batch_tqueue->list)->next = &tq_timer;
   (&batch_tqueue->list)->prev = (&tq_timer)->prev;
   (&(&tq_timer)->prev)->next = &batch_tqueue->list;
   0xc018bc54 <batch_entropy_store+112>:   mov    0xc0227e94 [(&tq_timer)->prev],%edx
   0xc018bc5a <batch_entropy_store+118>:   movl   $0xc027bd6c [&batch_tqueue->list],0xc0227e94 [(&tq_timer)->prev]
   0xc018bc64 <batch_entropy_store+128>:   movl   $0xc0227e90,0xc027bd6c [batch_tqueue]
   0xc018bc6e <batch_entropy_store+138>:   mov    %edx [(&tq_timer)->prev],0xc027bd70 [(&batch_tqueue->list)->prev]

**********CRASH**********, EDX == 0xd0a0f434:
   0xc018bc74 <batch_entropy_store+144>:   movl   $0xc027bd6c [&batch_tqueue->list],(%edx) [(&(&tq_timer)->prev)->next == (&tq_timer)->prev]

 spin_unlock_irqrestore(&tqueue_lock, flags);:
  spin_unlock(&tqueue_lock);:
  local_irq_restore(flags);:
   0xc018bc7a <batch_entropy_store+150>:   push   %eax
   0xc018bc7b <batch_entropy_store+151>:   popf

what's that ??? gcc problem ?:
0xc018bc7c <batch_entropy_store+152>:   lea    0x0(%esi,1),%esi

batch_head = new;:
0xc018bc80 <batch_entropy_store+156>:   mov    %ecx,0xc027bd64 [batch_head]
0xc018bc86 <batch_entropy_store+162>:   ret
0xc018bc87 <batch_entropy_store+163>:   nop

So can anybody tell me why it crashes at 0xc018bc74 ?

Note that I'm not sure whether the suspend is required for the OOPS;
I don't know any other way of triggering the OOPS, though.

BTW, if I reconnect the cable instead of unloading ppa, I get:
root@note:/root# ppa: Parallel port cable is unplugged!!
ppa: Parallel port cable is unplugged!!
ppa: Parallel port cable is unplugged!!
sda : READ CAPACITY failed.
sda : status = 0, message = 00, host = 1, driver = 00
sda : sense not available.
sda : block size assumed to be 512 bytes, disk size 1GB.
 /dev/scsi/host0/bus0/target6/lun0: I/O error: dev 08:00, sector 0

So it seems to try to do a READ CAPACITY call at this moment upon resume,
which maybe blocks the kernel somehow when no cable is available...

Thank you for any suggestions !

I'm subscribed to the list, so no need to CC.

-- 
Andreas Mohr                        Stauferstr. 6, D-71272 Renningen, Germany
Tel. +49 7159 800604                http://home.germany.net/100-30936/
