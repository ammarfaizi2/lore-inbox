Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281287AbRKETcq>; Mon, 5 Nov 2001 14:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281289AbRKETce>; Mon, 5 Nov 2001 14:32:34 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:21435 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281287AbRKETcT>; Mon, 5 Nov 2001 14:32:19 -0500
Date: Mon, 5 Nov 2001 12:31:32 -0700
Message-Id: <200111051931.fA5JVWK10415@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] New devfs core
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Appended is my first cut of the new devfs core, which I've
been working on (and off) for the past few months. It compiles and
boots, devfsd can create compatibility entries and I can log in.
However, I've not done any proper testing nor auditing of the code.
There's more cleaning up to do, and I'm sure it's riddled with bugs.

But since interest has been expressed ;-) in seeing this code, here it
is. So don't flame if you see problems. Remember that this is a very
rough cut. I have a list of "issues" to process before I consider this
alpha quality. Also, there are some design decisions I've deferred.

The point of this new devfs core, in case it's not obvious, is to have
proper locking and refcounting and thus eliminate the various races
which have drawn so much, erm, attention.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

diff -urN linux-2.4.14-pre8/fs/devfs/base.c linux/fs/devfs/base.c
--- linux-2.4.14-pre8/fs/devfs/base.c	Sun Nov  4 15:56:45 2001
+++ linux/fs/devfs/base.c	Mon Nov  5 12:17:29 2001
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
+    20011105   Richard Gooch <rgooch@atnf.csiro.au>
+	       First, un-audited cut of new locking code.
+  v1.0
 */
 #include <linux/types.h>
 #include <linux/errno.h>
@@ -592,7 +586,7 @@
 #include <asm/bitops.h>
 #include <asm/atomic.h>
 
-#define DEVFS_VERSION            "0.120 (20011103)"
+#define DEVFS_VERSION            "1.0 (20011105)"
 
 #define DEVFS_NAME "devfs"
 
@@ -605,14 +599,14 @@
 #  define FALSE 0
 #endif
 
-#define IS_HIDDEN(de) (( ((de)->hide && !is_devfsd_or_child(fs_info)) || !(de)->registered))
+#define IS_HIDDEN(de) ( (de)->hide && !is_devfsd_or_child(fs_info) )
 
 #define DEBUG_NONE         0x00000
 #define DEBUG_MODULE_LOAD  0x00001
 #define DEBUG_REGISTER     0x00002
 #define DEBUG_UNREGISTER   0x00004
 #define DEBUG_SET_FLAGS    0x00008
-#define DEBUG_S_PUT        0x00010
+#define DEBUG_S_READ       0x00010
 #define DEBUG_I_LOOKUP     0x00020
 #define DEBUG_I_CREATE     0x00040
 #define DEBUG_I_GET        0x00080
@@ -638,6 +632,7 @@
 
 struct directory_type
 {
+    rwlock_t lock;               /*  Lock for searching(R)/updating(W)       */
     struct devfs_entry *first;
     struct devfs_entry *last;
     unsigned int num_removable;
@@ -684,12 +679,12 @@
     gid_t gid;
 };
 
