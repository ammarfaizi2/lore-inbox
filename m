Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262839AbVG2UyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbVG2UyG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262809AbVG2UwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:52:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57283 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262839AbVG2Uv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:51:29 -0400
Date: Fri, 29 Jul 2005 13:51:20 -0700
From: Chris Wright <chrisw@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>, Michael Kerrisk <mtk-manpages@gmx.net>,
       mingo@elte.hu, linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net,
       akpm@osdl.org
Subject: Re: Broke nice range for RLIMIT NICE
Message-ID: <20050729205120.GJ19052@shell0.pdx.osdl.net>
References: <32710.1122563064@www32.gmx.net> <20050729061318.GD7425@waste.org> <20050729201836.GH19052@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729201836.GH19052@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wright (chrisw@osdl.org) wrote:
> Yes, this requires updated pam patch.

Here's the updated pam patch.  I left the lower end at 0 rather than 1,
since it's no harm.

--- Linux-PAM-0.77/modules/pam_limits/pam_limits.c.prio	2005-01-14 10:47:03.000000000 -0800
+++ Linux-PAM-0.77/modules/pam_limits/pam_limits.c	2005-01-14 10:55:13.000000000 -0800
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
 
@@ -293,6 +298,10 @@ static void process_limit(int source, co
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
@@ -360,6 +369,19 @@ static void process_limit(int source, co
         case RLIMIT_AS:
             limit_value *= 1024;
             break;
+        case RLIMIT_NICE:
+            limit_value = 20 - limit_value;
+            if (limit_value > 40)
+		limit_value = 40;
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
