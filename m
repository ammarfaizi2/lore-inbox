Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966324AbWKNUKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966324AbWKNUKF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966305AbWKNUJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:09:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63401 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966316AbWKNUJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:09:21 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 16/19] CacheFiles: Deal with LSM when accessing the cache
Date: Tue, 14 Nov 2006 20:06:56 +0000
To: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
       trond.myklebust@fys.uio.no
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       aviro@redhat.com, steved@redhat.com
Message-Id: <20061114200656.12943.98985.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the Cachefiles module deal with LSM/SELinux security when accessing the
cache.

This is the documentation added to:

	Documentation/filesystems/caching/cachefiles.txt

on the subject:

==========================
SECURITY MODEL AND SELINUX
==========================

CacheFiles is implemented to deal properly with the LSM security features of
the Linux kernel and the SELinux facility.

One of the problems that CacheFiles faces is that it is generally acting on
behalf of a process, and running in that process's context, and that includes a
security context that is not appropriate for accessing the cache - either
because the files in the cache are inaccessible to that process, or because if
the process creates a file in the cache, that file may be inaccessible to other
processes.

The way CacheFiles works is to temporarily change the security context (fsuid,
fsgid and actor security ID, file creation ID) that the process acts as -
without changing the security context of the process when it the target of an
operation performed by some other process (so signalling and suchlike still
work correctly).


When the CacheFiles module is asked to bind to its cache, it:

 (1) Finds the security label attached to the root cache directory and uses
     that as the security label with which it will create files.  By default,
     this is:

	cachefiles_var_t

 (2) Finds the security label of the process which issued the bind request
     (presumed to be the cachefilesd daemon), which by default will be:

	cachefilesd_t

     and asks LSM to supply a security ID as which it should act given the
     daemon's label.  By default, this will be:

	cachefiles_kernel_t

     SELinux transitions the daemon's security ID to the module's security ID
     based on a rule of this form in the policy.

	type_transition <daemon's-ID> kernel_t : process <module's-ID>;

     For instance:

	type_transition cachefilesd_t kernel_t : process cachefiles_kernel_t;


The module's security ID gives it permission to create, move and remove files
and directories in the cache, to find and access directories and files in the
cache, to set and access extended attributes on cache objects, and to read and
write files in the cache.

The daemon's security ID gives it only a very restricted set of permissions: it
may scan directories, stat files and erase files and directories.  It may
not read or write files in the cache, and so it is precluded from accessing the
data cached therein; nor is it permitted to create new files in the cache.


There are policy source files available in:

	http://people.redhat.com/~dhowells/fscache/cachefilesd-0.8.tar.bz2

and later versions.  In that tarball, see the files:

	cachefilesd.te
	cachefilesd.fc
	cachefilesd.if

They are built and installed directly by the RPM.

If a non-RPM based system is being used, then copy the above files to their own
directory and run:

	make -f /usr/share/selinux/devel/Makefile
	semodule -i cachefilesd.pp

You will need checkpolicy and selinux-policy-devel installed prior to the
build.


By default, the cache is located in /var/fscache, but if it is desirable that
it should be elsewhere, than either the above policy files must be altered, or
an auxiliary policy must be installed to label the alternate location of the
cache.

For instructions on how to add an auxiliary policy to enable the cache to be
located elsewhere when SELinux is in enforcing mode, please see:

	/usr/share/doc/cachefilesd-*/move-cache.txt

When the cachefilesd rpm is installed; alternatively, the document can be found
in the sources.


Signed-Off-By: David Howells <dhowells@redhat.com>
---

 Documentation/filesystems/caching/cachefiles.txt |   97 +++++++++++++++++++
 fs/cachefiles/Makefile                           |    4 +
 fs/cachefiles/cf-bind.c                          |   19 ++++
 fs/cachefiles/cf-daemon.c                        |    5 +
 fs/cachefiles/cf-interface.c                     |   35 +++++++
 fs/cachefiles/cf-namei.c                         |   25 -----
 fs/cachefiles/cf-security.c                      |  110 ++++++++++++++++++++++
 fs/cachefiles/internal.h                         |   37 +++++++
 8 files changed, 304 insertions(+), 28 deletions(-)

