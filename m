Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275836AbRI1FMi>; Fri, 28 Sep 2001 01:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275837AbRI1FM3>; Fri, 28 Sep 2001 01:12:29 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:27363 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S275836AbRI1FMO>; Fri, 28 Sep 2001 01:12:14 -0400
Date: Thu, 27 Sep 2001 23:12:42 -0600
Message-Id: <200109280512.f8S5CgB27875@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: new^H^H^Himproved devfs races
In-Reply-To: <Pine.GSO.4.21.0109272040390.1671-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0109272040390.1671-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 	Richard, your symlink-related race fixes do not fix anything.
> 
> Enter devfs_readlink()
> Let it sleep in copy_to_user()
> Have symlink unregistered
> ->registered is 0, ->refcount is 1, ->linkname points to link body
> Have symlink registered again (module had been unloaded, now attacker
> causes its reload)
> ->registered is checked. Looks OK.
> ->refcount is set to 1.
> ->linkname is set to _new_ link body
> copy_to_user() wakes up and finishes.
> devfs_readlink() decrements ->refcount to 0.
> devfs_readlink() does kfree() on ->linkname (new one)
> We are left with registered entry with zero refcount and linkname
> pointing nowhere.
> 
> Same scenario applies to other places of that kind.

Damn. Yeah, you're right. There's no good way to do this without
removing the entry from the parent upon unregister (which is what my
tree-in-progress does, BTW). I should have just stuck with the global
rwsem that I put in in devfs-patch-v190. 

OK, as a quick fix for this problem, I've gone back to the rwsem.
Patch appended. This will have to do until my rewrite is finished
(RSN:-).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

diff -urN linux-2.4.10/Documentation/filesystems/devfs/ChangeLog linux/Documentation/filesystems/devfs/ChangeLog
--- linux-2.4.10/Documentation/filesystems/devfs/ChangeLog	Fri Sep 21 11:55:22 2001
+++ linux/Documentation/filesystems/devfs/ChangeLog	Thu Sep 27 23:07:17 2001
@@ -1755,3 +1755,7 @@
 - Ported to kernel 2.4.10-pre11
 
 - Set inode->i_mapping->a_ops for block nodes in <get_vfs_inode>
+===============================================================================
+Changes for patch v193
+
+- Went back to global rwsem for symlinks (refcount scheme no good)
diff -urN linux-2.4.10/fs/devfs/base.c linux/fs/devfs/base.c
--- linux-2.4.10/fs/devfs/base.c	Sat Sep 22 21:35:43 2001
+++ linux/fs/devfs/base.c	Thu Sep 27 23:06:52 2001
@@ -545,6 +545,9 @@
     20010919   Richard Gooch <rgooch@atnf.csiro.au>
 	       Set inode->i_mapping->a_ops for block nodes in <get_vfs_inode>.
   v0.116
+    20010927   Richard Gooch <rgooch@atnf.csiro.au>
+	       Went back to global rwsem for symlinks (refcount scheme no good)
+  v0.117
 */
 #include <linux/types.h>
 #include <linux/errno.h>
@@ -577,7 +580,7 @@
 #include <asm/bitops.h>
 #include <asm/atomic.h>
 
-#define DEVFS_VERSION            "0.116 (20010919)"
+#define DEVFS_VERSION            "0.117 (20010927)"
 
 #define DEVFS_NAME "devfs"
 
@@ -659,8 +662,6 @@
 
 struct symlink_type
 {
-    atomic_t refcount;           /*  When this drops to zero, it's unused    */
-    rwlock_t lock;               /*  Lock around the registered flag         */
     unsigned int length;         /*  Not including the NULL-termimator       */
     char *linkname;              /*  This is NULL-terminated                 */
 };
@@ -750,6 +751,8 @@
 static unsigned int boot_options = OPTION_NONE;
 #endif
 
+static DECLARE_RWSEM (symlink_rwsem);
+
 /*  Forward function declarations  */
 static struct devfs_entry *search_for_entry (struct devfs_entry *dir,
 					     const char *name,
@@ -807,19 +810,12 @@
     if (curr == NULL) return NULL;
     if (!S_ISLNK (curr->mode) || !traverse_symlink) return curr;
     /*  Need to follow the link: this is a stack chomper  */
-    read_lock (&curr->u.symlink.lock);
-    if (!curr->registered)
-    {
-	read_unlock (&curr->u.symlink.lock);
-	return NULL;
-    }
-    atomic_inc (&curr->u.symlink.refcount);
-    read_unlock (&curr->u.symlink.lock);
-    retval = search_for_entry (parent, curr->u.symlink.linkname,
-			       curr->u.symlink.length, FALSE, FALSE, NULL,
-			       TRUE);
-    if ( atomic_dec_and_test (&curr->u.symlink.refcount) )
-	kfree (curr->u.symlink.linkname);
+    down_read (&symlink_rwsem);
+    retval = curr->registered ?
+	search_for_entry (parent, curr->u.symlink.linkname,
+			  curr->u.symlink.length, FALSE, FALSE, NULL,
+			  TRUE) : NULL;
+    up_read (&symlink_rwsem);
     return retval;
 }   /*  End Function search_for_entry_in_dir  */
 
