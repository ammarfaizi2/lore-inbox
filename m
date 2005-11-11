Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbVKKIgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbVKKIgG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVKKIgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:36:05 -0500
Received: from i121.durables.org ([64.81.244.121]:5326 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932235AbVKKIgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:36:03 -0500
Date: Fri, 11 Nov 2005 02:35:49 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
In-Reply-To: <1.282480653@selenic.com>
Message-Id: <2.282480653@selenic.com>
Subject: [PATCH 1/15] misc: Add bloat-o-meter to scripts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a rewrite of Andi Kleen's bloat-o-meter with sorting and
reporting of gainers/decliners. Sample output:

add/remove: 0/8 grow/shrink: 2/0 up/down: 88/-4424 (-4336)
function                                     old     new   delta
__copy_to_user_ll                             59     103     +44
__copy_from_user_ll                           59     103     +44
fill_note                                     32       -     -32
maydump                                       58       -     -58
dump_seek                                     67       -     -67
writenote                                    180       -    -180
elf_dump_thread_status                       274       -    -274
fill_psinfo                                  308       -    -308
fill_prstatus                                466       -    -466
elf_core_dump                               3039       -   -3039

The summary line says:
 no functions added, 8 removed
 two functions grew, none shrunk
 we gained 88 bytes and lost 4424 (or -4336 net)

This work was sponsored in part by CE Linux Forum

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tiny/scripts/bloat-o-meter
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ tiny/scripts/bloat-o-meter	2005-10-07 20:15:39.000000000 -0700
@@ -0,0 +1,58 @@
+#!/usr/bin/python
+#
+# Copyright 2004 Matt Mackall <mpm@selenic.com>
+#
+# inspired by perl Bloat-O-Meter (c) 1997 by Andi Kleen
+#
+# This software may be used and distributed according to the terms
+# of the GNU General Public License, incorporated herein by reference.
+
+import sys, os, re
+
+if len(sys.argv) != 3:
+    sys.stderr.write("usage: %s file1 file2\n" % sys.argv[0])
+    sys.exit(-1)
+
+def getsizes(file):
+    sym = {}
+    for l in os.popen("nm --size-sort " + file).readlines():
+        size, type, name = l[:-1].split()
+        if type in "tTdDbB":
+            sym[name] = int(size, 16)
+    return sym
+
+old = getsizes(sys.argv[1])
+new = getsizes(sys.argv[2])
+grow, shrink, add, remove, up, down = 0, 0, 0, 0, 0, 0
+delta, common = [], {}
+
+for a in old:
+    if a in new:
+        common[a] = 1
+
+for name in old:
+    if name not in common:
+        remove += 1
+        down += old[name]
+        delta.append((-old[name], name))
+
+for name in new:
+    if name not in common:
+        add += 1
+        up += new[name]
+        delta.append((new[name], name))
+
+for name in common:
+        d = new.get(name, 0) - old.get(name, 0)
+        if d>0: grow, up = grow+1, up+d
+        if d<0: shrink, down = shrink+1, down-d
+        delta.append((d, name))
+
+delta.sort()
+delta.reverse()
+
+print "add/remove: %s/%s grow/shrink: %s/%s up/down: %s/%s (%s)" % \
+      (add, remove, grow, shrink, up, -down, up-down)
+print "%-40s %7s %7s %+7s" % ("function", "old", "new", "delta")
+for d, n in delta:
+    if d: print "%-40s %7s %7s %+7d" % (n, old.get(n,"-"), new.get(n,"-"), d)
