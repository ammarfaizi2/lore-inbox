Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbTEYRRk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 13:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263653AbTEYRRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 13:17:40 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:3994 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263574AbTEYRR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 13:17:28 -0400
Date: Sun, 25 May 2003 12:41:48 -0400
From: Ben Collins <bcollins@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Resend [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
Message-ID: <20030525164148.GA602@phunnypharm.org>
References: <20030525000701.GG504@phunnypharm.org> <Pine.LNX.4.44.0305242045050.1666-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305242045050.1666-100000@home.transmeta.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> 
> which is what pretty much everybody really _wants_ to have anyway? We 
> should deprecate "strncpy()" within the kernel entirely.

Let's try this one for size. First patch adds strlcpy and strlcat. The
second patch applies to my initial offender, drivers/base.

I'll do obvious conversions of the rest of tree over the next week and
hope that the architectures will be able to do optimized versions in the
same time frame. If everything works out ok, strncpy (and maybe strncat)
can be either marked deprecated or just removed altogether.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="strlcpy-strlcat.diff"

Index: kernel/ksyms.c
===================================================================
--- kernel/ksyms.c	(revision 10041)
+++ kernel/ksyms.c	(working copy)
@@ -578,6 +578,8 @@
 EXPORT_SYMBOL(strnicmp);
 EXPORT_SYMBOL(strspn);
 EXPORT_SYMBOL(strsep);
+EXPORT_SYMBOL(strlcat);
+EXPORT_SYMBOL(strlcpy);
 
 /* software interrupts */
 EXPORT_SYMBOL(tasklet_init);
Index: include/linux/string.h
===================================================================
--- include/linux/string.h	(revision 10041)
+++ include/linux/string.h	(working copy)
@@ -25,12 +25,18 @@
 #ifndef __HAVE_ARCH_STRCPY
 extern char * strcpy(char *,const char *);
 #endif
+#ifndef __HAVE_ARCH_STRLCPY
+extern size_t strlcpy(char *dest, const char *src, size_t size);
+#endif
 #ifndef __HAVE_ARCH_STRNCPY
 extern char * strncpy(char *,const char *, __kernel_size_t);
 #endif
 #ifndef __HAVE_ARCH_STRCAT
 extern char * strcat(char *, const char *);
 #endif
+#ifndef __HAVE_ARCH_STRLCAT
+extern size_t strlcat(char *dest, const char *src, size_t size);
+#endif
 #ifndef __HAVE_ARCH_STRNCAT
 extern char * strncat(char *, const char *, __kernel_size_t);
 #endif
Index: lib/string.c
===================================================================
--- lib/string.c	(revision 10041)
+++ lib/string.c	(working copy)
@@ -17,8 +17,40 @@
  * * Sat Feb 09 2002, Jason Thomas <jason@topic.com.au>,
  *                    Matthew Hawkins <matt@mh.dropbear.id.au>
  * -  Kissed strtok() goodbye
+ *
+ * * Sun May 25 2003, Ben Collins <bcollins@debian.org>
+ * -  Added strlcpy and strlcat, which will replace strncpy and strncat
+ *    since they are safer and guarantee a NUL-terminated dest.
  */
- 
+
+/* Following applies to strlcpy and strlcat */
+/*
+ * Copyright (c) 2001 Richard Kettlewell <rjk@greenend.org.uk>
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. The name of the author may not be used to endorse or promote products
+ *    derived from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
+ * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
+ * THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
+ * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
+ * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
+ * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
@@ -72,6 +104,35 @@
 }
 #endif
 
+#ifndef __HAVE_ARCH_STRLCPY
+/**
+ * strlcpy - Copy a length-limited, %NUL-terminated string
+ * @dest: Where to copy the string to
+ * @src: Where to copy the string from
+ * @size: The size of the @dest buffer
+ *
+ * Note that unlike strncpy, the result is always guaranteed to be
+ * %NUL-terminated but is not %NUL-padded. This is much safer than
+ * strncpy. The return value is basically strlen(src), which means you can
+ * use it to check if the result should have been longer than @size,
+ * meaning it was truncated.
+ */
+size_t strlcpy(char *dest, const char *src, size_t size)
+{
+	size_t l = strlen(src);
+
+	if (l >= size) {
+		if (size) {
+			memcpy(dest, src, size - 1);
+			dest[size - 1] = 0;
+		}
+	} else if (l)
+		memcpy(dest, src, l + 1);
+
+	return l;
+}
+#endif
+
 #ifndef __HAVE_ARCH_STRNCPY
 /**
  * strncpy - Copy a length-limited, %NUL-terminated string
@@ -113,6 +174,53 @@
 }
 #endif
 
+#ifndef __HAVE_ARCH_STRLCAT
+/**
+ * strlcat - Append a length-limited, %NUL-terminated string to another
+ * @dest: The string to be appended to
+ * @src: The string to append to it
+ * @size: The size of the @dest buffer
+ *
+ * Note that even though strncat %NUL-terminates, this function is more
+ * useful since it is easier to check for truncation.
+ *
+ * Unlink strncat, @size is the total size of @dest, not just the amount
+ * left. The return value is strlen(src) + strlen(initial dest)).
+ *
+ * If the return value is greater than @size, truncation occured.
+ */
+size_t strlcat(char *dest, const char *src, size_t size)
+{
+	size_t sl = strlen(src);
+	size_t dl, tl;
+
+	/* strlcpy wont give us NULL termination if size is 0, so we can't
+	 * check strlen(dest) if someone does this scenario:
+	 *
+	 * strlcpy(dest, "My ", 0);
+	 * strlcat(dest, "string", 0);
+	 *
+	 * Stupid, I know, but just a check.
+	 */
+	if (!size)
+		return sl;
+
+	dl = strlen(dest);
+	tl = sl + dl;
+
+	if (tl >= size) {
+		/* Truncation occurs, but check for room */
+		if (size > dl) {
+			memcpy(dest + dl, src, size - dl - 1);
+			dest[size - 1] = 0;
+		}
+	} else
+		memcpy(dest + dl, src, sl + 1);
+
+	return tl;
+}
+#endif
+
 #ifndef __HAVE_ARCH_STRNCAT
 /**
  * strncat - Append a length-limited, %NUL-terminated string to another

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="base-strlcpy.diff"

Index: drivers/base/class.c
===================================================================
--- drivers/base/class.c	(revision 10041)
+++ drivers/base/class.c	(working copy)
@@ -87,8 +87,8 @@
 
 	INIT_LIST_HEAD(&cls->children);
 	INIT_LIST_HEAD(&cls->interfaces);
-	
-	strncpy(cls->subsys.kset.kobj.name,cls->name,KOBJ_NAME_LEN);
+
+	strlcpy(cls->subsys.kset.kobj.name, cls->name, KOBJ_NAME_LEN);
 	subsys_set_kset(cls,class_subsys);
 	subsystem_register(&cls->subsys);
 
@@ -258,7 +258,7 @@
 		 class_dev->class_id);
 
 	/* first, register with generic layer. */
-	strncpy(class_dev->kobj.name, class_dev->class_id, KOBJ_NAME_LEN);
+	strlcpy(class_dev->kobj.name, class_dev->class_id, KOBJ_NAME_LEN);
 	kobj_set_kset_s(class_dev, class_obj_subsys);
 	if (parent)
 		class_dev->kobj.parent = &parent->subsys.kset.kobj;
Index: drivers/base/sys.c
===================================================================
--- drivers/base/sys.c	(revision 10041)
+++ drivers/base/sys.c	(working copy)
@@ -63,8 +63,8 @@
 
 	error = device_register(&root->dev);
 	if (!error) {
-		strncpy(root->sysdev.bus_id,"sys",BUS_ID_SIZE);
-		strncpy(root->sysdev.name,"System Bus",DEVICE_NAME_SIZE);
+		strlcpy(root->sysdev.bus_id,"sys",BUS_ID_SIZE);
+		strlcpy(root->sysdev.name,"System Bus",DEVICE_NAME_SIZE);
 		root->sysdev.parent = &root->dev;
 		error = device_register(&root->sysdev);
 	};
Index: drivers/base/core.c
===================================================================
--- drivers/base/core.c	(revision 10041)
+++ drivers/base/core.c	(working copy)
@@ -211,7 +211,7 @@
 		 dev->bus_id, dev->name);
 
 	/* first, register with generic layer. */