-struct devfs_inode  /*  This structure is for "persistent" inode storage  */
+struct devfs_inode     /*  This structure is for "persistent" inode storage  */
 {
     time_t atime;
     time_t mtime;
     time_t ctime;
-    unsigned int ino;          /*  Inode number as seen in the VFS  */
+    unsigned int ino;            /*  Inode number as seen in the VFS         */
     struct dentry *dentry;
     umode_t mode;
     uid_t uid;
@@ -699,6 +694,7 @@
 struct devfs_entry
 {
     void *info;
+    atomic_t refcount;           /*  When this drops to zero, it's unused    */
     union 
     {
 	struct directory_type dir;
@@ -713,12 +709,11 @@
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
@@ -733,7 +728,7 @@
     gid_t gid;
 };
 
-struct fs_info      /*  This structure is for the mounted devfs  */
+struct fs_info                  /*  This structure is for the mounted devfs  */
 {
     struct super_block *sb;
     volatile struct devfsd_buf_entry *devfsd_buffer;
@@ -763,14 +758,10 @@
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
@@ -791,22 +782,52 @@
 
 
 /**
- *	search_for_entry_in_dir - Search for a devfs entry inside another devfs entry.
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
+    if ( S_ISLNK (de->mode) ) kfree (de->u.symlink.linkname);
+    if ( ( S_ISCHR (de->mode) || S_ISBLK (de->mode) ) && de->u.fcb.autogen )
+    {
+	devfs_dealloc_devnum ( S_ISCHR (de->mode) ? DEVFS_SPECIAL_CHR :
+			       DEVFS_SPECIAL_BLK,
+			       MKDEV (de->u.fcb.u.device.major,
+				      de->u.fcb.u.device.minor) );
+    }
+    kfree (de);
+}   /*  End Function devfs_put  */
+
+/**
+ *	_devfs_search_dir - Search for a devfs entry inside another devfs entry.
  *	@parent:  The parent devfs entry.
  *	@name:  The name of the entry.
  *	@namelen:  The number of characters in @name.
- *	@traverse_symlink:  If %TRUE then the entry is traversed if it is a symlink.
  *
  *  Search for a devfs entry inside another devfs entry and returns a pointer
- *   to the entry on success, else %NULL.
+ *   to the entry on success, else %NULL. The parent must be locked already.
+ *   An implicit devfs_get() is performed on the returned entry.
  */
 
-static struct devfs_entry *search_for_entry_in_dir (struct devfs_entry *parent,
-						    const char *name,
-						    unsigned int namelen,
-						    int traverse_symlink)
+static struct devfs_entry *_devfs_search_dir (struct devfs_entry *parent,
+					      const char *name,
+					      unsigned int namelen)
 {
-    struct devfs_entry *curr, *retval;
+    struct devfs_entry *curr;
 
     if ( !S_ISDIR (parent->mode) )
     {
@@ -819,18 +840,21 @@
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
 
-static struct devfs_entry *create_entry (struct devfs_entry *parent,
-					 const char *name,unsigned int namelen)
+
+/**
+ *	_devfs_alloc_entry - Allocate a devfs entry.
+ *	@name:  The name of the entry.
+ *	@namelen:  The number of characters in @name.
+ *
+ *  Allocate a devfs entry and returns a pointer to the entry on success, else
+ *   %NULL.
+ */
+
+static struct devfs_entry *_devfs_alloc_entry (const char *name,
+					       unsigned int namelen)
 {
     struct devfs_entry *new;
     static unsigned long inode_counter = FIRST_INODE;
@@ -842,20 +866,75 @@
     /*  Magic: this will set the ctime to zero, thus subsequent lookups will
 	trigger the call to <update_devfs_inode_from_entry>  */
     memset (new, 0, sizeof *new + namelen);
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
     return new;
-}   /*  End Function create_entry  */
+}   /*  End Function _devfs_alloc_entry  */
+
+
+/**
+ *	_devfs_alloc_dir - Allocate and initialise a devfs directory.
+ *	@name:  The name of the entry.
+ *	@namelen:  The number of characters in @name.
+ *
+ *  Allocate a devfs directory and returns a pointer to the entry on success, else
+ *   %NULL.
+ */
+
+static devfs_handle_t _devfs_alloc_dir (const char *name, unsigned int namelen)
+{
+    struct devfs_entry *de;
+
+    if ( ( de = _devfs_alloc_entry (name, namelen) ) == NULL ) return NULL;
+    de->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+    rwlock_init (&de->u.dir.lock);
+    return de;
+}   /*  End Function _devfs_alloc_dir  */
+
+
+/**
+ *	append_entry - Append a devfs entry to a directory's list of children.
+ *	@parent:  The parent directory.
+ *	@de:  The devfs entry to append.
+ *
+ *  Append a devfs entry to a directory's list of children, checking first to
+ *   see if an entry of the same name exists. The parent will be locked.
+ *   The value 0 is returned on success, else a negative error code.
+ */
+
+static int append_entry (struct devfs_entry *parent, struct devfs_entry *de)
+{
+    int retval;
+    struct devfs_entry *old;
+
+    if (!de || !parent) return 0;
+    if ( !S_ISDIR (parent->mode) )
+    {
+	printk ("%s: append_entry(): parent: \"%s\" is not a directory\n",
+		DEVFS_NAME, parent->name);
+	return -ENOTDIR;
+    }
+    write_lock (&parent->u.dir.lock);
+    old = _devfs_search_dir (parent, de->name, de->namelen);
+    devfs_put (old);
+    if (old == NULL)
+    {
+	de->parent = parent;
+	de->prev = parent->u.dir.last;
+	/*  Append to the parent directory's list of children  */
+	if (parent->u.dir.first == NULL) parent->u.dir.first = de;
+	else parent->u.dir.last->next = de;
+	parent->u.dir.last = de;
+	retval = 0;
+    }
+    else retval = -EEXIST;
+    write_unlock (&parent->u.dir.lock);
+    return retval;
+}   /*  End Function append_entry  */
 
 static void update_devfs_inode_from_entry (struct devfs_entry *de)
 {
@@ -889,26 +968,33 @@
 }   /*  End Function update_devfs_inode_from_entry  */
 
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
+    if (root_entry) return root_entry;
+    if ( ( new = _devfs_alloc_dir (NULL, 0) ) == NULL ) return NULL;
     /*  Force an inode update, because lookup() is never done for the root  */
-    update_devfs_inode_from_entry (root_entry);
-    root_entry->registered = TRUE;
+    update_devfs_inode_from_entry (new);
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
+    if ( ( new = _devfs_alloc_entry (".devfsd", 0) ) == NULL ) return NULL;
     devnum = devfs_alloc_devnum (DEVFS_SPECIAL_CHR);
     new->u.fcb.u.device.major = MAJOR (devnum);
     new->u.fcb.u.device.minor = MINOR (devnum);
@@ -916,91 +1002,140 @@
     new->u.fcb.default_uid = 0;
     new->u.fcb.default_gid = 0;
     new->u.fcb.ops = &devfsd_fops;
-    new->registered = TRUE;
+    append_entry (root_entry, new);
     return root_entry;
-}   /*  End Function get_root_entry  */
+}   /*  End Function _devfs_get_root_entry  */
 
 
-/**
- *	search_for_entry - Search for an entry in the devfs tree.
- *	@dir: The parent directory to search from. If this is %NULL the root is used
- *	@name: The name of the entry.
- *	@namelen: The number of characters in @name.
- *	@mkdir: If %TRUE intermediate directories are created as needed.
- *	@mkfile: If %TRUE the file entry is created if it doesn't exist.
- *	@is_new: If the returned entry was newly made, %TRUE is written here. If
- * 		this is %NULL nothing is written here.
- *	@traverse_symlink: If %TRUE then symbolic links are traversed.
- *
- *	If the entry is created, then it will be in the unregistered state.
- *	Returns a pointer to the entry on success, else %NULL.
- */
-
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
     {
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
+	if ( ( de = _devfs_descend (dir, name, namelen, &next_pos) ) == NULL )
 	{
-	    /*  Going up  */
-	    dir = dir->parent;
-	    if (dir == NULL) return NULL;  /*  Cannot escape from devfs  */
-	    subname += 3;
-	    continue;
+	    if ( ( de = _devfs_alloc_dir (name, next_pos) ) == NULL )
+	    {
+		devfs_put (dir);
+		return NULL;
+	    }
+	    if ( append_entry (dir, de) )
+	    {
+		devfs_put (dir);
+		devfs_put (de);
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
+					   const char *name)
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
+    if ( ( de = _devfs_alloc_entry (name + leaf_pos, namelen - leaf_pos) )
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
@@ -1063,7 +1198,6 @@
  *		%DEVFS_SPECIAL_CHR or %DEVFS_SPECIAL_BLK.
  *	@traverse_symlink: If %TRUE then symbolic links are traversed.
  *
- *	FIXME: What the hell is @handle? - ch
  *	Returns the devfs_entry pointer on success, else %NULL.
  */
 
@@ -1095,10 +1229,7 @@
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
@@ -1114,7 +1245,7 @@
     if (inode == NULL) return NULL;
     de = inode->u.generic_ip;
     if (!de) printk (__FUNCTION__ "(): NULL de for inode %ld\n", inode->i_ino);
-    if (do_check && de && !de->registered) de = NULL;
+    /*FIXME: what to do with do_check?  */
     return de;
 }   /*  End Function get_devfs_entry_from_vfs_inode  */
 
@@ -1201,8 +1332,9 @@
 
 
 /**
- *	devfsd_notify_one - Notify a single devfsd daemon of a change.
- *	@data: Data to be passed.
+ *	devfsd_notify_one - Notify the devfsd daemon of a change.
+ *	@data: Data to be passed. This must remain in scope until devfsd has
+ *             processed the event.
  *	@type: The type of change.
  *	@mode: The mode of the entry.
  *	@uid: The user ID.
@@ -1246,17 +1378,43 @@
 
 
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
+    if ( devfsd_notify_one (de, type, mode, uid, gid, fs_info) )
+    {
+	for (; de != NULL; de = de->parent) devfs_get (de);
+	return (TRUE);
+    }
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
 
@@ -1287,7 +1445,6 @@
 			       umode_t mode, void *ops, void *info)
 {
     char devtype = S_ISCHR (mode) ? DEVFS_SPECIAL_CHR : DEVFS_SPECIAL_BLK;
-    int is_new;
     kdev_t devnum = NODEV;
     struct devfs_entry *de;
 
@@ -1332,39 +1489,13 @@
 	major = MAJOR (devnum);
 	minor = MINOR (devnum);
     }
-    de = search_for_entry (dir, name, strlen (name), TRUE, TRUE, &is_new,
-			   FALSE);
-    if (de == NULL)
+    if ( ( de = _devfs_prepare_leaf (&dir, name) ) == NULL )
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
     de->u.fcb.autogen = FALSE;
     if ( S_ISCHR (mode) || S_ISBLK (mode) )
     {
@@ -1375,8 +1506,11 @@
     else if ( S_ISREG (mode) ) de->u.fcb.u.file.size = 0;
     else
     {
-	printk ("%s: devfs_register(): illegal mode: %x\n",
-		DEVFS_NAME, mode);
+	printk ("%s: devfs_register(%s): illegal mode: %x\n",
+		DEVFS_NAME, name, mode);
+	devfs_put (de);
+	devfs_put (dir);
+	if (devnum != NODEV) devfs_dealloc_devnum (devtype, devnum);
 	return (NULL);
     }
     de->info = info;
@@ -1401,77 +1535,77 @@
     }
     de->u.fcb.open = FALSE;
     de->hide = (flags & DEVFS_FL_HIDE) ? TRUE : FALSE;
-    de->no_persistence = (flags & DEVFS_FL_NO_PERSISTENCE) ? TRUE : FALSE;
-    de->registered = TRUE;
+    if ( append_entry (dir, de) )
+    {
+	printk ("%s: devfs_register(%s): could not append to parent\n",
+		DEVFS_NAME, name);
+	devfs_put (de);
+	devfs_put (dir);
+	if (devnum != NODEV) devfs_dealloc_devnum (devtype, devnum);
+	return NULL;
+    }
+#ifdef CONFIG_DEVFS_DEBUG
+    if (devfs_debug & DEBUG_REGISTER)
+	printk ("%s: devfs_register(%s): de: %p\n", DEVFS_NAME, name, de);
+#endif
     devfsd_notify (de, DEVFSD_NOTIFY_REGISTERED, flags & DEVFS_FL_WAIT);
+    devfs_put (dir);
     return de;
 }   /*  End Function devfs_register  */
 
 
 /**
+ *	_devfs_unhook - Unhook a device entry from its parents list
+ *	@de: The entry to unhook.
+ */
+
+static void _devfs_unhook (struct devfs_entry *de)
+{
+    struct devfs_entry *parent;
+
+    if (!de) return;
+    parent = de->parent;
+    write_lock (&parent->u.dir.lock);
+    if (de->prev == NULL) parent->u.dir.first = de->next;
+    else de->prev->next = de->next;
+    if (de->next == NULL) parent->u.dir.last = de->prev;
+    else de->next->prev = de->prev;
+    de->next = NULL;        /*  Force early termination for <devfs_readdir>  */
+    write_unlock (&parent->u.dir.lock);
+}   /*  End Function _devfs_unhook  */
+
+
+/**
  *	unregister - Unregister a device entry.
  *	@de: The entry to unregister.
  */
 
 static void unregister (struct devfs_entry *de)
 {
-    struct devfs_entry *child;
-
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
+    if (!de) return;
+    _devfs_unhook (de);
+    devfs_get (de->parent);
+    unregister (de->slave);
+    devfs_put (de->slave);
+    devfsd_notify (de, DEVFSD_NOTIFY_UNREGISTERED, 0);
+    free_dentries (de);
+    devfs_put (de->parent);
+    if ( !S_ISDIR (de->mode) ) return;
+    while (TRUE)  /*  Recursively unregister: this is a stack chomper  */
+    {
+	struct devfs_entry *child;
+
+	read_lock (&de->u.dir.lock);
+	child = devfs_get (de->u.dir.first);
+	read_unlock (&de->u.dir.lock);
+	if (!child) break;
 #ifdef CONFIG_DEVFS_DEBUG
 	if (devfs_debug & DEBUG_UNREGISTER)
 	    printk ("%s: unregister(): child->name: \"%s\" child: %p\n",
 		    DEVFS_NAME, child->name, child);
 #endif
 	unregister (child);
+	devfs_put (child);
     }
 }   /*  End Function unregister  */
 
@@ -1491,13 +1625,13 @@
 		DEVFS_NAME, de->name, de);
 #endif
     unregister (de);
+    devfs_put (de);
 }   /*  End Function devfs_unregister  */
 
 static int devfs_do_symlink (devfs_handle_t dir, const char *name,
 			     unsigned int flags, const char *link,
 			     devfs_handle_t *handle, void *info)
 {
-    int is_new;
     unsigned int linklength;
     char *newlink;
     struct devfs_entry *de;
@@ -1522,28 +1656,27 @@
 	return -ENOMEM;
     memcpy (newlink, link, linklength);
     newlink[linklength] = '\0';
-    if ( ( de = search_for_entry (dir, name, strlen (name), TRUE, TRUE,
-				  &is_new, FALSE) ) == NULL )
+    if ( ( de = _devfs_prepare_leaf (&dir, name) ) == NULL )
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
     de->mode = S_IFLNK | S_IRUGO | S_IXUGO;
     de->info = info;
     de->hide = (flags & DEVFS_FL_HIDE) ? TRUE : FALSE;
     de->u.symlink.linkname = newlink;
     de->u.symlink.length = linklength;
-    de->registered = TRUE;
-    up_write (&symlink_rwsem);
+    if ( append_entry (dir, de) )
+    {
+	printk ("%s: devfs_do_symlink(%s): could not append to parent\n",
+		DEVFS_NAME, name);
+	devfs_put (de);
+	devfs_put (dir);
+	return -EEXIST;
+    }
+    devfs_put (dir);
     if (handle != NULL) *handle = de;
     return 0;
 }   /*  End Function devfs_do_symlink  */
@@ -1593,7 +1726,6 @@
 
 devfs_handle_t devfs_mk_dir (devfs_handle_t dir, const char *name, void *info)
 {
-    int is_new;
     struct devfs_entry *de;
 
     if (name == NULL)
@@ -1601,36 +1733,28 @@
 	printk ("%s: devfs_mk_dir(): NULL name pointer\n", DEVFS_NAME);
 	return NULL;
     }
-    de = search_for_entry (dir, name, strlen (name), TRUE, TRUE, &is_new,
-			   FALSE);
-    if (de == NULL)
+    if ( ( de = _devfs_prepare_leaf (&dir, name) ) == NULL )
     {
-	printk ("%s: devfs_mk_dir(): could not create entry: \"%s\"\n",
+	printk ("%s: devfs_mk_dir(%s): could not prepare leaf\n",
 		DEVFS_NAME, name);
 	return NULL;
     }
-    if (!S_ISDIR (de->mode) && de->registered)
+    de->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+    de->info = info;
+    rwlock_init (&de->u.dir.lock);
+    if ( append_entry (dir, de) )
     {
-	printk ("%s: devfs_mk_dir(): existing non-directory entry: \"%s\"\n",
+	printk ("%s: devfs_mk_dir(%s): could not append to parent\n",
 		DEVFS_NAME, name);
+	devfs_put (de);
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
 
@@ -1659,9 +1783,9 @@
     devfs_handle_t de;
 
     if ( (name != NULL) && (name[0] == '\0') ) name = NULL;
-    de = find_entry (dir, name, 0, major, minor, type, traverse_symlinks);
+    de = find_entry (dir, name, 0, major, minor, type,
+		     traverse_symlinks);
     if (de == NULL) return NULL;
-    if (!de->registered) return NULL;
     return de;
 }   /*  End Function devfs_find_handle  */
 
@@ -1679,7 +1803,6 @@
     unsigned int fl = 0;
 
     if (de == NULL) return -EINVAL;
-    if (!de->registered) return -ENODEV;
     if (de->hide) fl |= DEVFS_FL_HIDE;
     if ( S_ISCHR (de->mode) || S_ISBLK (de->mode) || S_ISREG (de->mode) )
     {
@@ -1703,7 +1826,6 @@
 int devfs_set_flags (devfs_handle_t de, unsigned int flags)
 {
     if (de == NULL) return -EINVAL;
-    if (!de->registered) return -ENODEV;
 #ifdef CONFIG_DEVFS_DEBUG
     if (devfs_debug & DEBUG_SET_FLAGS)
 	printk ("%s: devfs_set_flags(): de->name: \"%s\"\n",
@@ -1742,7 +1864,6 @@
 		       unsigned int *minor)
 {
     if (de == NULL) return -EINVAL;
-    if (!de->registered) return -ENODEV;
     if ( S_ISDIR (de->mode) ) return -EISDIR;
     if ( !S_ISCHR (de->mode) && !S_ISBLK (de->mode) ) return -EINVAL;
     if (major != NULL) *major = de->u.fcb.u.device.major;
@@ -1808,7 +1929,6 @@
 void *devfs_get_ops (devfs_handle_t de)
 {
     if (de == NULL) return NULL;
-    if (!de->registered) return NULL;
     if ( S_ISCHR (de->mode) || S_ISBLK (de->mode) || S_ISREG (de->mode) )
 	return de->u.fcb.ops;
     return NULL;
@@ -1826,7 +1946,6 @@
 int devfs_set_file_size (devfs_handle_t de, unsigned long size)
 {
     if (de == NULL) return -EINVAL;
-    if (!de->registered) return -EINVAL;
     if ( !S_ISREG (de->mode) ) return -EINVAL;
     if (de->u.fcb.u.file.size == size) return 0;
     de->u.fcb.u.file.size = size;
@@ -1846,7 +1965,6 @@
 void *devfs_get_info (devfs_handle_t de)
 {
     if (de == NULL) return NULL;
-    if (!de->registered) return NULL;
     return de->info;
 }   /*  End Function devfs_get_info  */
 
@@ -1861,7 +1979,6 @@
 int devfs_set_info (devfs_handle_t de, void *info)
 {
     if (de == NULL) return -EINVAL;
-    if (!de->registered) return -EINVAL;
     de->info = info;
     return 0;
 }   /*  End Function devfs_set_info  */
@@ -1876,7 +1993,6 @@
 devfs_handle_t devfs_get_parent (devfs_handle_t de)
 {
     if (de == NULL) return NULL;
-    if (!de->registered) return NULL;
     return de->parent;
 }   /*  End Function devfs_get_parent  */
 
@@ -1891,7 +2007,6 @@
 devfs_handle_t devfs_get_first_child (devfs_handle_t de)
 {
     if (de == NULL) return NULL;
-    if (!de->registered) return NULL;
     if ( !S_ISDIR (de->mode) ) return NULL;
     return de->u.dir.first;
 }   /*  End Function devfs_get_first_child  */
@@ -1907,7 +2022,6 @@
 devfs_handle_t devfs_get_next_sibling (devfs_handle_t de)
 {
     if (de == NULL) return NULL;
-    if (!de->registered) return NULL;
     return de->next;
 }   /*  End Function devfs_get_next_sibling  */
 
@@ -1961,7 +2075,6 @@
 const char *devfs_get_name (devfs_handle_t de, unsigned int *namelen)
 {
     if (de == NULL) return NULL;
-    if (!de->registered) return NULL;
     if (namelen != NULL) *namelen = de->namelen;
     return de->name;
 }   /*  End Function devfs_get_name  */
@@ -2059,6 +2172,7 @@
 	{"dunreg",    DEBUG_UNREGISTER,   &devfs_debug_init},
 	{"diget",     DEBUG_I_GET,        &devfs_debug_init},
 	{"dchange",   DEBUG_SET_FLAGS,    &devfs_debug_init},
+	{"dsread",    DEBUG_S_READ,       &devfs_debug_init},
 	{"dichange",  DEBUG_I_CHANGE,     &devfs_debug_init},
 	{"dimknod",   DEBUG_I_MKNOD,      &devfs_debug_init},
 	{"dilookup",  DEBUG_I_LOOKUP,     &devfs_debug_init},
@@ -2129,13 +2243,13 @@
 
 
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
@@ -2206,7 +2320,6 @@
     if (dir->u.dir.num_removable < 1) return;
     for (de = dir->u.dir.first; de != NULL; de = de->next)
     {
-	if (!de->registered) continue;
 	if ( !S_ISBLK (de->mode) ) continue;
 	if (!de->u.fcb.removable) continue;
 	check_disc_changed (de);
@@ -2229,7 +2342,6 @@
 
     for (de = dir->u.dir.first; de != NULL; de = de->next)
     {
-	if (!de->registered) continue;
 	if ( !S_ISBLK (de->mode) ) continue;
 	if (!de->u.fcb.removable) continue;
 	if (strcmp (de->name, "disc") == 0) return check_disc_changed (de);
@@ -2283,8 +2395,8 @@
     de->inode.mtime = inode->i_mtime;
     de->inode.ctime = inode->i_ctime;
     if ( iattr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID) )
-	devfsd_notify_one (de, DEVFSD_NOTIFY_CHANGE, inode->i_mode,
-			   inode->i_uid, inode->i_gid, fs_info);
+	devfsd_notify_de (de, DEVFSD_NOTIFY_CHANGE, inode->i_mode,
+			  inode->i_uid, inode->i_gid, fs_info);
     return 0;
 }   /*  End Function devfs_notify_change  */
 
@@ -2299,11 +2411,10 @@
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
@@ -2319,7 +2430,8 @@
  *	@de: The devfs inode.
  *	@dentry: The dentry to register with the devfs inode.
  *
- *	Returns the inode on success, else %NULL.
+ *	Returns the inode on success, else %NULL. An implicit devfs_get() is
+ *       performed if the inode is created.
  */
 
 static struct inode *get_vfs_inode (struct super_block *sb,
@@ -2344,7 +2456,7 @@
 	return NULL;
     }
     de->inode.dentry = dentry;
-    inode->u.generic_ip = de;
+    inode->u.generic_ip = devfs_get (de);
     inode->i_ino = de->inode.ino;
 #ifdef CONFIG_DEVFS_DEBUG
     if (devfs_debug & DEBUG_I_GET)
@@ -2366,7 +2478,7 @@
     {
 	inode->i_rdev = MKDEV (de->u.fcb.u.device.major,
 			       de->u.fcb.u.device.minor);
-	if (bd_acquire(inode) == 0)
+	if (bd_acquire (inode) == 0)
 	{
 	    if (!inode->i_bdev->bd_op && de->u.fcb.ops)
 		inode->i_bdev->bd_op = de->u.fcb.ops;
@@ -2409,7 +2521,7 @@
     int err, count;
     int stored = 0;
     struct fs_info *fs_info;
-    struct devfs_entry *parent, *de;
+    struct devfs_entry *parent, *de, *next = NULL;
     struct inode *inode = file->f_dentry->d_inode;
 
     fs_info = inode->i_sb->u.generic_sbp;
@@ -2441,19 +2553,32 @@
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
@@ -2467,14 +2592,9 @@
     struct devfs_entry *de;
     struct fs_info *fs_info = inode->i_sb->u.generic_sbp;
 
-    lock_kernel ();
     de = get_devfs_entry_from_vfs_inode (inode, TRUE);
-    err = -ENODEV;
-    if (de == NULL)
-	goto out;
-    err = 0;
-    if ( S_ISDIR (de->mode) )
-	goto out;
+    if (de == NULL) return -ENODEV;
+    if ( S_ISDIR (de->mode) ) return 0;
     df = &de->u.fcb;
     file->private_data = de->info;
     if ( S_ISBLK (inode->i_mode) )
@@ -2482,7 +2602,7 @@
 	file->f_op = &def_blk_fops;
 	if (df->ops) inode->i_bdev->bd_op = df->ops;
     }
-    else file->f_op = fops_get ( (struct file_operations*) df->ops );
+    else file->f_op = fops_get ( (struct file_operations *) df->ops );
     if (file->f_op)
 	err = file->f_op->open ? (*file->f_op->open) (inode, file) : 0;
     else
@@ -2491,10 +2611,9 @@
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
@@ -2507,23 +2626,21 @@
 	inode->i_gid = de->inode.gid;
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
 
 
@@ -2556,15 +2673,17 @@
 {
     struct devfs_entry *de;
 
-    lock_kernel ();
     de = get_devfs_entry_from_vfs_inode (inode, FALSE);
 #ifdef CONFIG_DEVFS_DEBUG
     if (devfs_debug & DEBUG_D_IPUT)
 	printk ("%s: d_iput(): dentry: %p inode: %p de: %p  de->dentry: %p\n",
 		DEVFS_NAME, dentry, inode, de, de->inode.dentry);
 #endif
-    if (de->inode.dentry == dentry) de->inode.dentry = NULL;
-    unlock_kernel ();
+    if (de->inode.dentry == dentry)  /*FIXME: do I need this test?  */
+    {
+	de->inode.dentry = NULL;
+	devfs_put (de);
+    }
     iput (inode);
 }   /*  End Function devfs_d_iput  */
 
@@ -2622,8 +2741,8 @@
     if (!de->u.fcb.open) return 0;
     de->u.fcb.open = FALSE;
     if (de->u.fcb.aopen_notify)
-	devfsd_notify_one (de, DEVFSD_NOTIFY_CLOSE, inode->i_mode,
-			   current->euid, current->egid, fs_info);
+	devfsd_notify_de (de, DEVFSD_NOTIFY_CLOSE, inode->i_mode,
+			  current->euid, current->egid, fs_info);
     if (!de->u.fcb.auto_owner) return 0;
     /*  Change the ownership/protection back  */
     de->inode.mode = (de->inode.mode & ~S_IALLUGO) | S_IRUGO | S_IWUGO;
@@ -2641,10 +2760,9 @@
     struct inode *dir;
     struct fs_info *fs_info;
 
-    lock_kernel ();
     dir = dentry->d_parent->d_inode;
     fs_info = dir->i_sb->u.generic_sbp;
-    if (!de || de->registered)
+    if (!de)
     {
 	if ( !dentry->d_inode && is_devfsd_or_child (fs_info) )
 	{
@@ -2666,30 +2784,28 @@
 		devfs_handle_t parent;
 
 		parent = get_devfs_entry_from_vfs_inode (dir, TRUE);
-		de = search_for_entry_in_dir (parent, dentry->d_name.name,
-					      dentry->d_name.len, FALSE);
+		de = _devfs_search_dir (parent, dentry->d_name.name,
+					dentry->d_name.len);
 	    }
-	    if (de == NULL) goto out;
+	    if (de == NULL) return 1;
 	    /*  Create an inode, now that the driver information is available
 	     */
-	    if (de->no_persistence) update_devfs_inode_from_entry (de);
-	    else if (de->inode.ctime == 0) update_devfs_inode_from_entry (de);
+	    if (de->inode.ctime == 0) update_devfs_inode_from_entry (de);
 	    else de->inode.mode =
 		     (de->mode & ~S_IALLUGO) | (de->inode.mode & S_IALLUGO);
-	    if ( ( inode = get_vfs_inode (dir->i_sb, de, dentry) ) == NULL )
-		goto out;
+	    inode = get_vfs_inode (dir->i_sb, de, dentry);
+	    devfs_put (de);
+	    if (!inode) return 1;
 #ifdef CONFIG_DEVFS_DEBUG
 	    if (devfs_debug & DEBUG_I_LOOKUP)
 		printk ("%s: d_revalidate(): new VFS inode(%u): %p  devfs_entry: %p\n",
 			DEVFS_NAME, de->inode.ino, inode, de);
 #endif
 	    d_instantiate (dentry, inode);
-	    goto out;
+	    return 1;
 	}
     }
     if ( wait_for_devfsd_finished (fs_info) ) dentry->d_op = &devfs_dops;
-out:
-    unlock_kernel ();
     return 1;
 }   /*  End Function devfs_d_revalidate_wait  */
 
@@ -2719,20 +2835,19 @@
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
@@ -2747,7 +2862,6 @@
 	}
 	/*  devfsd claimed success  */
 	dentry->d_op = &devfs_wait_dops;
-	dentry->d_fsdata = de;
 	d_add (dentry, NULL);  /*  Open the floodgates  */
 	/*  Unlock directory semaphore, which will release any waiters. They
 	    will get the hashed dentry, and may be forced to wait for
@@ -2758,10 +2872,10 @@
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
@@ -2771,12 +2885,12 @@
 	d_add (dentry, NULL);  /*  Open the floodgates  */
     }
     /*  Create an inode, now that the driver information is available  */
-    if (de->no_persistence) update_devfs_inode_from_entry (de);
-    else if (de->inode.ctime == 0) update_devfs_inode_from_entry (de);
+    if (de->inode.ctime == 0) update_devfs_inode_from_entry (de);
     else de->inode.mode =
 	     (de->mode & ~S_IALLUGO) | (de->inode.mode & S_IALLUGO);
-    if ( ( inode = get_vfs_inode (dir->i_sb, de, dentry) ) == NULL )
-	return ERR_PTR (-ENOMEM);
+    inode = get_vfs_inode (dir->i_sb, de, dentry);
+    devfs_put (de);
+    if (!inode) return ERR_PTR (-ENOMEM);
 #ifdef CONFIG_DEVFS_DEBUG
     if (devfs_debug & DEBUG_I_LOOKUP)
 	printk ("%s: lookup(): new VFS inode(%u): %p  devfs_entry: %p\n",
@@ -2809,20 +2923,14 @@
     }
 #endif
 
-    de = get_devfs_entry_from_vfs_inode (dentry->d_inode, TRUE);
+    de = get_devfs_entry_from_vfs_inode (inode, TRUE);
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
+    if (!de->vfs_created) return -EPERM;
+    _devfs_unhook (de);
+    devfsd_notify_de (de, DEVFSD_NOTIFY_DELETE, inode->i_mode,
+		      inode->i_uid, inode->i_gid, dir->i_sb->u.generic_sbp);
     free_dentries (de);
+    devfs_put (de);
     return 0;
 }   /*  End Function devfs_unlink  */
 
@@ -2846,6 +2954,7 @@
 		DEVFS_NAME, err);
 #endif
     if (err < 0) return err;
+    de->vfs_created = TRUE;
     de->inode.mode = de->mode;
     de->inode.atime = CURRENT_TIME;
     de->inode.mtime = CURRENT_TIME;
@@ -2857,50 +2966,38 @@
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
     struct fs_info *fs_info;
     struct devfs_entry *parent, *de;
     struct inode *inode;
 
     mode = (mode & ~S_IFMT) | S_IFDIR;
     fs_info = dir->i_sb->u.generic_sbp;
-    /*  First try to get the devfs entry for this directory  */
     parent = get_devfs_entry_from_vfs_inode (dir, TRUE);
     if (parent == NULL) return -ENOENT;
-    /*  Try to reclaim an existing devfs entry, create if there isn't one  */
-    de = search_for_entry (parent, dentry->d_name.name, dentry->d_name.len,
-			   FALSE, TRUE, &is_new, FALSE);
-    if (de == NULL) return -ENOMEM;
-    if (de->registered)
+    de = _devfs_alloc_dir (dentry->d_name.name, dentry->d_name.len);
+    if (!de) return -ENOMEM;
+    de->vfs_created = TRUE;
+    de->mode = mode;
+    if ( append_entry (parent, de) )
     {
-	printk ("%s: mkdir(): existing entry\n", DEVFS_NAME);
+	devfs_put (de);
+	printk ("%s: mkdir(): existing devfs entry\n", DEVFS_NAME);
 	return -EEXIST;
     }
-    de->hide = FALSE;
-    if (!S_ISDIR (de->mode) && !is_new)
-    {
-	/*  Transmogrifying an old entry  */
-	de->u.dir.first = NULL;
-	de->u.dir.last = NULL;
-    }
-    de->mode = mode;
-    de->u.dir.num_removable = 0;
     de->inode.mode = mode;
     de->inode.uid = current->euid;
     de->inode.gid = current->egid;
     de->inode.atime = CURRENT_TIME;
     de->inode.mtime = CURRENT_TIME;
     de->inode.ctime = CURRENT_TIME;
-    de->registered = TRUE;
     if ( ( inode = get_vfs_inode (dir->i_sb, de, dentry) ) == NULL )
 	return -ENOMEM;
 #ifdef CONFIG_DEVFS_DEBUG
@@ -2909,16 +3006,15 @@
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
+    struct devfs_entry *de;
     struct fs_info *fs_info;
-    struct devfs_entry *de, *child;
     struct inode *inode = dentry->d_inode;
 
     if (dir->i_sb->u.generic_sbp != inode->i_sb->u.generic_sbp) return -EINVAL;
@@ -2926,27 +3022,19 @@
     de = get_devfs_entry_from_vfs_inode (inode, TRUE);
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
+    if (!de->vfs_created) return -EPERM;
+    if (de->u.dir.first) return -ENOTEMPTY;
+    _devfs_unhook (de);
+    devfsd_notify_de (de, DEVFSD_NOTIFY_DELETE, inode->i_mode,
+		      inode->i_uid, inode->i_gid, fs_info);
     free_dentries (de);
+    devfs_put (de);
     return 0;
 }   /*  End Function devfs_rmdir  */
 
 static int devfs_mknod (struct inode *dir, struct dentry *dentry, int mode,
 			int rdev)
 {
-    int is_new;
     struct fs_info *fs_info;
     struct devfs_entry *parent, *de;
     struct inode *inode;
@@ -2963,21 +3051,12 @@
 		DEVFS_NAME, txt, mode, rdev);
     }
 #endif
-
     fs_info = dir->i_sb->u.generic_sbp;
-    /*  First try to get the devfs entry for this directory  */
     parent = get_devfs_entry_from_vfs_inode (dir, TRUE);
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
+    de = _devfs_alloc_entry (dentry->d_name.name, dentry->d_name.len);
+    if (!de) return -ENOMEM;
+    de->vfs_created = TRUE;
     de->mode = mode;
     if ( S_ISBLK (mode) || S_ISCHR (mode) )
     {
@@ -2995,14 +3074,18 @@
 	de->u.fifo.uid = current->euid;
 	de->u.fifo.gid = current->egid;
     }
-    de->hide = FALSE;
+    if ( append_entry (parent, de) )
+    {
+	devfs_put (de);
+	printk ("%s: mknod(): existing devfs entry\n", DEVFS_NAME);
+	return -EEXIST;
+    }
     de->inode.mode = mode;
     de->inode.uid = current->euid;
     de->inode.gid = current->egid;
     de->inode.atime = CURRENT_TIME;
     de->inode.mtime = CURRENT_TIME;
     de->inode.ctime = CURRENT_TIME;
-    de->registered = TRUE;
     if ( ( inode = get_vfs_inode (dir->i_sb, de, dentry) ) == NULL )
 	return -ENOMEM;
 #ifdef CONFIG_DEVFS_DEBUG
@@ -3011,8 +3094,8 @@
 		DEVFS_NAME, de->inode.ino, inode, dentry);
 #endif
     d_instantiate (dentry, inode);
-    devfsd_notify_one (de, DEVFSD_NOTIFY_CREATE, inode->i_mode,
-		       inode->i_uid, inode->i_gid, fs_info);
+    devfsd_notify_de (de, DEVFSD_NOTIFY_CREATE, inode->i_mode,
+		      inode->i_uid, inode->i_gid, fs_info);
     return 0;
 }   /*  End Function devfs_mknod  */
 
