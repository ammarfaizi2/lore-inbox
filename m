Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317299AbSHGLj7>; Wed, 7 Aug 2002 07:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317141AbSHGLj6>; Wed, 7 Aug 2002 07:39:58 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:45454 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S317170AbSHGLj5>; Wed, 7 Aug 2002 07:39:57 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: Jakob Oestergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org
Subject: Re: Disk (block) write strangeness
Date: Wed, 7 Aug 2002 14:43:30 +0300
User-Agent: KMail/1.4.1
References: <20020805184921.GC2671@unthought.net>
In-Reply-To: <20020805184921.GC2671@unthought.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208071443.30551.nahshon@actcom.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 August 2002 21:49 pm, Jakob Oestergaard wrote:
> Hello all,
>
> While investigating how various disks handle power-loss during writes, I
> came across something *very* strange.
>
> It seems that
>
> *) Either the disk writes backwards  (no I don't believe that)
> *) Or the kernel is writing 256 B blocks (AFAIK it can't)
> *) The disk has some internal magic that cause a power-loss during
>    a full block write to leave the first half of the block intact with
>    old data, and update the second half of a block correctly with new
>    data.  (And I don't believe that either).
>
> The scenario is:   I wrote a program that will write a 50 MB block with
> O_SYNC to /dev/hdc.  The block is full of 32-bit integers, initialized
> to 0.  For every full block write (the block is written with one single
> write() call), the integers are incremented once.
>
> So first I have 50 MB of 0's. Then 50 MB of 1's. etc.
>
> During this write cycle, I pull the power cable.   I get the machine
> back online and I dump the 50 MB block.
>
> What I found was a 50 MB block holding:
>  11668992 times "0x00000002"
>    231168 times "0x00000003"
>   1174528 times "0x00000002"
>     32512 times "0x00000003"
>
> Please note that 32512 is *not* a multiple of 512.  And please note that
> the 3's are written *after* the 2's, so actually there is a 512 byte
> block on the disk which contains 2's in the first half, and 3's in the
> second half!

Integers are 32 bit, so a 512 byte disk block contains 128 such integers...
Indeed, All the values above are divisible by 128, so you have:
11668992/128 = 91164 blocks of "0x00000002"
231168/128 = 1806 blocks of "0x00000003"
1174528/128 = 9176 blocks of "0x00000002"
32512/128 = 254 blocks of "0x00000003"

This does not prove, neither disprove anything about your
main concern, that writes are non-atomic in the block level.

>
> How on earth could that happen ?
>
> Why does the kernel not write from beginning to end ?   Or why doesn't
> the disk ?
>
> And does the elevator cause the writes to be shuffled around like that -
> I would have expected the kernel to write from beginning to end every
> single time...
>

I would not expect writes to be in order.
A simple elevator algorithm could write fragments (cylinder sized?)
in reverse order. On-disk write scheduling could start writing at any
sector (to minimize rotational latency).

Knowing the disk geometry and parameters could help with understanding
your results.

> The kernel is 2.4.18 on some i686 box
> The disk is a Quantum Fireball 1GB IDE (from way back then ;)
> The IDE chipset is an I820 Camino 2
>
> I can submit the test program or do further tests, if anyone is
> interested.
>
> Thank you,


-- Itai

