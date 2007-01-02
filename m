Return-Path: <linux-kernel-owner+w=401wt.eu-S964770AbXABL6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770AbXABL6D (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 06:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932897AbXABL6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 06:58:03 -0500
Received: from brick.kernel.dk ([62.242.22.158]:27418 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932888AbXABL6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 06:58:01 -0500
Date: Tue, 2 Jan 2007 12:57:57 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Rene Herman <rene.herman@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Tejun Heo <htejun@gmail.com>,
       Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.20-rc2+: CFQ halving disk throughput.
Message-ID: <20070102115757.GT2483@kernel.dk>
References: <45893CAD.9050909@gmail.com> <45921E73.1080601@gmail.com> <4592B25A.4040906@gmail.com> <45932AF1.9040900@gmail.com> <45998F62.6010904@gmail.com> <20070101213601.c526f779.akpm@osdl.org> <20070102084447.GS2483@kernel.dk> <459A32E5.70506@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459A32E5.70506@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02 2007, Rene Herman wrote:
> Jens Axboe wrote:
> 
> >On Mon, Jan 01 2007, Andrew Morton wrote:
> 
> >>The patch would appear to need this fix:
> >>
> >>--- a/block/cfq-iosched.c~a
> >>+++ a/block/cfq-iosched.c
> >>@@ -592,7 +592,7 @@ static int cfq_allow_merge(request_queue
> >> 	if (cfqq == RQ_CFQQ(rq))
> >> 		return 1;
> >> 
> >>-	return 1;
> >>+	return 0;
> >> }
> >> 
> >> static inline void
> >>_
> >>
> >>But that might not fix things...
> >
> >Yeah it is, but I don't think it'll fix it (if anything, it'll be more
> >conservative).
> 
> (to possibly save others from trying -- no, doesn't fix any)

As expected. The issue is rq_is_sync(rq) takes the data direction into
account as well, while bio_sync() only checks the sync bit. This should
fix it.

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 4b4217d..26fb40f 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -574,12 +574,14 @@ static int cfq_allow_merge(request_queue
 	struct cfq_data *cfqd = q->elevator->elevator_data;
 	const int rw = bio_data_dir(bio);
 	struct cfq_queue *cfqq;
+	int bio_is_sync;
 	pid_t key;
 
 	/*
 	 * Disallow merge, if bio and rq aren't both sync or async
 	 */
-	if (!!bio_sync(bio) != !!rq_is_sync(rq))
+	bio_is_sync = bio_data_dir(bio) == READ || bio_sync(bio);
+	if (bio_is_sync != !!rq_is_sync(rq))
 		return 0;
 
 	/*
@@ -592,7 +594,7 @@ static int cfq_allow_merge(request_queue
 	if (cfqq == RQ_CFQQ(rq))
 		return 1;
 
-	return 1;
+	return 0;
 }
 

-- 
Jens Axboe

