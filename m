Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269682AbUJSRAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269682AbUJSRAS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 13:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269823AbUJSQ6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:58:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:46276 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269683AbUJSQik convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:40 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <10982038243480@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:37:07 -0700
Message-Id: <10982038272844@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1993, 2004/09/29 17:24:36-07:00, roland@topspin.com

[PATCH] kobject: add add_hotplug_env_var()

Add a (non-inlined) add_hotplug_env_var() function to <linux/kobject.h>
and lib/kobject.c.  There's a lot of boilerplate code involved in
setting environment variables in a hotplug method, so we should have a
convenience function to consolidate it (and avoid subtle bugs).


Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/kobject.h |   10 ++++++++-
 lib/kobject_uevent.c    |   52 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 2 deletions(-)


diff -Nru a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h	2004-10-19 09:20:35 -07:00
+++ b/include/linux/kobject.h	2004-10-19 09:20:35 -07:00
@@ -237,9 +237,17 @@
 extern void subsys_remove_file(struct subsystem * , struct subsys_attribute *);
 
 #ifdef CONFIG_HOTPLUG
-extern void kobject_hotplug(struct kobject *kobj, enum kobject_action action);
+void kobject_hotplug(struct kobject *kobj, enum kobject_action action);
+int add_hotplug_env_var(char **envp, int num_envp, int *cur_index,
+			char *buffer, int buffer_size, int *cur_len,
+			const char *format, ...)
+	__attribute__((format (printf, 7, 8)));
 #else
 static inline void kobject_hotplug(struct kobject *kobj, enum kobject_action action) { }
+static inline int add_hotplug_env_var(char **envp, int num_envp, int *cur_index, 
+				      char *buffer, int buffer_size, int *cur_len, 
+				      const char *format, ...)
+{ return 0; }
 #endif
 
 #endif /* __KERNEL__ */
diff -Nru a/lib/kobject_uevent.c b/lib/kobject_uevent.c
--- a/lib/kobject_uevent.c	2004-10-19 09:20:35 -07:00
+++ b/lib/kobject_uevent.c	2004-10-19 09:20:35 -07:00
@@ -290,6 +290,56 @@
 	return;
 }
 EXPORT_SYMBOL(kobject_hotplug);
-#endif /* CONFIG_HOTPLUG */
 
+/**
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
 
+	if (*cur_len > buffer_size)
+		return -ENOMEM;
+
+	(*cur_index)++;
+	return 0;
+}
+EXPORT_SYMBOL(add_hotplug_env_var);
+
+#endif /* CONFIG_HOTPLUG */

