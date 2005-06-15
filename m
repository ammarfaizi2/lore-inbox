Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVFOVlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVFOVlv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVFOVlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:41:17 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:65448 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261584AbVFOVh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 17:37:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FeJvKU++yl75icdjoMK7/KaKy+yo2OnZnhIWEWKVDjlfGCgrS7pGwN+jYVYFIF3zD5QppXUNbE9mTCBkEnzvv/TtLrkVHK2c3ICPk6ix2jkfEfh2YmBzkw3MHeZzNlRVKwzDXAi4UA8armbI0qGjy8QU4ybCd1jVDnR5jDF0X38=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/2] Introduce tty_unregister_ldisc()
Date: Thu, 16 Jun 2005 01:40:46 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506160140.46721.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's a bit strange to see tty_register_ldisc call in modules' exit functions.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Documentation/tty.txt |    2 +-
 drivers/char/tty_io.c |   35 ++++++++++++++++++++++++-----------
 include/linux/tty.h   |    1 +
 3 files changed, 26 insertions(+), 12 deletions(-)

diff -uprN linux-tty_register_ldisc_000/Documentation/tty.txt linux-tty_register_ldisc_001/Documentation/tty.txt
--- linux-tty_register_ldisc_000/Documentation/tty.txt	2005-05-31 20:12:47.000000000 +0400
+++ linux-tty_register_ldisc_001/Documentation/tty.txt	2005-05-31 23:19:32.000000000 +0400
@@ -22,7 +22,7 @@ copy of the structure. You must not re-r
 discipline even with the same data or your computer again will be eaten by
 demons.
 
-In order to remove a line discipline call tty_register_ldisc passing NULL.
+In order to remove a line discipline call tty_unregister_ldisc().
 In ancient times this always worked. In modern times the function will
 return -EBUSY if the ldisc is currently in use. Since the ldisc referencing
 code manages the module counts this should not usually be a concern.
diff -uprN linux-tty_register_ldisc_000/drivers/char/tty_io.c linux-tty_register_ldisc_001/drivers/char/tty_io.c
--- linux-tty_register_ldisc_000/drivers/char/tty_io.c	2005-05-31 20:13:34.000000000 +0400
+++ linux-tty_register_ldisc_001/drivers/char/tty_io.c	2005-05-31 23:17:40.000000000 +0400
@@ -262,17 +262,10 @@ int tty_register_ldisc(int disc, struct 
 		return -EINVAL;
 	
 	spin_lock_irqsave(&tty_ldisc_lock, flags);
-	if (new_ldisc) {
-		tty_ldiscs[disc] = *new_ldisc;
-		tty_ldiscs[disc].num = disc;
-		tty_ldiscs[disc].flags |= LDISC_FLAG_DEFINED;
-		tty_ldiscs[disc].refcount = 0;
-	} else {
-		if(tty_ldiscs[disc].refcount)
-			ret = -EBUSY;
-		else
-			tty_ldiscs[disc].flags &= ~LDISC_FLAG_DEFINED;
-	}
+	tty_ldiscs[disc] = *new_ldisc;
+	tty_ldiscs[disc].num = disc;
+	tty_ldiscs[disc].flags |= LDISC_FLAG_DEFINED;
+	tty_ldiscs[disc].refcount = 0;
 	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 	
 	return ret;
@@ -280,6 +273,26 @@ int tty_register_ldisc(int disc, struct 
 
 EXPORT_SYMBOL(tty_register_ldisc);
 
+int tty_unregister_ldisc(int disc)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	if (disc < N_TTY || disc >= NR_LDISCS)
+		return -EINVAL;
+
+	spin_lock_irqsave(&tty_ldisc_lock, flags);
+	if (tty_ldiscs[disc].refcount)
+		ret = -EBUSY;
+	else
+		tty_ldiscs[disc].flags &= ~LDISC_FLAG_DEFINED;
+	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+
+	return ret;
+}
+
+EXPORT_SYMBOL(tty_unregister_ldisc);
+
 struct tty_ldisc *tty_ldisc_get(int disc)
 {
 	unsigned long flags;
diff -uprN linux-tty_register_ldisc_000/include/linux/tty.h linux-tty_register_ldisc_001/include/linux/tty.h
--- linux-tty_register_ldisc_000/include/linux/tty.h	2005-05-31 20:15:51.000000000 +0400
+++ linux-tty_register_ldisc_001/include/linux/tty.h	2005-05-31 23:18:23.000000000 +0400
@@ -345,6 +345,7 @@ extern int tty_check_change(struct tty_s
 extern void stop_tty(struct tty_struct * tty);
 extern void start_tty(struct tty_struct * tty);
 extern int tty_register_ldisc(int disc, struct tty_ldisc *new_ldisc);
+extern int tty_unregister_ldisc(int disc);
 extern int tty_register_driver(struct tty_driver *driver);
 extern int tty_unregister_driver(struct tty_driver *driver);
 extern void tty_register_device(struct tty_driver *driver, unsigned index, struct device *dev);
