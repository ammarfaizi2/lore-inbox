Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265081AbSKRV7N>; Mon, 18 Nov 2002 16:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbSKRV6U>; Mon, 18 Nov 2002 16:58:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16141 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265012AbSKRV6J>;
	Mon, 18 Nov 2002 16:58:09 -0500
Date: Mon, 18 Nov 2002 22:05:08 +0000
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Cc: Janitors <kernel-janitor-discuss@lists.sourceforge.net>
Subject: More interesting problems than C99 initialisers
Message-ID: <20021118220508.P7530@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm seeing a lot of energy being expended converting the kernel from GNU
style initialisers to C99 style.  While proactively fixing the whims
of the gcc developers is laudable, there are more pressing problems.
gcc 3.2/3.3 seem to emit many more warnings -- I believe -Wall now
includes -Wsign-compare, but they don't document this in their changes
file.  Time spent fixing these additional warnings seems much more useful.

Use of the min/max macros also causes warnings in some cases.
See: http://gcc.gnu.org/ml/gcc/2002-11/msg00327.html and
http://gcc.gnu.org/ml/gcc/2002-11/msg00333.html

We can't compile the kernel with -std=gnu99 because our spinlock
initialisers are apparently a gnu89 extension that's removed from gnu99.

BTW, here's a patch that fixes gnu89 mode to not warn about min/max:

Index: gcc/c-decl.c
===================================================================
RCS file: /cvsroot/gcc/gcc/gcc/c-decl.c,v
retrieving revision 1.353
diff -u -r1.353 c-decl.c
--- gcc/c-decl.c        10 Nov 2002 16:24:24 -0000      1.353
+++ gcc/c-decl.c        18 Nov 2002 22:03:49 -0000
@@ -3788,12 +3788,15 @@
   restrictp = !! (specbits & 1 << (int) RID_RESTRICT) + TYPE_RESTRICT (type);
   volatilep = !! (specbits & 1 << (int) RID_VOLATILE) + TYPE_VOLATILE (type);
   inlinep = !! (specbits & (1 << (int) RID_INLINE));
-  if (constp > 1 && ! flag_isoc99)
-    pedwarn ("duplicate `const'");
-  if (restrictp > 1 && ! flag_isoc99)
-    pedwarn ("duplicate `restrict'");
-  if (volatilep > 1 && ! flag_isoc99)
-    pedwarn ("duplicate `volatile'");
+  if (flag_iso && ! flag_isoc99)
+    {
+      if (constp > 1)
+       pedwarn ("duplicate `const'");
+      if (restrictp > 1)
+       pedwarn ("duplicate `restrict'");
+      if (volatilep > 1)
+       pedwarn ("duplicate `volatile'");
+    }
   if (! flag_gen_aux_info && (TYPE_QUALS (type)))
     type = TYPE_MAIN_VARIANT (type);
   type_quals = ((constp ? TYPE_QUAL_CONST : 0)

I certainly can't be bothered to go through their submissions procedure
for a patch which will probably be rejected.  Maybe vendors will pick
up this patch.  Who knows.

-- 
Revolutions do not require corporate support.
