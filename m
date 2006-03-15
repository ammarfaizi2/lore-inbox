Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWCOCvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWCOCvF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 21:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbWCOCvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 21:51:05 -0500
Received: from metis.starhub.net.sg ([203.117.3.21]:32534 "EHLO
	metis.starhub.net.sg") by vger.kernel.org with ESMTP
	id S1750846AbWCOCvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 21:51:04 -0500
X-SBRS: 3.5
X-HAT: Message received through Sender Group RELAYLIST,Policy $RELAYED applied.
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
Date: Wed, 15 Mar 2006 10:39:00 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Fix hostap_cs double kfree
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: jkmaline@cc.hut.fi
Reply-to: Eugene Teo <eugene.teo@eugeneteo.net>
Message-id: <20060315023900.GA8179@eugeneteo.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-PGP-Key: http://www.honeynet.org/misc/pgp/eugene-teo.pgp
X-Operating-System: Debian GNU/Linux 2.6.16-rc6
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

prism2_config() kfree's twice if kmalloc fails.

Coverity bug #930

Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>

--- linux-2.6/drivers/net/wireless/hostap/hostap_cs.c~	2006-03-15 10:05:36.000000000 +0800
+++ linux-2.6/drivers/net/wireless/hostap/hostap_cs.c	2006-03-15 10:24:53.000000000 +0800
@@ -585,8 +585,6 @@
 	parse = kmalloc(sizeof(cisparse_t), GFP_KERNEL);
 	hw_priv = kmalloc(sizeof(*hw_priv), GFP_KERNEL);
 	if (parse == NULL || hw_priv == NULL) {
-		kfree(parse);
-		kfree(hw_priv);
 		ret = -ENOMEM;
 		goto failed;
 	}
@@ -783,8 +781,10 @@
 	cs_error(link->handle, last_fn, last_ret);
 
  failed:
-	kfree(parse);
-	kfree(hw_priv);
+	if (parse)
+		kfree(parse);
+	if (hw_priv)
+		kfree(hw_priv);
 	prism2_release((u_long)link);
 	return ret;
 }

-- 
1024D/A6D12F80 print D51D 2633 8DAC 04DB 7265  9BB8 5883 6DAA A6D1 2F80
main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i); }
