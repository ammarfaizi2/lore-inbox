Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWJOH2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWJOH2x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 03:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWJOH2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 03:28:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:64906 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964816AbWJOH2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 03:28:52 -0400
X-Authenticated: #14349625
Subject: Re: Major slab mem leak with 2.6.17 / GCC 4.1.1
From: Mike Galbraith <efault@gmx.de>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       "nmeyers@vestmark.com" <nmeyers@vestmark.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0610130459w22e6b9a1g57ee67a2c2b97f81@mail.gmail.com>
References: <20061013004918.GA8551@viviport.com>
	 <84144f020610122256p7f615f93lc6d8dcce7be39284@mail.gmail.com>
	 <b0943d9e0610130459w22e6b9a1g57ee67a2c2b97f81@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-5aOq7PV4RwcbYKTcWVAk"
Date: Sun, 15 Oct 2006 07:59:14 +0000
Message-Id: <1160899154.5935.19.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5aOq7PV4RwcbYKTcWVAk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-10-13 at 12:59 +0100, Catalin Marinas wrote:
> On 13/10/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> > On 10/13/06, nmeyers@vestmark.com <nmeyers@vestmark.com> wrote:
> > > If anyone has a version of kmemleak that I can build with 4.1.1, or
> > > any other suggestions for instrumentation, I'd be happy to gather more
> > > data - the problem is very easy for me to reproduce.
> >
> > You should cc Catalin for that. Alternatively, you could try
> > CONFIG_DEBUG_SLAB_LEAK.
> 
> Thanks for cc'ing me (I'm still on holiday and not following the
> mailing list). The problem is the __builtin_constant_p gcc function
> which doesn't work properly with 4.x versions. It was fixed in latest
> gcc versions though. Kmemleak relies on __builtin_constant_p to
> determine the pointer aliases and without it you would get plenty of
> false positives.

SuSE (for one?) doesn't appear to know about it. gcc version 4.1.2
20060920 (month old prerelease) still has the problem.  After some
rummaging around, I found the fix (attached in case someone else wants
to try it).

2.6.19-rc1 + patch-2.6.19-rc1-kmemleak-0.11 compiles fine now (unless
CONFIG_DEBUG_KEEP_INIT is set), boots and runs too.. but axle grease
runs a lot faster ;-)  I'll try a stripped down config sometime.

	-Mike

--=-5aOq7PV4RwcbYKTcWVAk
Content-Disposition: attachment; filename=gcc41-rh198849.patch
Content-Type: text/x-patch; name=gcc41-rh198849.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

2006-06-04  Mark Shinwell  <shinwell codesourcery com>

	* tree.h: Declare folding_initializer.
	* builtins.c (fold_builtin_constant_p): Give definite answer
	if folding inside an initializer.
	* fold-const.c: Define folding_initializer.
	(START_FOLD_INIT): Save and then set folding_initializer.
	(END_FOLD_INIT): Restore folding_initializer.

	* gcc.c-torture/compile/builtin_constant_p.c: New test.

--- gcc/tree.h	(revision 114357)
+++ gcc/tree.h	(revision 114359)
@@ -4142,6 +4142,10 @@ extern void using_eh_for_cleanups (void)
 
 /* In fold-const.c */
 
+/* Non-zero if we are folding constants inside an initializer; zero
+   otherwise.  */
+extern int folding_initializer;
+
 /* Fold constants as much as possible in an expression.
    Returns the simplified expression.
    Acts only on the top level of the expression;
--- gcc/builtins.c	(revision 114357)
+++ gcc/builtins.c	(revision 114359)
@@ -6495,7 +6495,8 @@ fold_builtin_constant_p (tree arglist)
   if (TREE_SIDE_EFFECTS (arglist)
       || AGGREGATE_TYPE_P (TREE_TYPE (arglist))
       || POINTER_TYPE_P (TREE_TYPE (arglist))
-      || cfun == 0)
+      || cfun == 0
+      || folding_initializer)
     return integer_zero_node;
 
   return 0;
--- gcc/fold-const.c	(revision 114357)
+++ gcc/fold-const.c	(revision 114359)
@@ -59,6 +59,10 @@ Software Foundation, 51 Franklin Street,
 #include "langhooks.h"
 #include "md5.h"
 
+/* Non-zero if we are folding constants inside an initializer; zero
+   otherwise.  */
+int folding_initializer = 0;
+
 /* The following constants represent a bit based encoding of GCC's
    comparison operators.  This encoding simplifies transformations
    on relational comparison operators, such as AND and OR.  */
@@ -11708,16 +11712,19 @@ fold_build3_stat (enum tree_code code, t
   int saved_trapping_math = flag_trapping_math;\
   int saved_rounding_math = flag_rounding_math;\
   int saved_trapv = flag_trapv;\
+  int saved_folding_initializer = folding_initializer;\
   flag_signaling_nans = 0;\
   flag_trapping_math = 0;\
   flag_rounding_math = 0;\
-  flag_trapv = 0
+  flag_trapv = 0;\
+  folding_initializer = 1;
 
 #define END_FOLD_INIT \
   flag_signaling_nans = saved_signaling_nans;\
   flag_trapping_math = saved_trapping_math;\
   flag_rounding_math = saved_rounding_math;\
-  flag_trapv = saved_trapv
+  flag_trapv = saved_trapv;\
+  folding_initializer = saved_folding_initializer;
 
 tree
 fold_build1_initializer (enum tree_code code, tree type, tree op)
--- gcc/testsuite/gcc.c-torture/compile/builtin_constant_p.c	(revision 0)
+++ gcc/testsuite/gcc.c-torture/compile/builtin_constant_p.c	(revision 114359)
@@ -0,0 +1,8 @@
+/* { dg-options "-O2" } */
+
+int main (int argc, char *argv[])
+{
+  static int a[] = { __builtin_constant_p (argc) ? 1 : 0 };
+  return a[0];
+}
+


--=-5aOq7PV4RwcbYKTcWVAk--

