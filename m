Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289484AbSDAABN>; Sun, 31 Mar 2002 19:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289817AbSDAABD>; Sun, 31 Mar 2002 19:01:03 -0500
Received: from puce.csi.cam.ac.uk ([131.111.8.40]:8695 "EHLO
	puce.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S289484AbSDAAA5>; Sun, 31 Mar 2002 19:00:57 -0500
Date: Mon, 1 Apr 2002 01:00:56 +0100
From: Liyang Hu <liyang@nerv.cx>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Bug in NLS UTF-8 code
Message-ID: <20020401000056.GA5896@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've recently (actually, last month, but I had been a bit too busy
since then) come across a wee problem, in what I originally thought
was the VFAT code -- having `utf8' as one of the options, creating
UTF-8 file names on a VFAT partition mysteriously gains a couple of
(random) characters just after the UTF-8 escaped character: eg.
touch "fooCbar" where C is an UTF-8 escape sequence ends up creating
a file named "fooCRbar". (R being some random character.)

I eventually tracked it down to one line in fs/nls/nls_base.c -- the
UCS-2 (wchar_t) string pointer was being incremented too fast. After
consulting Ogawa Hirofumi-san on the subject, he mentioned that
include/linux/nls.h also needs to be changed for proper UTF-8
support in the NLS code.

Patch enclosed below.

/Liyang

----8<----snip----8<----

--- kernel-source-2.4.18/fs/nls/nls_base.c.orig	Mon Apr  1 00:26:37 2002
+++ kernel-source-2.4.18-nls/fs/nls/nls_base.c	Mon Apr  1 00:26:57 2002
@@ -1,5 +1,5 @@
 /*
- * linux/fs/nls.c
+ * linux/fs/nls_base.c
  *
  * Native language support--charsets and unicode translations.
  * By Gordon Chaffee 1996, 1997
@@ -93,7 +93,7 @@
 				ip++;
 				n--;
 			} else {
-				op += size;
+				op++;
 				ip += size;
 				n -= size;
 			}
--- kernel-source-2.4.18/include/linux/nls.h.orig	Fri Jul 20 20:53:03 2001
+++ kernel-source-2.4.18-nls/include/linux/nls.h	Mon Apr  1 00:28:16 2002
@@ -18,7 +18,7 @@
 };
 
 /* this value hold the maximum octet of charset */
-#define NLS_MAX_CHARSET_SIZE 3
+#define NLS_MAX_CHARSET_SIZE 6 /* for UTF-8 */
 
 /* nls.c */
 extern int register_nls(struct nls_table *);

----8<----snip----8<----

-- 
.--{ Liyang HU }--{ http://nerv.cx/ }--{ Caius@Cam }--{ ICQ: 39391385 }--.
| :: Well, we just happen to *have* an infinite number of monkeys! ::::: |
| ::::::: http://stats.distributed.net/rc5-64/psummary.php3?id=284324 :: |
