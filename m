Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316576AbSIIHWY>; Mon, 9 Sep 2002 03:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316580AbSIIHWY>; Mon, 9 Sep 2002 03:22:24 -0400
Received: from dsl092-066-024.bos1.dsl.speakeasy.net ([66.92.66.24]:8716 "HELO
	everypoint.net") by vger.kernel.org with SMTP id <S316576AbSIIHWW>;
	Mon, 9 Sep 2002 03:22:22 -0400
Date: 09 Sep 2002 03:27:11 -0400
Message-Id: <m24rczzkq8.fsf@everypoint.net>
From: Allan MacKinnon <allanmac@everypoint.net>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
Subject: results on "fully HT-aware scheduler" patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All,

I've been running some simple tests on Ingo Molnar's "fully HT-aware
scheduler" patch and included the initial results at the end of this
message.  [ see: http://lwn.net/Articles/8553/ for patch info ]

Some observations...

- Tests with one or two active tasks show significant improvement with
  the HT-aware patch.  [ See Ingo's comments about this in his patch
  notes. ]

- I was a little surprised to see that having as few as three active
  (user) tasks is efficient -- at least in the 'make bzImage' case.

- There was quite a bit of variance from run to run with my internal
  tests _without_ the HT-aware scheduler.  With the patch it was very
  consistent.

  Note that the "everypoint internal" test is written in Java and is
  memory intensive (lots of search).  It also has at least two active
  threads.  It appears that this test corresponds with the best case
  for the HT-aware scheduler and the worst for the existing
  implementations.  Thus my hunt for HT "fixes"...

- With four active folding@home tasks and the HT-patch, %CPU and %user
  stats indicate that the tasks are each receiving over 50% of each
  (logical) CPU.  To be more clear, CPU0+1 shows a total of ~116% user
  and CPU2+3 shows ~109%.


-ASM


----------------------------------------------------------------------------------------------------------------

       test              kernel:  2.5.33-HT-aware  2.5.33         2.4.8-10bigmem  notes
----------------------   -------  ---------------  -------------  --------------  ------------------------------

make -j 1 bzImage                 195              206            210             make the 2.5.33 kernel
                                         +5.3%
make -j 2 bzImage                 117              138,147        127                       "
                                        +15.2%
make -j 3 bzImage                 110              110            110                       "

make -j 4 bzImage                 109              109            107                       "

make -j 5 bzImage                 109              109            109                       "

everypoint internal bench         150              168,188,218    154,216,224     Sun 1.4.1RC1 "-server -Xms..."
                                        +10.7%
                                      -----------
                                      %over2.5.33

Supermicro P4DPE-G2               1. times are in real time
E7500 chipset                     2. multiple times are listed if there is variance
2 x 2.2GHz Xeon                   3. otherwise, best times were selected
Hyperthreading enabled in BIOS
8GB RAM

Allan MacKinnon
allanmac@everypoint.net

----------------------------------------------------------------------------------------------------------------

