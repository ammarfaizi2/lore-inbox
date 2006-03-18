Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWCRXxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWCRXxK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 18:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWCRXxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 18:53:10 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:52084 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751147AbWCRXxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 18:53:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=R3JXhuAGUpXo+w+UEQxS4JjiTRNoeT9EC82pE2cGQ4nLqt3rkSFbXJ/Y6YuIcUzVeAu+bzUJh2eijM+aQLd44LvusBbeopMGo3lsfyoBSQqdVRfVAjtZUszl4Vv2oNB29w2KlE73Z4Zi27MuR63IHb/0ejX3J7TtgKb9AZGQ9Ig=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix resource leak in isapnp
Date: Sun, 19 Mar 2006 00:52:27 +0100
User-Agent: KMail/1.9.1
Cc: Jaroslav Kysela <perex@suse.cz>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603190052.27770.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We may leak memory in drivers/pnp/isapnp/core.c::isapnp_create_device()
Spotted by the Coverity checker as bug #666 - this should fix it.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/pnp/isapnp/core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.16-rc6-orig/drivers/pnp/isapnp/core.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-rc6/drivers/pnp/isapnp/core.c	2006-03-19 00:49:04.000000000 +0100
@@ -646,8 +646,10 @@ static int __init isapnp_create_device(s
 				size = 0;
 				skip = 0;
 				option = pnp_register_independent_option(dev);
-				if (!option)
+				if (!option) {
+					kfree(dev);
 					return 1;
+				}
 				pnp_add_card_device(card,dev);
 			} else {
 				skip = 1;


