Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWAKRRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWAKRRZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 12:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWAKRRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 12:17:24 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:56253 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751140AbWAKRRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 12:17:23 -0500
Message-ID: <43C53DA0.60704@us.ibm.com>
Date: Wed, 11 Jan 2006 12:17:20 -0500
From: "Mike D. Day" <ncmike@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Macintosh/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: xen-devel@lists.xensource.com
Subject: [RFC] [PATCH] sysfs support for Xen attributes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The included patch provides some sysfs helper routines so that xen 
domain kernel processes can easily attributes to sysfs. The intent is 
that any kernel process can add an attribute under /sys/xen just as 
easily as adding a file under /proc. In other words, without using the 
driver core to create a subsystem, dealing with kobjects and ksets, etc.

One example adds xen version info under /sys/xen/version

The comments desired are (1) do the helper routines in xen_sysfs 
duplicate code already present in linux (or under development somewhere 
else). (2) Is it appropriate for a process to create sysfs attributes 
without implementing a driver subsystem or (3) are such attributes 
better off living under /proc. (4) any other feedback is appreciated.


# HG changeset patch
# User mdday@mdday.raleigh.ibm.com
# Node ID f6e4c20a786b9322843fb46a45f7796fc6a33b44
# Parent  ed7888c838ad5cd213a24d21ae294b31a2500f4d
Export Xen information to sysfs Allow xen domain kernel to add xen
data to /sys/xen without also requiring creation of driver subsystems.

As an example, add xen version by creating /sys/xen/version

signed-off-by Mike Day <ncmike@us.ibm.com>

diff -r ed7888c838ad -r f6e4c20a786b 
linux-2.6-xen-sparse/arch/xen/kernel/Makefile
--- a/linux-2.6-xen-sparse/arch/xen/kernel/Makefile     Tue Jan 10 
17:53:44 2006
+++ b/linux-2.6-xen-sparse/arch/xen/kernel/Makefile     Tue Jan 10 
23:30:37 2006
@@ -16,3 +16,4 @@
  obj-$(CONFIG_PROC_FS) += xen_proc.o
  obj-$(CONFIG_NET)     += skbuff.o
  obj-$(CONFIG_SMP)     += smpboot.o
