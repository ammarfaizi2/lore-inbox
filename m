Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261707AbSJJR7k>; Thu, 10 Oct 2002 13:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261744AbSJJR7k>; Thu, 10 Oct 2002 13:59:40 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:50956 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261707AbSJJR7i>; Thu, 10 Oct 2002 13:59:38 -0400
Date: Thu, 10 Oct 2002 20:04:36 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Alexander Viro <viro@math.psu.edu>,
       Linus Torvalds <torvalds@transmeta.com>,
       Patrick Mochel <mochel@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.LNX.4.44.0210091704040.5883-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0210100107410.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 9 Oct 2002, Kai Germaschewski wrote:

> So at this point, you decide to rather not have the user wait
> forever until his "rmmod net_pci" succeeds, but return -EBUSY right away.
> You do it by running MOD_INC_USE_COUNT in ::open(), and DEC again in
> ::close().

You don't really want to do this. Imagine what happens if you get
preempted before you had a chance to run MOD_INC_USE_COUNT.

> The current implementation gives you a way of knowing if unloading will
> succeed shortly (if not, it'll fail with -EBUSY). Yours doesn't AFAICS,
> and that's actually bad IMO, I think you actually have to try to see if
> the unload would succeed, and that's not pretty.

The unload path could look something like this:

	if (mod->usecount())
		return -EBUSY;
	mod->state = cleanup;
	if (mod->exit())
		return -EBUSY;
	(free module)

So this does what you want. The only problem is here that the exit call
can fail, because there are still users, so the module will stay in the
cleanup state. start/stop functions would give you better control over
this.

> And, done right, the API for the current implementation is so simple that
> I doubt you'll be able to come up with something with more ease-of-use.

The current API just hides the complexity, but it requires extra checks
all over the kernel, to test if an object belongs to a module and if the
module is running. My proposal would get rid of this.
Deciding whether when you can release a device object or a driver object
is pretty much the same problem and a common solution is IMO prefered. The
module code should work like the remaining kernel and not require extra
care everywhere.
The diff below shows how filesystem.c would change, which becomes simpler
as it doesn't has to care about the module state anymore.

bye, Roman

Index: fs/filesystems.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/fs/filesystems.c,v
retrieving revision 1.1.1.5
diff -u -p -r1.1.1.5 filesystems.c
--- fs/filesystems.c	16 Apr 2002 08:45:18 -0000	1.1.1.5
+++ fs/filesystems.c	10 Oct 2002 15:23:46 -0000
@@ -28,17 +28,17 @@
 static struct file_system_type *file_systems;
 static rwlock_t file_systems_lock = RW_LOCK_UNLOCKED;

-/* WARNING: This can be used only if we _already_ own a reference */
+/* WARNING: This can be used only if we _already_ own a reference
+ * or hold the file_systems_lock
+ */
 void get_filesystem(struct file_system_type *fs)
 {
-	if (fs->owner)
-		__MOD_INC_USE_COUNT(fs->owner);
+	atomic_inc(&fs->refcnt);
 }

 void put_filesystem(struct file_system_type *fs)
 {
-	if (fs->owner)
-		__MOD_DEC_USE_COUNT(fs->owner);
+	atomic_dec(&fs->refcnt);
 }

 static struct file_system_type **find_filesystem(const char *name)
@@ -77,8 +77,10 @@ int register_filesystem(struct file_syst
 	p = find_filesystem(fs->name);
 	if (*p)
 		res = -EBUSY;
-	else
+	else {
 		*p = fs;
+		get_filesystem(fs);
+	}
 	write_unlock(&file_systems_lock);
 	return res;
 }
@@ -103,15 +105,15 @@ int unregister_filesystem(struct file_sy
 	tmp = &file_systems;
 	while (*tmp) {
 		if (fs == *tmp) {
+			put_filesystem(fs);
 			*tmp = fs->next;
 			fs->next = NULL;
-			write_unlock(&file_systems_lock);
-			return 0;
+			break;
 		}
 		tmp = &(*tmp)->next;
 	}
 	write_unlock(&file_systems_lock);
-	return -EINVAL;
+	return atomic_read(&fs->refcnt) > 0 ? -EBUSY : 0;
 }

 static int fs_index(const char * __name)
@@ -145,8 +147,10 @@ static int fs_name(unsigned int index, c

 	read_lock(&file_systems_lock);
 	for (tmp = file_systems; tmp; tmp = tmp->next, index--)
-		if (index <= 0 && try_inc_mod_count(tmp->owner))
-				break;
+		if (index <= 0) {
+			get_filesystem(tmp)
+			break;
+		}
 	read_unlock(&file_systems_lock);
 	if (!tmp)
 		return -EINVAL;
@@ -216,14 +220,14 @@ struct file_system_type *get_fs_type(con

 	read_lock(&file_systems_lock);
 	fs = *(find_filesystem(name));
-	if (fs && !try_inc_mod_count(fs->owner))
-		fs = NULL;
+	if (fs)
+		get_filesystem(fs);
 	read_unlock(&file_systems_lock);
 	if (!fs && (request_module(name) == 0)) {
 		read_lock(&file_systems_lock);
 		fs = *(find_filesystem(name));
-		if (fs && !try_inc_mod_count(fs->owner))
-			fs = NULL;
+		if (fs)
+			put_filesystem(fs);
 		read_unlock(&file_systems_lock);
 	}
 	return fs;


