Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263418AbRFRXXR>; Mon, 18 Jun 2001 19:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263416AbRFRXXH>; Mon, 18 Jun 2001 19:23:07 -0400
Received: from mail.ece.umn.edu ([128.101.168.129]:20947 "EHLO
	mail.ece.umn.edu") by vger.kernel.org with ESMTP id <S263415AbRFRXXB>;
	Mon, 18 Jun 2001 19:23:01 -0400
Date: Mon, 18 Jun 2001 18:22:56 -0500
From: Bob Glamm <glamm@mail.ece.umn.edu>
To: linux-kernel@vger.kernel.org
Subject: [SMP] 2.4.5-ac13 deadlocked?
Message-ID: <20010618182256.A29279@kittpeak.ece.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a strange situation, and I'm looking for a little direction.
Quick summary: I get sporadic lockups running 2.4.5-ac13 on a
ServerWorks HE-SL board (SuperMicro 370DE6), 2 800MHz Coppermine CPUs,
512M RAM, 512M+ swap.  Machine has 8 active disks, two as RAID 1,
6 as RAID 5.  Swap is on RAID 1.  Machine also has a 100Mbit Netgear
FA310TX and an Intel 82559-based 100Mbit card.  SCSI controllers
are AIC-7899 (2) and AIC-7895 (1).  RAM is PC-133 ECC RAM; two
identical machines display these problems.

I've seen three variations of symptoms:

  1) Almost complete lockout - machine responds to interrupts (indeed,
     it can even complete a TCP connection) but no userspace code gets
     executed.  Alt-SysRq-* still works, console scrollback does not;
  2) Partial lockout - lock_kernel() seems to be getting called without
     a corresponding unlock_kernel().  This manifested as programs such
     as 'ps' and 'top' getting stuck in kernel space;
  3) Unkillable programs - a test program that allocates 512M of memory
     and touches every page; running two copies of this simultaneously
     repeatedly results in at least one of the copies getting stuck
     in 'raid1_alloc_r1bh'.

Symptom number 1 was present in 2.4.2-ac20 as well; symptoms 2 and 3
were observed under 2.4.5-ac13 only.  I never get any PANICs, only
these variety of deadlocks.  A reboot is the only way to resolve the
problem.

There seem to be two ways to manifest the problem.  As alluded to in
(3), running two copies of the memory eater simultaneously along with
calls to 'ps' and 'top' trigger the bug fairly quickly (within a minute
or two).  Another method to manifest the problem is to run multiple
copies of this script (I run 10 simultaneous copies):

  #!/bin/sh

  while /bin/true; do
    ssh remote-machine 'sleep 1'
  done

This script causes (1) in about a day or two.

If anyone has any suggestions about how to proceed to figure out what
the problem is (or if there is already a fix), please let me know.
I would be more than willing to provide a wide range of cooperation on
this problem.  I don't have a feel for where to go from here, and I'm
hoping that someone with more experience can give me some
assistance..

-Bob
