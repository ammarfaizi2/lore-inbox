Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVCTXKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVCTXKl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 18:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVCTXHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 18:07:46 -0500
Received: from ns3.dataphone.se ([212.37.0.170]:29139 "EHLO
	mail-slave.dataphone.se") by vger.kernel.org with ESMTP
	id S261334AbVCTXGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 18:06:17 -0500
From: Magnus Damm <damm@opensource.se>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>
Message-Id: <20050320223824.25305.94292.15135@clementine.local>
In-Reply-To: <20050320223814.25305.52695.65404@clementine.local>
References: <20050320223814.25305.52695.65404@clementine.local>
Subject: [PATCH 2/5] autoparam: script
Date: Mon, 21 Mar 2005 00:06:16 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The quick ruby hack that generates text from the section data. The script
should probably be rewritten in some other languare to minimize dependencies.
Parameters without types are the result of MODULE_PARM_DESC typos or the use of
MODULE_PARM() instead of module_param() and are treated as errors.

Signed-off-by: Magnus Damm <damm@opensource.se>

diff -urN linux-2.6.12-rc1/scripts/section2text.rb linux-2.6.12-rc1-autoparam/scripts/section2text.rb
--- linux-2.6.12-rc1/scripts/section2text.rb	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-rc1-autoparam/scripts/section2text.rb	2005-03-20 22:53:10.847470760 +0100
@@ -0,0 +1,72 @@
+#!/usr/bin/env ruby
+
+param = {}   # param[parametername] = [ type, description ]
+
+STDIN.read.split("\0").each do | x |
+  if x != ""
+    d = x.split
+    p = d.shift
+    t = d.shift
+
+    if d.length > 0
+      d = d.join(" ")
+    else
+      d = ""
+    end
+
+    if param[p]
+      if param[p][0] == "()"
+        param[p][0] = t
+      end
+      if param[p][1] == ""
+        param[p][1] = d
+      end
+    else
+      param[p] = [ t, d ]
+    end
+  end
+end
+
+bad = []
+
+param.keys.sort.each do | p |
+  t, d = param[p]
+
+  if t == "()"
+    bad << p
+  end
+end
+
+if bad != []
+  STDERR.puts "#{bad.length} error(s):"
+  bad.each do | p |
+    STDERR.puts "MODULE_PARM_DESC() on non-existing parameter \"#{p}\""
+  end
+  exit 1
+end
+
+param.keys.sort.each do | p |
+  t, d = param[p]
+
+  if not t
+    if p.index("=")
+      t = "(string)"
+    else
+      t = "(bool)"
+    end
+  end
+
+  if t == "()"
+    bad << p
+  else
+    puts "#{p} #{t}"
+    if d == ""
+      puts "  Unknown"
+    else
+      puts "  #{d}"
+    end
+    puts
+  end
+end
+
+exit 0
