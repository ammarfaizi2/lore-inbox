Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277564AbRKDC1a>; Sat, 3 Nov 2001 21:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277559AbRKDC1U>; Sat, 3 Nov 2001 21:27:20 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:39058 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S277656AbRKDC1F>; Sat, 3 Nov 2001 21:27:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org
Subject: Ext2 directory index, updated
Date: Sun, 4 Nov 2001 03:28:06 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011104022659Z16995-4784+750@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

***N.B.: still for use on test partitions only.***

This update mainly fixes a bug, a one-in-a-million occurance on an untested 
code path.  This bug resulted in rm -rf deleting all files but one from a 
million-file directory.  I believe that's the last untested code path, and 
otherwise it's been very stable.

I didn't expect highmem to work properly, and it didn't.  It's on my to-do 
list, but for now highmem has to be off or you will oops on boot.

I elaborated the dx_show_buckets debug output to show dump the full index 
tree instead of just one level.  This function now serves as a capsule 
summary of the index tree structure, and as you can see, it's simple.

I've done quite a bit more testing, including stress testing on a real 
machine and I find that everything works quite comfortably up to about 2 
million files, turning in an average time of about 50 microseconds/create and 
300 microseconds/delete (1 GHz PIII).  In the 4 million file range things go 
pear-shaped, which I believe is not due to the index patch, but to rd.  The 
runs do complete, but require exponentially more time, with cpu 98% idle and 
block throughput in the 300/second range.  I'll look into that more later.

I did run into some bad mm behavior on 2.4.13.  The icache seems to be too 
severely throttled, resulting in delete performance being less than it should 
be.  I also find I am rarely unable to create a million file test run on uml 
(2.4.13) without oom-ing.  In my experience, such problems are not due to 
uml, but to the kernel's memory manager.  These issues may have been 
addressed in recent pre-patch kernels, but it seems there is a still some 
room for improvement in mm stability.

The patch is available at:

  http://nl.linux.org/~phillips/htree/ext2.index-2.4.13

To apply:

  cd /your/source/tree
  patch -p0 <this.patch

--
Daniel

