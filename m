Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272442AbTGZIjJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 04:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272444AbTGZIjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 04:39:09 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:19721 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S272442AbTGZIjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 04:39:04 -0400
Subject: Re: Random Oopses on 2.6.0-test1-mm2
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Apurva Mehta <apurva@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030726071801.GB1358@home.woodlands>
References: <20030726071801.GB1358@home.woodlands>
Content-Type: multipart/mixed; boundary="=-LpPfWSyatzZkTSFM0sD/"
Message-Id: <1059209649.577.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3.99 
Date: Sat, 26 Jul 2003 10:54:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LpPfWSyatzZkTSFM0sD/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2003-07-26 at 09:18, Apurva Mehta wrote:
> Hi, 
> 
> I get random oopses while using 2.6.0-test1-mm2. I have attached the
> oops message and also the ksymoops output. I get the same behaviour
> with the 08int patch applied also. The OOPs message attached was
> obtained on a 2.6.0-test1-mm2-08int.

Please, try the following patch...

--=-LpPfWSyatzZkTSFM0sD/
Content-Disposition: attachment; filename=ext3-inode.patch
Content-Type: text/x-patch; name=ext3-inode.patch; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

diff -puN fs/ext3/inode.c~ext3_getblk-race-fix-fix fs/ext3/inode.c
--- 25/fs/ext3/inode.c~ext3_getblk-race-fix-fix	2003-07-19 22:59:50.000000000 -0700
+++ 25-akpm/fs/ext3/inode.c	2003-07-19 23:07:42.000000000 -0700
@@ -936,19 +936,17 @@ struct buffer_head *ext3_getblk(handle_t
 			   ext3_get_block instead, so it's not a
 			   problem. */
 			lock_buffer(bh);
-			if (!buffer_uptodate(bh)) {
-				BUFFER_TRACE(bh, "call get_create_access");
-				fatal = ext3_journal_get_create_access(handle, bh);
-				if (!fatal) {
-					memset(bh->b_data, 0,
-							inode->i_sb->s_blocksize);
-					set_buffer_uptodate(bh);
-				}
+			BUFFER_TRACE(bh, "call get_create_access");
+			fatal = ext3_journal_get_create_access(handle, bh);
+			if (!fatal && !buffer_uptodate(bh)) {
+				memset(bh->b_data, 0, inode->i_sb->s_blocksize);
+				set_buffer_uptodate(bh);
 			}
 			unlock_buffer(bh);
 			BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
 			err = ext3_journal_dirty_metadata(handle, bh);
-			if (!fatal) fatal = err;
+			if (!fatal)
+				fatal = err;
 		} else {
 			BUFFER_TRACE(bh, "not a new buffer");
 		}

_


--=-LpPfWSyatzZkTSFM0sD/--

