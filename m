Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUKMHXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUKMHXM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 02:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUKMHXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 02:23:12 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:40080 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261474AbUKMHXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 02:23:03 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jurriaan <thunder7@xs4all.nl>
Date: Sat, 13 Nov 2004 18:25:49 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16789.46845.6950.773945@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: md linear personality oops on boot with 2.6.10-rc1-mm4 and 2.6.10-rc1-mm5
In-Reply-To: message from Jurriaan on Friday November 12
References: <20041112143012.GA3676@middle.of.nowhere>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday November 12, thunder7@xs4all.nl wrote:
> 
> In 2.6.9-mm1, this works.
> In 2.6.10-rc1-mm4 and 2.6.10-rc1-mm5, I get an oops during boot:
> 
> linear_run+0x20b
> 

Thanks.  Looks like an unsigned variable going negative:-(
I made the mistake of only testing it with a linear array with all
components the same size.

Please verify that this patch fixes it.

Thanks,
NeilBrown


###Comments for ChangeSet
Fix problem with unsigned variable going "negative" in linear.c

We replace 'size' by 'start'.
'start' means exactly the same as 'curr_offset - size', and
the equivalence of the new code can be tested based on this.
The difference is that 'start' will never be negative and so can
fit in a 'sector_t' while 'size' could be negative.

Also make curr_offset sector_t, as it should have been.

Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>

### Diffstat output
 ./drivers/md/linear.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff ./drivers/md/linear.c~current~ ./drivers/md/linear.c
--- ./drivers/md/linear.c~current~	2004-11-13 17:34:23.000000000 +1100
+++ ./drivers/md/linear.c	2004-11-13 18:18:17.000000000 +1100
@@ -117,8 +117,8 @@ static int linear_run (mddev_t *mddev)
 	struct linear_hash *table;
 	mdk_rdev_t *rdev;
 	int i, nb_zone, cnt;
-	sector_t size;
-	unsigned int curr_offset;
+	sector_t start;
+	sector_t curr_offset;
 	struct list_head *tmp;
 
 	conf = kmalloc (sizeof (*conf) + mddev->raid_disks*sizeof(dev_info_t),
@@ -193,23 +193,24 @@ static int linear_run (mddev_t *mddev)
 	 * Here we generate the linear hash table
 	 */
 	table = conf->hash_table;
-	size = 0;
+	start = 0;
 	curr_offset = 0;
 	for (i = 0; i < cnt; i++) {
 		dev_info_t *disk = conf->disks + i;
 
+		if (start > curr_offset)
+			table[-1].dev1 = disk;
+
 		disk->offset = curr_offset;
 		curr_offset += disk->size;
 
-		if (size < 0) {
-			table[-1].dev1 = disk;
-		}
-		size += disk->size;
-
-		while (size>0) {
+		/* 'curr_offset' is the end of this disk
+		 * 'start' is the start of table
+		 */
+		while (start < curr_offset) {
 			table->dev0 = disk;
 			table->dev1 = NULL;
-			size -= conf->smallest->size;
+			start += conf->smallest->size;
 			table++;
 		}
 	}
