Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVAaOk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVAaOk2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 09:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVAaOk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 09:40:27 -0500
Received: from ns1.coraid.com ([65.14.39.133]:202 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S261220AbVAaOkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 09:40:12 -0500
To: linux-kernel@vger.kernel.org
Cc: Adrian Bunk <bunk@stusta.de>, Greg K-H <greg@kroah.com>
Subject: Re: [2.6 patch] drivers/block/aoe/aoechr.c cleanups
References: <20050129133520.GV28047@stusta.de>
From: Ed L Cashin <ecashin@coraid.com>
Date: Mon, 31 Jan 2005 09:34:58 -0500
In-Reply-To: <20050129133520.GV28047@stusta.de> (Adrian Bunk's message of
 "Sat, 29 Jan 2005 14:35:20 +0100")
Message-ID: <87acqpu0od.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Adrian Bunk <bunk@stusta.de> writes:

> This patch contains the following cleanups:
> - make the needlessly global struct aoe_fops static
> - #if 0 the unused global function aoechr_hdump

Thanks for the patch.  The original patch leaves the prototype for
aoechr_hdump in aoe.h, but since this function is just for debugging,
it seems better to just take both prototype and definition out.


remove aoechr_hdump
make aoe_fops static

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

--=-=-=
Content-Disposition: inline; filename=diff-cleanup

diff -urNp aa/drivers/block/aoe/aoe.h bb/drivers/block/aoe/aoe.h
--- aa/drivers/block/aoe/aoe.h	2005-01-31 09:20:53.000000000 -0500
+++ bb/drivers/block/aoe/aoe.h	2005-01-31 09:21:01.000000000 -0500
@@ -143,7 +143,6 @@ void aoedisk_rm_sysfs(struct aoedev *d);
 int aoechr_init(void);
 void aoechr_exit(void);
 void aoechr_error(char *);
-void aoechr_hdump(char *, int len);
 
 void aoecmd_work(struct aoedev *d);
 void aoecmd_cfg(ushort, unsigned char);
diff -urNp aa/drivers/block/aoe/aoechr.c bb/drivers/block/aoe/aoechr.c
--- aa/drivers/block/aoe/aoechr.c	2005-01-31 09:20:53.000000000 -0500
+++ bb/drivers/block/aoe/aoechr.c	2005-01-31 09:21:01.000000000 -0500
@@ -99,41 +99,6 @@ bail:		spin_unlock_irqrestore(&emsgs_loc
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
@@ -233,7 +198,7 @@ loop:
 	}
 }
 
-struct file_operations aoe_fops = {
+static struct file_operations aoe_fops = {
 	.write = aoechr_write,
 	.read = aoechr_read,
 	.open = aoechr_open,

--=-=-=



-- 
  Ed L Cashin <ecashin@coraid.com>

--=-=-=--