-	strncpy(dev->kobj.name,dev->bus_id,KOBJ_NAME_LEN);
+	strlcpy(dev->kobj.name, dev->bus_id, KOBJ_NAME_LEN);
 	if (parent)
 		dev->kobj.parent = &parent->kobj;
 
Index: drivers/base/bus.c
===================================================================
--- drivers/base/bus.c	(revision 10041)
+++ drivers/base/bus.c	(working copy)
@@ -431,7 +431,7 @@
 	if (bus) {
 		pr_debug("bus %s: add driver %s\n",bus->name,drv->name);
 
-		strncpy(drv->kobj.name,drv->name,KOBJ_NAME_LEN);
+		strlcpy(drv->kobj.name, drv->name, KOBJ_NAME_LEN);
 		drv->kobj.kset = &bus->drivers;
 
 		if ((error = kobject_register(&drv->kobj))) {
@@ -540,15 +540,15 @@
  */
 int bus_register(struct bus_type * bus)
 {
-	strncpy(bus->subsys.kset.kobj.name,bus->name,KOBJ_NAME_LEN);
+	strlcpy(bus->subsys.kset.kobj.name, bus->name, KOBJ_NAME_LEN);
 	subsys_set_kset(bus,bus_subsys);
 	subsystem_register(&bus->subsys);
 
-	snprintf(bus->devices.kobj.name,KOBJ_NAME_LEN,"devices");
+	strlcpy(bus->devices.kobj.name, "devices", KOBJ_NAME_LEN);
 	bus->devices.subsys = &bus->subsys;
 	kset_register(&bus->devices);
 
-	snprintf(bus->drivers.kobj.name,KOBJ_NAME_LEN,"drivers");
+	strlcpy(bus->drivers.kobj.name, "drivers", KOBJ_NAME_LEN);
 	bus->drivers.subsys = &bus->subsys;
 	bus->drivers.ktype = &ktype_driver;
 	kset_register(&bus->drivers);

--9amGYk9869ThD9tj--
