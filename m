Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbRFSSxg>; Tue, 19 Jun 2001 14:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264702AbRFSSx0>; Tue, 19 Jun 2001 14:53:26 -0400
Received: from mail.ece.umn.edu ([128.101.168.129]:33198 "EHLO
	mail.ece.umn.edu") by vger.kernel.org with ESMTP id <S264697AbRFSSxX>;
	Tue, 19 Jun 2001 14:53:23 -0400
Date: Tue, 19 Jun 2001 13:53:10 -0500
From: Bob Glamm <glamm@mail.ece.umn.edu>
To: Carlos E Gorges <carlos@techlinux.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [SMP] 2.4.5-ac13 memory corruption/deadlock?
Message-ID: <20010619135310.A15004@kittpeak.ece.umn.edu>
In-Reply-To: <20010618182256.A29279@kittpeak.ece.umn.edu> <01061819382904.08756@skydive.techlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
In-Reply-To: <01061819382904.08756@skydive.techlinux>; from carlos@techlinux.com.br on Mon, Jun 18, 2001 at 07:38:29PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I've got a strange situation, and I'm looking for a little direction.
> > Quick summary: I get sporadic lockups running 2.4.5-ac13 on a
> > ServerWorks HE-SL board (SuperMicro 370DE6), 2 800MHz Coppermine CPUs,
> > 512M RAM, 512M+ swap.  Machine has 8 active disks, two as RAID 1,
> > 6 as RAID 5.  Swap is on RAID 1.  Machine also has a 100Mbit Netgear
> > FA310TX and an Intel 82559-based 100Mbit card.  SCSI controllers
> > are AIC-7899 (2) and AIC-7895 (1).  RAM is PC-133 ECC RAM; two
> > identical machines display these problems.
> 
> please adds nmi_watchdog=1 as kernel parameter ( append=... in lilo ) and try 
> again.

Done, and I managed to get it to lock solid in under three hours.  Two
oopses in the syslog (follow).  It looks like memory corruption: the
BUG() that is called from spin_lock() and spin_unlock() test to see whether
the spinlock at the given address has the proper magic; apparently
it's gotten to the point where it doesn't.  In this case the lock that
has gotten mangled is dcache_lock.

Unfortunately, I don't think that this particular lockup is repeatable,
but I'm going to try again anyway to see if the same pattern of memory
corruption occurs.

-Bob

kernel BUG at /usr/src/linux-2.4.5-ac13/include/asm/spinlock.h:113!
invalid operand: 0000
CPU:    0
EIP:    0010:[d_alloc+413/504]
EFLAGS: 00010286
eax: 00000044   ebx: de9f811c   ecx: c027c088   edx: 0000869b
esi: c6e3fed1   edi: c190a14c   ebp: c6e3fee8   esp: c6e3fe94
ds: 0018   es: 0018   ss: 0018
Process sshd (pid: 565, stackpage=c6e3f000)
Stack: c0238840 00000071 de38bd04 c7f5ee94 c6e3fed2 00000004 c01dae97 c190a11c
       c6e3fee8 de38bd04 c7975f14 c6e3ff14 bffffca8 3532325b 35373138 c01d005d
       bffffca8 c6e3ff14 00000010 de38bd04 c7975f14 c6e3fec8 00000009 002274ff
Call Trace: [sock_map_fd+211/532] [mark_rdev_faulty+17/60] [sys_accept+197/252] [__free_pages+27/28] [free_pages+33/36]
   [poll_freewait+58/68] [do_select+523/548] [select_bits_free+10/16] [sys_select+1135/1148] [sys_socketcall+180/512] [system_call+51/56]

Code: 0f 0b 83 c4 08 8d b6 00 00 00 00 a0 c0 e2 27 c0 84 c0 7e 17
 eip: c0152f37 (d_lookup)
kernel BUG at /usr/src/linux-2.4.5-ac13/include/asm/spinlock.h:101!
invalid operand: 0000
CPU:    1
EIP:    0010:[d_lookup+121/476]
EFLAGS: 00010282
eax: 00000044   ebx: dffe9f68   ecx: c027c088   edx: 00008a07
esi: 00000000   edi: c1933824   ebp: bffff818   esp: dffe9f04
ds: 0018   es: 0018   ss: 0018
Process init (pid: 1, stackpage=dffe9000)
Stack: c0238840 00000065 dffe9f68 00000000 c1933824 bffff818 dff40a20 d228d001
       0023ee05 00000003 c014850c c1932de4 dffe9f68 dffe9f68 c0148d09 c1932de4
       dffe9f68 00000004 d228d000 00000000 dffe9fa4 bffff818 c01480ca 00000009
Call Trace: [cached_lookup+16/84] [path_walk+889/3104] [getname+90/152] [__user_walk+60/88] [sys_stat64+22/120]
   [system_call+51/56]
eip: c021f2f4 (atomic_dec_and_lock)
kernel BUG at /usr/src/linux-2.4.5-ac13/include/asm/spinlock.h:101!

Code: 0f 0b 83 c4 08 f0 fe 0d c0 e2 27 c0 0f 88 22 17 0d 00 8b 54
 invalid operand: 0000
Kernel panic: Attempted to kill init!

> > I've seen three variations of symptoms:
> >
> >   1) Almost complete lockout - machine responds to interrupts (indeed,
> >      it can even complete a TCP connection) but no userspace code gets
> >      executed.  Alt-SysRq-* still works, console scrollback does not;
> >   2) Partial lockout - lock_kernel() seems to be getting called without
> >      a corresponding unlock_kernel().  This manifested as programs such
> >      as 'ps' and 'top' getting stuck in kernel space;
> >   3) Unkillable programs - a test program that allocates 512M of memory
> >      and touches every page; running two copies of this simultaneously
> >      repeatedly results in at least one of the copies getting stuck
> >      in 'raid1_alloc_r1bh'.
> >
> > Symptom number 1 was present in 2.4.2-ac20 as well; symptoms 2 and 3
> > were observed under 2.4.5-ac13 only.  I never get any PANICs, only
> > these variety of deadlocks.  A reboot is the only way to resolve the
> > problem.
> >
> > There seem to be two ways to manifest the problem.  As alluded to in
> > (3), running two copies of the memory eater simultaneously along with
> > calls to 'ps' and 'top' trigger the bug fairly quickly (within a minute
> > or two).  Another method to manifest the problem is to run multiple
> > copies of this script (I run 10 simultaneous copies):
> >
> >   #!/bin/sh
> >
> >   while /bin/true; do
> >     ssh remote-machine 'sleep 1'
> >   done
> >
> > This script causes (1) in about a day or two.
> >
> > If anyone has any suggestions about how to proceed to figure out what
> > the problem is (or if there is already a fix), please let me know.
> > I would be more than willing to provide a wide range of cooperation on
> > this problem.  I don't have a feel for where to go from here, and I'm
> > hoping that someone with more experience can give me some
> > assistance..
> >
> > -Bob
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> cya;
> 
> 	 _________________________
> 	 Carlos E Gorges          
> 	 (carlos@techlinux.com.br)
> 	 Tech informática LTDA
> 	 Brazil                   
> 	 _________________________

-- 
Q: How is software like drug addiction?
A: Periodically you need a fix, and a patch will cure all your ills.
