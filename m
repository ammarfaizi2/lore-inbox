Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277528AbRKMS6M>; Tue, 13 Nov 2001 13:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278177AbRKMS6C>; Tue, 13 Nov 2001 13:58:02 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:18827 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S277528AbRKMS5l>; Tue, 13 Nov 2001 13:57:41 -0500
Date: Tue, 13 Nov 2001 11:55:02 -0700
Message-Id: <200111131855.fADIt2Q26535@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] Next cut of new devfs core
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Another cut of the new devfs core. Better debugging and a
devfsd notification race was fixed.

If people could try this out and report back, I'd appreciate it.

Patch against 2.4.14, and applies cleanly against 2.4.15-pre4.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

diff -urN linux-2.4.14/Documentation/filesystems/devfs/README linux/Documentation/filesystems/devfs/README
--- linux-2.4.14/Documentation/filesystems/devfs/README	Thu Oct 11 00:23:24 2001
+++ linux/Documentation/filesystems/devfs/README	Sat Nov 10 19:44:15 2001
@@ -3,7 +3,7 @@
 
 Linux Devfs (Device File System) FAQ
 Richard Gooch
-29-SEP-2001
+9-NOV-2001
 
 -----------------------------------------------------------------------------
 
@@ -11,7 +11,9 @@
 
 http://www.atnf.csiro.au/~rgooch/linux/docs/devfs.html
 and looks much better than the text version distributed with the
-kernel sources.
+kernel sources. A mirror site is available at:
+
+http://www.ras.ucalgary.ca/~rgooch/linux/docs/devfs.html
 
 There is also an optional daemon that may be used with devfs. You can
 find out more about it at:
diff -urN linux-2.4.14/fs/devfs/base.c linux/fs/devfs/base.c
--- linux-2.4.14/fs/devfs/base.c	Sat Nov  3 11:06:38 2001
+++ linux/fs/devfs/base.c	Tue Nov 13 11:42:55 2001
@@ -545,21 +545,15 @@
     20010919   Richard Gooch <rgooch@atnf.csiro.au>
 	       Set inode->i_mapping->a_ops for block nodes in <get_vfs_inode>.
   v0.116
-    20010927   Richard Gooch <rgooch@atnf.csiro.au>
-	       Went back to global rwsem for symlinks (refcount scheme no good)
-  v0.117
     20011008   Richard Gooch <rgooch@atnf.csiro.au>
 	       Fixed overrun in <devfs_link> by removing function (not needed).
-  v0.118
     20011009   Richard Gooch <rgooch@atnf.csiro.au>
 	       Fixed buffer underrun in <try_modload>.
-	       Moved down_read() from <search_for_entry_in_dir> to <find_entry>
-  v0.119
     20011029   Richard Gooch <rgooch@atnf.csiro.au>
 	       Fixed race in <devfsd_ioctl> when setting event mask.
-    20011103   Richard Gooch <rgooch@atnf.csiro.au>
-	       Avoid deadlock in <devfs_follow_link> by using temporary buffer.
-  v0.120
+    20011113   Richard Gooch <rgooch@atnf.csiro.au>
+	       Pre-alpha cut of new locking code.
+  v1.0-pre7
 */
 #include <linux/types.h>
 #include <linux/errno.h>
@@ -592,7 +586,7 @@
 #include <asm/bitops.h>
 #include <asm/atomic.h>
 
-#define DEVFS_VERSION            "0.120 (20011103)"
+#define DEVFS_VERSION            "1.0-pre7 (20011113)"
 
 #define DEVFS_NAME "devfs"
 
@@ -605,27 +599,28 @@
 #  define FALSE 0
 #endif
 
-#define IS_HIDDEN(de) (( ((de)->hide && !is_devfsd_or_child(fs_info)) || !(de)->registered))
+#define IS_HIDDEN(de) ( (de)->hide && !is_devfsd_or_child(fs_info) )
 
-#define DEBUG_NONE         0x00000
-#define DEBUG_MODULE_LOAD  0x00001
-#define DEBUG_REGISTER     0x00002
-#define DEBUG_UNREGISTER   0x00004
-#define DEBUG_SET_FLAGS    0x00008
-#define DEBUG_S_PUT        0x00010
-#define DEBUG_I_LOOKUP     0x00020
-#define DEBUG_I_CREATE     0x00040
-#define DEBUG_I_GET        0x00080
-#define DEBUG_I_CHANGE     0x00100
-#define DEBUG_I_UNLINK     0x00200
-#define DEBUG_I_RLINK      0x00400
-#define DEBUG_I_FLINK      0x00800
-#define DEBUG_I_MKNOD      0x01000
-#define DEBUG_F_READDIR    0x02000
-#define DEBUG_D_DELETE     0x04000
-#define DEBUG_D_RELEASE    0x08000
-#define DEBUG_D_IPUT       0x10000
-#define DEBUG_ALL          0xfffff
+#define DEBUG_NONE         0x0000000
+#define DEBUG_MODULE_LOAD  0x0000001
+#define DEBUG_REGISTER     0x0000002
+#define DEBUG_UNREGISTER   0x0000004
+#define DEBUG_FREE         0x0000008
+#define DEBUG_SET_FLAGS    0x0000010
+#define DEBUG_S_READ       0x0000100        /*  Break  */
+#define DEBUG_I_LOOKUP     0x0001000        /*  Break  */
+#define DEBUG_I_CREATE     0x0002000
+#define DEBUG_I_GET        0x0004000
+#define DEBUG_I_CHANGE     0x0008000
+#define DEBUG_I_UNLINK     0x0010000
+#define DEBUG_I_RLINK      0x0020000
+#define DEBUG_I_FLINK      0x0040000
+#define DEBUG_I_MKNOD      0x0080000
+#define DEBUG_F_READDIR    0x0100000        /*  Break  */
+#define DEBUG_D_DELETE     0x1000000        /*  Break  */
+#define DEBUG_D_RELEASE    0x2000000
+#define DEBUG_D_IPUT       0x4000000
+#define DEBUG_ALL          0xfffffff
 #define DEBUG_DISABLED     DEBUG_NONE
 
 #define OPTION_NONE             0x00
@@ -638,9 +633,11 @@
 
 struct directory_type
 {
+    rwlock_t lock;                   /*  Lock for searching(R)/updating(W)   */
     struct devfs_entry *first;
     struct devfs_entry *last;
-    unsigned int num_removable;
+    unsigned short num_removable;    /*  Lock for writing but not reading    */
+    unsigned char no_more_additions:1;
 };
 
 struct file_type
@@ -656,8 +653,6 @@
 
 struct fcb_type  /*  File, char, block type  */
 {
-    uid_t default_uid;
-    gid_t default_gid;
     void *ops;
     union 
     {
@@ -678,20 +673,13 @@
     char *linkname;              /*  This is NULL-terminated                 */
 };
 
-struct fifo_type
-{
-    uid_t uid;
-    gid_t gid;
-};
-
-struct devfs_inode  /*  This structure is for "persistent" inode storage  */
+struct devfs_inode     /*  This structure is for "persistent" inode storage  */
 {
+    struct dentry *dentry;
     time_t atime;
     time_t mtime;
     time_t ctime;
-    unsigned int ino;          /*  Inode number as seen in the VFS  */
-    struct dentry *dentry;
-    umode_t mode;
+    unsigned int ino;            /*  Inode number as seen in the VFS         */
     uid_t uid;
     gid_t gid;
 };
@@ -699,12 +687,12 @@
 struct devfs_entry
 {
     void *info;
+    atomic_t refcount;           /*  When this drops to zero, it's unused    */
     union 
     {
 	struct directory_type dir;
 	struct fcb_type fcb;
 	struct symlink_type symlink;
-	struct fifo_type fifo;
     }
     u;
     struct devfs_entry *prev;    /*  Previous entry in the parent directory  */
@@ -713,12 +701,11 @@
     struct devfs_entry *slave;   /*  Another entry to unregister             */
     struct devfs_inode inode;
     umode_t mode;
-    unsigned short namelen;  /*  I think 64k+ filenames are a way off...  */
-    unsigned char registered:1;
+    unsigned short namelen;      /*  I think 64k+ filenames are a way off... */
     unsigned char hide:1;
-    unsigned char no_persistence:1;
-    char name[1];            /*  This is just a dummy: the allocated array is
-				 bigger. This is NULL-terminated  */
+    unsigned char vfs_created:1; /*  Whether created by driver or VFS        */
+    char name[1];                /*  This is just a dummy: the allocated array
+				     is bigger. This is NULL-terminated      */
 };
 
 /*  The root of the device tree  */
@@ -733,7 +720,7 @@
     gid_t gid;
 };
 
-struct fs_info      /*  This structure is for the mounted devfs  */
+struct fs_info                  /*  This structure is for the mounted devfs  */
 {
     struct super_block *sb;
     volatile struct devfsd_buf_entry *devfsd_buffer;
@@ -755,6 +742,9 @@
 #ifdef CONFIG_DEVFS_DEBUG
 static unsigned int devfs_debug_init __initdata = DEBUG_NONE;
 static unsigned int devfs_debug = DEBUG_NONE;
+static spinlock_t stat_lock = SPIN_LOCK_UNLOCKED;
+static unsigned int stat_num_entries;
+static unsigned int stat_num_bytes;
 #endif
 
 #ifdef CONFIG_DEVFS_MOUNT
@@ -763,19 +753,23 @@
 static unsigned int boot_options = OPTION_NONE;
 #endif
 
-static DECLARE_RWSEM (symlink_rwsem);
-
 /*  Forward function declarations  */
-static struct devfs_entry *search_for_entry (struct devfs_entry *dir,
-					     const char *name,
-					     unsigned int namelen, int mkdir,
-					     int mkfile, int *is_new,
-					     int traverse_symlink);
+static devfs_handle_t _devfs_walk_path (struct devfs_entry *dir,
+					const char *name, int namelen,
+					int traverse_symlink);
 static ssize_t devfsd_read (struct file *file, char *buf, size_t len,
 			    loff_t *ppos);
 static int devfsd_ioctl (struct inode *inode, struct file *file,
 			 unsigned int cmd, unsigned long arg);
 static int devfsd_close (struct inode *inode, struct file *file);
+#ifdef CONFIG_DEVFS_DEBUG
+static int stat_read (struct file *file, char *buf, size_t len,
+			    loff_t *ppos);
+static struct file_operations stat_fops =
+{
+    read:    stat_read,
+};
+#endif
 
 
 /*  Devfs daemon file operations  */
@@ -791,46 +785,94 @@
 
 
 /**
- *	search_for_entry_in_dir - Search for a devfs entry inside another devfs entry.
- *	@parent:  The parent devfs entry.
- *	@name:  The name of the entry.
+ *	devfs_get - Get a reference to a devfs entry.
+ *	@de:  The devfs entry.
+ */
+
+static struct devfs_entry *devfs_get (struct devfs_entry *de)
+{
+    if (de) atomic_inc (&de->refcount);
+    return de;
+}   /*  End Function devfs_get  */
+
+/**
+ *	devfs_put - Put (release) a reference to a devfs entry.
+ *	@de:  The devfs entry.
+ */
+
+static void devfs_put (struct devfs_entry *de)
+{
+    if (!de) return;
+    if ( !atomic_dec_and_test (&de->refcount) ) return;
+    if (!de->parent)
+	OOPS ("%s: devfs_put(): root entry being freed\n", DEVFS_NAME);
+#ifdef CONFIG_DEVFS_DEBUG
+    if (devfs_debug & DEBUG_FREE)
+	printk ("%s: devfs_put(%s): de: %p, parent: %p \"%s\"\n",
+		DEVFS_NAME, de->name, de, de->parent, de->parent->name);
+#endif
+    if ( S_ISLNK (de->mode) ) kfree (de->u.symlink.linkname);
+    if ( ( S_ISCHR (de->mode) || S_ISBLK (de->mode) ) && de->u.fcb.autogen )
+    {
+	devfs_dealloc_devnum ( S_ISCHR (de->mode) ? DEVFS_SPECIAL_CHR :
+			       DEVFS_SPECIAL_BLK,
+			       MKDEV (de->u.fcb.u.device.major,
+				      de->u.fcb.u.device.minor) );
+    }
+#ifdef CONFIG_DEVFS_DEBUG
+    spin_lock (&stat_lock);
+    --stat_num_entries;
+    stat_num_bytes -= sizeof *de + de->namelen;
+    if ( S_ISLNK (de->mode) ) stat_num_bytes -= de->u.symlink.length + 1;
+    spin_unlock (&stat_lock);
+#endif
+    kfree (de);
+}   /*  End Function devfs_put  */
+
+/**
+ *	_devfs_search_dir - Search for a devfs entry in a directory.
+ *	@dir:  The directory to search.
+ *	@name:  The name of the entry to search for.
  *	@namelen:  The number of characters in @name.
- *	@traverse_symlink:  If %TRUE then the entry is traversed if it is a symlink.
  *
- *  Search for a devfs entry inside another devfs entry and returns a pointer
- *   to the entry on success, else %NULL.
+ *  Search for a devfs entry in a directory and returns a pointer to the entry
+ *   on success, else %NULL. The directory must be locked already.
+ *   An implicit devfs_get() is performed on the returned entry.
  */
 
-static struct devfs_entry *search_for_entry_in_dir (struct devfs_entry *parent,
-						    const char *name,
-						    unsigned int namelen,
-						    int traverse_symlink)
+static struct devfs_entry *_devfs_search_dir (struct devfs_entry *dir,
+					      const char *name,
+					      unsigned int namelen)
 {
-    struct devfs_entry *curr, *retval;
+    struct devfs_entry *curr;
 
-    if ( !S_ISDIR (parent->mode) )
+    if ( !S_ISDIR (dir->mode) )
     {
-	printk ("%s: entry is not a directory\n", DEVFS_NAME);
+	printk ("%s: search_dir(%s): not a directory\n", DEVFS_NAME,dir->name);
 	return NULL;
     }
-    for (curr = parent->u.dir.first; curr != NULL; curr = curr->next)
+    for (curr = dir->u.dir.first; curr != NULL; curr = curr->next)
     {
 	if (curr->namelen != namelen) continue;
 	if (memcmp (curr->name, name, namelen) == 0) break;
 	/*  Not found: try the next one  */
     }
-    if (curr == NULL) return NULL;
-    if (!S_ISLNK (curr->mode) || !traverse_symlink) return curr;
-    /*  Need to follow the link: this is a stack chomper  */
-    retval = curr->registered ?
-	search_for_entry (parent, curr->u.symlink.linkname,
-			  curr->u.symlink.length, FALSE, FALSE, NULL,
-			  TRUE) : NULL;
-    return retval;
-}   /*  End Function search_for_entry_in_dir  */
+    return devfs_get (curr);
+}   /*  End Function _devfs_search_dir  */
+
+
+/**
+ *	_devfs_alloc_entry - Allocate a devfs entry.
+ *	@name:  The name of the entry.
+ *	@namelen:  The number of characters in @name.
+ *
+ *  Allocate a devfs entry and returns a pointer to the entry on success, else
+ *   %NULL.
+ */
 
