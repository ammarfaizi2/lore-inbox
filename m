Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbUEJWJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUEJWJp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUEJWJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:09:44 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:53453 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261984AbUEJWJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:09:16 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] add path-oriented proc_mkdir_path() function to /proc
Message-Id: <E1BNIxQ-00013R-Fo@peregrine.corp.google.com>
From: Edward Falk <efalk@google.com>
Date: Mon, 10 May 2004 15:09:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all; apologies if there's a maintainer I should be sending this to
as well; couldn't find one in the maintainers list or in the source code.

This patch adds the function proc_mkdir_path() to fs/proc/generic.c.
This allows kernel code to create e.g. "/proc/foo/bar/baz" without needing
to check the hard way if /proc/foo/ and /proc/foo/bar/ already exist.

This patch works with both 2.6.6-rc3 and 2.6.6

	-ed falk, efalk@google.com



diff -urN linux-2.6.6-rc3/fs/proc/generic.c linux/fs/proc/generic.c
--- linux-2.6.6-rc3/fs/proc/generic.c	2004-05-08 15:24:03.000000000 -0700
+++ linux/fs/proc/generic.c	2004-05-08 15:47:04.000000000 -0700
@@ -612,6 +612,40 @@
 	return proc_mkdir_mode(name, S_IRUGO | S_IXUGO, parent);
 }
 
+
+struct proc_dir_entry *proc_mkdir_path(const char *name,
+				struct proc_dir_entry *parent)
+{
+	const char		*next;
+	int			len;
+	struct proc_dir_entry	*de;
+
+	/* Search top level for first component of name.  If not found,
+	 * create it.  Keep doing this until we run out of name components.
+	 */
+
+	for(;;) {
+		next = strchr(name, '/');
+		len = next != NULL ? next - name : strlen(name);
+		for (de = parent->subdir; de != NULL; de = de->next) {
+			if (proc_match(len, name, de))
+				break;
+		}
+		if (de == NULL) {
+			char fname[NAME_MAX+1];
+			memcpy(fname, name, len); fname[len] = '\0';
+			de = proc_mkdir(fname, parent);
+		}
+		if (next == NULL)
+			break;
+		parent = de;
+		name = next + 1;
+	}
+	return de;
+}
+
+
+
 struct proc_dir_entry *create_proc_entry(const char *name, mode_t mode,
 					 struct proc_dir_entry *parent)
 {
diff -urN linux-2.6.6-rc3/include/linux/proc_fs.h linux/include/linux/proc_fs.h
--- linux-2.6.6-rc3/include/linux/proc_fs.h	2004-05-08 15:24:07.000000000 -0700
+++ linux/include/linux/proc_fs.h	2004-05-08 15:46:06.000000000 -0700
@@ -142,6 +142,8 @@
 extern struct proc_dir_entry *proc_mkdir(const char *,struct proc_dir_entry *);
 extern struct proc_dir_entry *proc_mkdir_mode(const char *name, mode_t mode,
 			struct proc_dir_entry *parent);
+extern struct proc_dir_entry *proc_mkdir_path(const char *path,
+			struct proc_dir_entry *parent);
 
 static inline struct proc_dir_entry *create_proc_read_entry(const char *name,
 	mode_t mode, struct proc_dir_entry *base, 
