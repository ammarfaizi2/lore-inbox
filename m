Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267566AbSLEWhU>; Thu, 5 Dec 2002 17:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267567AbSLEWhT>; Thu, 5 Dec 2002 17:37:19 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:29194 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S267566AbSLEWhS>; Thu, 5 Dec 2002 17:37:18 -0500
Date: Thu, 5 Dec 2002 16:44:50 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] GCC patch for detecting pre-C99 initializers
Message-ID: <20021205224450.GA10638@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The latest kernels have stamped out many of the pre-C99 initializers,
and 2.5.51 will remove even more. There are still a few hanging around
here and there, and some will be fixed when Linus merges updates for
various bits of code (i.e. framebuffer, things in drivers/mtd, etc).

Here's a handy little patch I've just built GCC with that will warn if
the obsolete style initializers are used. GCC-3.2 can do this now if the
'-pedantic' flag is used, but building a kernel with that flag generates
a huge amount of noise, and adding '-std=gnu99' reduces some of it, but
then the kernel fails to build do to compiler problems. This patch
changes GCC so it always warns if it encounters an old style
initializer. No flags are needed to activate this warning (and none turn
it off), so it will always catch these obsolete constructs.  This patch
flagged a few initializers that my script for doing the changes had missed,
so it's proven useful to me already. Hopefully others will agree.

If you rebuild the compiler with this patch and run the test suite, be
aware that a number of failures will occur due to the warnings printed
out because of the old initializers. A few files in the test suite need
patching so they either use the new initializers or expect the warnings.
Also, building a 2.4 kernel with the modified compiler will produce lots
of warnings, so the compiler would best be used for just dealing with
2.5 kernels.

The patch is against the current gcc-3-2 branch. I don't have a patch
for what will become 3-3, but I'll bet this could be used there. As the
old style constructs have been obsolete since gcc-2.5, it may be
worthwhile to try and get this into the GCC-3.3 compiler. I don't know
what the feelings are regarding that are, so I'll see what sort of
feedback I get from posting this ( no flames please! :-) ) before it
would be sent off to GCC land.

Art Haas

Index: gcc/c-parse.in
===================================================================
RCS file: /cvsroot/gcc/gcc/gcc/c-parse.in,v
retrieving revision 1.127.2.2.4.2
diff -u -r1.127.2.2.4.2 c-parse.in
--- gcc/c-parse.in	21 Oct 2002 18:37:41 -0000	1.127.2.2.4.2
+++ gcc/c-parse.in	5 Dec 2002 22:29:12 -0000
@@ -1520,12 +1520,10 @@
 		{ if (pedantic && ! flag_isoc99)
 		    pedwarn ("ISO C89 forbids specifying subobject to initialize"); }
 	| designator initval
-		{ if (pedantic)
-		    pedwarn ("obsolete use of designated initializer without `='"); }
+		{ warning ("obsolete use of designated initializer without `='"); }
 	| identifier ':'
 		{ set_init_label ($1);
-		  if (pedantic)
-		    pedwarn ("obsolete use of designated initializer with `:'"); }
+		  warning ("obsolete use of designated initializer with `:'"); }
 	  initval
 		{}
 	| initval
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
