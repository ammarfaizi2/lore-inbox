Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWDJKnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWDJKnE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 06:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWDJKnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 06:43:04 -0400
Received: from wine.ocn.ne.jp ([220.111.47.146]:28909 "EHLO
	smtp.wine.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S1751130AbWDJKnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 06:43:01 -0400
To: linux-kernel@vger.kernel.org
Subject: [Cent OS 4.3] Bug in do_execve().
From: Tetsuo Handa <from-linux-kernel@I-love.SAKURA.ne.jp>
Message-Id: <200604101942.GFJ52540.JMFSOVttFSPMGLNYO@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.50]
X-Accept-Language: ja,en
Date: Mon, 10 Apr 2006 19:42:49 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Kernel 2.6.9 has a bug that forgets to undo open_exec() in do_execve().
This bug was fixed in 2.6.10.

I noticed this bug remains in kernel-2.6.9-34.EL.src.rpm for Cent OS.
Distributors who use 2.6.9-based kernels, please check this.

---------- Start of patch ----------
--- before/exec.c	2006-04-10 11:34:58.000000000 +0900
+++ after/exec.c	2006-04-10 13:04:51.000000000 +0900
@@ -1168,8 +1168,11 @@ int do_execve(char * filename,
 
 	retval = -ENOMEM;
 	bprm = kmalloc(sizeof(*bprm), GFP_KERNEL);
-	if (!bprm)
+	if (!bprm) {
+		allow_write_access(file);
+		fput(file);
 		goto out_ret;
+	}
 	memset(bprm, 0, sizeof(*bprm));
 
 	bprm->p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
---------- End of patch ----------

Regards.
