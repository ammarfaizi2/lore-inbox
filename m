Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266250AbTABRjZ>; Thu, 2 Jan 2003 12:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266256AbTABRjY>; Thu, 2 Jan 2003 12:39:24 -0500
Received: from smtp03.uc3m.es ([163.117.136.123]:50440 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S266250AbTABRjX>;
	Thu, 2 Jan 2003 12:39:23 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200301021747.h02Hlio19517@oboe.it.uc3m.es>
Subject: getblk spins endlessly in 2.4.19 SMP
To: linux-kernel@vger.kernel.org
Date: Thu, 2 Jan 2003 18:46:29 +0100 (MET)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


get_blk() loops forever internally for in a sort piece of driver code of
mine.  Why?  Somebody send me a clue, please!  get_hash_table returns
NULL inside get_blk and get_blk loops calling grow_buffers and
free_more_memory until death occurs hours later.

The same code works fine on the same kernel (binary!) on my laptop
with a 8M test device, and yet fails as described on my real SMP
machine on a 2GB test device.

What I'm trying to do is read one device and write to another,
in a loop. The code does:

    bh = bread (dev, blocknr, blksize);  // never gets past here! first time.
    if (!bh) return -EINVAL;
    req = my_make_request(dev2, bh);
    my_wait_until_request_done_timeout(req, timeout);
    bforget(bh);

and loops.

On the laptop, it loops through the whole (8M) device, block by block.
On the server, it hangs on bread() forever on the first pass through the
loop, with blocknr=0, because bread spins forever inside getblk, because
get_hash_table(dev, block, blksize) fails, and it calls free_more_memory
...  if I use get_hash_table directly, it runs through each block of
the device, failing on each block.

The laptop has 256M, and the server has 128M. The blksize is 1K on
both.

Both are newly booted.

The server is a REAL smp machine. The laptop is only running the SMP
kernel - it's not SMP.

I need a clue.  Please somebody send a clue.  Can it be that bread()
needs the buffer in cache?  I don't believe it - surely it should cause
a read request to drop through to the device when it gets to do its
ll_rw_block(), which it will as soon as getblk() returns.  But getblk
does not return.

Yet  memory is available:


               total       used       free     shared    buffers cached
   Mem:        127016     115532      11484          0 2164      68608
   -/+ buffers/cache:      44760      82256
   Swap:       144504          0     144504


I'm currently stumped. I thought it was a locking issue, and that
bread() needed to be run inside some lock, but I don't see one.
What else could distinguish a true SMP issue?  

The code runs in a kernel_thread, started from an ioctl, and reparented
to init.

There must be somebody out there who knows immediately what it is
I'm missing! If you do, I'd be very happy to hear from you!


Peter
