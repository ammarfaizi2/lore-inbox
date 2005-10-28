Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751694AbVJ1Uq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbVJ1Uq5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 16:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbVJ1Uq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 16:46:57 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:24807 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751694AbVJ1Uqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 16:46:53 -0400
Date: Fri, 28 Oct 2005 16:46:30 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Matt Mackall <mpm@selenic.com>
cc: Esben Nielsen <simlo@phys.au.dk>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [ketchup] patch to alt urls for local trees
In-Reply-To: <20051028170030.GA4367@waste.org>
Message-ID: <Pine.LNX.4.58.0510281639030.13877@localhost.localdomain>
References: <Pine.LNX.4.58.0510170316310.5859@localhost.localdomain>
 <20051017213915.GN26160@waste.org> <Pine.LNX.4.58.0510180211320.13581@localhost.localdomain>
 <20051018063031.GR26160@waste.org> <Pine.LNX.4.58.0510180239550.13581@localhost.localdomain>
 <20051018072927.GU26160@waste.org> <1130504043.9574.56.camel@localhost.localdomain>
 <1130506546.9574.62.camel@localhost.localdomain> <20051028170030.GA4367@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Oct 2005, Matt Mackall wrote:

> Hmm. I think I'd prefer to generalize this by adding another field to
> the tree array. Care to take a stab at it?

Argh, you ask, I do!

Man, a day with python really makes you hate it! ;-)
OK, I'm a perl guy, and I'm much more comfortable with that. But I did
manage to get python to do what I wanted.

If you add a 6 element to the version_info tree, it will be used as an
alternate url.  I tested this a little, and it seems to work.  Might want
to review it though. I'm still not comfortable with python, and I only did
some small tests.  Basically I checked to see if it would work if it had
the 6th element, and if it didn't.  But not much else was done to test.

-- Steve

Index: Ketchup-d9503020b3c1/ketchup
===================================================================
--- Ketchup-d9503020b3c1.orig/ketchup	2005-10-28 14:46:04.000000000 -0400
+++ Ketchup-d9503020b3c1/ketchup	2005-10-28 16:34:16.000000000 -0400
@@ -280,11 +280,17 @@
     '2.6-git': (latest_dir,
                kernel_url + "/v2.6" +
                "/snapshots/patch-%(full)s.bz2", r'patch-(.*?).bz2',
-               1, "current stable kernel series snapshots"),
+               1, "current stable kernel series snapshots",
+               kernel_url + "/v2.6" +
+               "/snapshots/old/patch-%(full)s.bz2"
+	       ),
     '2.6-bk': (latest_dir,
                kernel_url + "/v2.6" +
                "/snapshots/patch-%(full)s.bz2", r'patch-(.*?).bz2',
-               1, "old stable kernel series snapshots"),
+               1, "old stable kernel series snapshots",
+               kernel_url + "/v2.6" +
+               "/snapshots/old/patch-%(full)s.bz2"
+	       ),
     '2.6-tip': (latest_26_tip, "", "", 1,
                 "current stable kernel series tip"),
     '2.6-mm': (latest_mm,
@@ -302,11 +308,11 @@
     '2.6-rt': (latest_dir,
                 "http://people.redhat.com/mingo/realtime-preempt/patch-%(full)s",
 		r'patch-(2.6.*?)',
-		0, "Ingo Molnar's realtime-preempt kernel")
+		0, "Ingo Molnar's realtime-preempt kernel",
+                "http://people.redhat.com/mingo/realtime-preempt/older/patch-%(full)s")
     }

-def version_url(ver, sign = 0):
-    """ Return the URL for the patch associated with the specified version """
+def find_info(ver):
     b = "%.1f" % tree(ver)
     f = forkname(ver)
     p = pre(ver)
@@ -314,10 +320,16 @@
     s = b
     if f: s = "%s-%s" % (b, f)
     elif p: s = "%s-pre" % b
+
+    return version_info[s]

+def version_url(ver, sign = 0):
+    """ Return the URL for the patch associated with the specified version """
     if sign and options["no-gpg"]: return None
     if sign and not version_info[s][3]: return None

+    i = find_info(ver)
+
     v = {
         'full': ver,
         'tree': tree(ver),
@@ -325,11 +337,29 @@
         'prebase': prebase(ver)
         }

-    u = version_info[s][1] % v
+    u = i[1] % v

     if sign: u += ".sign"
     return u

+def version_url2(ver):
+    i = find_info(ver)
+
+    if len(i) < 6:
+    	s = i[1]
+    else:
+        s = i[5]
+
+    v = {
+        'full': ver,
+        'tree': tree(ver),
+        'base': base(ver),
+        'prebase': prebase(ver)
+        }
+
+    return s % v
+
+
 def patch_path(ver):
     return os.path.join(archive, os.path.basename(version_url(ver)))

@@ -349,13 +379,10 @@

     return 1

-def trydownload(url, file):
+def trydownload(url, file, url2):
     if download(url, file): return file

-    # the jgarzik memorial hack
-    url2 = re.sub("/snapshots/", "/snapshots/old/", url)
-    url2 = re.sub("/realtime-preempt/", "/realtime-preempt/older/", url2)
-    if url2 != url:
+    if url2 != url :
         if download(url2, file): return file
         if url2[-4:] == ".bz2":
             f2 = file[:-4] + ".gz"
@@ -372,7 +399,7 @@
 def verify(signurl, file):
     if options["gpg-path"] and signurl and not options["dry-run"]:
         sf = file + ".sign"
-        sf = trydownload(signurl, sf)
+        sf = trydownload(signurl, sf, signurl)
         if not sf:
             error("signature download failed")
             error("removing files...")
@@ -398,7 +425,8 @@
         if os.path.exists(f2): return f2

     url = version_url(ver)
-    f = trydownload(url, f)
+    url2 = version_url2(ver)
+    f = trydownload(url, f, url2)
     if not f:
         error("patch download failed")
         sys.exit(-1)
