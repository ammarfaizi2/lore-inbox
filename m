Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVCNJOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVCNJOZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 04:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVCNJOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 04:14:25 -0500
Received: from mail-mx1.hia.no ([158.36.80.150]:25797 "EHLO mail-mx1.hia.no")
	by vger.kernel.org with ESMTP id S261399AbVCNJOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 04:14:17 -0500
From: Vegard Lima <Vegard.Lima@hia.no>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 14 Mar 2005 10:14:17 +0100
Message-Id: <1110791657.1807.11.camel@pingvin.krs.hia.no>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Subject: pam and nice-rt-prio-rlimits
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

in the long thread on "[request for inclusion] Realtime LSM" there
doesn't appear to be too many people who has actually tested the
nice-and-rt-prio-rlimits.patch. Well, it works for me...

However, the patch to pam_limits posted here:
  http://lkml.org/lkml/2005/1/14/174
is a little bit aggressive on the semi-colon side.

Tested patch (and pam.src.rpm for fedora c3) can be found here
  http://home.hia.no/~vegardl/rlimit/
and below

--- Linux-PAM-0.77/modules/pam_limits/pam_limits.c.rtprio	2005-03-13 16:15:07.000000000 +0100
+++ Linux-PAM-0.77/modules/pam_limits/pam_limits.c	2005-03-13 16:27:54.000000000 +0100
@@ -39,6 +39,11 @@
 #include <grp.h>
 #include <pwd.h>
 
+/* Hack to test new rlimit values */
+#define RLIMIT_NICE	13
+#define RLIMIT_RTPRIO	14
+#define RLIM_NLIMITS	15
+
 /* Module defines */
 #define LINE_LENGTH 1024
 
@@ -293,6 +298,10 @@
     else if (strcmp(lim_item, "locks") == 0)
 	limit_item = RLIMIT_LOCKS;
 #endif
+    else if (strcmp(lim_item, "rt_priority") == 0)
+	limit_item = RLIMIT_RTPRIO;
+    else if (strcmp(lim_item, "nice") == 0)
+	limit_item = RLIMIT_NICE;
     else if (strcmp(lim_item, "maxlogins") == 0) {
 	limit_item = LIMIT_LOGIN;
 	pl->flag_numsyslogins = 0;
@@ -360,6 +369,18 @@
         case RLIMIT_AS:
             limit_value *= 1024;
             break;
+        case RLIMIT_NICE:
+            if (limit_value > 39)
+		limit_value = 39;
+	    if (limit_value < 0)
+		limit_value = 0;
+            break;
+        case RLIMIT_RTPRIO:
+            if (limit_value > 99)
+		limit_value = 99;
+	    if (limit_value < 0)
+		limit_value = 0;
+            break;
     }
 
     if ( (limit_item != LIMIT_LOGIN)



Thanks,
-- 
Vegard Lima


