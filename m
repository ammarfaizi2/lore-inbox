Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161036AbWBHGsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbWBHGsr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161034AbWBHGse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:48:34 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:28033 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161014AbWBHGnH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:43:07 -0500
Message-Id: <20060208064849.262214000@sorel.sous-sol.org>
References: <20060208064503.924238000@sorel.sous-sol.org>
Date: Tue, 07 Feb 2006 22:45:05 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       git-commits-head@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Stefan Rompf <stefan@loplof.de>,
       Clemens Fruhwirth <clemens@endorphin.org>,
       Alasdair G Kergon <agk@redhat.com>
Subject: [PATCH 02/23] [PATCH] dm-crypt: zero key before freeing it
Content-Disposition: inline; filename=dm-crypt-zero-key-before-freeing-it.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Zap the memory before freeing it so we don't leave crypto information
around in memory.

Signed-off-by: Stefan Rompf <stefan@loplof.de>
Acked-by: Clemens Fruhwirth <clemens@endorphin.org>
Acked-by: Alasdair G Kergon <agk@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/md/dm-crypt.c |    5 +++++
 1 files changed, 5 insertions(+)

Index: linux-2.6.15.3/drivers/md/dm-crypt.c
===================================================================
--- linux-2.6.15.3.orig/drivers/md/dm-crypt.c
+++ linux-2.6.15.3/drivers/md/dm-crypt.c
@@ -690,6 +690,8 @@ bad3:
 bad2:
 	crypto_free_tfm(tfm);
 bad1:
+	/* Must zero key material before freeing */
+	memset(cc, 0, sizeof(*cc) + cc->key_size * sizeof(u8));
 	kfree(cc);
 	return -EINVAL;
 }
@@ -706,6 +708,9 @@ static void crypt_dtr(struct dm_target *
 		cc->iv_gen_ops->dtr(cc);
 	crypto_free_tfm(cc->tfm);
 	dm_put_device(ti, cc->dev);
+
+	/* Must zero key material before freeing */
+	memset(cc, 0, sizeof(*cc) + cc->key_size * sizeof(u8));
 	kfree(cc);
 }
 

--
