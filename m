Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267332AbSKPSjz>; Sat, 16 Nov 2002 13:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267333AbSKPSjz>; Sat, 16 Nov 2002 13:39:55 -0500
Received: from [195.223.140.107] ([195.223.140.107]:50321 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267332AbSKPSjy>;
	Sat, 16 Nov 2002 13:39:54 -0500
Date: Sat, 16 Nov 2002 19:46:22 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Con Kolivas <conman@kolivas.net>
Subject: Re: 2.[45] fixes for design locking bug in wait_on_page/wait_on_buffer/get_request_wait
Message-ID: <20021116184622.GJ31697@dualathlon.random>
References: <200211161657.51357.m.c.p@wolk-project.de> <200211161810.23039.m.c.p@wolk-project.de> <20021116173224.GG31697@dualathlon.random> <200211161841.59889.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211161841.59889.m.c.p@wolk-project.de>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2002 at 06:43:36PM +0100, Marc-Christian Petersen wrote:
> On Saturday 16 November 2002 18:32, Andrea Arcangeli wrote:
> 
> Hi Andrea,
> 
> > you may want to try with this setting that helps with very slow devices:
> > 	echo 2 500 0 0 500 3000 3 1 0 > /proc/sys/vm/bdflush
> >
> > or also with my current default tuned for high performance:
> > 	echo 50 500 0 0 500 3000 60 20 > /proc/sys/vm/bdflush
> I've tested both without any changes, "pausings" are still there.
> 
> > you may have too many dirty buffers around and you end running at disk
> > speed at every memory allocation, the first setting will decrease the
> > amount of dirty buffers dramatically, if you still have significant
> > slowdown with the first setting above, it's most probably only the usual
> > elevator issue.
> Seems so.
> 
> So I have to use 2.4.18 until there is a real proper fix for that.

just to make a quick test, can you try an hack like this combined with a
setting of elvtune -r 128 -w 256 on top of 2.4.20rc1?

--- x/drivers/block/ll_rw_blk.c.~1~	Sat Nov  2 19:45:33 2002
+++ x/drivers/block/ll_rw_blk.c	Sat Nov 16 19:44:20 2002
@@ -432,7 +432,7 @@ static void blk_init_free_list(request_q
 
 	si_meminfo(&si);
 	megs = si.totalram >> (20 - PAGE_SHIFT);
-	nr_requests = 128;
+	nr_requests = 16;
 	if (megs < 32)
 		nr_requests /= 2;
 	blk_grow_request_list(q, nr_requests);



Andrea
