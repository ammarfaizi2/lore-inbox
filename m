Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422873AbWJFTAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422873AbWJFTAL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 15:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422860AbWJFS6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:58:33 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:33315 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1422853AbWJFS6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:58:04 -0400
Message-Id: <20061006185456.523874000@mvista.com>
References: <20061006185439.667702000@mvista.com>
User-Agent: quilt/0.45-1
Date: Fri, 06 Oct 2006 11:54:42 -0700
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: [PATCH 03/10] -mm: clocksource: move old API calls
Content-Disposition: inline; filename=clocksource_move_old_api.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I added this to make the next few patches cleaner. The mixing of code removal
and code addition can make a patchset harder to read. 

There's nothing new here from the first patchset, it just moves some code out
of the way.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 kernel/time/clocksource.c |  120 +++++++++++++++++++++++-----------------------
 1 files changed, 61 insertions(+), 59 deletions(-)

Index: linux-2.6.18/kernel/time/clocksource.c
===================================================================
--- linux-2.6.18.orig/kernel/time/clocksource.c
+++ linux-2.6.18/kernel/time/clocksource.c
@@ -31,6 +31,8 @@
 
 /* XXX - Would like a better way for initializing curr_clocksource */
 extern struct clocksource clocksource_jiffies;
+static int is_registered_source(struct clocksource *c);
+static struct clocksource *select_clocksource(void);
 
 /*[Clocksource internal variables]---------
  * curr_clocksource:
@@ -70,65 +72,6 @@ struct clocksource *clocksource_get_next
 }
 
 /**
- * select_clocksource - Finds the best registered clocksource.
- *
- * Private function. Must hold clocksource_lock when called.
- *
- * Looks through the list of registered clocksources, returning
- * the one with the highest rating value. If there is a clocksource
- * name that matches the override string, it returns that clocksource.
- */
-static struct clocksource *select_clocksource(void)
-{
-	struct clocksource *best = NULL;
-	struct list_head *tmp;
-
-	list_for_each(tmp, &clocksource_list) {
-		struct clocksource *src;
-
-		src = list_entry(tmp, struct clocksource, list);
-		if (!best)
-			best = src;
-
-		/* check for override: */
-		if (strlen(src->name) == strlen(override_name) &&
-		    !strcmp(src->name, override_name)) {
-			best = src;
-			break;
-		}
-		/* pick the highest rating: */
-		if (src->rating > best->rating)
-		 	best = src;
-	}
-
-	return best;
-}
-
-/**
- * is_registered_source - Checks if clocksource is registered
- * @c:		pointer to a clocksource
- *
- * Private helper function. Must hold clocksource_lock when called.
- *
- * Returns one if the clocksource is already registered, zero otherwise.
- */
-static int is_registered_source(struct clocksource *c)
-{
-	int len = strlen(c->name);
-	struct list_head *tmp;
-
-	list_for_each(tmp, &clocksource_list) {
-		struct clocksource *src;
-
-		src = list_entry(tmp, struct clocksource, list);
-		if (strlen(src->name) == len &&	!strcmp(src->name, c->name))
-			return 1;
-	}
-
-	return 0;
-}
-
-/**
  * clocksource_register - Used to install new clocksources
  * @t:		clocksource to be registered
  *
@@ -334,3 +277,62 @@ static int __init boot_override_clock(ch
 }
 
 __setup("clock=", boot_override_clock);
+
+/**
+ * select_clocksource - Finds the best registered clocksource.
+ *
+ * Private function. Must hold clocksource_lock when called.
+ *
+ * Looks through the list of registered clocksources, returning
+ * the one with the highest rating value. If there is a clocksource
+ * name that matches the override string, it returns that clocksource.
+ */
+static struct clocksource *select_clocksource(void)
+{
+	struct clocksource *best = NULL;
+	struct list_head *tmp;
+
+	list_for_each(tmp, &clocksource_list) {
+		struct clocksource *src;
+
+		src = list_entry(tmp, struct clocksource, list);
+		if (!best)
+			best = src;
+
+		/* check for override: */
+		if (strlen(src->name) == strlen(override_name) &&
+		    !strcmp(src->name, override_name)) {
+			best = src;
+			break;
+		}
+		/* pick the highest rating: */
+		if (src->rating > best->rating)
+		 	best = src;
+	}
+
+	return best;
+}
+
+/**
+ * is_registered_source - Checks if clocksource is registered
+ * @c:		pointer to a clocksource
+ *
+ * Private helper function. Must hold clocksource_lock when called.
+ *
+ * Returns one if the clocksource is already registered, zero otherwise.
+ */
+static int is_registered_source(struct clocksource *c)
+{
+	int len = strlen(c->name);
+	struct list_head *tmp;
+
+	list_for_each(tmp, &clocksource_list) {
+		struct clocksource *src;
+
+		src = list_entry(tmp, struct clocksource, list);
+		if (strlen(src->name) == len &&	!strcmp(src->name, c->name))
+			return 1;
+	}
+
+	return 0;
+}

--

