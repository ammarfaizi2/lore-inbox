Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbTJBBrK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 21:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbTJBBrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 21:47:09 -0400
Received: from hera.cwi.nl ([192.16.191.8]:7813 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263137AbTJBBrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 21:47:06 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 2 Oct 2003 03:46:52 +0200 (MEST)
Message-Id: <UTC200310020146.h921kqg15004.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, torvalds@osdl.org
Subject: [PATCH on sparse] - was Re: [PATCH] fat sparse fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Linus Torvalds <torvalds@osdl.org>

    On Mon, 29 Sep 2003 Andries.Brouwer@cwi.nl wrote:

    > -        if (put_user(0, d2->d_name)            ||
    > +        if (put_user(0, d2->d_name+0)            ||

    The above seems to just work around a sparse bug. Please don't - I'd 
    rather have regular code and try to fix the sparse problem.

    Hmm.. I wonder why sparse doesn't get the address space right on arrays. 
    It should see that "d2" is a user pointer , so d2->d_name is one too.

    It gets it right if you add the "+0", or if you add a "&" in front. So 
    it looks like the sparse array->pointer degeneration misses something.


Please examine the below diff.

Andries

--- sparse-bk/evaluate.c	Wed Sep 10 07:00:14 2003
+++ sparse-bk-aeb/evaluate.c	Thu Oct  2 03:33:33 2003
@@ -799,11 +799,14 @@
 	struct symbol *ctype = op->ctype, *sym;
 
 	sym = alloc_symbol(expr->pos, SYM_NODE);
+
 	if (ctype->type == SYM_NODE) {
+		sym->ctype = ctype->ctype;
 		ctype = ctype->ctype.base_type;
 		merge_type(sym, ctype);
-	}
-	sym->ctype = ctype->ctype;
+	} else
+		sym->ctype = ctype->ctype;
+
 	if (ctype->type != SYM_PTR && ctype->type != SYM_ARRAY) {
 		warn(expr->pos, "cannot derefence this type");
 		return 0;
