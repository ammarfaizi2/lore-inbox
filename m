Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262609AbVCJBea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbVCJBea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVCJBTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:19:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:44703 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262610AbVCJAmY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:24 -0500
Cc: ecashin@coraid.com
Subject: [PATCH] aoe: drivers/block/aoe/aoechr.c cleanups
In-Reply-To: <11104139632443@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:19:24 -0800
Message-Id: <11104139633316@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2040, 2005/03/09 10:22:12-08:00, ecashin@coraid.com

[PATCH] aoe: drivers/block/aoe/aoechr.c cleanups

Adrian Bunk <bunk@stusta.de> writes:

> This patch contains the following cleanups:
> - make the needlessly global struct aoe_fops static
> - #if 0 the unused global function aoechr_hdump

Thanks for the patch.  The original patch leaves the prototype for
aoechr_hdump in aoe.h, but since this function is just for debugging,
it seems better to just take both prototype and definition out.


remove aoechr_hdump
make aoe_fops static

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Ed L. Cashin <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/block/aoe/aoe.h    |    1 -
 drivers/block/aoe/aoechr.c |   37 +------------------------------------
 2 files changed, 1 insertion(+), 37 deletions(-)


diff -Nru a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
--- a/drivers/block/aoe/aoe.h	2005-03-09 16:15:39 -08:00
+++ b/drivers/block/aoe/aoe.h	2005-03-09 16:15:39 -08:00
@@ -143,7 +143,6 @@
 int aoechr_init(void);
 void aoechr_exit(void);
 void aoechr_error(char *);
-void aoechr_hdump(char *, int len);
 
 void aoecmd_work(struct aoedev *d);
 void aoecmd_cfg(ushort, unsigned char);
diff -Nru a/drivers/block/aoe/aoechr.c b/drivers/block/aoe/aoechr.c
--- a/drivers/block/aoe/aoechr.c	2005-03-09 16:15:39 -08:00
+++ b/drivers/block/aoe/aoechr.c	2005-03-09 16:15:39 -08:00
@@ -99,41 +99,6 @@
 		up(&emsgs_sema);
 }
 
-#define PERLINE 16
-void
-aoechr_hdump(char *buf, int n)
-{
-	int bufsiz;
-	char *fbuf;
-	int linelen;
-	char *p, *e, *fp;
-
-	bufsiz = n * 3;			/* 2 hex digits and a space */
-	bufsiz += n / PERLINE + 1;	/* the newline characters */
-	bufsiz += 1;			/* the final '\0' */
-
-	fbuf = kmalloc(bufsiz, GFP_ATOMIC);
-	if (!fbuf) {
-		printk(KERN_INFO
-		       "%s: cannot allocate memory\n",
-		       __FUNCTION__);
-		return;
-	}
-	
-	for (p = buf; n <= 0;) {
-		linelen = n > PERLINE ? PERLINE : n;
-		n -= linelen;
-
-		fp = fbuf;
-		for (e=p+linelen; p<e; p++)
-			fp += sprintf(fp, "%2.2X ", *p & 255);
-		sprintf(fp, "\n");
-		aoechr_error(fbuf);
-	}
-
-	kfree(fbuf);
-}
-
 static ssize_t
 aoechr_write(struct file *filp, const char __user *buf, size_t cnt, loff_t *offp)
 {
@@ -233,7 +198,7 @@
 	}
 }
 
-struct file_operations aoe_fops = {
+static struct file_operations aoe_fops = {
 	.write = aoechr_write,
 	.read = aoechr_read,
 	.open = aoechr_open,