diff --git a/Documentation/filesystems/caching/cachefiles.txt b/Documentation/filesystems/caching/cachefiles.txt
index af074c4..b502cff 100644
--- a/Documentation/filesystems/caching/cachefiles.txt
+++ b/Documentation/filesystems/caching/cachefiles.txt
@@ -18,6 +18,8 @@ Contents:
 
  (*) Cache structure.
 
+ (*) Security model and SELinux.
+
 ========
 OVERVIEW
 ========
@@ -296,3 +298,98 @@ or retire them.
 
 Note that CacheFiles will erase from the cache any file it doesn't recognise or
 any file of an incorrect type (such as a FIFO file or a device file).
+
+
+==========================
+SECURITY MODEL AND SELINUX
+==========================
+
+CacheFiles is implemented to deal properly with the LSM security features of
+the Linux kernel and the SELinux facility.
+
+One of the problems that CacheFiles faces is that it is generally acting on
+behalf of a process, and running in that process's context, and that includes a
+security context that is not appropriate for accessing the cache - either
+because the files in the cache are inaccessible to that process, or because if
+the process creates a file in the cache, that file may be inaccessible to other
+processes.
+
+The way CacheFiles works is to temporarily change the security context (fsuid,
+fsgid and actor security label) that the process acts as - without changing the
+security context of the process when it the target of an operation performed by
+some other process (so signalling and suchlike still work correctly).
+
+
+When the CacheFiles module is asked to bind to its cache, it:
+
+ (1) Finds the security label attached to the root cache directory and uses
+     that as the security label with which it will create files.  By default,
+     this is:
+
+	cachefiles_var_t
+
+ (2) Finds the security label of the process which issued the bind request
+     (presumed to be the cachefilesd daemon), which by default will be:
+
+	cachefilesd_t
+
+     and asks LSM to supply a security ID as which it should act given the
+     daemon's label.  By default, this will be:
+
+	cachefiles_kernel_t
+
+     SELinux transitions the daemon's security ID to the module's security ID
+     based on a rule of this form in the policy.
+
+	type_transition <daemon's-ID> kernel_t : process <module's-ID>;
+
+     For instance:
+
+	type_transition cachefilesd_t kernel_t : process cachefiles_kernel_t;
+
+
+The module's security ID gives it permission to create, move and remove files
+and directories in the cache, to find and access directories and files in the
+cache, to set and access extended attributes on cache objects, and to read and
+write files in the cache.
+
+The daemon's security ID gives it only a very restricted set of permissions: it
+may scan directories, stat files and erase files and directories.  It may
+not read or write files in the cache, and so it is precluded from accessing the
+data cached therein; nor is it permitted to create new files in the cache.
+
+
+There are policy source files available in:
+
+	http://people.redhat.com/~dhowells/fscache/cachefilesd-0.8.tar.bz2
+
+and later versions.  In that tarball, see the files:
+
+	cachefilesd.te
+	cachefilesd.fc
+	cachefilesd.if
+
+They are built and installed directly by the RPM.
+
+If a non-RPM based system is being used, then copy the above files to their own
+directory and run:
+
+	make -f /usr/share/selinux/devel/Makefile
+	semodule -i cachefilesd.pp
+
+You will need checkpolicy and selinux-policy-devel installed prior to the
+build.
+
+
+By default, the cache is located in /var/fscache, but if it is desirable that
+it should be elsewhere, than either the above policy files must be altered, or
+an auxiliary policy must be installed to label the alternate location of the
+cache.
+
+For instructions on how to add an auxiliary policy to enable the cache to be
+located elsewhere when SELinux is in enforcing mode, please see:
+
+	/usr/share/doc/cachefilesd-*/move-cache.txt
+
+When the cachefilesd rpm is installed; alternatively, the document can be found
+in the sources.
diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
index 9109b75..08dabdb 100644
--- a/fs/cachefiles/Makefile
+++ b/fs/cachefiles/Makefile
@@ -2,7 +2,7 @@ #
 # Makefile for caching in a mounted filesystem
 #
 
-cachefiles-objs := \
+cachefiles-y := \
 	cf-bind.o \
 	cf-daemon.o \
 	cf-interface.o \
@@ -11,4 +11,6 @@ cachefiles-objs := \
 	cf-namei.o \
 	cf-xattr.o
 
+cachefiles-$(CONFIG_SECURITY) += cf-security.o
+
 obj-$(CONFIG_CACHEFILES) := cachefiles.o
