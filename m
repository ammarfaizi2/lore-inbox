Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161281AbVKIWHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161281AbVKIWHp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161286AbVKIWHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:07:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48554 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161281AbVKIWHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:07:44 -0500
Date: Wed, 09 Nov 2005 17:07:32 -0500 (EST)
Message-Id: <20051109.170732.41627574.k-ueda@ct.jp.nec.com>
To: agk@redhat.com, dm-devel@redhat.com
Cc: linux-kernel@vger.kernel.org, j-nomura@ce.jp.nec.com, k-ueda@ct.jp.nec.com
Subject: [PATCH] dm: memory leak in failed table_load()
From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
X-Mailer: Mew version 2.3 on Emacs 20.7 / Mule 4.1
 =?iso-2022-jp?B?KBskQjAqGyhCKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alasdair,

This patch fixes following two problems which occur when "dmsetup load foo"
is executed before the map of the "foo" is created.

  o memory leak.
  o unable to unload the dm_mod module.

Please consider to apply.

How to reproduce the problem:
  # echo "0 10 linear 8:16 0" | dmsetup load foo
  (Need to change "8:16" appropriately.)

Patch for 2.6.14:
Signed-off-by: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

diff -up 2.6.14/drivers/md/dm-ioctl.c fix/drivers/md/dm-ioctl.c
--- 2.6.14/drivers/md/dm-ioctl.c	2005-10-27 20:02:08.000000000 -0400
+++ fix/drivers/md/dm-ioctl.c	2005-11-09 15:29:59.000000000 -0500
@@ -974,6 +974,7 @@ static int table_load(struct dm_ioctl *p
 	if (!hc) {
 		DMWARN("device doesn't appear to be in the dev hash table.");
 		up_write(&_hash_lock);
+		dm_table_put(t);
 		return -ENXIO;
 	}

Thanks,
Kiyoshi Ueda
