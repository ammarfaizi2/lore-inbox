Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWBOUXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWBOUXS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 15:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWBOUXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 15:23:18 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:20941 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751287AbWBOUXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 15:23:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=SiCEYpPbsZ9LojcCfnGD2j/lSp35cERGs4cKL2uPpbo7RPUVaz5ACh1toxSWpVE276phPKHv8D7MBR767sXJAVLQAm2A4ZZVItS4mRGDyqlv4XycZ8o45H/qf6TTm1SkvFNf6qq4Gl3pxUUOxEuvh2D4a7fjcPxm7z1UyIhG4SU=
Date: Wed, 15 Feb 2006 18:23:06 -0300
From: Davi Arnaut <davi.arnaut@gmail.com>
To: torvalds@osdl.org
Cc: davi.arnaut@gmail.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] strndup_user, convert (module)
Message-Id: <20060215182306.d26a4121.davi.arnaut@gmail.com>
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert kernel/module.c string duplication to strdup_user()

Signed-off-by: Davi Arnaut <davi.arnaut@gmail.com>
--

diff --git a/kernel/module.c b/kernel/module.c
index 5aad477..d7d428d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1538,7 +1538,6 @@ static struct module *load_module(void _
 	unsigned int i, symindex = 0, strindex = 0, setupindex, exindex,
 		exportindex, modindex, obsparmindex, infoindex, gplindex,
 		crcindex, gplcrcindex, versindex, pcpuindex;
-	long arglen;
 	struct module *mod;
 	long err = 0;
 	void *percpu = NULL, *ptr = NULL; /* Stops spurious gcc warning */
@@ -1655,23 +1654,11 @@ static struct module *load_module(void _
 	}
 
 	/* Now copy in args */
-	arglen = strlen_user(uargs);
-	if (!arglen) {
-		err = -EFAULT;
-		goto free_hdr;
-	}
-	args = kmalloc(arglen, GFP_KERNEL);
-	if (!args) {
-		err = -ENOMEM;
+	args = strdup_user(uargs);
+	if (IS_ERR(args)) {
+		err = PTR_ERR(args);
 		goto free_hdr;
 	}
-	if (copy_from_user(args, uargs, arglen) != 0) {
-		err = -EFAULT;
-		goto free_mod;
-	}
-
-	/* Userspace could have altered the string after the strlen_user() */
-	args[arglen - 1] = '\0';
 
 	if (find_module(mod->name)) {
 		err = -EEXIST;
