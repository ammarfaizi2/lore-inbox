Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWFVDnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWFVDnP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 23:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932745AbWFVDnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 23:43:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59324 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932193AbWFVDnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 23:43:14 -0400
Date: Wed, 21 Jun 2006 20:43:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Orlov <bugfixer@list.ru>
Cc: linux-kernel@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>,
       reiserfs-dev@namesys.com
Subject: Re: bitmap loading related reiserfs changes in 2.6.17-mm1 are
 broken
Message-Id: <20060621204303.47facd01.akpm@osdl.org>
In-Reply-To: <20060622032733.GA5158@nickolas.homeunix.com>
References: <20060622032733.GA5158@nickolas.homeunix.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 23:27:33 -0400
Nick Orlov <bugfixer@list.ru> wrote:

> subj.
> 
> I've got a lot of BUG's during the boot and eventually box locked up.
> SYS-RQ worked. Unfortunately none of these errors did make it to log files,
> so I cannot provide the backtraces.
> 
> But reverting last 4 patches of reiserfs-changes series, namely
> 
> reiserfs-reorganize-bitmap-loading-functions.patch
> reiserfs-on-demand-bitmap-loading.patch
> reiserfs-on-demand-bitmap-loading-fix.patch
> reiserfs-use-generic_file_open-for-open-checks.patch
> 
> fixed the problem for me.
> 

Yeah, sorry.  I've uploaded the below to the hot-fixes directory - it
should repair things.


Jeff, given its track record, I have to say that my confidence in this work
is nanoscopic.  Given that, and given the importance of reiserfs and given
the low rate of reiser3 development and given my ignorance of how reiserfs
works, I'm inclined to move very slowly on these patches.

It would really help if Chris or one of the namesys developers could take
the time to review and test these patches closely, please.



diff -puN fs/reiserfs/bitmap.c~reiserfs-reorganize-bitmap-loading-functions-fix fs/reiserfs/bitmap.c
--- a/fs/reiserfs/bitmap.c~reiserfs-reorganize-bitmap-loading-functions-fix
+++ a/fs/reiserfs/bitmap.c
@@ -1292,25 +1292,25 @@ void reiserfs_cache_bitmap_metadata(stru
                                     struct buffer_head *bh,
                                     struct reiserfs_bitmap_info *info)
 {
-	unsigned long *cur = (unsigned long *)bh->b_data;
-	int i;
+	unsigned long *cur = (unsigned long *)(bh->b_data + bh->b_size);
+
+	while (--cur >= (unsigned long *)bh->b_data) {
+		int base = ((char *)cur - bh->b_data) << 3;
 
-	for (i = sb->s_blocksize / sizeof (*cur); i > 0; i--, cur++) {
 		/* 0 and ~0 are special, we can optimize for them */
 		if (*cur == 0) {
-			info->first_zero_hint = i << 3;
-			info->free_count += sizeof (*cur) << 3;
+			info->first_zero_hint = base;
+			info->free_count += BITS_PER_LONG;
 		} else if (*cur != ~0L) {       /* A mix, investigate */
 			int b;
-			for (b = sizeof (*cur) << 3; b >= 0; b--) {
+			for (b = BITS_PER_LONG - 1; b >= 0; b--) {
 				if (!reiserfs_test_le_bit(b, cur)) {
-					info->first_zero_hint = (i << 3) + b;
+					info->first_zero_hint = base + b;
 					info->free_count++;
 				}
 			}
 		}
 	}
-
 	/* The first bit must ALWAYS be 1 */
 	BUG_ON(info->first_zero_hint == 0);
 }
_

