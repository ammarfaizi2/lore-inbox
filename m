Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274882AbRIVAIz>; Fri, 21 Sep 2001 20:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274881AbRIVAIp>; Fri, 21 Sep 2001 20:08:45 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:53513 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S274877AbRIVAIc>; Fri, 21 Sep 2001 20:08:32 -0400
Date: Fri, 21 Sep 2001 20:10:48 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@portland.hansa.lan>
To: <linux-kernel@vger.kernel.org>
cc: <reiserfs-list@namesys.com>
Subject: [PATCH] 2.4.9-ac13 - parse_options() in reiserfs still broken
In-Reply-To: <Pine.LNX.4.33.0109192018010.1016-100000@portland.hansa.lan>
Message-ID: <Pine.LNX.4.33.0109211951010.1373-100000@portland.hansa.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm a bit disappointed that the bug with option parsing in reiserfs wasn't
fixed in 2.4.9-ac13.  It's a serious issue that prevents mounting
reiserfs partitions on system startup (except root partition).

Anyway, I'm using this opportunity to send a better patch.  The only
difference is that the faulty code has been actually identified and fixed
(do-while becomes while), not just worked around by a sanity check.

"pos" is initialized with "options", not NULL, because kgetopt()
effectively does it anyway, but the value of "pos" is now used earlier.

I also included fixes for the typos that I encountered while fixing and
testing my patch.

The patch has been tested by multiple mounting and unmounting a reiserfs
partition with specific (notail) and generic (ro) flags in different
combinations.

Simplification of kgetopt() is possible, but I'm intentionally avoiding
code changes other that the most urgent fix.

The patch is also available here:
http://www.red-bean.com/~proski/linux/reiserfs-parse.diff

---------------------------------------------------
--- linux.orig/fs/reiserfs/super.c
+++ linux/fs/reiserfs/super.c
@@ -144,8 +144,8 @@ static int kgetopt (char * options, opt_
     int len_arg;

     ptr1 = (*pos ? *pos : options);
-    ptr2 = NULL; /* here we will put pounter on '=' */
-    ptr3 = NULL; /* here we will put pounter on ',' */
+    ptr2 = NULL; /* here we will put pointer on '=' */
+    ptr3 = NULL; /* here we will put pointer on ',' */

     if (!options)
 	return -1;
@@ -164,7 +164,7 @@ static int kgetopt (char * options, opt_
 	}
     }
     if (!option_exists) {
-	printk ("reiserfs kgetopt: there is not option %s\n", ptr1);
+	printk ("reiserfs kgetopt: unrecognized option %s\n", ptr1);
 	return -1;
     }
     if (ptr2) {
@@ -213,7 +213,7 @@ static int parse_options (
 {
     int c;
     char * arg = NULL;
-    char * pos = NULL;
+    char * pos = options;
     char * p = NULL;
     arg_desc_t hash[] = {
 	{"rupasov", FORCE_RUPASOV_HASH},
@@ -227,7 +227,7 @@ static int parse_options (
 	/* use default configuration: create tails, journaling on, no
            conversion to newest format */
 	return 1;
-    do  {
+    while (*pos != '\0') {
 	opt_desc_t opts[] = {
 	    {"notail", 0, 0, NOTAIL},
 	    {"conv", 0, 0, REISERFS_CONVERT},
@@ -251,7 +251,7 @@ static int parse_options (
 		return 0;
 	    }
 	}
-    } while (*pos != '\0');
+    }
     return 1;
 }

---------------------------------------------------

Regards,
Pavel Roskin

