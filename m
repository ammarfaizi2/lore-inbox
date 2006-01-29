Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWA2G0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWA2G0q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 01:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWA2G0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 01:26:45 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26334 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750838AbWA2G0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 01:26:45 -0500
To: Andrew Morton <akpm@osdl.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386: Add a temporary to make put_user more type safe.
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 28 Jan 2006 23:26:18 -0700
Message-ID: <m1r76rft2t.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In some code I am developing I had occasion to change the type of a
variable.  This made the value put_user was putting to user space
wrong.  But the code continued to build cleanly without errors.

Introducing a temporary fixes this problem and at least with gcc-3.3.5
does not cause gcc any problems with optimizing out the temporary.
gcc-4.x using SSA internally ought to be even better at optimizing out
temporaries, so I don't expect a temporary to become a problem.
Especially because in all correct cases the types on both sides of the
assignment to the temporary are the same.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 include/asm-i386/uaccess.h |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

dd1215e541bfe2ed94a902f7fb263ca44b7e8afa
diff --git a/include/asm-i386/uaccess.h b/include/asm-i386/uaccess.h
index 3f1337c..1641613 100644
--- a/include/asm-i386/uaccess.h
+++ b/include/asm-i386/uaccess.h
@@ -198,12 +198,13 @@ extern void __put_user_8(void);
 #define put_user(x,ptr)						\
 ({	int __ret_pu;						\
 	__chk_user_ptr(ptr);					\
+	__typeof__(*(ptr)) __pu_val = x;			\
 	switch(sizeof(*(ptr))) {				\
-	case 1: __put_user_1(x, ptr); break;			\
-	case 2: __put_user_2(x, ptr); break;			\
-	case 4: __put_user_4(x, ptr); break;			\
-	case 8: __put_user_8(x, ptr); break;			\
-	default:__put_user_X(x, ptr); break;			\
+	case 1: __put_user_1(__pu_val, ptr); break;		\
+	case 2: __put_user_2(__pu_val, ptr); break;		\
+	case 4: __put_user_4(__pu_val, ptr); break;		\
+	case 8: __put_user_8(__pu_val, ptr); break;		\
+	default:__put_user_X(__pu_val, ptr); break;		\
 	}							\
 	__ret_pu;						\
 })
-- 
1.1.5.g3480

