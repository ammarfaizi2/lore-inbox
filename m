Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWBRNgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWBRNgK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 08:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWBRNgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 08:36:10 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:31116 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751250AbWBRNgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 08:36:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Vw697zXctymQT4U0U1IqW0xsvOM86f94Hly/DsxWRZHEIfMQlmJ05PcBROXCik/NCVrAq2sxVDik7EnlXrQxVTJDbJxvgOeN7RcX42Ia4Xp+iPKSwISg63DkGZPF9JENwQKtCDS7e/UjyMY3DfCTDYuMq9C7GBnQ/4BThsAzmGQ=
Date: Sat, 18 Feb 2006 11:35:56 -0300
From: Davi Arnaut <davi.arnaut@gmail.com>
To: akpm@osdl.org
Cc: davi.arnaut@gmail.com, vsu@altlinux.ru, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] strndup_user (v3), convert (module)
Message-Id: <20060218113556.6f6269b0.davi.arnaut@gmail.com>
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
index 5aad477..443b7a6 100644
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
+	args = strndup_user(uargs, ~0UL >> 1);
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

