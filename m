Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267298AbUIAP6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267298AbUIAP6s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 11:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUIAP6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:58:10 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:59826 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267298AbUIAPvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:51:43 -0400
Date: Wed, 1 Sep 2004 16:51:20 +0100
Message-Id: <200409011551.i81FpKXC000610@delerium.codemonkey.org.uk>
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix leak in ISAPNP core
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks odd, but there doesn't seem to be an
isapnp_free() or similar..

Spotted with the source checker from Coverity.com.

Signed-off-by: Dave Jones <davej@redhat.com>


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/pnp/isapnp/core.c linux-2.6/drivers/pnp/isapnp/core.c
--- bk-linus/drivers/pnp/isapnp/core.c	2004-06-19 00:01:33.000000000 +0100
+++ linux-2.6/drivers/pnp/isapnp/core.c	2004-08-23 14:08:16.000000000 +0100
@@ -655,8 +655,10 @@ static int __init isapnp_create_device(s
 	if ((dev = isapnp_parse_device(card, size, number++)) == NULL)
 		return 1;
 	option = pnp_register_independent_option(dev);
-	if (!option)
+	if (!option) {
+		kfree(dev);
 		return 1;
+	}
 	pnp_add_card_device(card,dev);
 
 	while (1) {
