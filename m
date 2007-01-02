Return-Path: <linux-kernel-owner+w=401wt.eu-S964785AbXABMKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbXABMKx (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 07:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbXABMKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 07:10:53 -0500
Received: from brick.kernel.dk ([62.242.22.158]:15549 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964785AbXABMKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 07:10:52 -0500
Date: Tue, 2 Jan 2007 13:10:48 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Rene Herman <rene.herman@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Tejun Heo <htejun@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.20-rc2+: CFQ halving disk throughput.
Message-ID: <20070102121048.GU2483@kernel.dk>
References: <45893CAD.9050909@gmail.com> <45921E73.1080601@gmail.com> <4592B25A.4040906@gmail.com> <45932AF1.9040900@gmail.com> <45998F62.6010904@gmail.com> <20070101213601.c526f779.akpm@osdl.org> <20070102084447.GS2483@kernel.dk> <459A32E5.70506@gmail.com> <20070102115757.GT2483@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070102115757.GT2483@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02 2007, Jens Axboe wrote:
> On Tue, Jan 02 2007, Rene Herman wrote:
> > Jens Axboe wrote:
> > 
> > >On Mon, Jan 01 2007, Andrew Morton wrote:
> > 
> > >>The patch would appear to need this fix:
> > >>
> > >>--- a/block/cfq-iosched.c~a
> > >>+++ a/block/cfq-iosched.c
> > >>@@ -592,7 +592,7 @@ static int cfq_allow_merge(request_queue
> > >> 	if (cfqq == RQ_CFQQ(rq))
> > >> 		return 1;
> > >> 
> > >>-	return 1;
> > >>+	return 0;
> > >> }
> > >> 
> > >> static inline void
> > >>_
> > >>
> > >>But that might not fix things...
> > >
> > >Yeah it is, but I don't think it'll fix it (if anything, it'll be more
> > >conservative).
> > 
> > (to possibly save others from trying -- no, doesn't fix any)
> 
> As expected. The issue is rq_is_sync(rq) takes the data direction into
> account as well, while bio_sync() only checks the sync bit. This should
> fix it.

And here a little more relaxed version, as Mark Lord suggested. We allow
merge of async bio into a sync request, but not vice versa.

Both patches pending testing, will do so now.

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 4b4217d..07b7062 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -577,9 +577,9 @@ static int cfq_allow_merge(request_queue
 	pid_t key;
 
 	/*
-	 * Disallow merge, if bio and rq aren't both sync or async
+	 * Disallow merge of a sync bio into an async request.
 	 */
-	if (!!bio_sync(bio) != !!rq_is_sync(rq))
+	if ((bio_data_dir(bio) == READ || bio_sync(bio)) && !rq_is_sync(rq))
 		return 0;
 
 	/*
@@ -592,7 +592,7 @@ static int cfq_allow_merge(request_queue
 	if (cfqq == RQ_CFQQ(rq))
 		return 1;
 
-	return 1;
+	return 0;
 }
 
 static inline void

-- 
Jens Axboe