-static struct devfs_entry *create_entry (struct devfs_entry *parent,
-					 const char *name,unsigned int namelen)
+static struct devfs_entry *_devfs_alloc_entry (const char *name,
+					       unsigned int namelen,
+					       umode_t mode)
 {
     struct devfs_entry *new;
     static unsigned long inode_counter = FIRST_INODE;
@@ -839,168 +881,266 @@
     if ( name && (namelen < 1) ) namelen = strlen (name);
     if ( ( new = kmalloc (sizeof *new + namelen, GFP_KERNEL) ) == NULL )
 	return NULL;
-    /*  Magic: this will set the ctime to zero, thus subsequent lookups will
-	trigger the call to <update_devfs_inode_from_entry>  */
     memset (new, 0, sizeof *new + namelen);
+    new->mode = mode;
+    if ( S_ISDIR (mode) ) rwlock_init (&new->u.dir.lock);
+    atomic_set (&new->refcount, 1);
     spin_lock (&counter_lock);
     new->inode.ino = inode_counter++;
     spin_unlock (&counter_lock);
-    new->parent = parent;
     if (name) memcpy (new->name, name, namelen);
     new->namelen = namelen;
-    if (parent == NULL) return new;
-    new->prev = parent->u.dir.last;
-    /*  Insert into the parent directory's list of children  */
-    if (parent->u.dir.first == NULL) parent->u.dir.first = new;
-    else parent->u.dir.last->next = new;
-    parent->u.dir.last = new;
+#ifdef CONFIG_DEVFS_DEBUG
+    spin_lock (&stat_lock);
+    ++stat_num_entries;
+    stat_num_bytes += sizeof *new + namelen;
+    spin_unlock (&stat_lock);
+#endif
     return new;
-}   /*  End Function create_entry  */
+}   /*  End Function _devfs_alloc_entry  */
+
+
+/**
+ *	_devfs_append_entry - Append a devfs entry to a directory's child list.
+ *	@dir:  The directory to add to.
+ *	@de:  The devfs entry to append.
+ *	@removable: If TRUE, increment the count of removable devices for %dir.
+ *
+ *  Append a devfs entry to a directory's list of children, checking first to
+ *   see if an entry of the same name exists. The directory will be locked.
+ *   The value 0 is returned on success, else a negative error code.
+ *   On failure, an implicit devfs_put() is performed on %de.
+ */
 
-static void update_devfs_inode_from_entry (struct devfs_entry *de)
+static int _devfs_append_entry (struct devfs_entry *dir,struct devfs_entry *de,
+				int removable)
 {
-    if (de == NULL) return;
-    if ( S_ISDIR (de->mode) )
-    {
-	de->inode.mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
-	de->inode.uid = 0;
-	de->inode.gid = 0;
-    }
-    else if ( S_ISLNK (de->mode) )
-    {
-	de->inode.mode = S_IFLNK | S_IRUGO | S_IXUGO;
-	de->inode.uid = 0;
-	de->inode.gid = 0;
-    }
-    else if ( S_ISFIFO (de->mode) )
+    int retval;
+    struct devfs_entry *old;
+
+    if (!de || !dir) return 0;
+    if ( !S_ISDIR (dir->mode) )
     {
-	de->inode.mode = de->mode;
-	de->inode.uid = de->u.fifo.uid;
-	de->inode.gid = de->u.fifo.gid;
+	printk ("%s: append_entry(): dir: \"%s\" is not a directory\n",
+		DEVFS_NAME, dir->name);
+	return -ENOTDIR;
     }
+    write_lock (&dir->u.dir.lock);
+    if (dir->u.dir.no_more_additions) retval = -ENOENT;
     else
     {
-	if (de->u.fcb.auto_owner)
-	    de->inode.mode = (de->mode & ~S_IALLUGO) | S_IRUGO | S_IWUGO;
-	else de->inode.mode = de->mode;
-	de->inode.uid = de->u.fcb.default_uid;
-	de->inode.gid = de->u.fcb.default_gid;
+	old = _devfs_search_dir (dir, de->name, de->namelen);
+	devfs_put (old);
+	if (old == NULL)
+	{
+	    de->parent = dir;
+	    de->prev = dir->u.dir.last;
+	    /*  Append to the directory's list of children  */
+	    if (dir->u.dir.first == NULL) dir->u.dir.first = de;
+	    else dir->u.dir.last->next = de;
+	    dir->u.dir.last = de;
+	    if (removable) ++dir->u.dir.num_removable;
+	    retval = 0;
+	}
+	else retval = -EEXIST;
     }
-}   /*  End Function update_devfs_inode_from_entry  */
+    write_unlock (&dir->u.dir.lock);
+    if (retval) devfs_put (de);
+    return retval;
+}   /*  End Function _devfs_append_entry  */
+
 
 /**
- *	get_root_entry - Get the root devfs entry.
+ *	_devfs_get_root_entry - Get the root devfs entry.
  *
  *	Returns the root devfs entry on success, else %NULL.
  */
 
-static struct devfs_entry *get_root_entry (void)
+static struct devfs_entry *_devfs_get_root_entry (void)
 {
     kdev_t devnum;
     struct devfs_entry *new;
+    static spinlock_t root_lock = SPIN_LOCK_UNLOCKED;
 
     /*  Always ensure the root is created  */
-    if (root_entry != NULL) return root_entry;
-    if ( ( root_entry = create_entry (NULL, NULL, 0) ) == NULL ) return NULL;
-    root_entry->mode = S_IFDIR;
-    /*  Force an inode update, because lookup() is never done for the root  */
-    update_devfs_inode_from_entry (root_entry);
-    root_entry->registered = TRUE;
+    if (root_entry) return root_entry;
+    if ( ( new = _devfs_alloc_entry (NULL, 0,
+				     S_IFDIR | S_IWUSR | S_IRUGO | S_IXUGO) )
+	 == NULL ) return NULL;
+    spin_lock (&root_lock);
+    if (root_entry)
+    {
+	spin_unlock (&root_lock);
+	devfs_put (new);
+	return (root_entry);
+    }
+    root_entry = new;
+    spin_unlock (&root_lock);
     /*  And create the entry for ".devfsd"  */
-    if ( ( new = create_entry (root_entry, ".devfsd", 0) ) == NULL )
-	return NULL;
+    if ( ( new = _devfs_alloc_entry (".devfsd", 0, S_IFCHR |S_IRUSR |S_IWUSR) )
+	 == NULL ) return NULL;
     devnum = devfs_alloc_devnum (DEVFS_SPECIAL_CHR);
     new->u.fcb.u.device.major = MAJOR (devnum);
     new->u.fcb.u.device.minor = MINOR (devnum);
-    new->mode = S_IFCHR | S_IRUSR | S_IWUSR;
-    new->u.fcb.default_uid = 0;
-    new->u.fcb.default_gid = 0;
     new->u.fcb.ops = &devfsd_fops;
-    new->registered = TRUE;
+    _devfs_append_entry (root_entry, new, FALSE);
+#ifdef CONFIG_DEVFS_DEBUG
+    if ( ( new = _devfs_alloc_entry (".stat", 0, S_IFCHR | S_IRUGO | S_IWUGO) )
+	 == NULL ) return NULL;
+    devnum = devfs_alloc_devnum (DEVFS_SPECIAL_CHR);
+    new->u.fcb.u.device.major = MAJOR (devnum);
+    new->u.fcb.u.device.minor = MINOR (devnum);
+    new->u.fcb.ops = &stat_fops;
+    _devfs_append_entry (root_entry, new, FALSE);
+#endif
     return root_entry;
-}   /*  End Function get_root_entry  */
+}   /*  End Function _devfs_get_root_entry  */
 
 
 /**
- *	search_for_entry - Search for an entry in the devfs tree.
- *	@dir: The parent directory to search from. If this is %NULL the root is used
- *	@name: The name of the entry.
- *	@namelen: The number of characters in @name.
- *	@mkdir: If %TRUE intermediate directories are created as needed.
- *	@mkfile: If %TRUE the file entry is created if it doesn't exist.
- *	@is_new: If the returned entry was newly made, %TRUE is written here. If
- * 		this is %NULL nothing is written here.
- *	@traverse_symlink: If %TRUE then symbolic links are traversed.
+ *	_devfs_descend - Descend down a tree using the next component name.
+ *	@dir:  The directory to search.
+ *	@name:  The component name to search for.
+ *	@namelen:  The length of %name.
+ *	@next_pos:  The position of the next '/' or '\0' is written here.
  *
- *	If the entry is created, then it will be in the unregistered state.
- *	Returns a pointer to the entry on success, else %NULL.
+ *  Descend into a directory, searching for a component. This function forms
+ *   the core of a tree-walking algorithm. The directory will be locked.
+ *   The devfs entry corresponding to the component is returned. If there is
+ *   no matching entry, %NULL is returned.
+ *   An implicit devfs_get() is performed on the returned entry.
  */
 
