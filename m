Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268153AbUI2CUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268153AbUI2CUS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 22:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268156AbUI2CUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 22:20:18 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:21993 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S268153AbUI2CT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 22:19:58 -0400
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200409281919.Xvizfpbjxoiv0MeE@topspin.com>
X-Mailer: roland_patchbomb
Date: Tue, 28 Sep 2004 19:19:34 -0700
Message-Id: <200409281919.aKAVlO4yKkPzE7f0@topspin.com>
Mime-Version: 1.0
To: greg@kroah.com, pj@sgi.com
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][1/2] [take 2] kobject: add add_hotplug_env_var
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 29 Sep 2004 02:19:34.0699 (UTC) FILETIME=[C303A7B0:01C4A5CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a (non-inlined) add_hotplug_env_var() function to <linux/kobject.h>
and lib/kobject.c.  There's a lot of boilerplate code involved in
setting environment variables in a hotplug method, so we should have a
convenience function to consolidate it (and avoid subtle bugs).


Signed-off-by: Roland Dreier <roland@topspin.com>

Index: linux-bk/include/linux/kobject.h
===================================================================
--- linux-bk.orig/include/linux/kobject.h	2004-09-28 09:51:09.000000000 -0700
+++ linux-bk/include/linux/kobject.h	2004-09-28 09:50:49.000000000 -0700
@@ -136,6 +136,32 @@
 
 
 /**
+ * add_hotplug_env_var - helper for creating hotplug environment variables
+ * @envp: Pointer to table of environment variables, as passed into
+ * hotplug() method.
+ * @num_envp: Number of environment variable slots available, as
+ * passed into hotplug() method.
+ * @cur_index: Pointer to current index into @envp.  It should be
+ * initialized to 0 before the first call to add_hotplug_env_var(),
+ * and will be incremented on success.
+ * @buffer: Pointer to buffer for environment variables, as passed
+ * into hotplug() method.
+ * @buffer_size: Length of @buffer, as passed into hotplug() method.
+ * @cur_len: Pointer to current length of space used in @buffer.
+ * Should be initialized to 0 before the first call to
+ * add_hotplug_env_var(), and will be incremented on success.
+ * @format: Format for creating environment variable (of the form
+ * "XXX=%x") for snprintf().
+ *
+ * Returns 0 if environment variable was added successfully or -ENOMEM
+ * if no space was available.
+ */
+extern int add_hotplug_env_var(char **envp, int num_envp, int *cur_index,
+			       char *buffer, int buffer_size, int *cur_len,
+			       const char *format, ...)
+	__attribute__((format (printf, 7, 8)));
+
+/**
  * Use this when initializing an embedded kset with no other 
  * fields to initialize.
  */
Index: linux-bk/lib/kobject.c
===================================================================
--- linux-bk.orig/lib/kobject.c	2004-09-28 09:30:17.000000000 -0700
+++ linux-bk/lib/kobject.c	2004-09-28 10:45:49.000000000 -0700
@@ -232,11 +232,51 @@
 	if (top_kobj->kset && top_kobj->kset->hotplug_ops)
 		kset_hotplug(action, top_kobj->kset, kobj);
 }
-#else
+
+int add_hotplug_env_var(char **envp, int num_envp, int *cur_index,
+			char *buffer, int buffer_size, int *cur_len,
+			const char *format, ...)
+{
+	va_list args;
+
+	/*
+	 * We check against num_envp - 1 to make sure there is at
+	 * least one slot left after we return, since the hotplug
+	 * method needs to set the last slot to NULL.
+	 */
+	if (*cur_index >= num_envp - 1)
+		return -ENOMEM;
+
+	envp[*cur_index] = buffer + *cur_len;
+
+	va_start(args, format);
+	*cur_len += vsnprintf(envp[*cur_index],
+			      max(buffer_size - *cur_len, 0),
+			      format, args) + 1;
+	va_end(args);
+
+	if (*cur_len > buffer_size)
+		return -ENOMEM;
+
+	(*cur_index)++;
+	return 0;
+}
+EXPORT_SYMBOL(add_hotplug_env_var);
+
+#else /* CONFIG_HOTPLUG */
+
 void kobject_hotplug(const char *action, struct kobject *kobj)
 {
 	return;
 }
+
+int add_hotplug_env_var(char **envp, int num_envp, int *cur_index,
+			char *buffer, int buffer_size, int *cur_len,
+			const char *format, ...)
+{
+	return 0;
+}
+EXPORT_SYMBOL(add_hotplug_env_var);
 #endif	/* CONFIG_HOTPLUG */
 
 /**

