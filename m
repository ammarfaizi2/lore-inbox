Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266188AbUBKWNi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 17:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266192AbUBKWNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 17:13:38 -0500
Received: from mail.kroah.org ([65.200.24.183]:55767 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266188AbUBKWNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 17:13:30 -0500
Date: Wed, 11 Feb 2004 14:13:24 -0800
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] udev 016 release
Message-ID: <20040211221324.GC14231@kroah.com>
References: <20040203201359.GB19476@kroah.com> <1075844602.7473.75.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075844602.7473.75.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 03, 2004 at 11:43:22PM +0200, Martin Schlemmer wrote:
> On Tue, 2004-02-03 at 22:13, Greg KH wrote:
> 
> Once again, patch to make logging a config option.
> 
> Reason for this (since you asked for it =):
> - In our setup it is easy (although still annoying) .. just
> edit the ebuild, add logging support (or remove it) and rebuild.
> For say a binary distro, having the logging is useful for debugging
> some times, but its more a once of, or rare thing, as you do not
> add or change config files every day.  Sure, we can have logging
> by default, but many do not want ~300 lines of extra debugging in
> their logs is not pleasant, and they will complain.  Rebuilding
> the package for that binary package (given the users it is targeted
> to) is usually not within most users grasp.

Ok, I applied this patch.

