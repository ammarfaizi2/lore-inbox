Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132493AbRCaU4W>; Sat, 31 Mar 2001 15:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132494AbRCaU4L>; Sat, 31 Mar 2001 15:56:11 -0500
Received: from storm.ca ([209.87.239.69]:30337 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id <S132493AbRCaU4A>;
	Sat, 31 Mar 2001 15:56:00 -0500
Message-ID: <3AC64428.4492ABE7@storm.ca>
Date: Sat, 31 Mar 2001 15:55:04 -0500
From: Sandy Harris <sandy@storm.ca>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en,fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [speculation] Partitioning the kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm wondering whether we have or need a formalisation of how work might be
divided in future kernels.

The question I'm interested in is how the work gets split up among various
components at different levels within a single box (not SMP with many at
the same level, or various multi-box techniques), in particular how you
separate computation and I/O given some intelligence in devices other than
the main CPU (or SMP set). 

There are a bunch of examples to look at:

	IBM mainframe
	  "channel processors" do all the I/O
	  main CPU sets up a control block, does an EXCP instruction
	  there's an interrupt when operation completes or fails

	VAX 782: basically two 780s with a big cable between busses
	  one has disk controllers, most of the (VMS) kernel
	  other has serial I/O, runs all user processes

	various smart network or disk controllers
	and really smart ones that do RAID or Crypto

	I2O stuff on newer PCs

	Larry McVoy's suggestion that the right way to run, say, a 32-CPU
	  box is with something like 8 separate kernels, each using 4 CPUs
	If one of those runs the file system for everyone, this somewhat
	  overlaps the techniques listed above.

All of these demonstrably work, but each partitions the work between processors
in a somewhat different way.

What I'm wondering is whether, given that many drivers have a top-half
vs. bottom-half split as a fairly basic part of their design, it would
make sense to make it a design goal to have a clean partition at that
boundary.

On well-endowed systems, you then have the main CPUs running the top half
of everything, while I2O processors handle all the bottom halves and the
I/O interrupts. On lesser boxes, the CPU does both halves.

It seems to me this might give a cleaner design than one where the work
is partitioned between devices at some other boundary.

If the locks you need between top and bottom halves of the driver are also
controlling most or all CPU-to-I2O communication, it might go some way
toward avoiding the "locking cliff" McVoy talks of.
