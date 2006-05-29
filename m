Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWE3FtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWE3FtY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 01:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWE3FtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 01:49:24 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:2961 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S932075AbWE3FtX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 01:49:23 -0400
From: Rob Landley <rob@landley.net>
To: mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: [PATCH] More bloat-o-meter tweaks.
Date: Mon, 29 May 2006 16:26:04 -0400
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605291626.04327.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the busybox users got confused by what looked like a table but didn't
have the total displayed at the bottom (where it won't scroll off it lots of
stuff changed).  Also, changes to string lengths weren't registering because
nm doesn't look at the rodata segment.  So I improvised.

This may not be the world's cleanest approach to addressing either issue. 
Feel free to improve upon it.  (And yes, it's svn output so it's -p0 instead
of -p1.  Sorry 'bout that.  Need to beat subversion with a large stick one of
these days.)

But what do you think of the approach?

Signed-off-by: Rob Landley <rob@landley.net>

Index: scripts/bloat-o-meter
===================================================================
--- scripts/bloat-o-meter	(revision 15036)
+++ scripts/bloat-o-meter	(working copy)
@@ -20,6 +20,10 @@
         if type in "tTdDbB":
             if "." in name: name = "static." + name.split(".")[0]
             sym[name] = sym.get(name, 0) + int(size, 16)
+    for l in os.popen("readelf -S " + file).readlines():
+        x = l.split()
+        if len(x)<6 or x[1] != ".rodata": continue
+        sym[".rodata"] = int(x[5], 16)
     return sym
 
 old = getsizes(sys.argv[1])
@@ -52,8 +56,10 @@
 delta.sort()
 delta.reverse()
 
-print "add/remove: %s/%s grow/shrink: %s/%s up/down: %s/%s (%s)" % \
-      (add, remove, grow, shrink, up, -down, up-down)
-print "%-40s %7s %7s %+7s" % ("function", "old", "new", "delta")
+print "%-48s %7s %7s %+7s" % ("function", "old", "new", "delta")
 for d, n in delta:
-    if d: print "%-40s %7s %7s %+7d" % (n, old.get(n,"-"), new.get(n,"-"), d)
+    if d: print "%-48s %7s %7s %+7d" % (n, old.get(n,"-"), new.get(n,"-"), d)
+print "-"*78
+total="(add/remove: %s/%s grow/shrink: %s/%s up/down: %s/%s)%%sTotal: %s bytes"\
+    % (add, remove, grow, shrink, up, -down, up-down)
+print total % (" "*(80-len(total)))

-- 
Never bet against the cheap plastic solution.
