Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261681AbTCLBKH>; Tue, 11 Mar 2003 20:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262978AbTCLBKH>; Tue, 11 Mar 2003 20:10:07 -0500
Received: from ns.splentec.com ([209.47.35.194]:47629 "EHLO pepsi.splentec.com")
	by vger.kernel.org with ESMTP id <S261681AbTCLBKG>;
	Tue, 11 Mar 2003 20:10:06 -0500
Message-ID: <3E6E8B6D.1000501@splentec.com>
Date: Tue, 11 Mar 2003 20:20:45 -0500
From: Luben Tuikov <luben@splentec.com>
Organization: Splentec Ltd.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: [PATCH] fix kernel oops in generic_unplug_device() for md
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes a kernel oops when doing
blk_unplug_work() (oopses in generic_unplug_device()) for md.

The oops and the original report are here:
http://MARC.10East.com/?l=linux-kernel&m=104706400705154&w=2

The problem is that the md driver provides its own unplug
function (among other things) and blk_unplug_work() assumes
that the generic one would work, but it doesn't and BOOM,
it oopses and dies.

-- 
Luben

--- linux-2.5.64bk6/drivers/block/ll_rw_blk.c.orig	2003-03-11 16:23:55.000000000 -0500
+++ linux-2.5.64bk6/drivers/block/ll_rw_blk.c	2003-03-11 18:38:40.000000000 -0500
@@ -29,6 +29,7 @@

  static void blk_unplug_work(void *data);
  static void blk_unplug_timeout(unsigned long data);
+static int __make_request(request_queue_t *, struct bio *);

  /*
   * For the allocated request tables
@@ -1040,7 +1041,13 @@

  static void blk_unplug_work(void *data)
  {
-	generic_unplug_device(data);
+	request_queue_t *q = data;
+
+	if (q->make_request_fn && q->make_request_fn != __make_request
+	    && q->unplug_fn)
+		q->unplug_fn(data);
+	else
+		generic_unplug_device(data);
  }

  static void blk_unplug_timeout(unsigned long data)
@@ -1246,8 +1253,6 @@
  	return 1;
  }

-static int __make_request(request_queue_t *, struct bio *);
-
  /**
   * blk_init_queue  - prepare a request queue for use with a block device
   * @q:    The &request_queue_t to be initialised