-static struct devfs_entry *search_for_entry (struct devfs_entry *dir,
-					     const char *name,
-					     unsigned int namelen, int mkdir,
-					     int mkfile, int *is_new,
-					     int traverse_symlink)
+static struct devfs_entry *_devfs_descend (struct devfs_entry *dir,
+					   const char *name, int namelen,
+					   int *next_pos)
 {
-    int len;
-    const char *subname, *stop, *ptr;
+    const char *stop, *ptr;
     struct devfs_entry *entry;
 
-    if (is_new) *is_new = FALSE;
-    if (dir == NULL) dir = get_root_entry ();
-    if (dir == NULL) return NULL;
-    /*  Extract one filename component  */
-    subname = name;
+    if ( (namelen >= 3) && (strncmp (name, "../", 3) == 0) )
+    {   /*  Special-case going to parent directory  */
+	*next_pos = 3;
+	return devfs_get (dir->parent);
+    }
     stop = name + namelen;
-    while (subname < stop)
-    {
-	/*  Search for a possible '/'  */
-	for (ptr = subname; (ptr < stop) && (*ptr != '/'); ++ptr);
-	if (ptr >= stop)
-	{
-	    /*  Look for trailing component  */
-	    len = stop - subname;
-	    entry = search_for_entry_in_dir (dir, subname, len,
-					     traverse_symlink);
-	    if (entry != NULL) return entry;
-	    if (!mkfile) return NULL;
-	    entry = create_entry (dir, subname, len);
-	    if (entry && is_new) *is_new = TRUE;
-	    return entry;
-	}
-	/*  Found '/': search for directory  */
-	if (strncmp (subname, "../", 3) == 0)
-	{
-	    /*  Going up  */
-	    dir = dir->parent;
-	    if (dir == NULL) return NULL;  /*  Cannot escape from devfs  */
-	    subname += 3;
-	    continue;
+    /*  Search for a possible '/'  */
+    for (ptr = name; (ptr < stop) && (*ptr != '/'); ++ptr);
+    *next_pos = ptr - name;
+    read_lock (&dir->u.dir.lock);
+    entry = _devfs_search_dir (dir, name, *next_pos);
+    read_unlock (&dir->u.dir.lock);
+    return entry;
+}   /*  End Function _devfs_descend  */
+
+
+static devfs_handle_t _devfs_make_parent_for_leaf (struct devfs_entry *dir,
+						   const char *name,
+						   int namelen, int *leaf_pos)
+{
+    int next_pos = 0;
+    struct devfs_entry *de;
+
+    if (dir == NULL) dir = _devfs_get_root_entry ();
+    if (dir == NULL) return NULL;
+    devfs_get (dir);
+    /*  Search for possible trailing component and ignore it  */
+    for (--namelen; (namelen > 0) && (name[namelen] != '/'); --namelen);
+    *leaf_pos = (name[namelen] == '/') ? (namelen + 1) : 0;
+    for (; namelen > 0; name += next_pos, namelen -= next_pos)
+    {
+	if ( ( de = _devfs_descend (dir, name, namelen, &next_pos) ) == NULL )
+	{
+	    if ( ( de = _devfs_alloc_entry (name, next_pos,
+					    S_IFDIR |S_IWUSR|S_IRUGO|S_IXUGO) )
+		 == NULL )
+	    {
+		devfs_put (dir);
+		return NULL;
+	    }
+	    if ( _devfs_append_entry (dir, de, FALSE) )
+	    {
+		devfs_put (dir);
+		return NULL;
+	    }
+	    devfs_get (de);
 	}
-	len = ptr - subname;
-	entry = search_for_entry_in_dir (dir, subname, len, traverse_symlink);
-	if (!entry && !mkdir) return NULL;
-	if (entry == NULL)
+	if (de == dir->parent)
 	{
-	    /*  Make it  */
-	    if ( ( entry = create_entry (dir, subname, len) ) == NULL )
-		return NULL;
-	    entry->mode = S_IFDIR | S_IRUGO | S_IXUGO | S_IWUSR;
-	    if (is_new) *is_new = TRUE;
+	    devfs_put (dir);
+	    devfs_put (de);
+	    return NULL;
 	}
-	if ( !S_ISDIR (entry->mode) )
+	devfs_put (dir);
+	dir = de;
+	if (name[next_pos] == '/') ++next_pos;
+    }
+    return dir;
+}   /*  End Function _devfs_make_parent_for_leaf  */
+
+
+static devfs_handle_t _devfs_prepare_leaf (devfs_handle_t *dir,
+					   const char *name, umode_t mode)
+{
+    int namelen, leaf_pos;
+    struct devfs_entry *de;
+
+    namelen = strlen (name);
+    if ( ( *dir = _devfs_make_parent_for_leaf (*dir, name, namelen,
+					       &leaf_pos) ) == NULL )
+    {
+	printk ("%s: prepare_leaf(%s): could not create parent path\n",
+		DEVFS_NAME, name);
+	return NULL;
+    }
+    if ( ( de = _devfs_alloc_entry (name + leaf_pos, namelen - leaf_pos,mode) )
+	 == NULL )
+    {
+	printk ("%s: prepare_leaf(%s): could not allocate entry\n",
+		DEVFS_NAME, name);
+	devfs_put (*dir);
+	return NULL;
+    }
+    return de;
+}   /*  End Function _devfs_prepare_leaf  */
+
+
+static devfs_handle_t _devfs_walk_path (struct devfs_entry *dir,
+					const char *name, int namelen,
+					int traverse_symlink)
+{
+    int next_pos = 0;
+
+    if (dir == NULL) dir = _devfs_get_root_entry ();
+    if (dir == NULL) return NULL;
+    devfs_get (dir);
+    for (; namelen > 0; name += next_pos, namelen -= next_pos)
+    {
+	struct devfs_entry *de, *link;
+
+	if ( ( de = _devfs_descend (dir, name, namelen, &next_pos) ) == NULL )
 	{
-	    printk ("%s: existing non-directory entry\n", DEVFS_NAME);
+	    devfs_put (dir);
 	    return NULL;
 	}
-	/*  Ensure an unregistered entry is re-registered and visible  */
-	entry->hide = FALSE;
-	entry->registered = TRUE;
-	subname = ptr + 1;
-	dir = entry;
+	if (S_ISLNK (de->mode) && traverse_symlink)
+	{   /*  Need to follow the link: this is a stack chomper  */
+	    link = _devfs_walk_path (dir, de->u.symlink.linkname,
+				     de->u.symlink.length, TRUE);
+	    devfs_put (de);
+	    if (!link)
+	    {
+		devfs_put (dir);
+		return NULL;
+	    }
+	    de = link;
+	}
+	devfs_put (dir);
+	dir = de;
+	if (name[next_pos] == '/') ++next_pos;
     }
-    return NULL;
-}   /*  End Function search_for_entry  */
+    return dir;
+}   /*  End Function _devfs_walk_path  */
 
 
 /**
@@ -1020,20 +1160,29 @@
 {
     struct devfs_entry *entry, *de;
 
+    devfs_get (dir);
     if (dir == NULL) return NULL;
     if ( !S_ISDIR (dir->mode) )
     {
 	printk ("%s: find_by_dev(): not a directory\n", DEVFS_NAME);
+	devfs_put (dir);
 	return NULL;
     }
     /*  First search files in this directory  */
+    read_lock (&dir->u.dir.lock);
     for (entry = dir->u.dir.first; entry != NULL; entry = entry->next)
     {
 	if ( !S_ISCHR (entry->mode) && !S_ISBLK (entry->mode) ) continue;
 	if ( S_ISCHR (entry->mode) && (type != DEVFS_SPECIAL_CHR) ) continue;
 	if ( S_ISBLK (entry->mode) && (type != DEVFS_SPECIAL_BLK) ) continue;
 	if ( (entry->u.fcb.u.device.major == major) &&
-	     (entry->u.fcb.u.device.minor == minor) ) return entry;
+	     (entry->u.fcb.u.device.minor == minor) )
+	{
+	    devfs_get (entry);
+	    read_unlock (&dir->u.dir.lock);
+	    devfs_put (dir);
+	    return entry;
+	}
 	/*  Not found: try the next one  */
     }
     /*  Now recursively search the subdirectories: this is a stack chomper  */
@@ -1041,8 +1190,15 @@
     {
 	if ( !S_ISDIR (entry->mode) ) continue;
 	de = find_by_dev (entry, major, minor, type);
-	if (de) return de;
+	if (de)
+	{
+	    read_unlock (&dir->u.dir.lock);
+	    devfs_put (dir);
+	    return de;
+	}
     }
+    read_unlock (&dir->u.dir.lock);
+    devfs_put (dir);
     return NULL;
 }   /*  End Function find_by_dev  */
 
@@ -1063,7 +1219,6 @@
  *		%DEVFS_SPECIAL_CHR or %DEVFS_SPECIAL_BLK.
  *	@traverse_symlink: If %TRUE then symbolic links are traversed.
  *
- *	FIXME: What the hell is @handle? - ch
  *	Returns the devfs_entry pointer on success, else %NULL.
  */
 
@@ -1095,10 +1250,7 @@
 	    ++name;
 	    --namelen;
 	}
-	if (traverse_symlink) down_read (&symlink_rwsem);
-	entry = search_for_entry (dir, name, namelen, FALSE, FALSE, NULL,
-				  traverse_symlink);
-	if (traverse_symlink) up_read (&symlink_rwsem);
+	entry = _devfs_walk_path (dir, name, namelen, traverse_symlink);
 	if (entry != NULL) return entry;
     }
     /*  Have to search by major and minor: slow  */
@@ -1106,42 +1258,34 @@
     return find_by_dev (root_entry, major, minor, type);
 }   /*  End Function find_entry  */
 
-static struct devfs_entry *get_devfs_entry_from_vfs_inode (struct inode *inode,
-							   int do_check)
+static struct devfs_entry *get_devfs_entry_from_vfs_inode (struct inode *inode)
 {
-    struct devfs_entry *de;
-
     if (inode == NULL) return NULL;
-    de = inode->u.generic_ip;
-    if (!de) printk (__FUNCTION__ "(): NULL de for inode %ld\n", inode->i_ino);
-    if (do_check && de && !de->registered) de = NULL;
-    return de;
+    return inode->u.generic_ip;
 }   /*  End Function get_devfs_entry_from_vfs_inode  */
 
 
 /**
- *	free_dentries - Free the dentries for a device entry and invalidate inodes.
+ *	free_dentry - Free the dentry for a device entry and invalidate inode.
  *	@de: The entry.
+ *
+ *	This must only be called after the entry has been unhooked from it's
+ *	 parent directory.
  */
 
-static void free_dentries (struct devfs_entry *de)
+static void free_dentry (struct devfs_entry *de)
 {
-    struct dentry *dentry;
+    struct dentry *dentry = de->inode.dentry;
 
+    if (!dentry) return;
     spin_lock (&dcache_lock);
-    dentry = de->inode.dentry;
-    if (dentry != NULL)
-    {
-	dget_locked (dentry);
-	de->inode.dentry = NULL;
-	spin_unlock (&dcache_lock);
-	/*  Forcefully remove the inode  */
-	if (dentry->d_inode != NULL) dentry->d_inode->i_nlink = 0;
-	d_drop (dentry);
-	dput (dentry);
-    }
-    else spin_unlock (&dcache_lock);
-}   /*  End Function free_dentries  */
+    dget_locked (dentry);
+    spin_unlock (&dcache_lock);
+    /*  Forcefully remove the inode  */
+    if (dentry->d_inode != NULL) dentry->d_inode->i_nlink = 0;
+    d_drop (dentry);
+    dput (dentry);
+}   /*  End Function free_dentry  */
 
 
 /**
@@ -1201,8 +1345,9 @@
 
 
 /**
- *	devfsd_notify_one - Notify a single devfsd daemon of a change.
- *	@data: Data to be passed.
+ *	devfsd_notify_one - Notify the devfsd daemon of a change.
+ *	@data: Data to be passed. This must remain in scope until devfsd has
+ *             processed the event.
  *	@type: The type of change.
  *	@mode: The mode of the entry.
  *	@uid: The user ID.
@@ -1246,17 +1391,44 @@
 
 
 /**
- *	devfsd_notify - Notify all devfsd daemons of a change.
+ *	devfsd_notify_de - Notify the devfsd daemon of a change.
+ *	@de: The devfs entry that has changed. This and all parent entries will
+ *            have their reference counts incremented if the event was queued.
+ *	@type: The type of change.
+ *	@mode: The mode of the entry.
+ *	@uid: The user ID.
+ *	@gid: The group ID.
+ *	@fs_info: The filesystem info.
+ *
+ *	Returns %TRUE if an event was queued and devfsd woken up, else %FALSE.
+ */
+
+static int devfsd_notify_de (struct devfs_entry *de,
+			     unsigned int type, umode_t mode,
+			     uid_t uid, gid_t gid, struct fs_info *fs_info)
+{
+    struct devfs_entry *curr;
+
+    for (curr = de; curr != NULL; curr = curr->parent) devfs_get (curr);
+    if ( devfsd_notify_one (de, type, mode, uid, gid, fs_info) )
+	return (TRUE);
+    for (curr = de; curr != NULL; curr = curr->parent) devfs_put (curr);
+    return (FALSE);
+}   /*  End Function devfsd_notify_de  */
+
+
+/**
+ *	devfsd_notify - Notify the devfsd daemon of a change.
  *	@de: The devfs entry that has changed.
  *	@type: The type of change event.
- *	@wait: If TRUE, the functions waits for all daemons to finish processing
+ *	@wait: If TRUE, the function waits for the daemon to finish processing
  *		the event.
  */
 
 static void devfsd_notify (struct devfs_entry *de, unsigned int type, int wait)
 {
-    if (devfsd_notify_one (de, type, de->mode, current->euid,
-			   current->egid, &fs_info) && wait)
+    if (devfsd_notify_de (de, type, de->mode, current->euid,
+			  current->egid, &fs_info) && wait)
 	wait_for_devfsd_finished (&fs_info);
 }   /*  End Function devfsd_notify  */
 
