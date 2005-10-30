Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932810AbVJ3DsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932810AbVJ3DsP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 23:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932811AbVJ3DsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 23:48:15 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:54979 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932810AbVJ3DsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 23:48:15 -0400
Date: Sat, 29 Oct 2005 23:48:07 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: David Weinehall <tao@acc.umu.se>
cc: linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>
Subject: Re: [ketchup] patch to allow for moving of .gitignore in 2.6.14
In-Reply-To: <20051030011959.GA17750@vasa.acc.umu.se>
Message-ID: <Pine.LNX.4.58.0510292343280.10073@localhost.localdomain>
References: <Pine.LNX.4.58.0510170316310.5859@localhost.localdomain>
 <20051017213915.GN26160@waste.org> <Pine.LNX.4.58.0510180211320.13581@localhost.localdomain>
 <20051018063031.GR26160@waste.org> <Pine.LNX.4.58.0510180239550.13581@localhost.localdomain>
 <20051018072927.GU26160@waste.org> <1130504043.9574.56.camel@localhost.localdomain>
 <Pine.LNX.4.58.0510291659140.10073@localhost.localdomain>
 <20051030011959.GA17750@vasa.acc.umu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 30 Oct 2005, David Weinehall wrote:
>
> Uhm, this patch assumes that you're using bash as /bin/sh.
> Not everyone does.  (I haven't checked the rest of the system calls
> in ketchup though, maybe this is a more generic problem?)

OK, if I work any more on ketchup, I'm going to convert the whole damn
thing into perl! ;-} (and call it "mustard").

Is this patch better? It even tests the version of tar and if it is less
than 1.15 it uses --strip-path (the old name) and if it is 1.15 or greater
it uses --strip-components (the new name).  And if it fails the version
test all together, it goes back to the old (broken) method of just moving
the contents.

Is this robust enough for you?

-- Steve

Index: Ketchup-d9503020b3c1/ketchup
===================================================================
--- Ketchup-d9503020b3c1.orig/ketchup	2005-10-29 17:02:26.000000000 -0400
+++ Ketchup-d9503020b3c1/ketchup	2005-10-29 23:41:32.000000000 -0400
@@ -477,16 +477,37 @@
     qprint("Unpacking %s" % os.path.basename(file))
     if options["dry-run"]: return ver

-    err = os.system("tar xjf %s" % file)
-    if err:
+    f = os.popen('tar --version', 'r')
+    if not f:
         error("Unpacking failed: ", err)
         sys.exit(-1)

-    err = os.system("mv linux*/* . ; rmdir linux*")
+    strip = ""
+    line = f.readline()
+    while line:
+        m = re.match(r'.*?(\d+)\.(\d+)', line)
+        if m:
+            v1 = int(m.group(1))
+            v2 = int(m.group(2))
+            if v1 > 1 or (v1 == 1 and v2 >= 15):
+                strip = "--strip-components 1 "
+            else:
+                strip = "--strip-path 1 "
+	    break
+        line = f.readline()
+    f.close()
+
+    err = os.system("tar %s-xjf %s" % (strip, file))
     if err:
         error("Unpacking failed: ", err)
         sys.exit(-1)

+    if not len(strip):
+        err = os.system("mv linux*/* . ; rmdir linux*")
+        if err:
+            error("Unpacking failed: ", err)
+            sys.exit(-1)
+
     return ver

 def find_ver(ver):
