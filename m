Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268333AbUHTRHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268333AbUHTRHb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 13:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266485AbUHTRHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 13:07:31 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:37036 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S268333AbUHTRG7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 13:06:59 -0400
Subject: [PATCH] ketchup - support new -post releases
From: Dave Hansen <haveblue@us.ibm.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-gZ8WFLu87uRU5N3xii/B"
Message-Id: <1093021608.15662.1228.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 10:06:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gZ8WFLu87uRU5N3xii/B
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Since 2.6.8.1 came out, I'm sure a lot of automated tools stopped
working, ketchup included. 

I'm sure this patch isn't complete, but it does work to patch from 2.6.8
-> 2.6.8.1 or 2.6.8.1-mm*, so it is at least a start. 

-- Dave

--=-gZ8WFLu87uRU5N3xii/B
Content-Disposition: attachment; filename=ketchup-postvers.patch
Content-Type: text/x-patch; name=ketchup-postvers.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- ketchup-0.8.orig	2004-08-16 15:42:28.000000000 -0700
+++ ketchup-0.8	2004-08-20 10:03:05.000000000 -0700
@@ -126,35 +126,42 @@
     return r
 
 def pre(ver):
-    try: return re.match(r'\d+\.\d+\.\d+-((rc|pre)\d+)', ver).group(1)
+    try: return re.match(r'\d+\.\d+\.\d+(\.\d+)?-((rc|pre)\d+)', ver).group(2)
+    except: return None
+
+def post(ver):
+    try: return re.match(r'(\d+\.\d+\.\d+\.\d+)', ver).group(1)
     except: return None
 
 def pretype(ver):
-    try: return re.match(r'\d+\.\d+\.\d+-((rc|pre)\d+)', ver).group(2)
+    try: return re.match(r'\d+\.\d+\.\d+(\.\d+)?-((rc|pre)\d+)', ver).group(3)
     except: return None
 
 def prenum(ver):
-    try: return int(re.match(r'\d+\.\d+\.\d+-((rc|pre)(\d+))', ver).group(3))
+    try: return int(re.match(r'\d+\.\d+\.\d+-((rc|pre)(\d+))', ver).group(4))
     except: return None
 
 def prebase(ver):
-    return re.match(r'(\d+\.\d+\.\d+(-(rc|pre)\d+)?)', ver).group(1)
+    return re.match(r'(\d+\.\d+\.\d+((-(rc|pre)|\.)\d+)?)', ver).group(1)
 
 def base(ver):
-    return "%s.%s" % (tree(ver), rev(ver))
+    if post(ver):
+	return prebase(ver)
+    else:
+    	return "%s.%s" % (tree(ver), rev(ver))
 
 def forkname(ver):
-    try: return re.match(r'\d+.\d+.\d+(-(rc|pre)\d+)?(-(\w+?)\d+)?',
-                         ver).group(4)
+    try: return re.match(r'\d+.\d+.\d+(\.\d+)?(-(rc|pre)\d+)?(-(\w+?)\d+)?',
+                         ver).group(5)
     except: return None
 
 def forknum(ver):
-    try: return int(re.match(r'\d+.\d+.\d+(-(rc|pre)\d+)?(-(\w+?)(\d+))?',
-                             ver).group(5))
+    try: return int(re.match(r'\d+.\d+.\d+(\.\d+)?(-(rc|pre)\d+)?(-(\w+?)(\d+))?',
+                             ver).group(6))
     except: return None
 
 def fork(ver):
-    try: return re.match(r'\d+.\d+.\d+(-(rc|pre)\d+)?(-(\w+))?', ver).group(4)
+    try: return re.match(r'\d+.\d+.\d+(\.\d+)?(-(rc|pre)\d+)?(-(\w+))?', ver).group(4)
     except: return None
 
 def get_ver(makefile):
@@ -484,6 +491,11 @@
         if pre(a):
             apply_patch(a, 1)
             a = base(a)
+	# need a loop here to apply all of the post patches
+	if post(b):
+	    apply_patch(prebase(b), 0)
+	# need a loop here to back out any a post patches
+	    
         ra, rb = rev(a), rev(b)
         if ra > rb:
             for r in range(ra, rb, -1):

--=-gZ8WFLu87uRU5N3xii/B--