@@ -1287,7 +1459,7 @@
 			       umode_t mode, void *ops, void *info)
 {
     char devtype = S_ISCHR (mode) ? DEVFS_SPECIAL_CHR : DEVFS_SPECIAL_BLK;
-    int is_new;
+    int err;
     kdev_t devnum = NODEV;
     struct devfs_entry *de;
 
@@ -1332,146 +1504,126 @@
 	major = MAJOR (devnum);
 	minor = MINOR (devnum);
     }
-    de = search_for_entry (dir, name, strlen (name), TRUE, TRUE, &is_new,
-			   FALSE);
-    if (de == NULL)
+    if ( ( de = _devfs_prepare_leaf (&dir, name, mode) ) == NULL )
     {
-	printk ("%s: devfs_register(): could not create entry: \"%s\"\n",
+	printk ("%s: devfs_register(%s): could not prepare leaf\n",
 		DEVFS_NAME, name);
 	if (devnum != NODEV) devfs_dealloc_devnum (devtype, devnum);
 	return NULL;
     }
-#ifdef CONFIG_DEVFS_DEBUG
-    if (devfs_debug & DEBUG_REGISTER)
-	printk ("%s: devfs_register(%s): de: %p %s\n",
-		DEVFS_NAME, name, de, is_new ? "new" : "existing");
-#endif
-    if (!is_new)
-    {
-	/*  Existing entry  */
-	if ( !S_ISCHR (de->mode) && !S_ISBLK (de->mode) &&
-	     !S_ISREG (de->mode) )
-	{
-	    printk ("%s: devfs_register(): existing non-device/file entry: \"%s\"\n",
-		    DEVFS_NAME, name);
-	    if (devnum != NODEV) devfs_dealloc_devnum (devtype, devnum);
-	    return NULL;
-	}
-	if (de->registered)
-	{
-	    printk("%s: devfs_register(): device already registered: \"%s\"\n",
-		   DEVFS_NAME, name);
-	    if (devnum != NODEV) devfs_dealloc_devnum (devtype, devnum);
-	    return NULL;
-	}
-    }
-    de->u.fcb.autogen = FALSE;
     if ( S_ISCHR (mode) || S_ISBLK (mode) )
     {
 	de->u.fcb.u.device.major = major;
 	de->u.fcb.u.device.minor = minor;
 	de->u.fcb.autogen = (devnum == NODEV) ? FALSE : TRUE;
     }
-    else if ( S_ISREG (mode) ) de->u.fcb.u.file.size = 0;
-    else
+    else if ( !S_ISREG (mode) )
     {
-	printk ("%s: devfs_register(): illegal mode: %x\n",
-		DEVFS_NAME, mode);
+	printk ("%s: devfs_register(%s): illegal mode: %x\n",
+		DEVFS_NAME, name, mode);
+	devfs_put (de);
+	devfs_put (dir);
 	return (NULL);
     }
     de->info = info;
-    de->mode = mode;
     if (flags & DEVFS_FL_CURRENT_OWNER)
     {
-	de->u.fcb.default_uid = current->uid;
-	de->u.fcb.default_gid = current->gid;
+	de->inode.uid = current->uid;
+	de->inode.gid = current->gid;
     }
     else
     {
-	de->u.fcb.default_uid = 0;
-	de->u.fcb.default_gid = 0;
+	de->inode.uid = 0;
+	de->inode.gid = 0;
     }
     de->u.fcb.ops = ops;
     de->u.fcb.auto_owner = (flags & DEVFS_FL_AUTO_OWNER) ? TRUE : FALSE;
     de->u.fcb.aopen_notify = (flags & DEVFS_FL_AOPEN_NOTIFY) ? TRUE : FALSE;
-    if (flags & DEVFS_FL_REMOVABLE)
+    de->hide = (flags & DEVFS_FL_HIDE) ? TRUE : FALSE;
+    if (flags & DEVFS_FL_REMOVABLE) de->u.fcb.removable = TRUE;
+    if ( ( err = _devfs_append_entry (dir, de, de->u.fcb.removable) ) != 0 )
     {
-	de->u.fcb.removable = TRUE;
-	++de->parent->u.dir.num_removable;
+	printk("%s: devfs_register(%s): could not append to parent, err: %d\n",
+	       DEVFS_NAME, name, err);
+	devfs_put (dir);
+	if (devnum != NODEV) devfs_dealloc_devnum (devtype, devnum);
+	return NULL;
     }
-    de->u.fcb.open = FALSE;
-    de->hide = (flags & DEVFS_FL_HIDE) ? TRUE : FALSE;
-    de->no_persistence = (flags & DEVFS_FL_NO_PERSISTENCE) ? TRUE : FALSE;
-    de->registered = TRUE;
+#ifdef CONFIG_DEVFS_DEBUG
+    if (devfs_debug & DEBUG_REGISTER)
+	printk ("%s: devfs_register(%s): de: %p dir: %p \"%s\"\n",
+		DEVFS_NAME, name, de, dir, dir->name);
+#endif
     devfsd_notify (de, DEVFSD_NOTIFY_REGISTERED, flags & DEVFS_FL_WAIT);
+    devfs_put (dir);
     return de;
 }   /*  End Function devfs_register  */
 
 
 /**
- *	unregister - Unregister a device entry.
+ *	_devfs_unhook - Unhook a device entry from its parents list
+ *	@de: The entry to unhook.
+ *
+ *	Returns %TRUE if the entry was unhooked, else %FALSE if it was
+ *		previously unhooked.
+ *	The caller must have a write lock on the parent directory.
+ */
+
+static int _devfs_unhook (struct devfs_entry *de)
+{
+    struct devfs_entry *parent;
+
+    if ( !de || (de->prev == de) ) return FALSE;
+    parent = de->parent;
+    if (de->prev == NULL) parent->u.dir.first = de->next;
+    else de->prev->next = de->next;
+    if (de->next == NULL) parent->u.dir.last = de->prev;
+    else de->next->prev = de->prev;
+    de->prev = de;          /*  Indicate we're unhooked                      */
+    de->next = NULL;        /*  Force early termination for <devfs_readdir>  */
+    if ( ( S_ISREG (de->mode) || S_ISCHR (de->mode) || S_ISBLK (de->mode) ) &&
+	 de->u.fcb.removable )
+	--parent->u.dir.num_removable;
+    return TRUE;
+}   /*  End Function _devfs_unhook  */
+
+
+/**
+ *	unregister - Unregister a device entry from it's parent.
+ *	@dir: The parent directory.
  *	@de: The entry to unregister.
+ *
+ *	The caller must have a write lock on the parent directory, which is
+ *	unlocked by this function.
  */
 
