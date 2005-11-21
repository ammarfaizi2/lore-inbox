Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVKUW16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVKUW16 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbVKUW16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:27:58 -0500
Received: from [205.233.219.253] ([205.233.219.253]:23177 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S1751174AbVKUW15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:27:57 -0500
Date: Mon, 21 Nov 2005 17:24:52 -0500
From: Jody McIntyre <scjody@steamballoon.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Adrian Bunk <bunk@stusta.de>, bcollins@debian.org,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] csr1212: check results of keyval reads
Message-ID: <20051121222452.GQ20781@conscoop.ottawa.on.ca>
References: <20051120231000.GE16060@stusta.de> <438223D9.8010504@s5r6.in-berlin.de> <20051121214130.GL20781@conscoop.ottawa.on.ca> <438243E2.6050807@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438243E2.6050807@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

csr1212_parse_csr() did not properly check return values when reading
keyvals.  Fix this by using _csr1212_read_keyval() instead of
csr1212_get_keyval() and checking the return code.

Signed-off-by: Jody McIntyre <scjody@steamballoon.com>

Index: linux/drivers/ieee1394/csr1212.c
===================================================================
--- linux.orig/drivers/ieee1394/csr1212.c
+++ linux/drivers/ieee1394/csr1212.c
@@ -1610,15 +1610,16 @@ int csr1212_parse_csr(struct csr1212_csr
 	csr->root_kv->valid = 0;
 	csr->root_kv->next = csr->root_kv;
 	csr->root_kv->prev = csr->root_kv;
-	csr1212_get_keyval(csr, csr->root_kv);
+	ret = _csr1212_read_keyval(csr, csr->root_kv);
+	if (ret != CSR1212_SUCCESS)
+		return ret;
 
 	/* Scan through the Root directory finding all extended ROM regions
 	 * and make cache regions for them */
 	for (dentry = csr->root_kv->value.directory.dentries_head;
 	     dentry; dentry = dentry->next) {
 		if (dentry->kv->key.id == CSR1212_KV_ID_EXTENDED_ROM) {
-			csr1212_get_keyval(csr, dentry->kv);
-
+			ret = _csr1212_read_keyval(csr, dentry->kv);
 			if (ret != CSR1212_SUCCESS)
 				return ret;
 		}
