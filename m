Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266318AbSLWO6T>; Mon, 23 Dec 2002 09:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266491AbSLWO6T>; Mon, 23 Dec 2002 09:58:19 -0500
Received: from h-64-105-34-78.SNVACAID.covad.net ([64.105.34.78]:39101 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266318AbSLWO6Q>; Mon, 23 Dec 2002 09:58:16 -0500
Date: Mon, 23 Dec 2002 07:05:47 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC/Preliminary patch - simpler raceless module unloading
Message-ID: <20021223070547.A562@baldur.yggdrasil.com>
References: <20021223053614.A31939@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20021223053614.A31939@baldur.yggdrasil.com>; from adam@yggdrasil.com on Mon, Dec 23, 2002 at 05:36:14AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I wrote:
> 	I plan to port net_device, filesystem, file_operations,
> block_device_operations, and device_driver to use it.  So if what
> I've described above is too verbose, it should become clearer once
> I post some ports of code to it.

	Here is a preliminary port of fs/filesystems.c, although I have
not done the clean-ups it enables.  I am running it now and have verified
that I can at least load and unload a filesystem module and that I'm
still prevented from unloading a filesystem module that is in use.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fs.diff"

--- linux-2.5.52/include/linux/fs.h	2002-12-15 18:07:50.000000000 -0800
+++ linux/include/linux/fs.h	2002-12-23 07:00:02.000000000 -0800
@@ -19,6 +19,7 @@
 #include <linux/stat.h>
 #include <linux/cache.h>
 #include <linux/radix-tree.h>
+#include <linux/module_rwsem.h>
 #include <asm/atomic.h>
 
 struct iovec;
@@ -953,7 +954,8 @@
 	int fs_flags;
 	struct super_block *(*get_sb) (struct file_system_type *, int, char *, void *);
 	void (*kill_sb) (struct super_block *);
-	struct module *owner;
+	struct module *owner;	/* Will be subsumed into mod_rwsem. */
+	struct module_rwsem	mod_rwsem;
 	struct file_system_type * next;
 	struct list_head fs_supers;
 };
--- linux-2.5.52/fs/filesystems.c	2002-12-15 18:08:14.000000000 -0800
+++ linux/fs/filesystems.c	2002-12-23 06:56:40.000000000 -0800
@@ -26,7 +26,7 @@
  */
 
 static struct file_system_type *file_systems;
-static rwlock_t file_systems_lock = RW_LOCK_UNLOCKED;
+static DECLARE_RWSEM(file_systems_rwsem);
 
 /* WARNING: This can be used only if we _already_ own a reference */
 void get_filesystem(struct file_system_type *fs)
@@ -81,13 +81,17 @@
 	if (fs->next)
 		return -EBUSY;
 	INIT_LIST_HEAD(&fs->fs_supers);
-	write_lock(&file_systems_lock);
+	down_write(&file_systems_rwsem);
 	p = find_filesystem(fs->name);
 	if (*p)
 		res = -EBUSY;
-	else
+	else {
 		*p = fs;
-	write_unlock(&file_systems_lock);
+		fs->mod_rwsem.module = fs->owner;
+		fs->mod_rwsem.rwsem = &file_systems_rwsem;
+		register_module_rwsem(&fs->mod_rwsem);
+	}
+	up_write(&file_systems_rwsem);
 	return res;
 }
 
@@ -107,18 +111,18 @@
 {
 	struct file_system_type ** tmp;
 
-	write_lock(&file_systems_lock);
+	/* sys_delete_module has already done a
+	   down_write(&file_systems_rwsem) for us. */
 	tmp = &file_systems;
 	while (*tmp) {
 		if (fs == *tmp) {
 			*tmp = fs->next;
 			fs->next = NULL;
-			write_unlock(&file_systems_lock);
+			up_write(&file_systems_rwsem);
 			return 0;
 		}
 		tmp = &(*tmp)->next;
 	}
-	write_unlock(&file_systems_lock);
 	return -EINVAL;
 }
 
@@ -134,14 +138,14 @@
 		return err;
 
 	err = -EINVAL;
-	read_lock(&file_systems_lock);
+	down_read(&file_systems_rwsem);
 	for (tmp=file_systems, index=0 ; tmp ; tmp=tmp->next, index++) {
 		if (strcmp(tmp->name,name) == 0) {
 			err = index;
 			break;
 		}
 	}
-	read_unlock(&file_systems_lock);
+	up_read(&file_systems_rwsem);
 	putname(name);
 	return err;
 }
@@ -151,11 +155,11 @@
 	struct file_system_type * tmp;
 	int len, res;
 
-	read_lock(&file_systems_lock);
+	down_read(&file_systems_rwsem);
 	for (tmp = file_systems; tmp; tmp = tmp->next, index--)
 		if (index <= 0 && try_inc_mod_count(tmp->owner))
 				break;
-	read_unlock(&file_systems_lock);
+	up_read(&file_systems_rwsem);
 	if (!tmp)
 		return -EINVAL;
 
@@ -171,10 +175,10 @@
 	struct file_system_type * tmp;
 	int index;
 
-	read_lock(&file_systems_lock);
+	down_read(&file_systems_rwsem);
 	for (tmp = file_systems, index = 0 ; tmp ; tmp = tmp->next, index++)
 		;
-	read_unlock(&file_systems_lock);
+	up_read(&file_systems_rwsem);
 	return index;
 }
 
@@ -206,7 +210,7 @@
 	int len = 0;
 	struct file_system_type * tmp;
 
-	read_lock(&file_systems_lock);
+	down_read(&file_systems_rwsem);
 	tmp = file_systems;
 	while (tmp && len < PAGE_SIZE - 80) {
 		len += sprintf(buf+len, "%s\t%s\n",
@@ -214,7 +218,7 @@
 			tmp->name);
 		tmp = tmp->next;
 	}
-	read_unlock(&file_systems_lock);
+	up_read(&file_systems_rwsem);
 	return len;
 }
 
@@ -222,17 +226,17 @@
 {
 	struct file_system_type *fs;
 
-	read_lock(&file_systems_lock);
+	down_read(&file_systems_rwsem);
 	fs = *(find_filesystem(name));
 	if (fs && !try_inc_mod_count(fs->owner))
 		fs = NULL;
-	read_unlock(&file_systems_lock);
+	up_read(&file_systems_rwsem);
 	if (!fs && (request_module(name) == 0)) {
-		read_lock(&file_systems_lock);
+		down_read(&file_systems_rwsem);
 		fs = *(find_filesystem(name));
 		if (fs && !try_inc_mod_count(fs->owner))
 			fs = NULL;
-		read_unlock(&file_systems_lock);
+		up_read(&file_systems_rwsem);
 	}
 	return fs;
 }

--ikeVEW9yuYc//A+q--
