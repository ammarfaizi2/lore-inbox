Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316519AbSFEXC4>; Wed, 5 Jun 2002 19:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316532AbSFEXCz>; Wed, 5 Jun 2002 19:02:55 -0400
Received: from h-64-105-34-84.SNVACAID.covad.net ([64.105.34.84]:52397 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316519AbSFEXCy>; Wed, 5 Jun 2002 19:02:54 -0400
Date: Wed, 5 Jun 2002 16:02:45 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Patch: linux-2.5.20/fs/bio.c - ll_rw_kio made incorrect assumptions about queue handler's capabilities
Message-ID: <20020605160245.A394@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I have not tested this patch, and I am not sure how to.
Perhaps you or someone else can suggest a program that exercises
ll_rw_kio.

	It seems to me that ll_rw_kio in linux-2.5.20 can generate
bio's that have more segments or more sectors than their queues declare
that they can handle.  For example, you could have block driver
that has max_hw_segments == 1, max_phys_segments == 1, max_sectors == 1.

	The intermediate bio merging code in drivers/block/ll_rw_blk.c
obeys these constraints when it comes to merging requests that
also are all within these constraints already, but it does break
up bio's that were to big for the underlying queue at the time they
were submitted.  As far as I can tell, it is the responsibility of
anything that calls submit_bio or generic_make_request to ensure that the
bio that is submitted is within the request_queue_t's limits
if the driver that pulls requests off of the queue is going to
be able to use max_hw_segments, max_phys_segments and max_sectors
as guarantees.

	I have attached an improved version of the patch that I
posted to linux-kernel yesterday.  There have been no comments
about that posting.  This new version also handles the case
where the queue's maximum number of sectors is too little to
hold even one full page.  I am cc'ing this version to linux-kernel
as well, in case anyone wants to comment.

	Jens, does this patch look OK to you?  If it does look OK,
is there anything else that I should do (e.g., is there some test I should
run?), or are do you want to take it from here and handle submitting
it to Linus?

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
