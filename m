Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281146AbRKEN0s>; Mon, 5 Nov 2001 08:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281148AbRKEN0h>; Mon, 5 Nov 2001 08:26:37 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:7370 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S281141AbRKEN0Z>; Mon, 5 Nov 2001 08:26:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Performance of Ext2 directory operations
Date: Mon, 5 Nov 2001 14:27:25 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011105132619Z17092-18973+34@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some test results for there versions of Ext2:

  Classic Ext2
  Current Ext2, with a cached position optimization in ext2_find_entry
  Indexed Ext2

The tests are:

  Create 10,000 files
  Delete 10,000 files (after remounting)
  Detete 10,000 files in the reverse of the creation order

There's one big surprise here: the find_entry optimization appears to slow 
down file creation in case by about 40%.  It doubles the speed of deletion,
but deletion is already fast, so this optimization isn't looking that good.

With the index patch, deletion is slightly slower than ext2 with the position 
optimization, but considerably faster than classic ext2.  In reverse 
deletion, indexed ext2 is the winner.  It's interesting to see the gap in 
delete speed increase enormously for between classic ext2 and ext2 with the 
position optimization, but this is also understandable because the position 
optimization results in 250 or so successive hits into the same block each 
time before having to do a full search.  On the other hand, classic ext2 
loses all its delete speed because it is no longer able to skip rapidly 
through empty blocks at the beginning of a directory.

I should also test random creation/deletion, but have not done so yet.  I 
also need more points on the curve, though I already know when the curve 
looks like: for indexed operations and unindexed delete with position caching 
it's a line.  For unindexed create and all random operations it's a parabola.

These tests were done with kernel 2.4.13.

Create 10,000 files

Classic Ext2  4.45 system 04.49 elapsed 100%CPU
Current Ext2  7.58 system 07.61 elapsed 99%CPU
Indexed Ext2  0.29 system 00.30 elapsed 100%CPU

Delete 10,000 files

Classic Ext2  0.24 system 00.29 elapsed 85%CPU
Current Ext2  0.05 system 00.14 elapsed 42%CPU
Indexed Ext2  0.13 system 00.17 elapsed 73%CPU

Reverse delete 10,000 files

Classic Ext2  3.55 system 03.64 elapsed 97%CPU
Current Ext2  0.58 system 00.71 elapsed 89%CPU
Indexed Ext2  0.19 system 00.32 elapsed 80%CPU

--
Daniel
