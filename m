Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269225AbUI3AVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269225AbUI3AVD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 20:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269218AbUI3AVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 20:21:02 -0400
Received: from mail.kroah.org ([69.55.234.183]:56806 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269227AbUI3ASn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 20:18:43 -0400
Date: Wed, 29 Sep 2004 17:18:06 -0700
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/2] [take 2] kobject: add add_hotplug_env_var
Message-ID: <20040930001806.GA27400@kroah.com>
References: <200409281919.Xvizfpbjxoiv0MeE@topspin.com> <200409281919.aKAVlO4yKkPzE7f0@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409281919.aKAVlO4yKkPzE7f0@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 07:19:34PM -0700, Roland Dreier wrote:
> Add a (non-inlined) add_hotplug_env_var() function to <linux/kobject.h>
> and lib/kobject.c.  There's a lot of boilerplate code involved in
> setting environment variables in a hotplug method, so we should have a
> convenience function to consolidate it (and avoid subtle bugs).

Cool.  Well the code in kobject.c has changed a lot recently (see the
-mm tree) and the kernel-doc comments should be with the .c code, not
the header file, so here's the version I committed to my trees.

thanks,

greg k-h

===== include/linux/kobject.h 1.31 vs edited =====
--- 1.31/include/linux/kobject.h	2004-09-15 11:26:10 -07:00
+++ edited/include/linux/kobject.h	2004-09-29 16:51:02 -07:00
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
===== lib/kobject_uevent.c 1.4 vs edited =====
--- 1.4/lib/kobject_uevent.c	2004-09-15 14:15:24 -07:00
+++ edited/lib/kobject_uevent.c	2004-09-29 16:54:19 -07:00
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