@@ -3023,10 +3106,7 @@
 
     de = get_devfs_entry_from_vfs_inode (dentry->d_inode, TRUE);
     if (!de) return -ENODEV;
-    down_read (&symlink_rwsem);
-    err = de->registered ? vfs_readlink (dentry, buffer, buflen,
-					 de->u.symlink.linkname) : -ENODEV;
-    up_read (&symlink_rwsem);
+    err = vfs_readlink (dentry, buffer, buflen, de->u.symlink.linkname);
     return err;
 }   /*  End Function devfs_readlink  */
 
@@ -3034,25 +3114,10 @@
 {
     int err;
     struct devfs_entry *de;
-    char *copy;
 
     de = get_devfs_entry_from_vfs_inode (dentry->d_inode, TRUE);
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
 
@@ -3084,7 +3149,7 @@
 {
     struct inode *root_inode = NULL;
 
-    if (get_root_entry () == NULL) goto out_no_root;
+    if (_devfs_get_root_entry () == NULL) goto out_no_root;
     atomic_set (&fs_info.devfsd_overrun_count, 0);
     init_waitqueue_head (&fs_info.devfsd_wait_queue);
     init_waitqueue_head (&fs_info.revalidate_wait_queue);
@@ -3099,7 +3164,7 @@
     sb->s_root = d_alloc_root (root_inode);
     if (!sb->s_root) goto out_no_root;
 #ifdef CONFIG_DEVFS_DEBUG
-    if (devfs_debug & DEBUG_DISABLED)
+    if (devfs_debug & DEBUG_S_READ)
 	printk ("%s: read super, made devfs ptr: %p\n",
 		DEVFS_NAME, sb->u.generic_sbp);
 #endif
@@ -3182,6 +3247,7 @@
 	if (pos < 0) return pos;
 	info->namelen = DEVFS_PATHLEN - pos - 1;
 	if (info->mode == 0) info->mode = de->mode;
+	for (; de != NULL; de = de->parent) devfs_put (de);
     }
     devname_offset = info->devname - (char *) info;
     rpos = *ppos;
