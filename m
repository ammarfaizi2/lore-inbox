Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268926AbRHBNn6>; Thu, 2 Aug 2001 09:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268928AbRHBNnt>; Thu, 2 Aug 2001 09:43:49 -0400
Received: from willow.commerce.uk.net ([213.219.35.202]:13594 "EHLO
	willow.commerce.uk.net") by vger.kernel.org with ESMTP
	id <S268926AbRHBNnn>; Thu, 2 Aug 2001 09:43:43 -0400
Date: Thu, 2 Aug 2001 14:43:36 +0100 (BST)
From: Corin Hartland-Swann <cdhs@commerce.uk.net>
To: linux-kernel@vger.kernel.org
cc: Jason Collins <jcollins@valinux.com>
Subject: Memory Problems - CTCS/memtst
Message-ID: <Pine.LNX.4.21.0108021442570.23264-100000@willow.commerce.uk.net>
Organization: Commerce Internet Ltd
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,

I have been trying to identify the cause of a number of problems we've
been having with a server.

The server consists of two Pentium III 1000/133's on a Tyan Tiger LE
motherboard, 4 x 1024MB PC133 ECC DIMMs and two UDMA disk drives. It is
running kernel 2.4.7 (unpatched, but with tailored config). To rule out
problems related to the large amount of memory, I temporarily removed all
but one of the DIMMs, leaving it with 1024MB.

I've been getting the usual signs of memory errors:

  segmentation faults
  "unable to handle kernel NULL pointer dereference at virtual address"
  kernel compilations failing
  random panics

I have been using VA CTCS (esp. memtst) to try to identify where the
problems lie.

The latest example of faulty memory somewhere was when I copied the root
disk to another disk using:

  find / -mount -print | cpio -pm /mnt/disk

When I compared the files (between the disks) with md5sum, two of the
files came up with differing checksums (i.e. the files had been corrupted
while copying).

The BIOS has an ECC logging feature, and if I understand it correctly,
then there /cannot/ have been any main memory errors or they would have
shown up in the logs. At least not any single or double-bit errors (ECC
corrects single-bit and detects double-bit, doesn't it?)

When using the older version of memtst (by Larry Augustin), I did not find
any errors, and I ran it a lot of times.

I'm now using CTCS 1.3.0pre2, and memtst has been completely rewritten (by
Jason Collins). There are a number of new tests in addition to the
original one. I find no memory errors with tests 1, 3, 4 and 5 - but test
2 consistently comes back with an error:

  # ./memtst -2 -B -c 1024

  <...snip...>

  Failure Context:
       offset        expected             got
            0        aaaaaaaa        aaaaaaaa   ### fail location
            1        aaaaaaa9        aaaaaaa9
            2        aaaaaaa8        aaaaaaa8
            3        aaaaaaa7        aaaaaaa7
            4        aaaaaaa6        aaaaaaa6
            5        aaaaaaa5        aaaaaaa5
            6        aaaaaaa4        aaaaaaa4
            7        aaaaaaa3        aaaaaaa3
            8        aaaaaaa2        aaaaaaa2
            9        aaaaaaa1        aaaaaaa1
  8 8 fail_page_offset
  Scanning /proc/kcore.  Fire in the hole!
  The memory failure location could not be determined. This,
  while not provably impossible, should never happen under practical
  circumstances unless there is a bug or the memtst program image is
  corrupt.
  Cache RAM fault likely.

I compiled the program on another machine, which has had no problems, and
have compared the two binaries with md5sum to ensure that it was not
corrupted in transit - so I don't think it's a problem with the binary.

Initially, memtst was finding the memory location very quickly, and it was
different each time it was run. I assumed that one of the two CPUs had a
hardware fault, and so I removed one of them and re-ran the test. From
this point on, it could not identify the location of the failed memory.

I then swapped over the two CPUs, and got the same as above again. It is
reproducible every time, including straight after a reboot.

Please could you CC: me in on any replies as I'm not on LKML.

Regards,

Corin

/------------------------+-------------------------------------\
| Corin Hartland-Swann   |    Tel: +44 (0) 20 7491 2000        |
| Commerce Internet Ltd  |    Fax: +44 (0) 20 7491 2010        |
| 22 Cavendish Buildings | Mobile: +44 (0) 79 5854 0027        | 
| Gilbert Street         |                                     |
| Mayfair                |    Web: http://www.commerce.uk.net/ |
| London W1K 5HJ         | E-Mail: cdhs@commerce.uk.net        |
\------------------------+-------------------------------------/