And then I went back and fixed it so it actually would work :(

Here's the changes I had to make to get everything to build properly,
and to let us have a boolean type for the config files.

thanks,

greg k-h

# fix log option code so that it actually works for all udev programs.
# Also introduce boolean type for config file to use.

diff -Nru a/logging.h b/logging.h
--- a/logging.h	Wed Feb 11 14:10:36 2004
+++ b/logging.h	Wed Feb 11 14:10:36 2004
@@ -34,9 +34,6 @@
 #include <unistd.h>
 #include <syslog.h>
 
-#include "udev.h"
-#include "udev_version.h"
-
 #undef info
 #define info(format, arg...)								\
 	do {										\
@@ -60,22 +57,23 @@
 	} while (0)
 #endif
 
+/* each program must declare this variable and function somewhere */
+extern unsigned char logname[42];
+extern int log_ok(void);
+
 static void log_message (int level, const char *format, ...)
 	__attribute__ ((format (printf, 2, 3)));
 static inline void log_message (int level, const char *format, ...)
 {
 	va_list	args;
 
-	if (0 != strncmp(udev_log_str, UDEV_LOG_DEFAULT, BOOL_SIZE))
+	if (!log_ok())
 		return;
 
 	va_start(args, format);
 	vsyslog(level, format, args);
 	va_end(args);
 }
-
-/* each program must declare this variable somewhere */
-extern unsigned char logname[42];
 
 #undef init_logging
 static inline void init_logging(char *program_name)
diff -Nru a/test/ignore_test b/test/ignore_test
--- a/test/ignore_test	Wed Feb 11 14:10:36 2004
+++ b/test/ignore_test	Wed Feb 11 14:10:36 2004
@@ -16,6 +16,7 @@
 udev_db="$PWD/udev/.udev.tdb"
 udev_rules="$PWD/$RULES"
 udev_permissions="$PWD/udev.permissions"
+udev_log="true"
 EOF
 
 mkdir udev
diff -Nru a/udev.c b/udev.c
--- a/udev.c	Wed Feb 11 14:10:36 2004
+++ b/udev.c	Wed Feb 11 14:10:36 2004
@@ -40,6 +40,11 @@
 char **main_envp;
 unsigned char logname[42];
 
+int log_ok(void)
+{
+	return udev_log;
+}
+
 static void sig_handler(int signum)
 {
 	dbg("caught signal %d", signum);
diff -Nru a/udev.h b/udev.h
--- a/udev.h	Wed Feb 11 14:10:36 2004
+++ b/udev.h	Wed Feb 11 14:10:36 2004
@@ -32,8 +32,6 @@
 #define OWNER_SIZE	30
 #define GROUP_SIZE	30
 #define MODE_SIZE	8
-#define BOOL_SIZE	5	/* 'yes', 'no' and possibly 'true' or 'false'
-				   in future */
 
 struct udevice {
 	char name[NAME_SIZE];
@@ -74,6 +72,6 @@
 extern char default_mode_str[MODE_SIZE];
 extern char default_owner_str[OWNER_SIZE];
 extern char default_group_str[GROUP_SIZE];
-extern char udev_log_str[BOOL_SIZE];
+extern int udev_log;
 
 #endif
diff -Nru a/udev_config.c b/udev_config.c
--- a/udev_config.c	Wed Feb 11 14:10:36 2004
+++ b/udev_config.c	Wed Feb 11 14:10:36 2004
@@ -48,9 +48,18 @@
 char default_mode_str[MODE_SIZE];
 char default_owner_str[OWNER_SIZE];
 char default_group_str[GROUP_SIZE];
-char udev_log_str[BOOL_SIZE];
+int udev_log;
 
 
+static int string_is_true(char *str)
+{
+	if (strcasecmp(str, "true") == 0)
+		return 1;
+	if (strcasecmp(str, "yes") == 0)
+		return 1;
+	return 0;
+}
+
 static void init_variables(void)
 {
 	/* fill up the defaults.  
@@ -61,7 +70,7 @@
 	strfieldcpy(udev_config_filename, UDEV_CONFIG_FILE);
 	strfieldcpy(udev_rules_filename, UDEV_RULES_FILE);
 	strfieldcpy(udev_permissions_filename, UDEV_PERMISSION_FILE);
-	strfieldcpy(udev_log_str, UDEV_LOG_DEFAULT);
+	udev_log = string_is_true(UDEV_LOG_DEFAULT);
 }
 
 #define set_var(_name, _var)				\
@@ -70,6 +79,12 @@
 		strncpy(_var, value, sizeof(_var));	\
 	}
 
+#define set_bool(_name, _var)				\
+	if (strcasecmp(variable, _name) == 0) {		\
+		dbg_parse("%s = '%s'", _name, value);	\
+		_var = string_is_true(value);		\
+	}
+
 int parse_get_pair(char **orig_string, char **left, char **right)
 {
 	char *temp;
@@ -158,7 +173,7 @@
 		set_var("default_mode", default_mode_str);
 		set_var("default_owner", default_owner_str);
 		set_var("default_group", default_group_str);
-		set_var("udev_log", udev_log_str);
+		set_bool("udev_log", udev_log);
 	}
 	dbg_parse("%s:%d:%Zd: error parsing '%s'", udev_config_filename,
 		  lineno, temp - line, temp);
@@ -194,7 +209,7 @@
 	dbg_parse("udev_db_filename = %s", udev_db_filename);
 	dbg_parse("udev_rules_filename = %s", udev_rules_filename);
 	dbg_parse("udev_permissions_filename = %s", udev_permissions_filename);
-	dbg_parse("udev_log_str = %s", udev_log_str);
+	dbg_parse("udev_log = %d", udev_log);
 	parse_config_file();
 
 	dbg_parse("udev_root = %s", udev_root);
@@ -202,7 +217,7 @@
 	dbg_parse("udev_db_filename = %s", udev_db_filename);
 	dbg_parse("udev_rules_filename = %s", udev_rules_filename);
 	dbg_parse("udev_permissions_filename = %s", udev_permissions_filename);
-	dbg_parse("udev_log_str = %s", udev_log_str);
+	dbg_parse("udev_log_str = %d", udev_log);
 }
 
 void udev_init_config(void)
diff -Nru a/udevd.c b/udevd.c
--- a/udevd.c	Wed Feb 11 14:10:36 2004
+++ b/udevd.c	Wed Feb 11 14:10:36 2004
@@ -40,7 +40,6 @@
 #include "udevd.h"
 #include "logging.h"
 
-unsigned char logname[42];
 static int expected_seqnum = 0;
 volatile static int children_waiting;
 volatile static int msg_q_timeout;
@@ -51,6 +50,13 @@
 
 static void exec_queue_manager(void);
 static void msg_queue_manager(void);
+
+unsigned char logname[42];
+
+int log_ok(void)
+{
+	return 1;
+}
 
 static void msg_dump_queue(void)
 {
diff -Nru a/udevinfo.c b/udevinfo.c
--- a/udevinfo.c	Wed Feb 11 14:10:36 2004
+++ b/udevinfo.c	Wed Feb 11 14:10:36 2004
@@ -40,6 +40,11 @@
 int main_argc;
 unsigned char logname[42];
 
+int log_ok(void)
+{
+	return 1;
+}
+
 static int print_all_attributes(const char *path)
 {
 	struct dlist *attributes;
diff -Nru a/udevsend.c b/udevsend.c
--- a/udevsend.c	Wed Feb 11 14:10:36 2004
+++ b/udevsend.c	Wed Feb 11 14:10:36 2004
@@ -42,6 +42,11 @@
 
 unsigned char logname[42];
 
+int log_ok(void)
+{
+	return 1;
+}
+
 static inline char *get_action(void)
 {
 	char *action;
