Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWGLIAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWGLIAd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 04:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWGLIAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 04:00:33 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6968 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750838AbWGLIAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 04:00:32 -0400
Date: Wed, 12 Jul 2006 10:03:20 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: nickpiggin@yahoo.com.au
Subject: [PATCHSET] 0/7 IO scheduler abstractions
Message-ID: <20060712080319.GA13920@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

So right now we have some duplicated code and data structures among the
io schedulers. Apart from noop, the others all implement their own back
merging with hash helpers, sorting with rbtree helpers, and FIFO
management in private request structures.

This patch set takes care of moving what makes sense into the elevator
core instead. It results in about a 3kb reduction of kernel text, and a
reduction of 550 (!!) lines of kernel C code. The noop scheduler gains
merging capabilities for free, and the deadline scheduler can get rid of
its private deadline_rq structure. The latter is especially nice for
deadline, as it is now allocation free in the request path! deadline
code is also reduced from about 19kb to 11kb.

The patches are also available in the 'iosched' branch of the git block
repo.

 block/as-iosched.c       |  351 ++++-------------------------------
 block/cfq-iosched.c      |  268 +++++----------------------
 block/deadline-iosched.c |  462 +++++++----------------------------------------
 block/elevator.c         |  231 +++++++++++++++++++++--
 block/ll_rw_blk.c        |    7 
 include/linux/blkdev.h   |   18 -
 include/linux/elevator.h |   33 +++
 include/linux/rbtree.h   |    2 
 lib/rbtree.c             |    6 
 9 files changed, 427 insertions(+), 951 deletions(-)

-- 
Jens Axboe

