Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161503AbWJ3VZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161503AbWJ3VZs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 16:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161499AbWJ3VZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 16:25:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51106 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161497AbWJ3VZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 16:25:47 -0500
Message-ID: <45466D61.5070701@ce.jp.nec.com>
Date: Mon, 30 Oct 2006 16:23:45 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: torvalds@osdl.org, akpm@osdl.org, rdunlap@xenotime.net, mst@mellanox.co.il,
       linux-kernel@vger.kernel.org
CC: bunk@stusta.de, pavel@suse.cz, len.brown@intel.com,
       linux-acpi@vger.kernel.org, linux-pm@osdl.org, martin@lorenz.eu.org
Subject: [PATCH 2.6.19-rc3] (1/2) fix bd_claim_by_kobject error handling
Content-Type: multipart/mixed;
 boundary="------------000600020308020906090007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000600020308020906090007
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hi,

Excuse me for the long Cc list.
I kept people in the thread below in Cc.
http://marc.theaimsgroup.com/?l=linux-kernel&m=116221664710826&w=2

The patch below fixes bd_claim_by_kobject to release bdev correctly
in case that bd_claim succeeds but following add_bd_holder fails.

If it happens, the caller takes it didn't bd_claim() where actually
it did. The bdev becomes no longer bd_claim-able from others.
I don't have any reproducible test case for it but it's a bug.
The bug is introduced in 2.6.18-rc1-mm2 and now in 2.6.19-rc3.

Please consider to apply.

Thanks,
-- 
Jun'ichi Nomura, NEC Corporation of America

--------------000600020308020906090007
Content-Type: text/x-patch;
 name="fix-bd_claim_by_kobject-error-handling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-bd_claim_by_kobject-error-handling.patch"

The patch below fixes bd_claim_by_kobject to release bdev correctly
in case that bd_claim succeeds but following add_bd_holder fails.

 fs/block_dev.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

--- linux-2.6.orig/fs/block_dev.c	2006-10-30 10:07:16.000000000 -0500
+++ linux-2.6/fs/block_dev.c	2006-10-30 15:38:21.000000000 -0500
@@ -751,8 +751,11 @@ static int bd_claim_by_kobject(struct bl
 
 	mutex_lock_nested(&bdev->bd_mutex, BD_MUTEX_PARTITION);
 	res = bd_claim(bdev, holder);
-	if (res == 0)
+	if (res == 0) {
 		res = add_bd_holder(bdev, bo);
+		if (res)
+			bd_release(bdev);
+	}
 	if (res)
 		free_bd_holder(bo);
 	mutex_unlock(&bdev->bd_mutex);

--------------000600020308020906090007--
