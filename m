Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbULYVXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbULYVXS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 16:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbULYVXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 16:23:18 -0500
Received: from gprs212-19.eurotel.cz ([160.218.212.19]:27266 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261570AbULYVWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 16:22:49 -0500
Date: Sat, 25 Dec 2004 22:22:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: docs: add sparse howto
Message-ID: <20041225212235.GA20147@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Installing / using sparse is not exactly trivial, this should make
setting it up easier. Please apply, 
								Pavel

Adapted From: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean/Documentation/sparse.txt	2004-10-16 23:48:08.000000000 +0200
+++ linux/Documentation/sparse.txt	2004-10-24 22:44:47.000000000 +0200
@@ -0,0 +1,72 @@
+Copyright 2004 Linus Torvalds
+Copyright 2004 Pavel Machek <pavel@suse.cz>
+
+Using sparse for typechecking
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+"__bitwise" is a type attribute, so you have to do something like this:
+
+        typedef int __bitwise pm_request_t;
+
+        enum pm_request {
+                PM_SUSPEND = (__force pm_request_t) 1,
+                PM_RESUME = (__force pm_request_t) 2
+        };
+
+which makes PM_SUSPEND and PM_RESUME "bitwise" integers (the "__force" is
+there because sparse will complain about casting to/from a bitwise type,
+but in this case we really _do_ want to force the conversion). And because
+the enum values are all the same type, now "enum pm_request" will be that
+type too.
+
+And with gcc, all the __bitwise/__force stuff goes away, and it all ends
+up looking just like integers to gcc.
+
+Quite frankly, you don't need the enum there. The above all really just
+boils down to one special "int __bitwise" type.
+
+So the simpler way is to just do
+
+        typedef int __bitwise pm_request_t;
+
+        #define PM_SUSPEND ((__force pm_request_t) 1)
+        #define PM_RESUME ((__force pm_request_t) 2)
+
+and you now have all the infrastructure needed for strict typechecking.
+
+One small note: the constant integer "0" is special. You can use a
+constant zero as a bitwise integer type without sparse ever complaining.
+This is because "bitwise" (as the name implies) was designed for making
+sure that bitwise types don't get mixed up (little-endian vs big-endian
+vs cpu-endian vs whatever), and there the constant "0" really _is_
+special.
+
+Modify top-level Makefile to say
+
+CHECK           = sparse -Wbitwise
+
+or you don't get any checking at all.
+
+
+Where to get sparse
+~~~~~~~~~~~~~~~~~~~
+
+With BK, you can just get it from
+
+        bk://sparse.bkbits.net/sparse
+
+and DaveJ has tar-balls at
+
+	http://www.codemonkey.org.uk/projects/bitkeeper/sparse/
+
+
+Once you have it, just do
+
+        make
+        make install
+
+as your regular user, and it will install sparse in your ~/bin directory.
+After that, doing a kernel make with "make C=1" will run sparse on all the
+C files that get recompiled, or with "make C=2" will run sparse on the
+files whether they need to be recompiled or not (ie the latter is fast way
+to check the whole tree if you have already built it).

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
