Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267687AbTGIMHx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 08:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268201AbTGIMHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 08:07:53 -0400
Received: from verein.lst.de ([212.34.189.10]:205 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S267687AbTGIMHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 08:07:46 -0400
Date: Wed, 9 Jul 2003 14:22:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kill proc_mknod
Message-ID: <20030709122213.GA32634@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -1.6 () HTML_10_20,PATCH_UNIFIED_DIFF,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's not used anymore since ALSA switched to traditional devices and
device nodes in procfs are a bad idea in general..

Also update the docs.


--- 1.3/Documentation/DocBook/procfs-guide.tmpl	Tue Oct 29 06:14:41 2002
+++ edited/Documentation/DocBook/procfs-guide.tmpl	Tue Jul  8 13:41:11 2003
@@ -253,41 +253,6 @@
       </para>
     </sect1>
 
-
-
-
-    <sect1>
-      <title>Creating a device</title>
-
-      <funcsynopsis>
-	<funcprototype>
-	  <funcdef>struct proc_dir_entry* <function>proc_mknod</function></funcdef>
-	  <paramdef>const char* <parameter>name</parameter></paramdef>
-	  <paramdef>mode_t <parameter>mode</parameter></paramdef>
-	  <paramdef>struct proc_dir_entry* <parameter>parent</parameter></paramdef>
-	  <paramdef>kdev_t <parameter>rdev</parameter></paramdef>
-	</funcprototype>
-      </funcsynopsis>
-      
-      <para>
-        Creates a device file <parameter>name</parameter> with mode
-        <parameter>mode</parameter> in the procfs directory
-        <parameter>parent</parameter>. The device file will work on
-        the device <parameter>rdev</parameter>, which can be generated
-        by using the <literal>MKDEV</literal> macro from
-        <literal>linux/kdev_t.h</literal>. The
-        <parameter>mode</parameter> parameter
-        <emphasis>must</emphasis> contain <constant>S_IFBLK</constant>
-        or <constant>S_IFCHR</constant> to create a device
-        node. Compare with userland <literal>mknod
-        --mode=</literal><parameter>mode</parameter>
-        <parameter>name</parameter> <parameter>rdev</parameter>.
-      </para>
-    </sect1>
-
-
-
-
     <sect1>
       <title>Creating a directory</title>
       
--- 1.4/Documentation/DocBook/procfs_example.c	Sun Nov 17 00:02:15 2002
+++ edited/Documentation/DocBook/procfs_example.c	Tue Jul  8 13:41:39 2003
@@ -63,7 +63,7 @@
 
 
 static struct proc_dir_entry *example_dir, *foo_file,
-	*bar_file, *jiffies_file, *tty_device, *symlink;
+	*bar_file, *jiffies_file, *symlink;
 
 
 struct fb_data_t foo_data, bar_data;
@@ -173,16 +173,6 @@
 	bar_file->write_proc = proc_write_foobar;
 	bar_file->owner = THIS_MODULE;
 		
-	/* create tty device */
-	tty_device = proc_mknod("tty", S_IFCHR | 0666,
-				example_dir, MKDEV(5, 0));
-	if(tty_device == NULL) {
-		rv = -ENOMEM;
-		goto no_tty;
-	}
-	
-	tty_device->owner = THIS_MODULE;
-
 	/* create symlink */
 	symlink = proc_symlink("jiffies_too", example_dir, 
 			       "jiffies");
--- 1.22/fs/proc/generic.c	Thu Jul  3 15:36:44 2003
+++ edited/fs/proc/generic.c	Tue Jul  8 13:40:04 2003
@@ -566,22 +566,6 @@
 	return ent;
 }
 
-struct proc_dir_entry *proc_mknod(const char *name, mode_t mode,
-		struct proc_dir_entry *parent, kdev_t rdev)
-{
-	struct proc_dir_entry *ent;
-
-	ent = proc_create(&parent,name,mode,1);
-	if (ent) {
-		ent->rdev = rdev;
-		if (proc_register(parent, ent) < 0) {
-			kfree(ent);
-			ent = NULL;
-		}
-	}
-	return ent;
-}
-
 struct proc_dir_entry *proc_mkdir(const char *name, struct proc_dir_entry *parent)
 {
 	struct proc_dir_entry *ent;
--- 1.23/fs/proc/inode.c	Tue May 27 22:07:01 2003
+++ edited/fs/proc/inode.c	Tue Jul  8 13:40:32 2003
@@ -204,8 +204,6 @@
 			inode->i_op = de->proc_iops;
 		if (de->proc_fops)
 			inode->i_fop = de->proc_fops;
-		else if (S_ISBLK(de->mode)||S_ISCHR(de->mode)||S_ISFIFO(de->mode))
-			init_special_inode(inode,de->mode,kdev_t_to_nr(de->rdev));
 	}
 
 out:
--- 1.15/fs/proc/root.c	Thu Jul  3 15:36:44 2003
+++ edited/fs/proc/root.c	Tue Jul  8 13:39:55 2003
@@ -153,7 +153,6 @@
 EXPORT_SYMBOL(proc_sys_root);
 #endif
 EXPORT_SYMBOL(proc_symlink);
-EXPORT_SYMBOL(proc_mknod);
 EXPORT_SYMBOL(proc_mkdir);
 EXPORT_SYMBOL(create_proc_entry);
 EXPORT_SYMBOL(remove_proc_entry);
--- 1.23/include/linux/proc_fs.h	Thu Jul  3 15:36:45 2003
+++ edited/include/linux/proc_fs.h	Tue Jul  8 13:42:02 2003
@@ -71,7 +71,6 @@
 	write_proc_t *write_proc;
 	atomic_t count;		/* use count */
 	int deleted;		/* delete flag */
-	kdev_t	rdev;
 };
 
 struct kcore_list {
@@ -141,8 +140,6 @@
 
 extern struct proc_dir_entry *proc_symlink(const char *,
 		struct proc_dir_entry *, const char *);
-extern struct proc_dir_entry *proc_mknod(const char *,mode_t,
-		struct proc_dir_entry *,kdev_t);
 extern struct proc_dir_entry *proc_mkdir(const char *,struct proc_dir_entry *);
 
 static inline struct proc_dir_entry *create_proc_read_entry(const char *name,
@@ -209,8 +206,6 @@
 
 static inline struct proc_dir_entry *proc_symlink(const char *name,
 		struct proc_dir_entry *parent,char *dest) {return NULL;}
-static inline struct proc_dir_entry *proc_mknod(const char *name,mode_t mode,
-		struct proc_dir_entry *parent,kdev_t rdev) {return NULL;}
 static inline struct proc_dir_entry *proc_mkdir(const char *name,
 	struct proc_dir_entry *parent) {return NULL;}
 
