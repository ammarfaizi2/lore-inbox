Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbTEQOXu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 10:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbTEQOXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 10:23:50 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:46208 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S261515AbTEQOXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 10:23:48 -0400
Subject: [PATCH] request_module_fmt(char "fmt, ...)
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1053182199.9218.5.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Sat, 17 May 2003 15:36:39 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Rcpt-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We do this all over the kernel, badly. Many people use sprintf, others
use snprintf but don't seem to have noticed they need to put the
trailing zero into the buffer if it truncates, etc.

If we put it in one place, we can get it right.

I didn't just change the prototype of request_module() because that
would cause stuff like 'ifconfig eth%s up' to cause oopsen. 

Untested -- 2.5 didn't even get to a prompt last time I tried to boot it
a week or so ago. Does compile though :)

===== include/linux/kmod.h 1.3 vs edited =====
--- 1.3/include/linux/kmod.h	Thu Feb 13 03:35:39 2003
+++ edited/include/linux/kmod.h	Sat May 17 15:30:01 2003
@@ -25,8 +25,12 @@
 
 #ifdef CONFIG_KMOD
 extern int request_module(const char * name);
+extern int request_module_fmt(const char *fmt, ...)
+     __attribute__ ((format (printf, 1, 2)));
 #else
 static inline int request_module(const char * name) { return -ENOSYS; }
+static inline int request_module_fmt(const char *fmt, ...)
+     __attribute__ ((format (printf, 1, 2))) { return -ENOSYS; }
 #endif
 
 #define try_then_request_module(x, mod) ((x) ?: request_module(mod), (x))
===== kernel/kmod.c 1.25 vs edited =====
--- 1.25/kernel/kmod.c	Mon Feb 24 17:40:34 2003
+++ edited/kernel/kmod.c	Sat May 17 15:30:51 2003
@@ -110,6 +110,29 @@
 	atomic_dec(&kmod_concurrent);
 	return ret;
 }
+
+int request_module_fmt(const char *fmt, ...)
+{
+	char name[32];
+	va_list args;
+	int ret;
+
+	name[sizeof(name)-1] = 0;
+
+	va_start(args, fmt);
+	ret = vsnprintf(name, sizeof(name)-1, fmt, args);
+	va_end(args);
+
+	if (ret >= sizeof(name)-1) {
+		printk(KERN_WARNING "Module name \"%s\"... too long.\n",
+		       name);
+		return -ENAMETOOLONG;
+	}
+	return request_module(name);
+}
+
+EXPORT_SYMBOL(request_module);
+EXPORT_SYMBOL(request_module_fmt);
 #endif /* CONFIG_KMOD */
 
 #ifdef CONFIG_HOTPLUG
@@ -273,8 +296,4 @@
 }
 
 EXPORT_SYMBOL(call_usermodehelper);
-
-#ifdef CONFIG_KMOD
-EXPORT_SYMBOL(request_module);
-#endif
 



-- 
dwmw2


