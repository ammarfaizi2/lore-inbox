Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135875AbRDTLqv>; Fri, 20 Apr 2001 07:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135876AbRDTLqj>; Fri, 20 Apr 2001 07:46:39 -0400
Received: from hitpro.hitachi.co.jp ([133.145.224.7]:18907 "EHLO
	hitpro.hitachi.co.jp") by vger.kernel.org with ESMTP
	id <S135875AbRDTLqY>; Fri, 20 Apr 2001 07:46:24 -0400
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel panics on raw I/O stress test
From: Takanori Kawano <t-kawano@ebina.hitachi.co.jp>
In-Reply-To: <20010419193322.F752@athlon.random>
In-Reply-To: <20010419210153Z.t-kawano@ebina.hitachi.co.jp>
	<20010419193322.F752@athlon.random>
X-Mailer: Mew version 1.94.1 on Emacs 20.4 / Mule 4.1 (AOI)
Reply-To: t-kawano@ebina.hitachi.co.jp
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010420204435M.t-kawano@ebina.hitachi.co.jp>
Date: Fri, 20 Apr 2001 20:44:35 +0900 (JST)
X-Dispatcher: imput version 990905(IM130)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Could you try again with 2.4.4pre4 plus the below patch?
> 
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.4pre2/rawio-3

I suppose that 2.4.4-pre4 + rawio-3 patch still has SMP-unsafe
raw i/o code and can cause the same panic I reported.

I think the following scenario is possible if there are 3 or more CPUs.

(1) CPU0 enter rw_raw_dev()
(2) CPU0 execute alloc_kiovec(1, &iobuf)    // drivers/char/raw.c line 309
(3) CPU0 enter brw_kiovec(rw, 1, &iobuf,..) // drivers/char/raw.c line 362
(4) CPU0 enter __wait_on_buffer()
(5) CPU0 execute run_task_queue() and wait
    while buffer_locked(bh) is true.        // fs/buffer.c line 152-158
(6) CPU1 enter end_buffer_io_kiobuf() with
     iobuf allocated at (2)
(7) CPU1 execute unlock_buffer()            // fs/buffer.c line 1994
(8) CPU0 exit __wait_on_buffer()
(9) CPU0 exit brw_kiovec(rw, 1, &iobuf,..)
(10) CPU0 execute free_kiovec(1, &iobuf)     // drivers/char/raw.c line 388
(11) The task on CPU2 reused the area freed
     at (10).
(12) CPU1 enter end_kio_request() and touch
     the corrupted iobuf, then panic.

---
Takanori Kawano
Hitachi Ltd,
Internet Systems Platform Division
t-kawano@ebina.hitachi.co.jp