-static void unregister (struct devfs_entry *de)
+static void unregister (struct devfs_entry *dir, struct devfs_entry *de)
 {
-    struct devfs_entry *child;
+    int unhooked = _devfs_unhook (de);
 
-    if ( (child = de->slave) != NULL )
-    {
-	de->slave = NULL;  /* Unhook first in case slave is parent directory */
-	unregister (child);
-    }
-    if (de->registered)
-    {
-	devfsd_notify (de, DEVFSD_NOTIFY_UNREGISTERED, 0);
-	free_dentries (de);
-    }
-    de->info = NULL;
-    if ( S_ISCHR (de->mode) || S_ISBLK (de->mode) || S_ISREG (de->mode) )
-    {
-	de->registered = FALSE;
-	de->u.fcb.ops = NULL;
-	if (!S_ISREG (de->mode) && de->u.fcb.autogen)
-	{
-	    devfs_dealloc_devnum ( S_ISCHR (de->mode) ? DEVFS_SPECIAL_CHR :
-				   DEVFS_SPECIAL_BLK,
-				   MKDEV (de->u.fcb.u.device.major,
-					  de->u.fcb.u.device.minor) );
-	}
-	de->u.fcb.autogen = FALSE;
-	return;
-    }
-    if (S_ISLNK (de->mode) && de->registered)
-    {
-	de->registered = FALSE;
-	down_write (&symlink_rwsem);
-	if (de->u.symlink.linkname) kfree (de->u.symlink.linkname);
-	de->u.symlink.linkname = NULL;
-	up_write (&symlink_rwsem);
-	return;
-    }
-    if ( S_ISFIFO (de->mode) )
-    {
-	de->registered = FALSE;
-	return;
-    }
-    if (!de->registered) return;
-    if ( !S_ISDIR (de->mode) )
-    {
-	printk ("%s: unregister(): unsupported type\n", DEVFS_NAME);
-	return;
-    }
-    de->registered = FALSE;
-    /*  Now recursively search the subdirectories: this is a stack chomper  */
-    for (child = de->u.dir.first; child != NULL; child = child->next)
-    {
+    write_unlock (&dir->u.dir.lock);
+    if (!unhooked) return;
+    devfs_get (dir);
+    devfs_unregister (de->slave);  /*  Let it handle the locking  */
+    devfsd_notify (de, DEVFSD_NOTIFY_UNREGISTERED, 0);
+    free_dentry (de);
+    devfs_put (dir);
+    if ( !S_ISDIR (de->mode) ) return;
+    while (TRUE)  /*  Recursively unregister: this is a stack chomper  */
+    {
+	struct devfs_entry *child;
+
+	write_lock (&de->u.dir.lock);
+	de->u.dir.no_more_additions = TRUE;
+	child = de->u.dir.first;
+	unregister (de, child);
+	if (!child) break;
 #ifdef CONFIG_DEVFS_DEBUG
 	if (devfs_debug & DEBUG_UNREGISTER)
 	    printk ("%s: unregister(): child->name: \"%s\" child: %p\n",
 		    DEVFS_NAME, child->name, child);
 #endif
-	unregister (child);
+	devfs_put (child);
     }
 }   /*  End Function unregister  */
 
@@ -1484,20 +1636,22 @@
 
 void devfs_unregister (devfs_handle_t de)
 {
-    if (de == NULL) return;
+    if ( (de == NULL) || (de->parent == NULL) ) return;
 #ifdef CONFIG_DEVFS_DEBUG
     if (devfs_debug & DEBUG_UNREGISTER)
 	printk ("%s: devfs_unregister(): de->name: \"%s\" de: %p\n",
 		DEVFS_NAME, de->name, de);
 #endif
-    unregister (de);
+    write_lock (&de->parent->u.dir.lock);
+    unregister (de->parent, de);
+    devfs_put (de);
 }   /*  End Function devfs_unregister  */
 
 static int devfs_do_symlink (devfs_handle_t dir, const char *name,
 			     unsigned int flags, const char *link,
 			     devfs_handle_t *handle, void *info)
 {
-    int is_new;
+    int err;
     unsigned int linklength;
     char *newlink;
     struct devfs_entry *de;
@@ -1522,28 +1676,31 @@
 	return -ENOMEM;
     memcpy (newlink, link, linklength);
     newlink[linklength] = '\0';
-    if ( ( de = search_for_entry (dir, name, strlen (name), TRUE, TRUE,
-				  &is_new, FALSE) ) == NULL )
+    if ( ( de = _devfs_prepare_leaf (&dir, name, S_IFLNK | S_IRUGO | S_IXUGO) )
+	 == NULL )
     {
-	kfree (newlink);
-	return -ENOMEM;
-    }
-    down_write (&symlink_rwsem);
-    if (de->registered)
-    {
-	up_write (&symlink_rwsem);
-	kfree (newlink);
-	printk ("%s: devfs_do_symlink(%s): entry already exists\n",
+	printk ("%s: devfs_do_symlink(%s): could not prepare leaf\n",
 		DEVFS_NAME, name);
-	return -EEXIST;
+	kfree (newlink);
+	return -ENOTDIR;
     }
-    de->mode = S_IFLNK | S_IRUGO | S_IXUGO;
     de->info = info;
     de->hide = (flags & DEVFS_FL_HIDE) ? TRUE : FALSE;
     de->u.symlink.linkname = newlink;
     de->u.symlink.length = linklength;
-    de->registered = TRUE;
-    up_write (&symlink_rwsem);
+    if ( ( err = _devfs_append_entry (dir, de, FALSE) ) != 0 )
+    {
+	printk ("%s: devfs_do_symlink(%s): could not append to parent, err: %d\n",
+		DEVFS_NAME, name, err);
+	devfs_put (dir);
+	return err;
+    }
+    devfs_put (dir);
+#ifdef CONFIG_DEVFS_DEBUG
+    spin_lock (&stat_lock);
+    stat_num_bytes += linklength + 1;
+    spin_unlock (&stat_lock);
+#endif
     if (handle != NULL) *handle = de;
     return 0;
 }   /*  End Function devfs_do_symlink  */
@@ -1593,7 +1750,7 @@
 
 devfs_handle_t devfs_mk_dir (devfs_handle_t dir, const char *name, void *info)
 {
-    int is_new;
+    int err;
     struct devfs_entry *de;
 
     if (name == NULL)
@@ -1601,36 +1758,27 @@
 	printk ("%s: devfs_mk_dir(): NULL name pointer\n", DEVFS_NAME);
 	return NULL;
     }
-    de = search_for_entry (dir, name, strlen (name), TRUE, TRUE, &is_new,
-			   FALSE);
-    if (de == NULL)
+    if ( ( de = _devfs_prepare_leaf (&dir, name,
+				     S_IFDIR | S_IWUSR | S_IRUGO | S_IXUGO) )
+	 == NULL )
     {
-	printk ("%s: devfs_mk_dir(): could not create entry: \"%s\"\n",
+	printk ("%s: devfs_mk_dir(%s): could not prepare leaf\n",
 		DEVFS_NAME, name);
 	return NULL;
     }
-    if (!S_ISDIR (de->mode) && de->registered)
+    de->info = info;
+    if ( ( err = _devfs_append_entry (dir, de, FALSE) ) != 0 )
     {
-	printk ("%s: devfs_mk_dir(): existing non-directory entry: \"%s\"\n",
-		DEVFS_NAME, name);
+	printk ("%s: devfs_mk_dir(%s): could not append to parent, err: %d\n",
+		DEVFS_NAME, name, err);
+	devfs_put (dir);
 	return NULL;
     }
 #ifdef CONFIG_DEVFS_DEBUG
     if (devfs_debug & DEBUG_REGISTER)
-	printk ("%s: devfs_mk_dir(%s): de: %p %s\n",
-		DEVFS_NAME, name, de, is_new ? "new" : "existing");
+	printk ("%s: devfs_mk_dir(%s): de: %p\n", DEVFS_NAME, name, de);
 #endif
-    if (!S_ISDIR (de->mode) && !is_new)
-    {
-	/*  Transmogrifying an old entry  */
-	de->u.dir.first = NULL;
-	de->u.dir.last = NULL;
-    }
-    de->mode = S_IFDIR | S_IRUGO | S_IXUGO;
-    de->info = info;
-    if (!de->registered) de->u.dir.num_removable = 0;
-    de->hide = FALSE;
-    de->registered = TRUE;
+    devfs_put (dir);
     return de;
 }   /*  End Function devfs_mk_dir  */
 
@@ -1660,8 +1808,8 @@
 
     if ( (name != NULL) && (name[0] == '\0') ) name = NULL;
     de = find_entry (dir, name, 0, major, minor, type, traverse_symlinks);
-    if (de == NULL) return NULL;
-    if (!de->registered) return NULL;
+    devfs_put (de);  /*  FIXME: in 2.5 consider dropping this and require a
+			 call to devfs_put()  */
     return de;
 }   /*  End Function devfs_find_handle  */
 
@@ -1679,7 +1827,6 @@
     unsigned int fl = 0;
 
     if (de == NULL) return -EINVAL;
-    if (!de->registered) return -ENODEV;
     if (de->hide) fl |= DEVFS_FL_HIDE;
     if ( S_ISCHR (de->mode) || S_ISBLK (de->mode) || S_ISREG (de->mode) )
     {
@@ -1703,7 +1850,6 @@
 int devfs_set_flags (devfs_handle_t de, unsigned int flags)
 {
     if (de == NULL) return -EINVAL;
-    if (!de->registered) return -ENODEV;
 #ifdef CONFIG_DEVFS_DEBUG
     if (devfs_debug & DEBUG_SET_FLAGS)
 	printk ("%s: devfs_set_flags(): de->name: \"%s\"\n",
@@ -1714,16 +1860,6 @@
     {
 	de->u.fcb.auto_owner = (flags & DEVFS_FL_AUTO_OWNER) ? TRUE : FALSE;
 	de->u.fcb.aopen_notify = (flags & DEVFS_FL_AOPEN_NOTIFY) ? TRUE:FALSE;
-	if ( de->u.fcb.removable && !(flags & DEVFS_FL_REMOVABLE) )
-	{
-	    de->u.fcb.removable = FALSE;
-	    --de->parent->u.dir.num_removable;
-	}
-	else if ( !de->u.fcb.removable && (flags & DEVFS_FL_REMOVABLE) )
-	{
-	    de->u.fcb.removable = TRUE;
-	    ++de->parent->u.dir.num_removable;
-	}
     }
     return 0;
 }   /*  End Function devfs_set_flags  */
@@ -1742,7 +1878,6 @@
 		       unsigned int *minor)
 {
     if (de == NULL) return -EINVAL;
-    if (!de->registered) return -ENODEV;
     if ( S_ISDIR (de->mode) ) return -EISDIR;
     if ( !S_ISCHR (de->mode) && !S_ISBLK (de->mode) ) return -EINVAL;
     if (major != NULL) *major = de->u.fcb.u.device.major;
@@ -1762,7 +1897,7 @@
 {
     if (!inode || !inode->i_sb) return NULL;
     if (inode->i_sb->s_magic != DEVFS_SUPER_MAGIC) return NULL;
-    return get_devfs_entry_from_vfs_inode (inode, TRUE);
+    return get_devfs_entry_from_vfs_inode (inode);
 }   /*  End Function devfs_get_handle_from_inode  */
 
 
@@ -1808,7 +1943,6 @@
 void *devfs_get_ops (devfs_handle_t de)
 {
     if (de == NULL) return NULL;
-    if (!de->registered) return NULL;
     if ( S_ISCHR (de->mode) || S_ISBLK (de->mode) || S_ISREG (de->mode) )
 	return de->u.fcb.ops;
     return NULL;
@@ -1826,7 +1960,6 @@
 int devfs_set_file_size (devfs_handle_t de, unsigned long size)
 {
     if (de == NULL) return -EINVAL;
-    if (!de->registered) return -EINVAL;
     if ( !S_ISREG (de->mode) ) return -EINVAL;
     if (de->u.fcb.u.file.size == size) return 0;
     de->u.fcb.u.file.size = size;
@@ -1846,7 +1979,6 @@
 void *devfs_get_info (devfs_handle_t de)
 {
     if (de == NULL) return NULL;
-    if (!de->registered) return NULL;
     return de->info;
 }   /*  End Function devfs_get_info  */
 
@@ -1861,7 +1993,6 @@
 int devfs_set_info (devfs_handle_t de, void *info)
 {
     if (de == NULL) return -EINVAL;
-    if (!de->registered) return -EINVAL;
     de->info = info;
     return 0;
 }   /*  End Function devfs_set_info  */
@@ -1876,7 +2007,6 @@
 devfs_handle_t devfs_get_parent (devfs_handle_t de)
 {
     if (de == NULL) return NULL;
-    if (!de->registered) return NULL;
     return de->parent;
 }   /*  End Function devfs_get_parent  */
 
@@ -1891,7 +2021,6 @@
 devfs_handle_t devfs_get_first_child (devfs_handle_t de)
 {
     if (de == NULL) return NULL;
-    if (!de->registered) return NULL;
     if ( !S_ISDIR (de->mode) ) return NULL;
     return de->u.dir.first;
 }   /*  End Function devfs_get_first_child  */
@@ -1907,7 +2036,6 @@
 devfs_handle_t devfs_get_next_sibling (devfs_handle_t de)
 {
     if (de == NULL) return NULL;
-    if (!de->registered) return NULL;
     return de->next;
 }   /*  End Function devfs_get_next_sibling  */
 
@@ -1961,7 +2089,6 @@
 const char *devfs_get_name (devfs_handle_t de, unsigned int *namelen)
 {
     if (de == NULL) return NULL;
-    if (!de->registered) return NULL;
     if (namelen != NULL) *namelen = de->namelen;
     return de->name;
 }   /*  End Function devfs_get_name  */
@@ -2057,8 +2184,10 @@
 	{"dmod",      DEBUG_MODULE_LOAD,  &devfs_debug_init},
 	{"dreg",      DEBUG_REGISTER,     &devfs_debug_init},
 	{"dunreg",    DEBUG_UNREGISTER,   &devfs_debug_init},
+	{"dfree",     DEBUG_FREE,         &devfs_debug_init},
 	{"diget",     DEBUG_I_GET,        &devfs_debug_init},
 	{"dchange",   DEBUG_SET_FLAGS,    &devfs_debug_init},
+	{"dsread",    DEBUG_S_READ,       &devfs_debug_init},
 	{"dichange",  DEBUG_I_CHANGE,     &devfs_debug_init},
 	{"dimknod",   DEBUG_I_MKNOD,      &devfs_debug_init},
 	{"dilookup",  DEBUG_I_LOOKUP,     &devfs_debug_init},
@@ -2129,13 +2258,13 @@
 
 
 /**
- *	try_modload - Notify devfsd of an inode lookup.
+ *	try_modload - Notify devfsd of an inode lookup by a non-devfsd process.
  *	@parent: The parent devfs entry.
  *	@fs_info: The filesystem info.
  *	@name: The device name.
  *	@namelen: The number of characters in @name.
- *	@buf: A working area that will be used. This must not go out of scope until
- *		devfsd is idle again.
+ *	@buf: A working area that will be used. This must not go out of scope
+ *            until devfsd is idle again.
  *
  *	Returns 0 on success, else a negative error code.
  */
@@ -2206,7 +2335,6 @@
     if (dir->u.dir.num_removable < 1) return;
     for (de = dir->u.dir.first; de != NULL; de = de->next)
     {
-	if (!de->registered) continue;
 	if ( !S_ISBLK (de->mode) ) continue;
 	if (!de->u.fcb.removable) continue;
 	check_disc_changed (de);
@@ -2229,7 +2357,6 @@
 
     for (de = dir->u.dir.first; de != NULL; de = de->next)
     {
-	if (!de->registered) continue;
 	if ( !S_ISBLK (de->mode) ) continue;
 	if (!de->u.fcb.removable) continue;
 	if (strcmp (de->name, "disc") == 0) return check_disc_changed (de);
@@ -2258,7 +2385,7 @@
     struct inode *inode = dentry->d_inode;
     struct fs_info *fs_info = inode->i_sb->u.generic_sbp;
 
-    de = get_devfs_entry_from_vfs_inode (inode, TRUE);
+    de = get_devfs_entry_from_vfs_inode (inode);
     if (de == NULL) return -ENODEV;
     retval = inode_change_ok (inode, iattr);
     if (retval != 0) return retval;
@@ -2276,15 +2403,19 @@
 #endif
     /*  Inode is not on hash chains, thus must save permissions here rather
 	than in a write_inode() method  */
-    de->inode.mode = inode->i_mode;
-    de->inode.uid = inode->i_uid;
-    de->inode.gid = inode->i_gid;
+    if ( ( !S_ISREG (inode->i_mode) && !S_ISCHR (inode->i_mode) &&
+	   !S_ISBLK (inode->i_mode) ) || !de->u.fcb.auto_owner )
+    {
+	de->mode = inode->i_mode;
+	de->inode.uid = inode->i_uid;
+	de->inode.gid = inode->i_gid;
+    }
     de->inode.atime = inode->i_atime;
     de->inode.mtime = inode->i_mtime;
     de->inode.ctime = inode->i_ctime;
     if ( iattr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID) )
-	devfsd_notify_one (de, DEVFSD_NOTIFY_CHANGE, inode->i_mode,
-			   inode->i_uid, inode->i_gid, fs_info);
+	devfsd_notify_de (de, DEVFSD_NOTIFY_CHANGE, inode->i_mode,
+			  inode->i_uid, inode->i_gid, fs_info);
     return 0;
 }   /*  End Function devfs_notify_change  */
 
@@ -2299,11 +2430,10 @@
     return 0;
 }   /*  End Function devfs_statfs  */
 
-static void devfs_clear_inode(struct inode *inode)
+static void devfs_clear_inode (struct inode *inode)
 {
-	if (S_ISBLK(inode->i_mode))
-		bdput(inode->i_bdev);
-}
+    if ( S_ISBLK (inode->i_mode) ) bdput (inode->i_bdev);
+}   /*  End Function devfs_clear_inode  */
 
 static struct super_operations devfs_sops =
 { 
@@ -2319,32 +2449,37 @@
  *	@de: The devfs inode.
  *	@dentry: The dentry to register with the devfs inode.
  *
- *	Returns the inode on success, else %NULL.
+ *	Returns the inode on success, else %NULL. An implicit devfs_get() is
+ *       performed if the inode is created.
  */
 
 static struct inode *get_vfs_inode (struct super_block *sb,
 				    struct devfs_entry *de,
 				    struct dentry *dentry)
 {
+    int is_fcb = FALSE;
     struct inode *inode;
 
-    if (de->inode.dentry != NULL)
-    {
-	printk ("%s: get_vfs_inode(%u): old de->inode.dentry: %p \"%s\"  new dentry: %p \"%s\"\n",
-		DEVFS_NAME, de->inode.ino,
-		de->inode.dentry, de->inode.dentry->d_name.name,
-		dentry, dentry->d_name.name);
-	printk ("  old inode: %p\n", de->inode.dentry->d_inode);
-	return NULL;
-    }
+    if (de->prev == de) return NULL;  /*  Quick check to see if unhooked  */
     if ( ( inode = new_inode (sb) ) == NULL )
     {
 	printk ("%s: get_vfs_inode(%s): new_inode() failed, de: %p\n",
 		DEVFS_NAME, de->name, de);
 	return NULL;
     }
-    de->inode.dentry = dentry;
-    inode->u.generic_ip = de;
+    if (de->parent)
+    {
+	read_lock (&de->parent->u.dir.lock);
+	if (de->prev != de) de->inode.dentry = dentry; /*      Not unhooked  */
+	read_unlock (&de->parent->u.dir.lock);
+    }
+    else de->inode.dentry = dentry;             /*  Root: no locking needed  */
+    if (de->inode.dentry != dentry)
+    {   /*  Must have been unhooked  */
+	iput (inode);
+	return NULL;
+    }
+    inode->u.generic_ip = devfs_get (de);
     inode->i_ino = de->inode.ino;
 #ifdef CONFIG_DEVFS_DEBUG
     if (devfs_debug & DEBUG_I_GET)
@@ -2356,37 +2491,45 @@
     inode->i_op = &devfs_iops;
     inode->i_fop = &devfs_fops;
     inode->i_rdev = NODEV;
-    if ( S_ISCHR (de->inode.mode) )
+    if ( S_ISCHR (de->mode) )
     {
 	inode->i_rdev = MKDEV (de->u.fcb.u.device.major,
 			       de->u.fcb.u.device.minor);
-	inode->i_cdev = cdget (kdev_t_to_nr(inode->i_rdev));
+	inode->i_cdev = cdget ( kdev_t_to_nr (inode->i_rdev) );
+	is_fcb = TRUE;
     }
-    else if ( S_ISBLK (de->inode.mode) )
+    else if ( S_ISBLK (de->mode) )
     {
 	inode->i_rdev = MKDEV (de->u.fcb.u.device.major,
 			       de->u.fcb.u.device.minor);
-	if (bd_acquire(inode) == 0)
+	if (bd_acquire (inode) == 0)
 	{
 	    if (!inode->i_bdev->bd_op && de->u.fcb.ops)
 		inode->i_bdev->bd_op = de->u.fcb.ops;
 	}
 	else printk ("%s: get_vfs_inode(%d): no block device from bdget()\n",
 		     DEVFS_NAME, (int) inode->i_ino);
+	is_fcb = TRUE;
+    }
+    else if ( S_ISFIFO (de->mode) ) inode->i_fop = &def_fifo_fops;
+    else if ( S_ISREG (de->mode) )
+    {
+	inode->i_size = de->u.fcb.u.file.size;
+	is_fcb = TRUE;
     }
-    else if ( S_ISFIFO (de->inode.mode) ) inode->i_fop = &def_fifo_fops;
-    else if ( S_ISREG (de->inode.mode) ) inode->i_size = de->u.fcb.u.file.size;
-    else if ( S_ISDIR (de->inode.mode) )
+    else if ( S_ISDIR (de->mode) )
     {
 	inode->i_op = &devfs_dir_iops;
     	inode->i_fop = &devfs_dir_fops;
     }
-    else if ( S_ISLNK (de->inode.mode) )
+    else if ( S_ISLNK (de->mode) )
     {
 	inode->i_op = &devfs_symlink_iops;
 	inode->i_size = de->u.symlink.length;
     }
-    inode->i_mode = de->inode.mode;
+    if (is_fcb && de->u.fcb.auto_owner)
+	inode->i_mode = (de->mode & S_IFMT) | S_IRUGO | S_IWUGO;
+    else inode->i_mode = de->mode;
     inode->i_uid = de->inode.uid;
     inode->i_gid = de->inode.gid;
     inode->i_atime = de->inode.atime;
@@ -2409,11 +2552,11 @@
     int err, count;
     int stored = 0;
     struct fs_info *fs_info;
-    struct devfs_entry *parent, *de;
+    struct devfs_entry *parent, *de, *next = NULL;
     struct inode *inode = file->f_dentry->d_inode;
 
     fs_info = inode->i_sb->u.generic_sbp;
-    parent = get_devfs_entry_from_vfs_inode (file->f_dentry->d_inode, TRUE);
+    parent = get_devfs_entry_from_vfs_inode (file->f_dentry->d_inode);
     if ( (long) file->f_pos < 0 ) return -EINVAL;
 #ifdef CONFIG_DEVFS_DEBUG
     if (devfs_debug & DEBUG_F_READDIR)
@@ -2441,19 +2584,32 @@
       default:
 	/*  Skip entries  */
 	count = file->f_pos - 2;
-	for (de = parent->u.dir.first; (de != NULL) && (count > 0);
-	     de = de->next)
+	read_lock (&parent->u.dir.lock);
+	for (de = parent->u.dir.first; de && (count > 0); de = de->next)
 	    if ( !IS_HIDDEN (de) ) --count;
+	devfs_get (de);
+	read_unlock (&parent->u.dir.lock);
 	/*  Now add all remaining entries  */
-	for (; de != NULL; de = de->next)
+	while (de)
 	{
-	    if ( IS_HIDDEN (de) ) continue;
-	    err = (*filldir) (dirent, de->name, de->namelen,
-			      file->f_pos, de->inode.ino, de->mode >> 12);
+	    if ( IS_HIDDEN (de) ) err = 0;
+	    else
+	    {
+		err = (*filldir) (dirent, de->name, de->namelen,
+				  file->f_pos, de->inode.ino, de->mode >> 12);
+		if (err >= 0)
+		{
+		    file->f_pos++;
+		    ++stored;
+		}
+	    }
+	    read_lock (&parent->u.dir.lock);
+	    next = devfs_get (de->next);
+	    read_unlock (&parent->u.dir.lock);
+	    devfs_put (de);
+	    de = next;
 	    if (err == -EINVAL) break;
 	    if (err < 0) return err;
-	    file->f_pos++;
-	    ++stored;
 	}
 	break;
     }
@@ -2467,14 +2623,9 @@
     struct devfs_entry *de;
     struct fs_info *fs_info = inode->i_sb->u.generic_sbp;
 
-    lock_kernel ();
-    de = get_devfs_entry_from_vfs_inode (inode, TRUE);
-    err = -ENODEV;
-    if (de == NULL)
-	goto out;
-    err = 0;
-    if ( S_ISDIR (de->mode) )
-	goto out;
+    de = get_devfs_entry_from_vfs_inode (inode);
+    if (de == NULL) return -ENODEV;
+    if ( S_ISDIR (de->mode) ) return 0;
     df = &de->u.fcb;
     file->private_data = de->info;
     if ( S_ISBLK (inode->i_mode) )
@@ -2482,7 +2633,7 @@
 	file->f_op = &def_blk_fops;
 	if (df->ops) inode->i_bdev->bd_op = df->ops;
     }
-    else file->f_op = fops_get ( (struct file_operations*) df->ops );
+    else file->f_op = fops_get ( (struct file_operations *) df->ops );
     if (file->f_op)
 	err = file->f_op->open ? (*file->f_op->open) (inode, file) : 0;
     else
@@ -2491,39 +2642,33 @@
 	if ( S_ISCHR (inode->i_mode) ) err = chrdev_open (inode, file);
 	else err = -ENODEV;
     }
-    if (err < 0) goto out;
+    if (err < 0) return err;
     /*  Open was successful  */
-    err = 0;
-    if (df->open) goto out;
+    if (df->open) return 0;
     df->open = TRUE;  /*  This is the first open  */
     if (df->auto_owner)
     {
-	/*  Change the ownership/protection  */
-	de->inode.mode = (de->inode.mode & ~S_IALLUGO) |(de->mode & S_IRWXUGO);
-	de->inode.uid = current->euid;
-	de->inode.gid = current->egid;
-	inode->i_mode = de->inode.mode;
-	inode->i_uid = de->inode.uid;
-	inode->i_gid = de->inode.gid;
+	/*  Change the ownership/protection to what driver specified  */
+	inode->i_mode = de->mode;
+	inode->i_uid = current->euid;
+	inode->i_gid = current->egid;
     }
     if (df->aopen_notify)
-	devfsd_notify_one (de, DEVFSD_NOTIFY_ASYNC_OPEN, inode->i_mode,
-			   current->euid, current->egid, fs_info);
-out:
-    unlock_kernel ();
-    return err;
+	devfsd_notify_de (de, DEVFSD_NOTIFY_ASYNC_OPEN, inode->i_mode,
+			  current->euid, current->egid, fs_info);
+    return 0;
 }   /*  End Function devfs_open  */
 
 static struct file_operations devfs_fops =
 {
-    open: devfs_open,
+    open:    devfs_open,
 };
 
 static struct file_operations devfs_dir_fops =
 {
-    read: generic_read_dir,
+    read:    generic_read_dir,
     readdir: devfs_readdir,
-    open: devfs_open,
+    open:    devfs_open,
 };
 
 
@@ -2556,16 +2701,18 @@
 {
     struct devfs_entry *de;
 
-    lock_kernel ();
-    de = get_devfs_entry_from_vfs_inode (inode, FALSE);
+    de = get_devfs_entry_from_vfs_inode (inode);
 #ifdef CONFIG_DEVFS_DEBUG
     if (devfs_debug & DEBUG_D_IPUT)
 	printk ("%s: d_iput(): dentry: %p inode: %p de: %p  de->dentry: %p\n",
 		DEVFS_NAME, dentry, inode, de, de->inode.dentry);
 #endif
-    if (de->inode.dentry == dentry) de->inode.dentry = NULL;
-    unlock_kernel ();
+    if ( de->inode.dentry && (de->inode.dentry != dentry) )
+	OOPS ("%s: d_iput(%s): de: %p dentry: %p de->dentry: %p\n",
+	      DEVFS_NAME, de->name, de, dentry, de->inode.dentry);
+    de->inode.dentry = NULL;
     iput (inode);
+    devfs_put (de);
 }   /*  End Function devfs_d_iput  */
 
 static int devfs_d_delete (struct dentry *dentry);
@@ -2610,7 +2757,7 @@
 	return 1;
     }
     fs_info = inode->i_sb->u.generic_sbp;
