Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272381AbTHKJAs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 05:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272325AbTHKJAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 05:00:48 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15025 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S272464AbTHKJAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 05:00:25 -0400
Date: Mon, 11 Aug 2003 10:56:06 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: 4GB+DEBUG_PAGEALLOC oopses with 2.6.0-test3-mm1
In-Reply-To: <3F361F5E.10106@colorfullife.com>
Message-ID: <Pine.LNX.4.56.0308111024330.19887@localhost.localdomain>
References: <3F361F5E.10106@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 10 Aug 2003, Manfred Spraul wrote:

> The functions in mm/usercopy assume that no exception handling is
> required if fs is KERNEL_DS. This is not true: at least the mount
> options copy and the i386 traps handler assume exception handling with
> fs==KERNEL_DS.

precisely how does copy_mount_options() break under 4G/4G?

one thing that is known is that copy_mount_options() handles a strange mix
of string-type and data-type pointers. Right now the tools rely on the
string copy getting a fault and aborting the copy early.  The
copy_mount_options() function takes a pointer and copies a full page -
even if we pass a string pointer to it which is at the end of the BSS, and
which thus cannot be copied as a full page.

the attached patch sort out some of this, but it's an incomplete (and thus
incorrect) patch, because some filesystems want a type parameter that is a
binary blob not a string. Some others call it with a string - which can
fault if copied as a PAGE_SIZE object.

in any case, this detail of fault handling is handled correctly by the
4G/4G patch. If there is any other hole, please let me know.

(in theory it's possible that kernel-internal mounts pass in a pointer
where pointer + PAGE_SIZE is not a valid kernel address - if this happens
then we'd get a hard crash.)

	Ingo

--- fs/namespace.c.orig
+++ fs/namespace.c
@@ -863,27 +863,40 @@
 }
 
 asmlinkage long sys_mount(char __user * dev_name, char __user * dir_name,
-			  char __user * type, unsigned long flags,
+			  char __user * type_name, unsigned long flags,
 			  void __user * data)
 {
 	int retval;
 	unsigned long data_page;
-	unsigned long type_page;
-	unsigned long dev_page;
-	char *dir_page;
+	char empty[] = "";
+	char *dev_page = empty, *type_page = empty, *dir_page = empty;
 
-	retval = copy_mount_options (type, &type_page);
-	if (retval < 0)
-		return retval;
+	/*
+	 * Copy those paramters that are string via the string
+	 * functions.
+	 *
+	 * only the data page is copied as a full page.
+	 */
+	if (type_name) {
+		type_page = getname(type_name);
+		retval = PTR_ERR(type_page);
+		if (IS_ERR(type_page))
+			return retval;
+	}
 
-	dir_page = getname(dir_name);
-	retval = PTR_ERR(dir_page);
-	if (IS_ERR(dir_page))
-		goto out1;
+	if (dir_name) {
+		dir_page = getname(dir_name);
+		retval = PTR_ERR(dir_page);
+		if (IS_ERR(dir_page))
+			goto out1;
+	}
 
-	retval = copy_mount_options (dev_name, &dev_page);
-	if (retval < 0)
-		goto out2;
+	if (dev_name) {
+		dev_page = getname(dev_name);
+		retval = PTR_ERR(dev_page);
+		if (IS_ERR(dev_page))
+			goto out2;
+	}
 
 	retval = copy_mount_options (data, &data_page);
 	if (retval < 0)
@@ -896,11 +909,14 @@
 	free_page(data_page);
 
 out3:
-	free_page(dev_page);
+	if (dev_name)
+		putname(dev_page);
 out2:
-	putname(dir_page);
+	if (dir_name)
+		putname(dir_page);
 out1:
-	free_page(type_page);
+	if (type_name)
+		putname(type_page);
 	return retval;
 }
 