diff --git a/fs/cachefiles/cf-bind.c b/fs/cachefiles/cf-bind.c
index 13ee6be..0ac3a6b 100644
--- a/fs/cachefiles/cf-bind.c
+++ b/fs/cachefiles/cf-bind.c
@@ -89,10 +89,20 @@ static int cachefiles_daemon_add_cache(s
 	struct nameidata nd;
 	struct kstatfs stats;
 	struct dentry *graveyard, *cachedir, *root;
+	uid_t fsuid;
+	gid_t fsgid;
+	u32 fscreatesid;
 	int ret;
 
 	_enter("");
 
+	/* we want to work under the module's security ID */
+	ret = cachefiles_get_security_ID(cache);
+	if (ret < 0)
+		return ret;
+
+	cachefiles_begin_secure(cache, &fsuid, &fsgid, &fscreatesid);
+
 	/* allocate the root index object */
 	ret = -ENOMEM;
 
@@ -134,6 +144,12 @@ static int cachefiles_daemon_add_cache(s
 	if (root->d_sb->s_flags & MS_RDONLY)
 		goto error_unsupported;
 
+	/* determine the security context within which we access the cache from
+	 * within the kernel */
+	ret = cachefiles_check_security(cache, root);
+	if (ret < 0)
+		goto error_unsupported;
+
 	/* get the cache size and blocksize */
 	ret = root->d_sb->s_op->statfs(root, &stats);
 	if (ret < 0)
@@ -224,7 +240,7 @@ static int cachefiles_daemon_add_cache(s
 
 	/* check how much space the cache has */
 	cachefiles_has_space(cache, 0, 0);
-
+	cachefiles_end_secure(cache, fsuid, fsgid, fscreatesid);
 	return 0;
 
 error_add_cache:
@@ -239,6 +255,7 @@ error_unsupported:
 error_open_root:
 	kmem_cache_free(cachefiles_object_jar, fsdef);
 error_root_object:
+	cachefiles_end_secure(cache, fsuid, fsgid, fscreatesid);
 	kerror("Failed to register: %d", ret);
 	return ret;
 }
diff --git a/fs/cachefiles/cf-daemon.c b/fs/cachefiles/cf-daemon.c
index ea6fe65..ae82685 100644
--- a/fs/cachefiles/cf-daemon.c
+++ b/fs/cachefiles/cf-daemon.c
@@ -517,6 +517,9 @@ static int cachefiles_daemon_cull(struct
 {
 	struct dentry *dir;
 	struct file *dirfile;
+	uid_t fsuid;
+	gid_t fsgid;
+	u32 fscreatesid;
 	int dirfd, fput_needed, ret;
 
 	_enter(",%s", args);
@@ -559,7 +562,9 @@ static int cachefiles_daemon_cull(struct
 	if (!S_ISDIR(dir->d_inode->i_mode))
 		goto notdir;
 
+	cachefiles_begin_secure(cache, &fsuid, &fsgid, &fscreatesid);
 	ret = cachefiles_cull(cache, dir, args);
+	cachefiles_end_secure(cache, fsuid, fsgid, fscreatesid);
 
 	dput(dir);
 	_leave(" = %d", ret);
diff --git a/fs/cachefiles/cf-interface.c b/fs/cachefiles/cf-interface.c
index fd6eb90..f467058 100644
--- a/fs/cachefiles/cf-interface.c
+++ b/fs/cachefiles/cf-interface.c
@@ -33,8 +33,11 @@ static struct fscache_object *cachefiles
 	struct cachefiles_cache *cache;
 	struct cachefiles_xattr *auxdata;
 	unsigned keylen, auxlen;
+	uid_t fsuid;
+	gid_t fsgid;
 	void *buffer;
 	char *key;
+	u32 fscreatesid;
 	int ret;
 
 	ASSERT(_parent);
@@ -92,7 +95,9 @@ static struct fscache_object *cachefiles
 	auxdata->type = cookie->def->type;
 
 	/* look up the key, creating any missing bits */
+	cachefiles_begin_secure(cache, &fsuid, &fsgid, &fscreatesid);
 	ret = cachefiles_walk_to_object(parent, object, key, auxdata);
+	cachefiles_end_secure(cache, fsuid, fsgid, fscreatesid);
 	if (ret < 0)
 		goto lookup_failed;
 
@@ -176,13 +181,18 @@ static void cachefiles_update_object(str
 {
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
+	uid_t fsuid;
+	gid_t fsgid;
+	u32 fscreatesid;
 
 	_enter("%p", _object);
 
 	object = container_of(_object, struct cachefiles_object, fscache);
 	cache = container_of(object->fscache.cache, struct cachefiles_cache, cache);
 
+	cachefiles_begin_secure(cache, &fsuid, &fsgid, &fscreatesid);
 	//cachefiles_tree_update_object(super, object);
+	cachefiles_end_secure(cache, fsuid, fsgid, fscreatesid);
 }
 
 /*
@@ -192,6 +202,9 @@ static void cachefiles_put_object(struct
 {
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
+	uid_t fsuid;
+	gid_t fsgid;
+	u32 fscreatesid;
 
 	ASSERT(_object);
 
@@ -217,7 +230,9 @@ #endif
 	    _object != cache->cache.fsdef
 	    ) {
 		_debug("- retire object %p", object);
+		cachefiles_begin_secure(cache, &fsuid, &fsgid, &fscreatesid);
 		cachefiles_delete_object(cache, object);
+		cachefiles_end_secure(cache, fsuid, fsgid, fscreatesid);
 	}
 
 	/* close the filesystem stuff attached to the object */
@@ -251,6 +266,9 @@ #endif
 static void cachefiles_sync_cache(struct fscache_cache *_cache)
 {
 	struct cachefiles_cache *cache;
+	uid_t fsuid;
+	gid_t fsgid;
+	u32 fscreatesid;
 	int ret;
 
 	_enter("%p", _cache);
@@ -259,7 +277,10 @@ static void cachefiles_sync_cache(struct
 
 	/* make sure all pages pinned by operations on behalf of the netfs are
 	 * written to disc */
+	cachefiles_begin_secure(cache, &fsuid, &fsgid, &fscreatesid);
 	ret = fsync_super(cache->mnt->mnt_sb);
+	cachefiles_end_secure(cache, fsuid, fsgid, fscreatesid);
+
 	if (ret == -EIO)
 		cachefiles_io_error(cache,
 				    "Attempt to sync backing fs superblock"
@@ -273,12 +294,18 @@ static void cachefiles_sync_cache(struct
 static int cachefiles_set_i_size(struct fscache_object *_object, loff_t i_size)
 {
 	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
 	struct iattr newattrs;
+	uid_t fsuid;
+	gid_t fsgid;
+	u32 fscreatesid;
 	int ret;
 
 	_enter("%p,%llu", _object, i_size);
 
 	object = container_of(_object, struct cachefiles_object, fscache);
+	cache = container_of(object->fscache.cache,
+			     struct cachefiles_cache, cache);
 
 	if (i_size == object->i_size)
 		return 0;
@@ -291,9 +318,11 @@ static int cachefiles_set_i_size(struct 
 	newattrs.ia_size = i_size;
 	newattrs.ia_valid = ATTR_SIZE;
 
+	cachefiles_begin_secure(cache, &fsuid, &fsgid, &fscreatesid);
 	mutex_lock(&object->backer->d_inode->i_mutex);
 	ret = notify_change(object->backer, &newattrs);
 	mutex_unlock(&object->backer->d_inode->i_mutex);
+	cachefiles_end_secure(cache, fsuid, fsgid, fscreatesid);
 
 	if (ret == -EIO) {
 		cachefiles_io_error_obj(object, "Size set failed");
@@ -683,7 +712,8 @@ static int cachefiles_read_or_alloc_page
 	int ret;
 
 	object = container_of(_object, struct cachefiles_object, fscache);
-	cache = container_of(object->fscache.cache, struct cachefiles_cache, cache);
+	cache = container_of(object->fscache.cache,
+			     struct cachefiles_cache, cache);
 
 	_enter("{%p},{%lx},,,", object, page->index);
 
@@ -994,7 +1024,8 @@ static int cachefiles_read_or_alloc_page
 	int ret, ret2, space;
 
 	object = container_of(_object, struct cachefiles_object, fscache);
-	cache = container_of(object->fscache.cache, struct cachefiles_cache, cache);
+	cache = container_of(object->fscache.cache,
+			     struct cachefiles_cache, cache);
 
 	_enter("{%p},,%d,,", object, *nr_pages);
 
diff --git a/fs/cachefiles/cf-namei.c b/fs/cachefiles/cf-namei.c
index 1bd5d27..80c9b66 100644
--- a/fs/cachefiles/cf-namei.c
+++ b/fs/cachefiles/cf-namei.c
@@ -18,6 +18,7 @@ #include <linux/quotaops.h>
 #include <linux/xattr.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
+#include <linux/security.h>
 #include "internal.h"
 
 /*
@@ -274,8 +275,6 @@ int cachefiles_walk_to_object(struct cac
 	struct cachefiles_cache *cache;
 	struct dentry *dir, *next = NULL, *new;
 	struct qstr name;
-	uid_t fsuid;
-	gid_t fsgid;
 	int ret;
 
 	_enter("{%p}", parent->dentry);
@@ -292,11 +291,6 @@ int cachefiles_walk_to_object(struct cac
 		return -ENOBUFS;
 	}
 
-	fsuid = current->fsuid;
-	fsgid = current->fsgid;
-	current->fsuid = 0;
-	current->fsgid = 0;
-
 	dir = dget(parent->dentry);
 
 advance:
@@ -502,8 +496,6 @@ lookup_again:
 		}
 	}
 
-	current->fsuid = fsuid;
-	current->fsgid = fsgid;
 	object->new = 0;
 
 	_leave(" = 0 [%lu]", object->dentry->d_inode->i_ino);
@@ -546,9 +538,6 @@ error:
 error_out2:
 	dput(dir);
 error_out:
-	current->fsuid = fsuid;
-	current->fsgid = fsgid;
-
 	if (ret == -ENOSPC)
 		ret = -ENOBUFS;
 
@@ -565,8 +554,6 @@ struct dentry *cachefiles_get_directory(
 {
 	struct dentry *subdir, *new;
 	struct qstr name;
-	uid_t fsuid;
-	gid_t fsgid;
 	int ret;
 
 	_enter("");
@@ -589,11 +576,6 @@ struct dentry *cachefiles_get_directory(
 	/* search the current directory for the element name */
 	_debug("lookup '%s' %x", name.name, name.hash);
 
-	fsuid = current->fsuid;
-	fsgid = current->fsgid;
-	current->fsuid = 0;
-	current->fsgid = 0;
-
 	mutex_lock(&dir->d_inode->i_mutex);
 
 	subdir = d_lookup(dir, &name);
@@ -640,9 +622,6 @@ struct dentry *cachefiles_get_directory(
 
 	mutex_unlock(&dir->d_inode->i_mutex);
 
-	current->fsuid = fsuid;
-	current->fsgid = fsgid;
-
 	/* we need to make sure the subdir is a directory */
 	ASSERT(subdir->d_inode);
 
@@ -691,8 +670,6 @@ nomem_d_alloc:
 	goto error_out;
 
 error_out:
-	current->fsuid = fsuid;
-	current->fsgid = fsgid;
 	_leave(" = %d", ret);
 	return ERR_PTR(ret);
 }
diff --git a/fs/cachefiles/cf-security.c b/fs/cachefiles/cf-security.c
new file mode 100644
index 0000000..4c5f052
--- /dev/null
+++ b/fs/cachefiles/cf-security.c
@@ -0,0 +1,110 @@
+/* CacheFiles security management
+ *
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/fs.h>
+#include "internal.h"
+
+/*
+ * determine the security context within which we access the cache from within
+ * the kernel
+ */
+int cachefiles_get_security_ID(struct cachefiles_cache *cache)
+{
+	char *seclabel;
+	u32 seclen, daemon_sid;
+	int ret;
+
+	_enter("");
+
+	cache->access_sid = 0;
+
+	/* ask the security policy to tell us what security ID we should be
+	 * using to access the cache, given the security ID that our daemon is
+	 * using */
+	security_task_getsecid(current, &daemon_sid);
+
+	ret = security_secid_to_secctx(daemon_sid, &seclabel, &seclen);
+	if (ret < 0)
+		goto error;
+	_debug("Cache Daemon SID: %x '%s'", daemon_sid, seclabel);
+	kfree(seclabel);
+
+	ret = security_cachefiles_get_secid(daemon_sid, &cache->access_sid);
+	if (ret < 0) {
+		printk(KERN_ERR "CacheFiles:"
+		       " Security can't provide module SID: error %d",
+		       ret);
+		goto error;
+	}
+
+	ret = security_secid_to_secctx(cache->access_sid, &seclabel, &seclen);
+	if (ret < 0)
+		goto error;
+	_debug("Cache Module SID: %x '%s'", cache->access_sid, seclabel);
+	kfree(seclabel);
+
+error:
+	if (ret == -EOPNOTSUPP)
+		ret = 0;
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * check the security details of the on-disk cache
+ */
+int cachefiles_check_security(struct cachefiles_cache *cache,
+			      struct dentry *root)
+{
+	char *seclabel;
+	u32 seclen;
+	int ret;
+
+	_enter("");
+
+	/* use the cache root dir's security ID as the SID with which to create
+	 * files */
+	cache->cache_sid = security_inode_get_secid(root->d_inode);
+
+	ret = security_secid_to_secctx(cache->cache_sid, &seclabel, &seclen);
+	if (ret < 0)
+		goto error;
+	_debug("Cache SID: %x '%s'", cache->cache_sid, seclabel);
+	kfree(seclabel);
+
+	/* check that we have permission to create files and directories with
+	 * the security ID we've been given */
+	security_act_as_secid(cache->access_sid);
+
+	ret = security_inode_mkdir(root->d_inode, root, 0);
+	if (ret < 0) {
+		printk(KERN_ERR "CacheFiles:"
+		       " Security denies permission to make dirs: error %d",
+		       ret);
+		goto error2;
+	}
+
+	ret = security_inode_create(root->d_inode, root, 0);
+	if (ret < 0) {
+		printk(KERN_ERR "CacheFiles:"
+		       " Security denies permission to create files: error %d",
+		       ret);
+		goto error2;
+	}
+
+error2:
+	security_act_as_self();
+error:
+	if (ret == -EOPNOTSUPP)
+		ret = 0;
+	_leave(" = %d", ret);
+	return ret;
+}
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 29c79a3..d56b443 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -30,6 +30,7 @@ #include <linux/fscache-cache.h>
 #include <linux/timer.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <linux/security.h>
 
 struct cachefiles_cache;
 struct cachefiles_object;
@@ -80,6 +81,8 @@ struct cachefiles_cache {
 	struct rb_root			active_nodes;	/* active nodes (can't be culled) */
 	rwlock_t			active_lock;	/* lock for active_nodes */
 	atomic_t			gravecounter;	/* graveyard uniquifier */
+	u32				access_sid;	/* cache access SID */
+	u32				cache_sid;	/* cache fs object SID */
 	unsigned			frun_percent;	/* when to stop culling (% files) */
 	unsigned			fcull_percent;	/* when to start culling (% files) */
 	unsigned			fstop_percent;	/* when to stop allocating (% files) */
@@ -181,6 +184,40 @@ extern int cachefiles_cull(struct cachef
 			   char *filename);
 
 /*
+ * cf-security.c
+ */
+#ifdef CONFIG_SECURITY
+extern int cachefiles_get_security_ID(struct cachefiles_cache *cache);
+extern int cachefiles_check_security(struct cachefiles_cache *cache,
+				     struct dentry *root);
+#else
+#define cachefiles_get_security_ID(cache) (0)
+#define cachefiles_check_security(cache, root) (0)
+#endif
+
+static inline void cachefiles_begin_secure(struct cachefiles_cache *cache,
+					   uid_t *fsuid, gid_t *fsgid,
+					   u32 *fscreatesid)
+{
+	security_act_as_secid(cache->access_sid);
+	*fscreatesid = security_set_fscreate_secid(cache->cache_sid);
+	*fsuid = current->fsuid;
+	*fsgid = current->fsgid;
+	current->fsuid = 0;
+	current->fsgid = 0;
+}
+
+static inline void cachefiles_end_secure(struct cachefiles_cache *cache,
+					 uid_t fsuid, gid_t fsgid,
+					 u32 fscreatesid)
+{
+	current->fsuid = fsuid;
+	current->fsgid = fsgid;
+	security_set_fscreate_secid(fscreatesid);
+	security_act_as_self();
+}
+
+/*
  * cf-xattr.c
  */
 extern int cachefiles_check_object_type(struct cachefiles_object *object);
