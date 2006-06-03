Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030314AbWFCOZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbWFCOZs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 10:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030310AbWFCOZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 10:25:31 -0400
Received: from mx2.mail.ru ([194.67.23.122]:60475 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1030292AbWFCOZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 10:25:03 -0400
Date: Sat, 3 Jun 2006 18:29:30 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/5]: ufs: unlock_super without lock
Message-ID: <20060603142930.GA16404@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ufs_free_blocks function looks now in so way:
if (err)
 goto failed;
 lock_super();
failed:
 unlock_super();

So if error happen we'll unlock not locked super.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---


Index: linux-2.6.17-rc5-mm1/fs/ufs/balloc.c
===================================================================
--- linux-2.6.17-rc5-mm1.orig/fs/ufs/balloc.c
+++ linux-2.6.17-rc5-mm1/fs/ufs/balloc.c
@@ -156,7 +156,7 @@ do_more:
 	bit = ufs_dtogd (fragment);
 	if (cgno >= uspi->s_ncg) {
 		ufs_panic (sb, "ufs_free_blocks", "freeing blocks are outside device");
-		goto failed;
+		goto failed_unlock;
 	}
 	end_bit = bit + count;
 	if (end_bit > uspi->s_fpg) {
@@ -167,11 +167,11 @@ do_more:
 
 	ucpi = ufs_load_cylinder (sb, cgno);
 	if (!ucpi) 
-		goto failed;
+		goto failed_unlock;
 	ucg = ubh_get_ucg (UCPI_UBH(ucpi));
 	if (!ufs_cg_chkmagic(sb, ucg)) {
 		ufs_panic (sb, "ufs_free_blocks", "internal error, bad magic number on cg %u", cgno);
-		goto failed;
+		goto failed_unlock;
 	}
 
 	for (i = bit; i < end_bit; i += uspi->s_fpb) {
@@ -210,8 +210,9 @@ do_more:
 	UFSD("EXIT\n");
 	return;
 
-failed:
+failed_unlock:
 	unlock_super (sb);
+failed:
 	UFSD("EXIT (FAILED)\n");
 	return;
 }

-- 
/Evgeniy

