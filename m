Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130619AbQKCS1U>; Fri, 3 Nov 2000 13:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129953AbQKCS1L>; Fri, 3 Nov 2000 13:27:11 -0500
Received: from fw.SuSE.com ([202.58.118.35]:29687 "EHLO linux.local")
	by vger.kernel.org with ESMTP id <S130619AbQKCS1E>;
	Fri, 3 Nov 2000 13:27:04 -0500
Date: Fri, 3 Nov 2000 11:38:18 -0800
From: Jens Axboe <axboe@suse.de>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Subject: Re: [BUG] /proc/<pid>/stat access stalls badly for swapping process, 2.4.0-test10
Message-ID: <20001103113818.T521@suse.de>
In-Reply-To: <Pine.Linu.4.10.10011030419430.818-100000@mikeg.weiden.de> <Pine.Linu.4.10.10011031638180.1496-200000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.Linu.4.10.10011031638180.1496-200000@mikeg.weiden.de>; from mikeg@wen-online.de on Fri, Nov 03, 2000 at 04:45:51PM +0100
X-OS: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 03 2000, Mike Galbraith wrote:
> > I very much agree.  Kflushd is still hungry for free write
> > bandwidth here.
> 
> In the LKML tradition of code talks and silly opinions walk...
> 
> Attached is a diagnostic patch which gets kflushd under control,
> and takes make -j30 bzImage build times down from 12 minutes to
> 9 here.  I have no more massive context switching on write, and
> copies seem to go a lot quicker to boot.  (that may be because
> some of my failures were really _really_ horrible)
> 
> Comments are very welcome.  I haven't had problems with this yet,
> but it's early so...  This patch isn't supposed to be pretty either
> (hw techs don't do pretty;) it's only supposed to say 'Huston...'
> so be sure to grab a barfbag before you take a look. 

Super, looks pretty good from here. I'll give it a go when I get back.
In addition, here's a small patch that disables the read stealing
of requests from the write list -- does that improve behaviour
when we are busy flushing?

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="read_steal.diff"

--- drivers/block/ll_rw_blk.c~	Fri Nov  3 03:22:25 2000
+++ drivers/block/ll_rw_blk.c	Fri Nov  3 03:23:24 2000
@@ -455,35 +455,17 @@
 	struct list_head *list = &q->request_freelist[rw];
 	struct request *rq;
 
-	/*
-	 * Reads get preferential treatment and are allowed to steal
-	 * from the write free list if necessary.
-	 */
 	if (!list_empty(list)) {
 		rq = blkdev_free_rq(list);
-		goto got_rq;
-	}
-
-	/*
-	 * if the WRITE list is non-empty, we know that rw is READ
-	 * and that the READ list is empty. allow reads to 'steal'
-	 * from the WRITE list.
-	 */
-	if (!list_empty(&q->request_freelist[WRITE])) {
-		list = &q->request_freelist[WRITE];
-		rq = blkdev_free_rq(list);
-		goto got_rq;
+		list_del(&rq->table);
+		rq->free_list = list;
+		rq->rq_status = RQ_ACTIVE;
+		rq->special = NULL;
+		rq->q = q;
+		return rq;
 	}
 
 	return NULL;
-
-got_rq:
-	list_del(&rq->table);
-	rq->free_list = list;
-	rq->rq_status = RQ_ACTIVE;
-	rq->special = NULL;
-	rq->q = q;
-	return rq;
 }
 
 /*

--CE+1k2dSO48ffgeK--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
