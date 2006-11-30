Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758626AbWK3HrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758626AbWK3HrX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 02:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758545AbWK3HrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 02:47:23 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:61639 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1758626AbWK3HrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 02:47:22 -0500
Message-ID: <456EA5BF.6090304@in.ibm.com>
Date: Thu, 30 Nov 2006 15:04:55 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.8 (X11/20061105)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, swhiteho@redhat.com,
       fabbione@ubuntu.com, bunk@stusta.de, aarora@linux.vnet.ibm.com,
       aarora@in.ibm.com
Subject: [RFC][PATCH] Mount problem with the GFS2 code
Content-Type: multipart/mixed;
 boundary="------------020006050100090108000501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020006050100090108000501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all
  While mounting the gfs2 filesystem,our test team had a problem and we 
got this error message.
=======================================================

GFS2: fsid=: Trying to join cluster "lock_nolock", "dasde1"
GFS2: fsid=dasde1.0: Joined cluster. Now mounting FS...
GFS2: not a GFS2 filesystem
GFS2: fsid=dasde1.0: can't read superblock: -22

==========================================================================
On debugging further we found that problem is while reading the super 
block(gfs2_read_super) and comparing the magic number in it.
When I  replace the submit_bio() call(present in gfs2_read_super) with 
the sb_getblk() and ll_rw_block(), mount operation succeded.
On further analysis we found that before calling submit_bio(), 
bio->bi_sector was set to "sector" variable. This "sector" variable has 
the same value of bh->b_blocknr(block number). Hence there is a need to 
multiply this valuwith (blocksize >> 9)(9 because,sector size 
2^9,samething happens in ll_rw_block also, before calling submit_bio()).
So I have developed the patch which solves this problem. Please let me 
know your comments.
================================================================

Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>



--------------020006050100090108000501
Content-Type: text/plain;
 name="gfs2.fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gfs2.fix"

 super.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.19-rc6/fs/gfs2/super.c
===================================================================
--- linux-2.6.19-rc6.orig/fs/gfs2/super.c
+++ linux-2.6.19-rc6/fs/gfs2/super.c
@@ -199,7 +199,7 @@ struct page *gfs2_read_super(struct supe
 		return NULL;
 	}
 
-	bio->bi_sector = sector;
+	bio->bi_sector = sector * (sb->s_blocksize >> 9);
 	bio->bi_bdev = sb->s_bdev;
 	bio_add_page(bio, page, PAGE_SIZE, 0);
 

--------------020006050100090108000501--
