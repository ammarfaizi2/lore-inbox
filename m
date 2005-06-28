Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVF1LFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVF1LFt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 07:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVF1LFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 07:05:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26326 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261299AbVF1LDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 07:03:03 -0400
Date: Tue, 28 Jun 2005 04:02:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marco Colombo <marco@esi.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tracking down a memory leak
Message-Id: <20050628040217.0132d9cc.akpm@osdl.org>
In-Reply-To: <1119950283.26948.271.camel@Frodo.esi>
References: <1119263592.31049.19.camel@Frodo.esi>
	<1119950283.26948.271.camel@Frodo.esi>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Colombo <marco@esi.it> wrote:
>
> Thanks to everybody who replied to me. Here's more data:
> 
>  sh-2.05b# sort -rn +1 /proc/slabinfo | head -5
>  biovec-1          7502216 7502296     16  226    1 : tunables  120   60    0 : slabdata  33196  33196      0
>  bio               7502216 7502262     96   41    1 : tunables  120   60    0 : slabdata 182982 182982      0

Are you using RAID?




From: Neil Brown <neilb@cse.unsw.edu.au>

insert a missing bio_put when writing the md superblock.

Without this we have a steady growth in the "bio" slab.

Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/md/md.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/md/md.c~md-bio-leak-fix drivers/md/md.c
--- 25/drivers/md/md.c~md-bio-leak-fix	2005-06-27 22:29:13.000000000 -0700
+++ 25-akpm/drivers/md/md.c	2005-06-27 22:29:13.000000000 -0700
@@ -338,6 +338,7 @@ static int super_written(struct bio *bio
 
 	if (atomic_dec_and_test(&rdev->mddev->pending_writes))
 		wake_up(&rdev->mddev->sb_wait);
+	bio_put(bio);
 	return 0;
 }
 
_