@@ -1436,11 +1432,11 @@
     }
     if (S_ISLNK (de->mode) && de->registered)
     {
-	write_lock (&de->u.symlink.lock);
 	de->registered = FALSE;
-	write_unlock (&de->u.symlink.lock);
-	if ( atomic_dec_and_test (&de->u.symlink.refcount) )
-	    kfree (de->u.symlink.linkname);
+	down_write (&symlink_rwsem);
+	if (de->u.symlink.linkname) kfree (de->u.symlink.linkname);
+	de->u.symlink.linkname = NULL;
+	up_write (&symlink_rwsem);
 	return;
     }
     if ( S_ISFIFO (de->mode) )
@@ -1520,8 +1516,10 @@
 	kfree (newlink);
 	return -ENOMEM;
     }
+    down_write (&symlink_rwsem);
     if (de->registered)
     {
+	up_write (&symlink_rwsem);
 	kfree (newlink);
 	printk ("%s: devfs_do_symlink(%s): entry already exists\n",
 		DEVFS_NAME, name);
@@ -1532,9 +1530,8 @@
     de->hide = (flags & DEVFS_FL_HIDE) ? TRUE : FALSE;
     de->u.symlink.linkname = newlink;
     de->u.symlink.length = linklength;
-    atomic_set (&de->u.symlink.refcount, 1);
-    rwlock_init (&de->u.symlink.lock);
     de->registered = TRUE;
+    up_write (&symlink_rwsem);
     if (handle != NULL) *handle = de;
     return 0;
 }   /*  End Function devfs_do_symlink  */
@@ -2818,16 +2815,15 @@
     if (de == NULL) return -ENOENT;
     devfsd_notify_one (de, DEVFSD_NOTIFY_DELETE, inode->i_mode,
 		       inode->i_uid, inode->i_gid, dir->i_sb->u.generic_sbp);
+    de->registered = FALSE;
+    de->hide = TRUE;
     if ( S_ISLNK (de->mode) )
     {
-	write_lock (&de->u.symlink.lock);
-	de->registered = FALSE;
-	write_unlock (&de->u.symlink.lock);
-	if ( atomic_dec_and_test (&de->u.symlink.refcount) )
-	    kfree (de->u.symlink.linkname);
+	down_write (&symlink_rwsem);
+	if (de->u.symlink.linkname) kfree (de->u.symlink.linkname);
+	de->u.symlink.linkname = NULL;
+	up_write (&symlink_rwsem);
     }
-    else de->registered = FALSE;
-    de->hide = TRUE;
     free_dentries (de);
     return 0;
 }   /*  End Function devfs_unlink  */
@@ -3029,17 +3025,10 @@
 
     de = get_devfs_entry_from_vfs_inode (dentry->d_inode, TRUE);
     if (!de) return -ENODEV;
-    read_lock (&de->u.symlink.lock);
-    if (!de->registered)
-    {
-	read_unlock (&de->u.symlink.lock);
-	return -ENODEV;
-    }
-    atomic_inc (&de->u.symlink.refcount);
-    read_unlock (&de->u.symlink.lock);
-    err = vfs_readlink (dentry, buffer, buflen, de->u.symlink.linkname);
-    if ( atomic_dec_and_test (&de->u.symlink.refcount) )
-	kfree (de->u.symlink.linkname);
+    down_read (&symlink_rwsem);
+    err = de->registered ? vfs_readlink (dentry, buffer, buflen,
+					 de->u.symlink.linkname) : -ENODEV;
+    up_read (&symlink_rwsem);
     return err;
 }   /*  End Function devfs_readlink  */
 
@@ -3050,17 +3039,10 @@
 
     de = get_devfs_entry_from_vfs_inode (dentry->d_inode, TRUE);
     if (!de) return -ENODEV;
-    read_lock (&de->u.symlink.lock);
-    if (!de->registered)
-    {
-	read_unlock (&de->u.symlink.lock);
-	return -ENODEV;
-    }
-    atomic_inc (&de->u.symlink.refcount);
-    read_unlock (&de->u.symlink.lock);
-    err = vfs_follow_link (nd, de->u.symlink.linkname);
-    if ( atomic_dec_and_test (&de->u.symlink.refcount) )
-	kfree (de->u.symlink.linkname);
+    down_read (&symlink_rwsem);
+    err = de->registered ? vfs_follow_link (nd,
+					    de->u.symlink.linkname) : -ENODEV;
+    up_read (&symlink_rwsem);
     return err;
 }   /*  End Function devfs_follow_link  */
 
