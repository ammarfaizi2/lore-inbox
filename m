Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965211AbWILAg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbWILAg5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 20:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965212AbWILAg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 20:36:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36056 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965211AbWILAg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 20:36:57 -0400
Message-ID: <4506011F.9080708@ce.jp.nec.com>
Date: Mon, 11 Sep 2006 20:36:47 -0400
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
CC: rdunlap@xenotime.net, Alasdair Kergon <agk@redhat.com>
Subject: [-mm patch] Correct add_bd_holder() return value
Content-Type: multipart/mixed;
 boundary="------------070007040202040504040804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070007040202040504040804
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hi,

In blockdevc-check-errors.patch, add_bd_holder() is modified to
return error values when some of its operation failed.
Among them, it returns -EEXIST when a given bd_holder object already
exists in the list.
However, in this case, the function completed its work successfully
and need no action by its caller other than freeing unused bd_holder
object.
So I think it's better to return success after freeing by itself.

Otherwise, bd_claim-ing with same claim pointer will fail.
Typically, lvresize will fails with following message:
  device-mapper: reload ioctl failed: Invalid argument
and you'll see messages like below in kernel log:
  device-mapper: table: 254:13: linear: dm-linear: Device lookup failed
  device-mapper: ioctl: error adding target to table

Similarly, it should not add bd_holder to the list if either one
of symlinking fails. I don't have a test case for this to happen
but it should cause dereference of freed pointer.

Thanks,
-- 
Jun'ichi Nomura, NEC Corporation of America

--------------070007040202040504040804
Content-Type: text/x-patch;
 name="correct-add_bd_holder-return-value.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="correct-add_bd_holder-return-value.patch"

If a matching bd_holder is found in bd_holder_list,
add_bd_holder() completes its job by just incrementing the reference count.
In this case, it should be considered as success but it used to return 'fail'
to let the caller free temporary bd_holder.
Fixed it to return success and free given object by itself.

Also, if either one of symlinking fails, the bd_holder should not
be added to the list so that it can be discarded later.
Otherwise, the caller will free bd_holder which is in the list.

This patch is neccessary only for -mm (later than 2.6.18-rc1-mm1).

 fs/block_dev.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

diff -urp linux-2.6.18-rc5-mm1.orig/fs/block_dev.c linux-2.6.18-rc5-mm1/fs/block_dev.c
--- linux-2.6.18-rc5-mm1.orig/fs/block_dev.c	2006-09-11 19:33:35.000000000 -0400
+++ linux-2.6.18-rc5-mm1/fs/block_dev.c	2006-09-11 19:21:46.000000000 -0400
@@ -655,8 +655,8 @@ static void free_bd_holder(struct bd_hol
  * If there is no matching entry with @bo in @bdev->bd_holder_list,
  * add @bo to the list, create symlinks.
  *
- * Returns 0 if @bo was added to the list.
- * Returns -ve if @bo wasn't used by any reason and should be freed.
+ * Returns 0 if symlinks are created or already there.
+ * Returns -ve if something fails and @bo can be freed.
  */
 static int add_bd_holder(struct block_device *bdev, struct bd_holder *bo)
 {
@@ -669,7 +669,9 @@ static int add_bd_holder(struct block_de
 	list_for_each_entry(tmp, &bdev->bd_holder_list, list) {
 		if (tmp->sdir == bo->sdir) {
 			tmp->count++;
-			return -EEXIST;
+			/* We've already done what we need to do here. */
+			free_bd_holder(bo);
+			return 0;
 		}
 	}
 
@@ -682,7 +684,8 @@ static int add_bd_holder(struct block_de
 		if (ret)
 			del_symlink(bo->sdir, bo->sdev);
 	}
-	list_add_tail(&bo->list, &bdev->bd_holder_list);
+	if (ret == 0)
+		list_add_tail(&bo->list, &bdev->bd_holder_list);
 	return ret;
 }

--------------070007040202040504040804--