-    de = get_devfs_entry_from_vfs_inode (inode, TRUE);
+    de = get_devfs_entry_from_vfs_inode (inode);
 #ifdef CONFIG_DEVFS_DEBUG
     if (devfs_debug & DEBUG_D_DELETE)
 	printk ("%s: d_delete(): dentry: %p  inode: %p  devfs_entry: %p\n",
@@ -2622,14 +2769,11 @@
     if (!de->u.fcb.open) return 0;
     de->u.fcb.open = FALSE;
     if (de->u.fcb.aopen_notify)
-	devfsd_notify_one (de, DEVFSD_NOTIFY_CLOSE, inode->i_mode,
-			   current->euid, current->egid, fs_info);
+	devfsd_notify_de (de, DEVFSD_NOTIFY_CLOSE, inode->i_mode,
+			  current->euid, current->egid, fs_info);
     if (!de->u.fcb.auto_owner) return 0;
     /*  Change the ownership/protection back  */
-    de->inode.mode = (de->inode.mode & ~S_IALLUGO) | S_IRUGO | S_IWUGO;
-    de->inode.uid = de->u.fcb.default_uid;
-    de->inode.gid = de->u.fcb.default_gid;
-    inode->i_mode = de->inode.mode;
+    inode->i_mode = (de->mode & S_IFMT) | S_IRUGO | S_IWUGO;
     inode->i_uid = de->inode.uid;
     inode->i_gid = de->inode.gid;
     return 0;
@@ -2637,59 +2781,44 @@
 
 static int devfs_d_revalidate_wait (struct dentry *dentry, int flags)
 {
-    devfs_handle_t de = dentry->d_fsdata;
-    struct inode *dir;
-    struct fs_info *fs_info;
+    struct inode *dir = dentry->d_parent->d_inode;
+    struct fs_info *fs_info = dir->i_sb->u.generic_sbp;
 
-    lock_kernel ();
-    dir = dentry->d_parent->d_inode;
-    fs_info = dir->i_sb->u.generic_sbp;
-    if (!de || de->registered)
+    if ( !dentry->d_inode && is_devfsd_or_child (fs_info) )
     {
-	if ( !dentry->d_inode && is_devfsd_or_child (fs_info) )
-	{
-	    struct inode *inode;
+	devfs_handle_t de;
+	devfs_handle_t parent = get_devfs_entry_from_vfs_inode (dir);
+	struct inode *inode;
 
 #ifdef CONFIG_DEVFS_DEBUG
-	    char txt[STRING_LENGTH];
-
-	    memset (txt, 0, STRING_LENGTH);
-	    memcpy (txt, dentry->d_name.name,
-		    (dentry->d_name.len >= STRING_LENGTH) ?
-		    (STRING_LENGTH - 1) : dentry->d_name.len);
-	    if (devfs_debug & DEBUG_I_LOOKUP)
-		printk ("%s: d_revalidate(): dentry: %p name: \"%s\" by: \"%s\"\n",
-			DEVFS_NAME, dentry, txt, current->comm);
-#endif
-	    if (de == NULL)
-	    {
-		devfs_handle_t parent;
+	char txt[STRING_LENGTH];
 
-		parent = get_devfs_entry_from_vfs_inode (dir, TRUE);
-		de = search_for_entry_in_dir (parent, dentry->d_name.name,
-					      dentry->d_name.len, FALSE);
-	    }
-	    if (de == NULL) goto out;
-	    /*  Create an inode, now that the driver information is available
-	     */
-	    if (de->no_persistence) update_devfs_inode_from_entry (de);
-	    else if (de->inode.ctime == 0) update_devfs_inode_from_entry (de);
-	    else de->inode.mode =
-		     (de->mode & ~S_IALLUGO) | (de->inode.mode & S_IALLUGO);
-	    if ( ( inode = get_vfs_inode (dir->i_sb, de, dentry) ) == NULL )
-		goto out;
-#ifdef CONFIG_DEVFS_DEBUG
-	    if (devfs_debug & DEBUG_I_LOOKUP)
-		printk ("%s: d_revalidate(): new VFS inode(%u): %p  devfs_entry: %p\n",
-			DEVFS_NAME, de->inode.ino, inode, de);
+	memset (txt, 0, STRING_LENGTH);
+	memcpy (txt, dentry->d_name.name,
+		(dentry->d_name.len >= STRING_LENGTH) ?
+		(STRING_LENGTH - 1) : dentry->d_name.len);
+	if (devfs_debug & DEBUG_I_LOOKUP)
+	    printk ("%s: d_revalidate(): dentry: %p name: \"%s\" by: \"%s\"\n",
+		    DEVFS_NAME, dentry, txt, current->comm);
+#endif
+	read_lock (&parent->u.dir.lock);
+	de = _devfs_search_dir (parent, dentry->d_name.name,
+				dentry->d_name.len);
+	read_lock (&parent->u.dir.lock);
+	if (de == NULL) return 1;
+	/*  Create an inode, now that the driver information is available  */
+	inode = get_vfs_inode (dir->i_sb, de, dentry);
+	devfs_put (de);
+	if (!inode) return 1;
+#ifdef CONFIG_DEVFS_DEBUG
+	if (devfs_debug & DEBUG_I_LOOKUP)
+	    printk ("%s: d_revalidate(): new VFS inode(%u): %p  devfs_entry: %p\n",
+		    DEVFS_NAME, de->inode.ino, inode, de);
 #endif
-	    d_instantiate (dentry, inode);
-	    goto out;
-	}
+	d_instantiate (dentry, inode);
+	return 1;
     }
     if ( wait_for_devfsd_finished (fs_info) ) dentry->d_op = &devfs_dops;
-out:
-    unlock_kernel ();
     return 1;
 }   /*  End Function devfs_d_revalidate_wait  */
 
@@ -2712,27 +2841,26 @@
 	    (STRING_LENGTH - 1) : dentry->d_name.len);
     fs_info = dir->i_sb->u.generic_sbp;
     /*  First try to get the devfs entry for this directory  */
