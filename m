Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWHaIGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWHaIGW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 04:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWHaIGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 04:06:22 -0400
Received: from tim.rpsys.net ([194.106.48.114]:20183 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751279AbWHaIGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 04:06:20 -0400
Subject: Re: end_swap_bio_write error handling
From: Richard Purdie <rpurdie@rpsys.net>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060831105826.b45ea424.kamezawa.hiroyu@jp.fujitsu.com>
References: <1156884514.5600.70.camel@localhost.localdomain>
	 <20060831105826.b45ea424.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 09:05:31 +0100
Message-Id: <1157011532.5530.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 10:58 +0900, KAMEZAWA Hiroyuki wrote:
> Now, swap-write-failure-fixup.patch is merged in -mm kernel.
> ==
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/broken-out/mm-swap-write-failure-fixup.patch
> ==
> error message comes and a page turns to be dirty again.

+	if (!uptodate) {
 		SetPageError(page);
+		/*
+		 * We failed to write the page out to swap-space.
+		 * Re-dirty the page in order to avoid it being reclaimed.
+		 * Also print a dire warning that things will go BAD (tm)
+		 * very quickly.
+		 *
+		 * Also clear PG_reclaim to avoid rotate_reclaimable_page()
+		 */
+		set_page_dirty(page);
+		printk(KERN_ALERT "Write-error on swap-device (%d:%d)\n",
+				imajor(bio->bi_bdev->bd_inode),
+				iminor(bio->bi_bdev->bd_inode));
+		ClearPageReclaim(page);

I'm not 100% convinced this will help as if you SetPageError, it will
still end up killing off the processes involved. Removing the
SetPageError gives much more stable results in my testing. I was
wondering how to stop it repeatedly trying to write to the particular
swap file sector. ClearPageReclaim() doesn't appear to help much as
rotate_reclaimable_page() does check if a page is dirty.

Ideally, we should remap the page to a new swap sector so we can mark
the existing one as bad. The easiest way to do that might be to have the
page move out of the PageSwapCache although I've not worked out how to
do that yet.

Richard



