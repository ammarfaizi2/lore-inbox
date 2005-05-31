Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVEaTyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVEaTyp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 15:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVEaTyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 15:54:40 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:15001 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261374AbVEaTyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 15:54:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gRJIjfm7DfLkAfGr0imN6MCE9BskcCfd/xHlkLGRDTwDP4gtH85uJJGGllTNYh0/pB+fmb0vRRlp/DMdc68Y9y9bmhmNkuvmQx+mmAo1XopUnw7GmvJXmKwlXEy84wCmMolWfuYPHF6PVyKiPiogkG3s4H9975ZZQ1ZLNT8YOnY=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/2] Introduce tty_unregister_ldisc()
Date: Tue, 31 May 2005 23:56:00 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505312356.00853.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's a bit strange to see tty_register_ldisc() call in modules' exit functions.

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