-    parent = get_devfs_entry_from_vfs_inode (dir, TRUE);
+    parent = get_devfs_entry_from_vfs_inode (dir);
 #ifdef CONFIG_DEVFS_DEBUG
     if (devfs_debug & DEBUG_I_LOOKUP)
 	printk ("%s: lookup(%s): dentry: %p parent: %p by: \"%s\"\n",
 		DEVFS_NAME, txt, dentry, parent, current->comm);
 #endif
     if (parent == NULL) return ERR_PTR (-ENOENT);
-    /*  Try to reclaim an existing devfs entry  */
-    de = search_for_entry_in_dir (parent,
-				  dentry->d_name.name, dentry->d_name.len,
-				  FALSE);
-    if ( ( (de == NULL) || !de->registered ) &&
-	 (parent->u.dir.num_removable > 0) &&
+    read_lock (&parent->u.dir.lock);
+    de = _devfs_search_dir (parent, dentry->d_name.name, dentry->d_name.len);
+    read_unlock (&parent->u.dir.lock);
+    if ( (de == NULL) && (parent->u.dir.num_removable > 0) &&
 	 get_removable_partition (parent, dentry->d_name.name,
 				  dentry->d_name.len) )
     {
-	if (de == NULL)
-	    de = search_for_entry_in_dir (parent, dentry->d_name.name,
-					  dentry->d_name.len, FALSE);
+	read_lock (&parent->u.dir.lock);
+	de = _devfs_search_dir (parent, dentry->d_name.name,
+				dentry->d_name.len);
+	read_unlock (&parent->u.dir.lock);
     }
-    if ( (de == NULL) || !de->registered )
+    if (de == NULL)
     {
 	/*  Try with devfsd. For any kind of failure, leave a negative dentry
 	    so someone else can deal with it (in the case where the sysadmin
@@ -2747,21 +2875,20 @@
 	}
 	/*  devfsd claimed success  */
 	dentry->d_op = &devfs_wait_dops;
-	dentry->d_fsdata = de;
 	d_add (dentry, NULL);  /*  Open the floodgates  */
 	/*  Unlock directory semaphore, which will release any waiters. They
 	    will get the hashed dentry, and may be forced to wait for
 	    revalidation  */
 	up (&dir->i_sem);
-	devfs_d_revalidate_wait (dentry, 0);  /*  I might have to wait too  */
+	devfs_d_revalidate_wait (dentry, 0);  /*  I might have to wait too   */
 	down (&dir->i_sem);      /*  Grab it again because them's the rules  */
 	/*  If someone else has been so kind as to make the inode, we go home
 	    early  */
 	if (dentry->d_inode) return NULL;
-	if (de && !de->registered) return NULL;
-	if (de == NULL)
-	    de = search_for_entry_in_dir (parent, dentry->d_name.name,
-					  dentry->d_name.len, FALSE);
+	read_lock (&parent->u.dir.lock);
+	de = _devfs_search_dir (parent, dentry->d_name.name,
+				dentry->d_name.len);
+	read_unlock (&parent->u.dir.lock);
 	if (de == NULL) return NULL;
 	/*  OK, there's an entry now, but no VFS inode yet  */
     }
@@ -2771,29 +2898,29 @@
 	d_add (dentry, NULL);  /*  Open the floodgates  */
     }
     /*  Create an inode, now that the driver information is available  */
-    if (de->no_persistence) update_devfs_inode_from_entry (de);
-    else if (de->inode.ctime == 0) update_devfs_inode_from_entry (de);
-    else de->inode.mode =
-	     (de->mode & ~S_IALLUGO) | (de->inode.mode & S_IALLUGO);
-    if ( ( inode = get_vfs_inode (dir->i_sb, de, dentry) ) == NULL )
-	return ERR_PTR (-ENOMEM);
+    inode = get_vfs_inode (dir->i_sb, de, dentry);
+    devfs_put (de);
+    if (!inode) return ERR_PTR (-ENOMEM);
 #ifdef CONFIG_DEVFS_DEBUG
     if (devfs_debug & DEBUG_I_LOOKUP)
 	printk ("%s: lookup(): new VFS inode(%u): %p  devfs_entry: %p\n",
 		DEVFS_NAME, de->inode.ino, inode, de);
 #endif
     d_instantiate (dentry, inode);
-    /*  Unlock directory semaphore, which will release any waiters. They will
-	get the hashed dentry, and may be forced to wait for revalidation  */
-    up (&dir->i_sem);
     if (dentry->d_op == &devfs_wait_dops)
-	devfs_d_revalidate_wait (dentry, 0);  /*  I might have to wait too  */
-    down (&dir->i_sem);          /*  Grab it again because them's the rules  */
+    {   /*  Unlock directory semaphore, which will release any waiters. They
+	    will get the hashed dentry, and may be forced to wait for
+	    revalidation  */
+	up (&dir->i_sem);
+	devfs_d_revalidate_wait (dentry, 0);  /*  I might have to wait too   */
+	down (&dir->i_sem);      /*  Grab it again because them's the rules  */
+    }
     return NULL;
 }   /*  End Function devfs_lookup  */
 
 static int devfs_unlink (struct inode *dir, struct dentry *dentry)
 {
+    int unhooked;
     struct devfs_entry *de;
     struct inode *inode = dentry->d_inode;
 
@@ -2809,20 +2936,17 @@
     }
 #endif
 
-    de = get_devfs_entry_from_vfs_inode (dentry->d_inode, TRUE);
+    de = get_devfs_entry_from_vfs_inode (inode);
     if (de == NULL) return -ENOENT;
-    devfsd_notify_one (de, DEVFSD_NOTIFY_DELETE, inode->i_mode,
-		       inode->i_uid, inode->i_gid, dir->i_sb->u.generic_sbp);
-    de->registered = FALSE;
-    de->hide = TRUE;
-    if ( S_ISLNK (de->mode) )
-    {
-	down_write (&symlink_rwsem);
-	if (de->u.symlink.linkname) kfree (de->u.symlink.linkname);
-	de->u.symlink.linkname = NULL;
-	up_write (&symlink_rwsem);
-    }
-    free_dentries (de);
+    if (!de->vfs_created) return -EPERM;
+    write_lock (&de->parent->u.dir.lock);
+    unhooked = _devfs_unhook (de);
+    write_unlock (&de->parent->u.dir.lock);
+    if (!unhooked) return -ENOENT;
+    devfsd_notify_de (de, DEVFSD_NOTIFY_DELETE, inode->i_mode,
+		      inode->i_uid, inode->i_gid, dir->i_sb->u.generic_sbp);
+    free_dentry (de);
+    devfs_put (de);
     return 0;
 }   /*  End Function devfs_unlink  */
 
@@ -2836,7 +2960,7 @@
 
     fs_info = dir->i_sb->u.generic_sbp;
     /*  First try to get the devfs entry for this directory  */
-    parent = get_devfs_entry_from_vfs_inode (dir, TRUE);
+    parent = get_devfs_entry_from_vfs_inode (dir);
     if (parent == NULL) return -ENOENT;
     err = devfs_do_symlink (parent, dentry->d_name.name, DEVFS_FL_NONE,
 			    symname, &de, NULL);
@@ -2846,7 +2970,9 @@
 		DEVFS_NAME, err);
 #endif
     if (err < 0) return err;
-    de->inode.mode = de->mode;
+    de->vfs_created = TRUE;
+    de->inode.uid = current->euid;
+    de->inode.gid = current->egid;
     de->inode.atime = CURRENT_TIME;
     de->inode.mtime = CURRENT_TIME;
     de->inode.ctime = CURRENT_TIME;
@@ -2857,50 +2983,32 @@
 	printk ("%s: symlink(): new VFS inode(%u): %p  dentry: %p\n",
 		DEVFS_NAME, de->inode.ino, inode, dentry);
 #endif
