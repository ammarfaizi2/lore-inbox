Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbTFJVMV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbTFJVKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:10:49 -0400
Received: from air-2.osdl.org ([65.172.181.6]:41366 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264054AbTFJVJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 17:09:51 -0400
Date: Tue, 10 Jun 2003 14:24:04 -0700
From: Dave Olien <dmo@osdl.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sparse type checking on function pointers
Message-ID: <20030610212404.GA25410@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes type checking on function arguments that are pointers
to functions.  Below is an example.

int total;

void dofunc(void (f)(int))
{
	f(5);
}

void func(int z)
{
	total += z;
}

main(void)
{
	dofunc(func);
}

without this patch, check reports the warnings:

warning: testfunc.c:16:9: incorrect type in argument 1 (different base types)
warning: testfunc.c:16:9:   expected void ( f )( ... )
warning: testfunc.c:16:9:   got void ( * )( ... )

------------------------------------------------------------------------

--- sparse_original/evaluate.c	2003-06-03 09:00:47.000000000 -0700
+++ sparse_test/evaluate.c	2003-06-10 12:08:23.000000000 -0700
@@ -431,6 +431,17 @@
 			/* Ignore ARRAY/PTR differences, as long as they point to the same type */
 			type1 = type1 == SYM_ARRAY ? SYM_PTR : type1;
 			type2 = type2 == SYM_ARRAY ? SYM_PTR : type2;
+
+			if ((type1 == SYM_PTR) && (target->ctype.base_type->type == SYM_FN)) {
+				target = target->ctype.base_type;
+				type1 = SYM_FN;
+			}
+
+			if ((type2 == SYM_PTR) && (source->ctype.base_type->type == SYM_FN)) {
+				source = source->ctype.base_type;
+				type2 = SYM_FN;
+			}
+
 			if (type1 != type2)
 				return "different base types";
 		}
