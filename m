Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267184AbTBKHOy>; Tue, 11 Feb 2003 02:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267189AbTBKHOy>; Tue, 11 Feb 2003 02:14:54 -0500
Received: from dp.samba.org ([66.70.73.150]:22671 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267184AbTBKHOv>;
	Tue, 11 Feb 2003 02:14:51 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, torvalds@transmeta.com
Subject: [PATCH] Bug in binfmt_misc?
Date: Tue, 11 Feb 2003 17:33:22 +1100
Message-Id: <20030211072439.3B09D2C0D5@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I can tell, this should never cause a problem, but someone
pointed this out:

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.21-pre4/fs/binfmt_misc.c working-2.4.21-pre4-rest-non_drivers/fs/binfmt_misc.c
--- linux-2.4.21-pre4/fs/binfmt_misc.c	2002-08-03 13:54:15.000000000 +1000
+++ working-2.4.21-pre4-rest-non_drivers/fs/binfmt_misc.c	2003-02-11 14:29:34.000000000 +1100
@@ -128,6 +128,8 @@ static int load_misc_binary(struct linux
 	retval = copy_strings_kernel(1, &iname_addr, bprm);
 	if (retval < 0) goto _ret; 
 	bprm->argc++;
+	/* BUG: iname is a local variable and given to an outside struct.
+	 * 	this will cause problems when function scope ends */
 	bprm->filename = iname;	/* for binfmt_script */
 
 	file = open_exec(iname);


Now, if this isn't a problem, the following should at least catch any
future misuses:

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.21-pre4/fs/binfmt_misc.c working-2.4.21-pre4-rest-non_drivers/fs/binfmt_misc.c
--- linux-2.4.21-pre4/fs/binfmt_misc.c	2002-08-03 13:54:15.000000000 +1000
+++ working-2.4.21-pre4-rest-non_drivers/fs/binfmt_misc.c	2003-02-11 15:03:06.000000000 +1100
@@ -139,6 +139,7 @@ static int load_misc_binary(struct linux
 	retval = prepare_binprm(bprm);
 	if (retval >= 0)
 		retval = search_binary_handler(bprm, regs);
+	bprm->filename = NULL;
 _ret:
 	return retval;
 }

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