-    de->hide = FALSE;
     d_instantiate (dentry, inode);
-    devfsd_notify_one (de, DEVFSD_NOTIFY_CREATE, inode->i_mode,
-		       inode->i_uid, inode->i_gid, fs_info);
+    devfsd_notify_de (de, DEVFSD_NOTIFY_CREATE, inode->i_mode,
+		      inode->i_uid, inode->i_gid, fs_info);
     return 0;
 }   /*  End Function devfs_symlink  */
 
 static int devfs_mkdir (struct inode *dir, struct dentry *dentry, int mode)
 {
-    int is_new;
+    int err;
     struct fs_info *fs_info;
     struct devfs_entry *parent, *de;
     struct inode *inode;
 
-    mode = (mode & ~S_IFMT) | S_IFDIR;
+    mode = (mode & ~S_IFMT) | S_IFDIR;  /*  VFS doesn't pass S_IFMT part  */
     fs_info = dir->i_sb->u.generic_sbp;
-    /*  First try to get the devfs entry for this directory  */
-    parent = get_devfs_entry_from_vfs_inode (dir, TRUE);
+    parent = get_devfs_entry_from_vfs_inode (dir);
     if (parent == NULL) return -ENOENT;
-    /*  Try to reclaim an existing devfs entry, create if there isn't one  */
-    de = search_for_entry (parent, dentry->d_name.name, dentry->d_name.len,
-			   FALSE, TRUE, &is_new, FALSE);
-    if (de == NULL) return -ENOMEM;
-    if (de->registered)
-    {
-	printk ("%s: mkdir(): existing entry\n", DEVFS_NAME);
-	return -EEXIST;
-    }
-    de->hide = FALSE;
-    if (!S_ISDIR (de->mode) && !is_new)
-    {
-	/*  Transmogrifying an old entry  */
-	de->u.dir.first = NULL;
-	de->u.dir.last = NULL;
-    }
-    de->mode = mode;
-    de->u.dir.num_removable = 0;
-    de->inode.mode = mode;
+    de = _devfs_alloc_entry (dentry->d_name.name, dentry->d_name.len, mode);
+    if (!de) return -ENOMEM;
+    de->vfs_created = TRUE;
+    if ( ( err = _devfs_append_entry (parent, de, FALSE) ) != 0 ) return err;
     de->inode.uid = current->euid;
     de->inode.gid = current->egid;
     de->inode.atime = CURRENT_TIME;
     de->inode.mtime = CURRENT_TIME;
     de->inode.ctime = CURRENT_TIME;
-    de->registered = TRUE;
     if ( ( inode = get_vfs_inode (dir->i_sb, de, dentry) ) == NULL )
 	return -ENOMEM;
 #ifdef CONFIG_DEVFS_DEBUG
@@ -2909,44 +3017,46 @@
 		DEVFS_NAME, de->inode.ino, inode, dentry);
 #endif
     d_instantiate (dentry, inode);
-    devfsd_notify_one (de, DEVFSD_NOTIFY_CREATE, inode->i_mode,
-		       inode->i_uid, inode->i_gid, fs_info);
+    devfsd_notify_de (de, DEVFSD_NOTIFY_CREATE, inode->i_mode,
+		      inode->i_uid, inode->i_gid, fs_info);
     return 0;
 }   /*  End Function devfs_mkdir  */
 
 static int devfs_rmdir (struct inode *dir, struct dentry *dentry)
 {
-    int has_children = FALSE;
+    int err = 0;
+    struct devfs_entry *de;
     struct fs_info *fs_info;
-    struct devfs_entry *de, *child;
     struct inode *inode = dentry->d_inode;
 
     if (dir->i_sb->u.generic_sbp != inode->i_sb->u.generic_sbp) return -EINVAL;
     fs_info = dir->i_sb->u.generic_sbp;
-    de = get_devfs_entry_from_vfs_inode (inode, TRUE);
+    de = get_devfs_entry_from_vfs_inode (inode);
     if (de == NULL) return -ENOENT;
     if ( !S_ISDIR (de->mode) ) return -ENOTDIR;
-    for (child = de->u.dir.first; child != NULL; child = child->next)
-    {
-	if (child->registered)
-	{
-	    has_children = TRUE;
-	    break;
-	}
-    }
-    if (has_children) return -ENOTEMPTY;
-    devfsd_notify_one (de, DEVFSD_NOTIFY_DELETE, inode->i_mode,
-		       inode->i_uid, inode->i_gid, fs_info);
-    de->hide = TRUE;
-    de->registered = FALSE;
-    free_dentries (de);
+    if (!de->vfs_created) return -EPERM;
+    /*  First ensure the directory is empty and will stay thay way  */
+    write_lock (&de->u.dir.lock);
+    de->u.dir.no_more_additions = TRUE;
+    if (de->u.dir.first) err = -ENOTEMPTY;
+    write_unlock (&de->u.dir.lock);
+    if (err) return err;
+    /*  Now unhook the directory from it's parent  */
+    write_lock (&de->parent->u.dir.lock);
+    if ( !_devfs_unhook (de) ) err = -ENOENT;
+    write_unlock (&de->parent->u.dir.lock);
+    if (err) return err;
+    devfsd_notify_de (de, DEVFSD_NOTIFY_DELETE, inode->i_mode,
+		      inode->i_uid, inode->i_gid, fs_info);
+    free_dentry (de);
+    devfs_put (de);
     return 0;
 }   /*  End Function devfs_rmdir  */
 
 static int devfs_mknod (struct inode *dir, struct dentry *dentry, int mode,
 			int rdev)
 {
-    int is_new;
+    int err;
     struct fs_info *fs_info;
     struct devfs_entry *parent, *de;
     struct inode *inode;
@@ -2963,46 +3073,23 @@
 		DEVFS_NAME, txt, mode, rdev);
     }
 #endif
-
     fs_info = dir->i_sb->u.generic_sbp;
-    /*  First try to get the devfs entry for this directory  */
-    parent = get_devfs_entry_from_vfs_inode (dir, TRUE);
+    parent = get_devfs_entry_from_vfs_inode (dir);
     if (parent == NULL) return -ENOENT;
-    /*  Try to reclaim an existing devfs entry, create if there isn't one  */
-    de = search_for_entry (parent, dentry->d_name.name, dentry->d_name.len,
-			   FALSE, TRUE, &is_new, FALSE);
-    if (de == NULL) return -ENOMEM;
-    if (de->registered)
-    {
-	printk ("%s: mknod(): existing entry\n", DEVFS_NAME);
-	return -EEXIST;
-    }
-    de->info = NULL;
-    de->mode = mode;
+    de = _devfs_alloc_entry (dentry->d_name.name, dentry->d_name.len, mode);
+    if (!de) return -ENOMEM;
+    de->vfs_created = TRUE;
     if ( S_ISBLK (mode) || S_ISCHR (mode) )
     {
 	de->u.fcb.u.device.major = MAJOR (rdev);
 	de->u.fcb.u.device.minor = MINOR (rdev);
-	de->u.fcb.default_uid = current->euid;
-	de->u.fcb.default_gid = current->egid;
-	de->u.fcb.ops = NULL;
-	de->u.fcb.auto_owner = FALSE;
-	de->u.fcb.aopen_notify = FALSE;
-	de->u.fcb.open = FALSE;
-    }
-    else if ( S_ISFIFO (mode) )
-    {
-	de->u.fifo.uid = current->euid;
-	de->u.fifo.gid = current->egid;
     }
-    de->hide = FALSE;
-    de->inode.mode = mode;
+    if ( ( err = _devfs_append_entry (parent, de, FALSE) ) != 0 ) return err;
     de->inode.uid = current->euid;
     de->inode.gid = current->egid;
     de->inode.atime = CURRENT_TIME;
     de->inode.mtime = CURRENT_TIME;
     de->inode.ctime = CURRENT_TIME;
-    de->registered = TRUE;
     if ( ( inode = get_vfs_inode (dir->i_sb, de, dentry) ) == NULL )
 	return -ENOMEM;
 #ifdef CONFIG_DEVFS_DEBUG
@@ -3011,8 +3098,8 @@
 		DEVFS_NAME, de->inode.ino, inode, dentry);
 #endif
     d_instantiate (dentry, inode);
-    devfsd_notify_one (de, DEVFSD_NOTIFY_CREATE, inode->i_mode,
-		       inode->i_uid, inode->i_gid, fs_info);
+    devfsd_notify_de (de, DEVFSD_NOTIFY_CREATE, inode->i_mode,
+		      inode->i_uid, inode->i_gid, fs_info);
     return 0;
 }   /*  End Function devfs_mknod  */
 
@@ -3021,12 +3108,9 @@
     int err;
     struct devfs_entry *de;
 
-    de = get_devfs_entry_from_vfs_inode (dentry->d_inode, TRUE);
+    de = get_devfs_entry_from_vfs_inode (dentry->d_inode);
     if (!de) return -ENODEV;
-    down_read (&symlink_rwsem);
-    err = de->registered ? vfs_readlink (dentry, buffer, buflen,
-					 de->u.symlink.linkname) : -ENODEV;
-    up_read (&symlink_rwsem);
+    err = vfs_readlink (dentry, buffer, buflen, de->u.symlink.linkname);
     return err;
 }   /*  End Function devfs_readlink  */
 
@@ -3034,25 +3118,10 @@
 {
     int err;
     struct devfs_entry *de;
-    char *copy;
 
-    de = get_devfs_entry_from_vfs_inode (dentry->d_inode, TRUE);
+    de = get_devfs_entry_from_vfs_inode (dentry->d_inode);
     if (!de) return -ENODEV;
-    down_read (&symlink_rwsem);
-    if (!de->registered)
-    {
-	up_read (&symlink_rwsem);
-	return -ENODEV;
-    }
-    copy = kmalloc (de->u.symlink.length + 1, GFP_KERNEL);
-    if (copy) memcpy (copy, de->u.symlink.linkname, de->u.symlink.length + 1);
-    up_read (&symlink_rwsem);
-    if (copy)
-    {
-	err = vfs_follow_link (nd, copy);
-	kfree (copy);
-    }
-    else err = -ENOMEM;
+    err = vfs_follow_link (nd, de->u.symlink.linkname);
     return err;
 }   /*  End Function devfs_follow_link  */
 
@@ -3084,7 +3153,7 @@
 {
     struct inode *root_inode = NULL;
 
-    if (get_root_entry () == NULL) goto out_no_root;
+    if (_devfs_get_root_entry () == NULL) goto out_no_root;
     atomic_set (&fs_info.devfsd_overrun_count, 0);
     init_waitqueue_head (&fs_info.devfsd_wait_queue);
     init_waitqueue_head (&fs_info.revalidate_wait_queue);
@@ -3099,7 +3168,7 @@
     sb->s_root = d_alloc_root (root_inode);
     if (!sb->s_root) goto out_no_root;
 #ifdef CONFIG_DEVFS_DEBUG
-    if (devfs_debug & DEBUG_DISABLED)
+    if (devfs_debug & DEBUG_S_READ)
 	printk ("%s: read super, made devfs ptr: %p\n",
 		DEVFS_NAME, sb->u.generic_sbp);
 #endif
@@ -3182,6 +3251,7 @@
 	if (pos < 0) return pos;
 	info->namelen = DEVFS_PATHLEN - pos - 1;
 	if (info->mode == 0) info->mode = de->mode;
+	for (; de != NULL; de = de->parent) devfs_put (de);
     }
     devname_offset = info->devname - (char *) info;
     rpos = *ppos;
@@ -3306,6 +3376,25 @@
     wake_up (&fs_info->revalidate_wait_queue);
     return 0;
 }   /*  End Function devfsd_close  */
+
+#ifdef CONFIG_DEVFS_DEBUG
+static ssize_t stat_read (struct file *file, char *buf, size_t len,
+			  loff_t *ppos)
+{
+    ssize_t num;
+    char txt[80];
+
+    num = sprintf (txt, "Number of entries: %u  number of bytes: %u\n",
+		   stat_num_entries, stat_num_bytes) + 1;
+    /*  Can't seek (pread) on this device  */
+    if (ppos != &file->f_pos) return -ESPIPE;
+    if (*ppos >= num) return 0;
+    if (*ppos + len > num) len = num - *ppos;
+    if ( copy_to_user (buf, txt + *ppos, len) ) return -EFAULT;
+    *ppos += len;
+    return len;
+}   /*  End Function stat_read  */
+#endif
 
 
 static int __init init_devfs_fs (void)
