Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWAKR4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWAKR4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 12:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWAKR4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 12:56:49 -0500
Received: from hera.kernel.org ([140.211.167.34]:51165 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932410AbWAKR4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 12:56:48 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
Date: Wed, 11 Jan 2006 09:56:38 -0800
Organization: OSDL
Message-ID: <20060111095638.7a059485@dxpl.pdx.osdl.net>
References: <43C53DA0.60704@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1137002199 18729 10.8.0.74 (11 Jan 2006 17:56:39 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 11 Jan 2006 17:56:39 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You probably want to submit Xen as a complete patch set. Rather
than asking kernel to accept pieces of infrastructure. But
also expect the the infrastructure changes like this to be more
carefully reviewed and alternatives recommended.


On Wed, 11 Jan 2006 12:17:20 -0500
"Mike D. Day" <ncmike@us.ibm.com> wrote:

> The included patch provides some sysfs helper routines so that xen 
> domain kernel processes can easily attributes to sysfs. The intent is 
> that any kernel process can add an attribute under /sys/xen just as 
> easily as adding a file under /proc. In other words, without using the 
> driver core to create a subsystem, dealing with kobjects and ksets, etc.
> 
> One example adds xen version info under /sys/xen/version
> 
> The comments desired are (1) do the helper routines in xen_sysfs 
> duplicate code already present in linux (or under development somewhere 
> else). (2) Is it appropriate for a process to create sysfs attributes 
> without implementing a driver subsystem or (3) are such attributes 
> better off living under /proc. (4) any other feedback is appreciated.
> 

Debugfs? Configfs?

> # HG changeset patch
> # User mdday@mdday.raleigh.ibm.com
> # Node ID f6e4c20a786b9322843fb46a45f7796fc6a33b44
> # Parent  ed7888c838ad5cd213a24d21ae294b31a2500f4d
> Export Xen information to sysfs Allow xen domain kernel to add xen
> data to /sys/xen without also requiring creation of driver subsystems.
> 
> As an example, add xen version by creating /sys/xen/version
> 
> signed-off-by Mike Day <ncmike@us.ibm.com>
> 
> diff -r ed7888c838ad -r f6e4c20a786b 
> linux-2.6-xen-sparse/arch/xen/kernel/Makefile
> --- a/linux-2.6-xen-sparse/arch/xen/kernel/Makefile     Tue Jan 10 
> 17:53:44 2006
> +++ b/linux-2.6-xen-sparse/arch/xen/kernel/Makefile     Tue Jan 10 
> 23:30:37 2006
> @@ -16,3 +16,4 @@
>   obj-$(CONFIG_PROC_FS) += xen_proc.o
>   obj-$(CONFIG_NET)     += skbuff.o
>   obj-$(CONFIG_SMP)     += smpboot.o
> +obj-$(CONFIG_SYSFS)   += xen_sysfs.o xen_sysfs_version.o
> diff -r ed7888c838ad -r f6e4c20a786b 
> linux-2.6-xen-sparse/arch/xen/kernel/xen_sysfs.c
> --- /dev/null   Tue Jan 10 17:53:44 2006
> +++ b/linux-2.6-xen-sparse/arch/xen/kernel/xen_sysfs.c  Tue Jan 10 
> 23:30:37 2006
> @@ -0,0 +1,694 @@
> +/*
> +    copyright (c) 2006 IBM Corporation
> +    Mike Day <ncmike@us.ibm.com>
> +
> +    This program is free software; you can redistribute it and/or modify
> +    it under the terms of the GNU General Public License as published by
> +    the Free Software Foundation; either version 2 of the License, or
> +    (at your option) any later version.
> +
> +    This program is distributed in the hope that it will be useful,
> +    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +    GNU General Public License for more details.
> +
> +    You should have received a copy of the GNU General Public License
> +    along with this program; if not, write to the Free Software
> +    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 
> 02111-1307  USA
> +*/
> +
> +
> +#include <linux/config.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/kobject.h>
> +#include <linux/sysfs.h>
> +#include <linux/module.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <asm/atomic.h>
> +#include <asm/semaphore.h>
> +#include <asm-generic/bug.h>
> +
> +#ifdef DEBUG
> +#define DPRINTK(fmt, args...)   printk(KERN_DEBUG "xen_sysfs: ",  fmt, 
> ## args)
> +#else
> +#define DPRINTK(fmt, args...)
> +#endif
> +
> +#ifndef BOOL
> +#define BOOL    int
> +#endif
> +
> +#ifndef FALSE
> +#define FALSE   0
> +#endif
> +
> +#ifndef TRUE
> +#define TRUE    1
> +#endif
> +
> +#ifndef NULL
> +#define NULL    0
> +#endif

Yuck, not Linux Coding Style...

> +
> +#define __sysfs_ref__

Why?

> +
> +struct xen_sysfs_object;
> +
> +struct xen_sysfs_attr {
> +       struct bin_attribute attr;
> +       ssize_t (*show)(void *, char *) ;
> +       ssize_t (*store)(void *, const char *, size_t) ;
> +       ssize_t (*read)(void *, char *, loff_t, size_t );
> +       ssize_t (*write)(void *, char *, loff_t, size_t) ;
> +};
> +
> +
> +/* flags bits */
> +#define XEN_SYSFS_UNINITIALIZED 0x00
> +#define XEN_SYSFS_CHAR_TYPE     0x01
> +#define XEN_SYSFS_BIN_TYPE      0x02
> +#define XEN_SYSFS_DIR_TYPE      0x04
> +#define XEN_SYSFS_LINKED        0x08
> +#define XEN_SYSFS_UNLINKED      0x10
> +#define XEN_SYSFS_LINK_TYPE     0x11
> +
> +
> +struct xen_sysfs_object {
> +       struct list_head        list;
> +       int                     flags;
> +       struct kobject          kobj;
> +       struct xen_sysfs_attr   attr;
> +       char                    * path;
> +       struct list_head        children;
> +       struct xen_sysfs_object * parent;
> +       atomic_t                refcount;
> +       void                    * user_data;
> +       void                   (*user_data_release)(void *);
> +       void                   (*destroy)(struct xen_sysfs_object *);
> +};
> +
> +
> +static __sysfs_ref__  struct xen_sysfs_object *
> +find_object(struct xen_sysfs_object * obj, const char * path);
> +
> +
> +static __sysfs_ref__ struct xen_sysfs_object *
> +new_sysfs_object(const char * path,
> +                int type,
> +                int mode,
> +                ssize_t (*show)(void *, char *),
> +                ssize_t (*store)(void *, const char *, size_t),
> +                ssize_t (*read)(void *, char *, loff_t, size_t),
> +                ssize_t (*write)(void *, char *, loff_t, size_t),
> +                void * user_data,
> +                void (* user_data_release)(void *)) ;
> +
> +static void destroy_sysfs_object(struct xen_sysfs_object * obj);
> +static __sysfs_ref__ struct xen_sysfs_object * __find_parent(const char 
> * path) ;
> +static __sysfs_ref__ int __add_child(struct xen_sysfs_object *parent,
> +                   struct xen_sysfs_object *child);
> +static void remove_child(struct xen_sysfs_object *child);
> +static void get_object(struct xen_sysfs_object *);
> +static int put_object(struct xen_sysfs_object *,
> +                    void (*)(struct xen_sysfs_object *));
> +
> +
> +/* Is A == B ? */
> +#define streq(a,b) (strcmp((a),(b)) == 0)

More non-linux coding style...

> +/* Does A start with B ? */
> +#define strstarts(a,b) (strncmp((a),(b),strlen(b)) == 0)
> +
> +
> +#define __sysfs_ref__
> +
> +#define XEN_SYSFS_ATTR(_name, _mode, _show, _store) \
> +       struct xen_sysfs_attr xen_sysfs_attr_##_name = __ATTR(_name, 
> _mode, _show, _store)
> +
> +#define __XEN_KOBJ(_parent, _dentry, _ktype)   \
> +       {                                       \
> +               .k_name = NULL,                 \
> +               .parent = _parent,              \
> +               .dentry = _dentry,              \
> +               .ktype = _ktype,                \
> +       }
> +
> +static struct semaphore xen_sysfs_mut = __MUTEX_INITIALIZER(xen_sysfs_mut);
> +static inline int
> +sysfs_down(struct semaphore * mut)
> +{
> +       int err;
> +       do {
> +               err = down_interruptible(mut);
> +       } while ( err && err == -EINTR );
> +       return err;
> +}

Wrapping mutex is not a bad idea on several levels.



-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
