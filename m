Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVESVlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVESVlp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 17:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVESVlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 17:41:45 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:33452 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261267AbVESVlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 17:41:15 -0400
Date: Thu, 19 May 2005 16:41:07 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       Serge Hallyn <serue@us.ibm.com>
Subject: Re: [updated patch 1/7] BSD Secure Levels: printk overhaul
Message-ID: <20050519214036.GC11385@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050517152303.GA2814@halcrow.us> <20050519205525.GB16215@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050519205525.GB16215@halcrow.us>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2005 at 01:58:06PM -0700, Andrew Morton wrote:
> Did anyone mention printk_ratelimit()?

Third time's a charm.  :-)

I think this makes the most sense.  Module size is 18284; messages are
globally limited, but the space savings is significant.

Signed-off by: Michael Halcrow <mhalcrow@us.ibm.com>

Index: linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c
===================================================================
--- linux-2.6.12-rc4-mm2-seclvl.orig/security/seclvl.c	2005-05-19 15:49:51.000000000 -0500
+++ linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c	2005-05-19 16:33:20.000000000 -0500
@@ -102,21 +102,25 @@
 #define MY_NAME "seclvl"
 
 /**
- * This time-limits log writes to one per second.
+ * This time-limits log writes to one per second for every message
+ * type.
  */
-#define seclvl_printk(verb, type, fmt, arg...)			\
-	do {							\
-		if (verbosity >= verb) {			\
-			static unsigned long _prior;		\
-			unsigned long _now = jiffies;		\
-			if ((_now - _prior) > HZ) {		\
-				printk(type "%s: %s: " fmt,	\
-					MY_NAME, __FUNCTION__ ,	\
-					## arg);		\
-				_prior = _now;			\
-			}					\
-		}						\
-	} while (0)
+static void __seclvl_printk(int verb, const char *fmt, ...)
+{
+	va_list args;
+	va_start(args, fmt);
+	if (verbosity >= verb && printk_ratelimit()) {
+		vprintk(fmt, args);
+	}
+	va_end(args);
+}
+
+/**
+ * Breaking the printk up into a macro and a function saves some text
+ * space.
+ */
+#define seclvl_printk(verb, type, fmt, arg...) \
+        __seclvl_printk((verb), type "%s: " fmt, __FUNCTION__, ## arg);
 
 /**
  * kobject stuff
@@ -711,7 +715,7 @@
 		goto exit;
 	}
 	seclvl_printk(0, KERN_INFO, "seclvl: Successfully initialized.\n");
- exit:
+      exit:
 	if (rc) {
 		printk(KERN_ERR "seclvl: Error during initialization: rc = "
 		       "[%d]\n", rc);
