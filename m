Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263267AbVGAHae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263267AbVGAHae (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 03:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263268AbVGAHae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 03:30:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23731 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263267AbVGAH3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 03:29:31 -0400
Date: Fri, 1 Jul 2005 00:26:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alasdair G Kergon <agk@redhat.com>
Cc: linux-kernel@vger.kernel.org, kevcorry@us.ibm.com, zhaoqian@aaastor.com
Subject: Re: [PATCH] device-mapper: dm-raid1: Limit bios to size of mirror
 region
Message-Id: <20050701002626.630c2b7d.akpm@osdl.org>
In-Reply-To: <20050630181931.GL4211@agk.surrey.redhat.com>
References: <20050630181931.GL4211@agk.surrey.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alasdair G Kergon <agk@redhat.com> wrote:
>
> Set the target's split_io field when building a dm-mirror device so
> incoming bios won't span the mirror's internal regions.  Without
> this, regions can be accessed while not holding correct locks and data
> corruption is possible.
> 
> Reported-By: "Zhao Qian" <zhaoqian@aaastor.com>
> From: Kevin Corry <kevcorry@us.ibm.com>
> Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
> 
> --- diff/drivers/md/dm-raid1.c	2005-06-17 20:48:29.000000000 +0100
> +++ source/drivers/md/dm-raid1.c	2005-06-29 21:12:13.000000000 +0100
> @@ -1060,6 +1060,7 @@
>  	}
>  
>  	ti->private = ms;
> + 	ti->split_io = ms->rh->region_size;
>  
>  	r = kcopyd_client_create(DM_IO_PAGES, &ms->kcopyd_client);
>  	if (r) {

Ahem.

drivers/md/dm-raid1.c: In function `mirror_ctr':
drivers/md/dm-raid1.c:1072: invalid type argument of `->'

--- devel/drivers/md/dm-raid1.c~device-mapper-dm-raid1-limit-bios-to-size-of-mirror-region-fix	2005-07-01 00:25:26.000000000 -0700
+++ devel-akpm/drivers/md/dm-raid1.c	2005-07-01 00:25:26.000000000 -0700
@@ -1060,7 +1060,7 @@ static int mirror_ctr(struct dm_target *
 	}
 
 	ti->private = ms;
- 	ti->split_io = ms->rh->region_size;
+ 	ti->split_io = ms->rh.region_size;
 
 	r = kcopyd_client_create(DM_IO_PAGES, &ms->kcopyd_client);
 	if (r) {

How well tested was this?
