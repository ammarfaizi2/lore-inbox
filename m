Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261462AbSJMIqV>; Sun, 13 Oct 2002 04:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbSJMIqV>; Sun, 13 Oct 2002 04:46:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21901 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261462AbSJMIqS>;
	Sun, 13 Oct 2002 04:46:18 -0400
Date: Sun, 13 Oct 2002 01:45:17 -0700 (PDT)
Message-Id: <20021013.014517.51702915.davem@redhat.com>
To: wagnerjd@prodigy.net
Cc: robm@fastmail.fm, hahn@physics.mcmaster.ca, linux-kernel@vger.kernel.org,
       jhoward@fastmail.fm
Subject: Re: Strange load spikes on 2.4.19 kernel
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <000f01c27294$438d5fa0$7443f4d1@joe>
References: <20021013.011344.58438240.davem@redhat.com>
	<000f01c27294$438d5fa0$7443f4d1@joe>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
   Date: Sun, 13 Oct 2002 03:40:51 -0500

   If you can code multi-threading SMP block and inode
   allocation using a non-preemptive kernel (which Linux is) ON THE SAME
   PARTITION, I will eat my hard drive.
   
First, what you're asking me for is already occuring in the reiserfs
and xfs code in 2.5.x.

Now onto ext2/ext3 where it doesn't exactly happen now.

It can easily be done using the SMP atomic bit operations we have in
the kernel.  On many cpus (x86 is one) it would thus reduce to one
atomic instruction to allocate a block or inode anywhere on the
filesystem, no locks even needed to make it atomic.

Allocating a block/inode is just a compare and set operation after
all.  The block/inode maps in ext2/ext3 are already just plain
bitmaps suitable for sending to the SMP bit operations we have.

It's very doable and I've even discussed this with Stephen Tweedie
and others in the past.

I think I bring some credibility to the table, being that I worked on
threading the entire Linux networking.  You can choose to disagree. :)

Why hasn't it been done?  Because ext2/ext3 block allocation
synchronization isn't showing up high on anyone's profiles at all
since the operations are so short and quick that the lock is dropped
almost immediately after it is taken.  And it's not like people aren't
running large workloads on 16-way and higher NUMA boxes in 2.5.x.
Copying the data around and doing the I/O eats the bulk of the
computing cycles.

And if you're of the "numbers talk, bullshit walks" variety just have
a look at the Linux specweb99 submissions if you don't believe the
Linux kernel can scale quite well.  Show us something that scales
better than what we have now if you're going to say we suck.  We do
suck, just a lot less than most implementations. :-)
