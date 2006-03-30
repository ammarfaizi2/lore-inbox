Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWC3GM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWC3GM2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 01:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWC3GM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 01:12:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4324 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751100AbWC3GM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 01:12:27 -0500
Date: Wed, 29 Mar 2006 22:12:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 001 of 3] md: Don't clear bits in bitmap when writing to
 one device fails during recovery.
Message-Id: <20060329221209.20e7fd00.akpm@osdl.org>
In-Reply-To: <1060330055237.25270@suse.de>
References: <20060330164933.25210.patches@notabene>
	<1060330055237.25270@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown <neilb@suse.de> wrote:
>
> +	if (!uptodate) {
>  +		int sync_blocks = 0;
>  +		sector_t s = r1_bio->sector;
>  +		long sectors_to_go = r1_bio->sectors;
>  +		/* make sure these bits doesn't get cleared. */
>  +		do {
>  +			bitmap_end_sync(mddev->bitmap, r1_bio->sector,
>  +					&sync_blocks, 1);
>  +			s += sync_blocks;
>  +			sectors_to_go -= sync_blocks;
>  +		} while (sectors_to_go > 0);
>   		md_error(mddev, conf->mirrors[mirror].rdev);
>  +	}

Can mddev->bitmap be NULL?

If so, will the above loop do the right thing when this:

void bitmap_end_sync(struct bitmap *bitmap, sector_t offset, int *blocks, int aborted)
{
	bitmap_counter_t *bmc;
	unsigned long flags;
/*
	if (offset == 0) printk("bitmap_end_sync 0 (%d)\n", aborted);
*/	if (bitmap == NULL) {
		*blocks = 1024;
		return;
	}

triggers?
