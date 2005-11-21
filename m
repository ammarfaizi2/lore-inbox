Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbVKUVsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbVKUVsE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbVKUVsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:48:03 -0500
Received: from [205.233.219.253] ([205.233.219.253]:19912 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S1751078AbVKUVsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:48:01 -0500
Date: Mon, 21 Nov 2005 16:41:30 -0500
From: Jody McIntyre <scjody@steamballoon.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Adrian Bunk <bunk@stusta.de>, bcollins@debian.org,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/csr1212.c: remove dead code
Message-ID: <20051121214130.GL20781@conscoop.ottawa.on.ca>
References: <20051120231000.GE16060@stusta.de> <438223D9.8010504@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438223D9.8010504@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 08:45:29PM +0100, Stefan Richter wrote:

> Or for better yet, we should use _csr1212_read_keyval() instead so that 
> we get more sensible error codes.

Good idea.  How about:


csr1212: check results of keyval reads

csr1212_parse_csr() did not properly check return values when reading
keyvals.  Fix this by using _csr1212_read_keyval() instead of
csr1212_get_keyval() and checking the return code.

Signed-off-by: Jody McIntyre <scjody@steamballoon.com>

Index: linux/drivers/ieee1394/csr1212.c
===================================================================
--- linux.orig/drivers/ieee1394/csr1212.c
+++ linux/drivers/ieee1394/csr1212.c
@@ -1610,16 +1610,16 @@ int csr1212_parse_csr(struct csr1212_csr
 	csr->root_kv->valid = 0;
 	csr->root_kv->next = csr->root_kv;
 	csr->root_kv->prev = csr->root_kv;
-	csr1212_get_keyval(csr, csr->root_kv);
+	if (_csr1212_read_keyval(csr, csr->root_kv) != CSR1212_SUCCESS)
+		return ret;
 
 	/* Scan through the Root directory finding all extended ROM regions
 	 * and make cache regions for them */
 	for (dentry = csr->root_kv->value.directory.dentries_head;
 	     dentry; dentry = dentry->next) {
 		if (dentry->kv->key.id == CSR1212_KV_ID_EXTENDED_ROM) {
-			csr1212_get_keyval(csr, dentry->kv);
-
-			if (ret != CSR1212_SUCCESS)
+			if (_csr1212_read_keyval(csr, dentry->kv) !=
+						CSR1212_SUCCESS)
 				return ret;
 		}
 	}

> -- 
> Stefan Richter
> -=====-=-=-= =-== =-=-=
> http://arcgraph.de/sr/
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
> Register for a JBoss Training Course.  Free Certification Exam
> for All Training Attendees Through End of 2005. For more info visit:
> http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
> _______________________________________________
> mailing list linux1394-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux1394-devel

-- 
