Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267632AbSKTHUG>; Wed, 20 Nov 2002 02:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267643AbSKTHT7>; Wed, 20 Nov 2002 02:19:59 -0500
Received: from dp.samba.org ([66.70.73.150]:50643 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267632AbSKTHTs>;
	Wed, 20 Nov 2002 02:19:48 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, arashi@arashi.yi.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] mii module broken under new scheme
Date: Wed, 20 Nov 2002 09:23:01 +1100
Message-Id: <20021120072653.BFDC42C056@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, this is a better fix, until the module post-link patch goes in
(rth and I are working on it, Kai likes the idea for other reasons).

Once again, fix up my assumptions so we err on the side of not
breaking anything.

Untested (on plane home and low on battery), but trivial.

Hope this helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/kernel/module.c working-2.5-bk-modname/kernel/module.c
--- linux-2.5-bk/kernel/module.c	2002-11-20 05:58:00.000000000 +1100
+++ working-2.5-bk-modname/kernel/module.c	2002-11-20 09:18:04.000000000 +1100
@@ -895,12 +895,6 @@ static struct module *load_module(void *
 #endif
 	}
 
-	if (!modnameindex) {
-		DEBUGP("Module has no name!\n");
-		err = -ENOEXEC;
-		goto free_hdr;
-	}
-
 	/* Now allocate space for the module proper, and copy name and args. */
 	err = strlen_user(uargs);
 	if (err < 0)
@@ -917,8 +911,17 @@ static struct module *load_module(void *
 		err = -EFAULT;
 		goto free_mod;
 	}
-	strncpy(mod->name, (char *)hdr + sechdrs[modnameindex].sh_offset,
-		sizeof(mod->name)-1);
+
+	if (modnameindex)
+		strncpy(mod->name,
+			(char *)hdr + sechdrs[modnameindex].sh_offset,
+			sizeof(mod->name)-1);
+	else {
+		/* FIXME: With module post-link phase, always insert
+                   .modname section. --RR */
+		static unsigned int num_unknown;
+		sprintf(mod->name, "unknown%u", num_unknown++);
+	}
 
 	if (find_module(mod->name)) {
 		err = -EEXIST;
