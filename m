Return-Path: <linux-kernel-owner+w=401wt.eu-S1755279AbXABFgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755279AbXABFgM (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 00:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755280AbXABFgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 00:36:12 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33250 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755279AbXABFgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 00:36:11 -0500
Date: Mon, 1 Jan 2007 21:36:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rene Herman <rene.herman@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.20-rc2+: CFQ halving disk throughput.
Message-Id: <20070101213601.c526f779.akpm@osdl.org>
In-Reply-To: <45998F62.6010904@gmail.com>
References: <45893CAD.9050909@gmail.com>
	<45921E73.1080601@gmail.com>
	<4592B25A.4040906@gmail.com>
	<45932AF1.9040900@gmail.com>
	<45998F62.6010904@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Jan 2007 23:46:58 +0100
Rene Herman <rene.herman@gmail.com> wrote:

> > Everything seems fine in the dmesg.  Performance degradation is
> > probably some other issue in -rc kernel.  I'm suspecting recently
> > fixed block layer bug.  If it's still the same in the next -rc,
> > please report.
> 
> In fact, it's CFQ. The PATA thing was a red herring. 2.6.20-rc2 and 3 
> give me ~ 24 MB/s from "hdparm t /dev/hda" while 2.6.20-rc1 and below 
> give me ~ 50 MB/s.
> 
> Jens: this is due to "[PATCH] cfq-iosched: tighten allow merge 
> criteria", 719d34027e1a186e46a3952e8a24bf91ecc33837:
> 
> http://www2.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=719d34027e1a186e46a3952e8a24bf91ecc33837
> 
> If I revert that one, I have my 50 M/s back. config and dmesg attached 
> in case they're useful.

The patch would appear to need this fix:

--- a/block/cfq-iosched.c~a
+++ a/block/cfq-iosched.c
@@ -592,7 +592,7 @@ static int cfq_allow_merge(request_queue
 	if (cfqq == RQ_CFQQ(rq))
 		return 1;
 
-	return 1;
+	return 0;
 }
 
 static inline void
_

But that might not fix things...