+obj-$(CONFIG_SYSFS)   += xen_sysfs.o xen_sysfs_version.o
diff -r ed7888c838ad -r f6e4c20a786b 
linux-2.6-xen-sparse/arch/xen/kernel/xen_sysfs.c
--- /dev/null   Tue Jan 10 17:53:44 2006
+++ b/linux-2.6-xen-sparse/arch/xen/kernel/xen_sysfs.c  Tue Jan 10 
23:30:37 2006
@@ -0,0 +1,694 @@
+/*
+    copyright (c) 2006 IBM Corporation
+    Mike Day <ncmike@us.ibm.com>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 
02111-1307  USA
+*/
+
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <asm/atomic.h>
+#include <asm/semaphore.h>
+#include <asm-generic/bug.h>
+
+#ifdef DEBUG
+#define DPRINTK(fmt, args...)   printk(KERN_DEBUG "xen_sysfs: ",  fmt, 
## args)
+#else
+#define DPRINTK(fmt, args...)
+#endif
+
+#ifndef BOOL
+#define BOOL    int
+#endif
+
+#ifndef FALSE
+#define FALSE   0
+#endif
+
+#ifndef TRUE
+#define TRUE    1
+#endif
+
+#ifndef NULL
+#define NULL    0
+#endif
+
+
+#define __sysfs_ref__
+
+struct xen_sysfs_object;
+
+struct xen_sysfs_attr {
+       struct bin_attribute attr;
+       ssize_t (*show)(void *, char *) ;
+       ssize_t (*store)(void *, const char *, size_t) ;
+       ssize_t (*read)(void *, char *, loff_t, size_t );
+       ssize_t (*write)(void *, char *, loff_t, size_t) ;
+};
+
+
+/* flags bits */
+#define XEN_SYSFS_UNINITIALIZED 0x00
+#define XEN_SYSFS_CHAR_TYPE     0x01
+#define XEN_SYSFS_BIN_TYPE      0x02
+#define XEN_SYSFS_DIR_TYPE      0x04
+#define XEN_SYSFS_LINKED        0x08
+#define XEN_SYSFS_UNLINKED      0x10
+#define XEN_SYSFS_LINK_TYPE     0x11
+
+
+struct xen_sysfs_object {
+       struct list_head        list;
+       int                     flags;
+       struct kobject          kobj;
+       struct xen_sysfs_attr   attr;
+       char                    * path;
+       struct list_head        children;
+       struct xen_sysfs_object * parent;
+       atomic_t                refcount;
+       void                    * user_data;
+       void                   (*user_data_release)(void *);
+       void                   (*destroy)(struct xen_sysfs_object *);
+};
+
+
+static __sysfs_ref__  struct xen_sysfs_object *
+find_object(struct xen_sysfs_object * obj, const char * path);
+
+
+static __sysfs_ref__ struct xen_sysfs_object *
+new_sysfs_object(const char * path,
+                int type,
+                int mode,
+                ssize_t (*show)(void *, char *),
+                ssize_t (*store)(void *, const char *, size_t),
+                ssize_t (*read)(void *, char *, loff_t, size_t),
+                ssize_t (*write)(void *, char *, loff_t, size_t),
+                void * user_data,
+                void (* user_data_release)(void *)) ;
+
+static void destroy_sysfs_object(struct xen_sysfs_object * obj);
+static __sysfs_ref__ struct xen_sysfs_object * __find_parent(const char 
* path) ;
+static __sysfs_ref__ int __add_child(struct xen_sysfs_object *parent,
+                   struct xen_sysfs_object *child);
+static void remove_child(struct xen_sysfs_object *child);
+static void get_object(struct xen_sysfs_object *);
+static int put_object(struct xen_sysfs_object *,
+                    void (*)(struct xen_sysfs_object *));
+
+
+/* Is A == B ? */
+#define streq(a,b) (strcmp((a),(b)) == 0)
+
+/* Does A start with B ? */
+#define strstarts(a,b) (strncmp((a),(b),strlen(b)) == 0)
+
+
+#define __sysfs_ref__
+
+#define XEN_SYSFS_ATTR(_name, _mode, _show, _store) \
+       struct xen_sysfs_attr xen_sysfs_attr_##_name = __ATTR(_name, 
_mode, _show, _store)
+
+#define __XEN_KOBJ(_parent, _dentry, _ktype)   \
+       {                                       \
+               .k_name = NULL,                 \
+               .parent = _parent,              \
+               .dentry = _dentry,              \
+               .ktype = _ktype,                \
+       }
+
+static struct semaphore xen_sysfs_mut = __MUTEX_INITIALIZER(xen_sysfs_mut);
+static inline int
+sysfs_down(struct semaphore * mut)
+{
+       int err;
+       do {
+               err = down_interruptible(mut);
+       } while ( err && err == -EINTR );
+       return err;
+}
+
+#define sysfs_up(mut) up(mut)
+#define to_xen_attr(_attr) container_of(_attr, struct xen_sysfs_attr, 
attr.attr)
+#define to_xen_obj(_xen_attr) container_of(_xen_attr, struct 
xen_sysfs_object, attr)
+
+static ssize_t
+xen_sysfs_show(struct kobject * kobj, struct attribute * attr, char * buf)
+{
+       struct xen_sysfs_attr * xen_attr = to_xen_attr(attr);
+       struct xen_sysfs_object * xen_obj = to_xen_obj(xen_attr);
+       if(xen_attr->show)
+               return xen_attr->show(xen_obj->user_data, buf);
+       return 0;
+}
+
+static ssize_t
+xen_sysfs_store(struct kobject * kobj, struct attribute * attr,
+               const char *buf, size_t count)
+{
+       struct xen_sysfs_attr * xen_attr = to_xen_attr(attr);
+       struct xen_sysfs_object * xen_obj = to_xen_obj(xen_attr);
+       if(xen_attr->store)
+               return xen_attr->store(xen_obj->user_data, buf, count) ;
+       return 0;
+}
+
+#define to_xen_obj_bin(_kobj) container_of(_kobj, struct 
xen_sysfs_object, kobj)
+
+static ssize_t
+xen_sysfs_read(struct kobject *kobj, char * buf, loff_t offset, size_t 
size)
+{
+       struct xen_sysfs_object * xen_obj = to_xen_obj_bin(kobj);
+       if(xen_obj->attr.read)
+               return xen_obj->attr.read(xen_obj->user_data, buf, 
offset, size);
+       return 0;
+}
+
+
+static ssize_t
+xen_sysfs_write(struct kobject *kobj, char * buf, loff_t offset, size_t 
size)
+{
+       struct xen_sysfs_object * xen_obj = to_xen_obj_bin(kobj);
+       if (xen_obj->attr.write)
+               return xen_obj->attr.write(xen_obj->user_data, buf, 
offset, size);
+       if(size == 0 )
+               return PAGE_SIZE;
+
+       return size;
+}
+
+static struct sysfs_ops xen_sysfs_ops = {
+       .show = xen_sysfs_show,
+       .store = xen_sysfs_store,
+};
+
+static struct kobj_type xen_kobj_type = {
+       .release = NULL,
+       .sysfs_ops = &xen_sysfs_ops,
+       .default_attrs = NULL,
+};
+
+
+/* xen sysfs root entry */
+static struct xen_sysfs_object xen_root = {
+       .flags = 0,
+       .kobj = {
+               .k_name = NULL,
+               .parent = NULL,
+               .dentry = NULL,
+               .ktype = &xen_kobj_type,
+       },
+       .attr = {
+                .attr = {
+                        .attr = {
+                        .name = NULL,
+                        .mode = 0775,
+                         },
+
+                },
+                .show = NULL,
+                .store = NULL,
+                .read = NULL,
+                .write = NULL,
+        },
+       .path = __stringify(/sys/xen),
+       .list = LIST_HEAD_INIT(xen_root.list),
+       .children = LIST_HEAD_INIT(xen_root.children),
+       .parent = NULL,
+};
+
+/* xen sysfs path functions */
+
+static BOOL
+valid_chars(const char *path)
+{
+       if( ! strstarts(path, "/sys/xen") )
+               return FALSE;
+       if(strstr(path, "//"))
+               return FALSE;
+       return (strspn(path,
+                      "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+                      "abcdefghijklmnopqrstuvwxyz"
+                      "0123456789-/_@~$") == strlen(path));
+}
+
+
+/* return value must be kfree'd */
+static char *
+dup_path(const char *path)
+{
+       char * ret;
+       int len;
+       BUG_ON( ! path );
+
+       if( FALSE == valid_chars(path) ) {
+               return NULL;
+       }
+
+       len = strlen(path) + 1;
+       ret = kcalloc(len - 1, sizeof(char), GFP_KERNEL);
+       memcpy(ret, path, len);
+       return ret;
+}
+
+
+
+static char *
+basename(const char *name)
+{
+       return strrchr(name, '/') + 1;
+}
+
+static char *
+strip_trailing_slash(char * path)
+{
+       int len = strlen(path);
+
+       char * term = path + len - 1;
+       if( *term == '/')
+               *term = 0;
+       return path;
+}
+
+/* return value must be kfree'd */
+static char * dirname(const char * name)
+{
+       char *ret;
+       int len;
+
+       len = strlen(name) - strlen(basename(name)) + 1;
+       ret = kcalloc(len, sizeof(char), GFP_KERNEL);
+       memcpy(ret, name, len - 1);
+       ret = strip_trailing_slash(ret);
+
+       return ret;
+}
+
+
+/* type must be char, bin, or dir */
+static __sysfs_ref__ struct xen_sysfs_object *
+new_sysfs_object(const char * path,
+                int type,
+                int mode,
+                ssize_t (*show)(void *, char *),
+                ssize_t (*store)(void *, const char *, size_t),
+                ssize_t (*read)(void *, char *, loff_t, size_t),
+                ssize_t (*write)(void *, char *, loff_t, size_t),
+                void * user_data,
+                void (* user_data_release)(void *))
+{
+       struct xen_sysfs_object * ret =
+               (struct xen_sysfs_object *)kcalloc(sizeof(struct 
xen_sysfs_object),
+                                                  sizeof(char),
+                                                  GFP_KERNEL);
+       BUG_ON(ret == NULL);
+
+       ret->flags = type;
+       BUG_ON( (type & XEN_SYSFS_DIR_TYPE) && (show || store) );
+
+       if( NULL == (ret->path = dup_path(path)) ) {
+               kfree(ret);
+               return NULL;
+       }
+       kobject_set_name(&ret->kobj, basename(path));
+       kobject_init(&ret->kobj);
+       ret->attr.attr.attr.name = kobject_name(&ret->kobj);
+       ret->attr.attr.attr.owner = THIS_MODULE;
+       ret->attr.attr.attr.mode = mode;
+       ret->kobj.ktype = &xen_kobj_type;
+       if( type & XEN_SYSFS_CHAR_TYPE ) {
+               ret->attr.show = show;
+               ret->attr.store = store;
+       }
+       else if ( type & XEN_SYSFS_BIN_TYPE ) {
+               ret->attr.attr.size = PAGE_SIZE;
+               ret->attr.attr.read = xen_sysfs_read;
+               ret->attr.attr.write = xen_sysfs_write;
+               ret->attr.read = read;
+               ret->attr.write = write;
+       }
+       INIT_LIST_HEAD(&ret->list);
+       INIT_LIST_HEAD(&ret->children);
+       atomic_set(&ret->refcount, 1);
+       ret->destroy = destroy_sysfs_object;
+       return ret;
+}
+
+static void
+get_object(struct xen_sysfs_object *obj)
+{
+       BUG_ON( ! atomic_read(&obj->refcount) );
+       kobject_get(&obj->kobj);
+       atomic_inc(&obj->refcount);
+       return;
+}
+
+static int
+put_object(struct xen_sysfs_object *obj,
+                    void (*release)(struct xen_sysfs_object *))
+{
+       BUG_ON( ! release );
+       BUG_ON( release == (void (*)(struct xen_sysfs_object *))kfree);
+       kobject_put(&obj->kobj);
+       if(atomic_dec_and_test(&obj->refcount)) {
+               release(obj);
+               return 1;
+       }
+       return 0;
+}
+
+
+static void
+sysfs_release(struct xen_sysfs_object * obj)
+{
+       BUG_ON( ! (obj->flags & XEN_SYSFS_UNLINKED) );
+       BUG_ON( ! list_empty(&obj->children) );
+       BUG_ON( obj->parent ) ;
+
+       kobject_cleanup(&obj->kobj);
+       if(obj->attr.attr.attr.name)
+               kfree(obj->attr.attr.attr.name);
+       if(obj->user_data && obj->user_data_release )
+               obj->user_data_release(obj->user_data);
+       if( obj->path ) {
+               kfree(obj->path);
+               obj->path = NULL;
+       }
+       if (obj->destroy)
+               obj->destroy(obj);
+       return;
+}
+
+static void
+destroy_sysfs_object(struct xen_sysfs_object * obj)
+{
+       if(obj->path)
+               kfree(obj->path);
+       BUG_ON( ! list_empty(&obj->children) ) ;
+       BUG_ON ( obj->parent );
+       kfree(obj);
+       return;
+}
+
+
+/* refcounts object when returned */
+static __sysfs_ref__ struct xen_sysfs_object *
+find_object(struct xen_sysfs_object * obj, const char * path)
+{
+       struct list_head * tmp = NULL;
+       struct xen_sysfs_object *this_obj = NULL, * tmp_obj = NULL;
+
+       if(obj->flags & XEN_SYSFS_UNLINKED) {
+               return NULL;
+       }
+       if(! strcmp(obj->path, path) ) {
+               get_object(obj);
+                       return obj;
+       }
+       // if path is longer than obj-path, search children
+       if ( strstarts(path, obj->path) &&
+            strlen(path) > strlen(obj->path) &&
+            ! list_empty(&obj->children) ) {
+               list_for_each(tmp, (&obj->children)) {
+                       tmp_obj = list_entry(tmp, struct 
xen_sysfs_object, list);
+                       if( NULL !=  (this_obj = find_object(tmp_obj, 
path)) ) {
+                               return this_obj;
+                       }
+               }
+       }
+       return NULL;
+}
+
+/* parent is ref counted when returned */
+static __sysfs_ref__ struct xen_sysfs_object *
+__find_parent(const char * path)
+{
+       char * dir;
+       struct xen_sysfs_object * parent;
+
+       BUG_ON( ! path );
+       if ( ! valid_chars(path))
+               return NULL;
+       dir = dirname(path);
+       BUG_ON ( sysfs_down(&xen_sysfs_mut) );
+       parent = find_object(&xen_root, dir);
+
+       sysfs_up(&xen_sysfs_mut);
+       kfree(dir);
+
+       return parent;
+}
+
+static __sysfs_ref__ int
+__add_child(struct xen_sysfs_object *parent,
+                   struct xen_sysfs_object *child)
+{
+       int err = EINVAL;
+
+       BUG_ON ( sysfs_down(&xen_sysfs_mut) );
+       list_add_tail(&child->list, &parent->children);
+       child->kobj.parent = &parent->kobj;
+       child->kobj.dentry = parent->kobj.dentry;
+       if(child->flags & XEN_SYSFS_DIR_TYPE)
+               err = sysfs_create_dir(&child->kobj);
+       else if (child->flags & XEN_SYSFS_CHAR_TYPE)
+               err = sysfs_create_file(&child->kobj, 
&child->attr.attr.attr);
+       else if (child->flags & XEN_SYSFS_BIN_TYPE)
+               err = sysfs_create_bin_file(&child->kobj, 
&child->attr.attr);
+       child->flags |= XEN_SYSFS_LINKED;
+       child->flags &= ~XEN_SYSFS_UNLINKED;
+       child->parent = parent;
+       sysfs_up(&xen_sysfs_mut);
+       get_object(parent);
+       return err;
+}
+
+static void remove_child(struct xen_sysfs_object *child)
+{
+       struct list_head *children;
+       struct xen_sysfs_object *tmp_obj;
+
+       children = (&child->children)->next;
+       while( children != &child->children ) {
+               tmp_obj = list_entry(children, struct xen_sysfs_object, 
list );
+               remove_child(tmp_obj);
+               children = (&child->children)->next;
+       }
+       child->flags |= XEN_SYSFS_UNLINKED;
+       child->flags &= ~XEN_SYSFS_LINKED;
+       if(child->flags & XEN_SYSFS_DIR_TYPE)
+               sysfs_remove_dir(&child->kobj);
+       else if (child->flags & XEN_SYSFS_CHAR_TYPE)
+               sysfs_remove_file(&child->kobj, &child->attr.attr.attr);
+       else if (child->flags & XEN_SYSFS_BIN_TYPE)
+               sysfs_remove_bin_file(&child->kobj, &child->attr.attr);
+       list_del(&child->list);
+       put_object(child->parent, sysfs_release);
+       child->parent = NULL;
+       put_object(child, sysfs_release);
+       return;
+}
+
+
+
+
+int
+xen_sysfs_create_dir(const char * path, int mode)
+{
+       struct xen_sysfs_object * child, * parent;
+       int err;
+
+       if(path == NULL)
+               return -EINVAL;
+       if ( NULL == (parent = __find_parent(path)) )
+               return -EBADF;
+       if( NULL == (child = new_sysfs_object(path, XEN_SYSFS_DIR_TYPE,
+                                           mode, NULL,NULL, NULL,
+                                             NULL, NULL,NULL))) {
+               put_object(parent, sysfs_release);
+               return -ENOMEM;
+       }
+       err = __add_child(parent, child);
+       put_object(parent, sysfs_release);
+
+       return -err;
+}
+
+int
+xen_sysfs_remove_dir(const char* path, BOOL recursive)
+{
+       __label__ mut;
+       __label__ ref;
+       int err = 0;
+       struct xen_sysfs_object * dir;
+
+       if(path == NULL)
+               return -EINVAL;
+       BUG_ON(sysfs_down(&xen_sysfs_mut));
+       if(NULL == (dir = find_object(&xen_root, path))) {
+               err =  -EBADF;
+               goto mut;
+       }
+       if(FALSE == recursive && ! list_empty(&dir->children) ) {
+               err =  -EBUSY;
+               goto ref;
+       }
+       remove_child(dir);
+ref:
+       put_object(dir, sysfs_release);
+mut:
+       sysfs_up(&xen_sysfs_mut);
+       return err;
+}
+
+
+
+int
+xen_sysfs_create_file(const char * path,
+                     int mode,
+                     ssize_t (*show)(void *, char *),
+                     ssize_t (*store)(void *, const char *, size_t),
+                     void * private_data,
+                     void (*private_data_release)(void *))
+{
+
+       struct xen_sysfs_object *parent, * file;
+       int err;
+
+       if(path == NULL || FALSE == valid_chars(path))
+               return -EINVAL;
+       if(NULL == ( parent = __find_parent(path)) )
+               return -EBADF;
+
+       if( NULL == ( file = new_sysfs_object(path,
+                                             XEN_SYSFS_CHAR_TYPE,
+                                             mode,
+                                             show,
+                                             store,
+                                             NULL,
+                                             NULL,
+                                             private_data,
+                                             private_data_release)))
+               return -ENOMEM;
+
+       err = __add_child(parent, file);
+       put_object(parent, sysfs_release);
+       return err;
+}
+
+
+int
+xen_sysfs_update_file(const char * path)
+{
+       __label__ mut;
+       int err;
+       struct xen_sysfs_object * obj;
+
+       if(path == NULL || FALSE == valid_chars(path))
+               return -EINVAL;
+       sysfs_down(&xen_sysfs_mut);
+
+       if(NULL == (obj = find_object(&xen_root, path))) {
+               err = -EBADF;
+               goto mut;
+       }
+
+       err = sysfs_update_file(&obj->kobj, &obj->attr.attr.attr);
+       put_object(obj, sysfs_release);
+mut:
+       sysfs_up(&xen_sysfs_mut);
+       return err;
+}
+
+
+int
+xen_sysfs_remove_file(const char* path)
+{
+       __label__ mut;
+       int err = 0;
+       struct xen_sysfs_object * file;
+
+       if(path == NULL)
+               return -EINVAL;
+       BUG_ON(sysfs_down(&xen_sysfs_mut));
+       if(NULL == (file = find_object(&xen_root, path))) {
+               err =  -EBADF;
+               goto mut;
+       }
+       remove_child(file);
+       put_object(file, sysfs_release);
+mut:
+       sysfs_up(&xen_sysfs_mut);
+       return err;
+}
+
+int
+xen_sysfs_create_bin_file(const char * path,
+                         int mode,
+                         ssize_t (*read) (void *, char *, loff_t, size_t),
+                         ssize_t (*write) (void *, char *, loff_t, 
size_t),
+                         void * private_data,
+                         void (*private_data_release)(void *))
+{
+
+       struct xen_sysfs_object *parent, * file;
+       int err;
+
+       if(path == NULL || FALSE == valid_chars(path))
+               return -EINVAL;
+       if(NULL == ( parent = __find_parent(path)) )
+               return -EBADF;
+
+       if( NULL == ( file = new_sysfs_object(path,
+                                             XEN_SYSFS_BIN_TYPE,
+                                             mode,
+                                             NULL,
+                                             NULL,
+                                             read,
+                                             write,
+                                             private_data,
+                                             private_data_release)))
+               return -ENOMEM;
+
+       err = __add_child(parent, file);
+       put_object(parent, sysfs_release);
+       return err;
+}
+
+int __init
+xen_sysfs_init(void)
+{
+       kobject_init(&xen_root.kobj);
+       kobject_set_name(&xen_root.kobj, "xen");
+       atomic_set(&xen_root.refcount, 1);
+       return sysfs_create_dir(&xen_root.kobj);
+}
+
+arch_initcall(xen_sysfs_init);
+
+EXPORT_SYMBOL(xen_sysfs_create_dir);
+EXPORT_SYMBOL(xen_sysfs_remove_dir);
+EXPORT_SYMBOL(xen_sysfs_create_file);
+EXPORT_SYMBOL(xen_sysfs_update_file);
+EXPORT_SYMBOL(xen_sysfs_remove_file);
+
+
diff -r ed7888c838ad -r f6e4c20a786b 
linux-2.6-xen-sparse/arch/xen/kernel/xen_sysfs_version.c
--- /dev/null   Tue Jan 10 17:53:44 2006
+++ b/linux-2.6-xen-sparse/arch/xen/kernel/xen_sysfs_version.c  Tue Jan 
10 23:30:37 2006
@@ -0,0 +1,60 @@
+/*
+    copyright (c) 2006 IBM Corporation
+    Mike Day <ncmike@us.ibm.com>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 
02111-1307  USA
+*/
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <asm/page.h>
+#include <asm-xen/xen-public/version.h>
+#include <asm-xen/xen-public/dom0_ops.h>
+#include <asm-xen/asm/hypercall.h>
+#include <asm-xen/xen_sysfs.h>
+
+extern int HYPERVISOR_xen_version(int, void*);
+
+
+static ssize_t xen_version_show(void *data, char *page)
+{
+       long version;
+       long major, minor;
+       static xen_extraversion_t extra_version;
+
+       version = HYPERVISOR_xen_version(XENVER_version, NULL);
+       major = version >> 16;
+       minor = version & 0xff;
+
+       HYPERVISOR_xen_version(XENVER_extraversion, extra_version);
+       return snprintf(page, PAGE_SIZE, "xen-%ld.%ld%s\n", major, 
minor, extra_version);
+}
+
+
+
+int __init
+sysfs_xen_version_init(void)
+{
+       return xen_sysfs_create_file("/sys/xen/version",
+                                    0444,
+                                    xen_version_show,
+                                    NULL,
+                                    NULL,
+                                    NULL);
+}
+
+device_initcall(sysfs_xen_version_init);
diff -r ed7888c838ad -r f6e4c20a786b 
linux-2.6-xen-sparse/include/asm-xen/xen_sysfs.h
--- /dev/null   Tue Jan 10 17:53:44 2006
+++ b/linux-2.6-xen-sparse/include/asm-xen/xen_sysfs.h  Tue Jan 10 
23:30:37 2006
@@ -0,0 +1,88 @@
+/*
+    copyright (c) 2006 IBM Corporation
+    Mike Day <ncmike@us.ibm.com>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 
02111-1307  USA
+*/
+
+
+#include <asm/page.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/string.h>
+
+
+
+#ifndef _XEN_SYSFS_H_
+#define _XEN_SYSFS_H_
+
+#ifdef __KERNEL__
+
+#ifndef BOOL
+#define BOOL    int
+#endif
+
+#ifndef FALSE
+#define FALSE   0
+#endif
+
+#ifndef TRUE
+#define TRUE    1
+#endif
+
+#ifndef NULL
+#define NULL    0
+#endif
+
+
+extern int
+xen_sysfs_create_dir(const char * path, int mode);
+
+extern int
+xen_sysfs_remove_dir(const char * path, BOOL recursive);
+
+extern int
+xen_sysfs_create_file(const char * path,
+                     int mode,
+                     ssize_t (*show)(void * user_data, char * buf),
+                     ssize_t (*store)(void * user_data,
+                                      const char * buf,
+                                      size_t length),
+                     void * private_data,
+                     void (*private_data_release)(void *));
+
+extern int
+xen_sysfs_update_file(const char * path);
+
+extern int
+xen_sysfs_remove_file(const char * path);
+
+
+int xen_sysfs_create_bin_file(const char * path,
+                             int mode,
+                             ssize_t (*read)(void * user_data,
+                                             char * buf,
+                                             loff_t offset,
+                                             size_t length),
+                             ssize_t (*write)(void * user_data,
+                                              char *buf,
+                                              loff_t offset,
+                                              size_t length),
+                             void * private_data,
+                             void (*private_data_release)(void *));
+int xen_sysfs_remove_bin_file(const char * path);
+
+#endif /* __KERNEL__ */
+#endif /* _XEN_SYSFS_H_ */
[mdday@silverwood xen-sysfs.hg]$


-- 

Mike D. Day
STSM and Architect, Open Virtualization
IBM Linux Technology Center
ncmike@us.ibm.com
