Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318811AbSHESps>; Mon, 5 Aug 2002 14:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318825AbSHESpq>; Mon, 5 Aug 2002 14:45:46 -0400
Received: from unthought.net ([212.97.129.24]:10423 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S318811AbSHESpp>;
	Mon, 5 Aug 2002 14:45:45 -0400
Date: Mon, 5 Aug 2002 20:49:21 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: linux-kernel@vger.kernel.org
Subject: Disk (block) write strangeness
Message-ID: <20020805184921.GC2671@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,

While investigating how various disks handle power-loss during writes, I
came across something *very* strange.

It seems that

*) Either the disk writes backwards  (no I don't believe that)
*) Or the kernel is writing 256 B blocks (AFAIK it can't)
*) The disk has some internal magic that cause a power-loss during
   a full block write to leave the first half of the block intact with
   old data, and update the second half of a block correctly with new
   data.  (And I don't believe that either).

The scenario is:   I wrote a program that will write a 50 MB block with
O_SYNC to /dev/hdc.  The block is full of 32-bit integers, initialized
to 0.  For every full block write (the block is written with one single
write() call), the integers are incremented once.

So first I have 50 MB of 0's. Then 50 MB of 1's. etc.

During this write cycle, I pull the power cable.   I get the machine
back online and I dump the 50 MB block.

What I found was a 50 MB block holding:
 11668992 times "0x00000002"
   231168 times "0x00000003"
  1174528 times "0x00000002"
    32512 times "0x00000003"

Please note that 32512 is *not* a multiple of 512.  And please note that
the 3's are written *after* the 2's, so actually there is a 512 byte
block on the disk which contains 2's in the first half, and 3's in the
second half!

How on earth could that happen ?

Why does the kernel not write from beginning to end ?   Or why doesn't
the disk ?

And does the elevator cause the writes to be shuffled around like that -
I would have expected the kernel to write from beginning to end every
single time...

The kernel is 2.4.18 on some i686 box
The disk is a Quantum Fireball 1GB IDE (from way back then ;)
The IDE chipset is an I820 Camino 2

I can submit the test program or do further tests, if anyone is
interested.

Thank you,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
