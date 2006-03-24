Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWCXVnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWCXVnP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 16:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWCXVnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 16:43:15 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:51854
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751441AbWCXVnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 16:43:14 -0500
Date: Fri, 24 Mar 2006 13:42:46 -0800
From: Greg KH <gregkh@suse.de>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-rc6-xen] export Xen Hypervisor attributes to sysfs
Message-ID: <20060324214246.GE4646@suse.de>
References: <200603202335.k2KNZEjo005673@mdday.raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603202335.k2KNZEjo005673@mdday.raleigh.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 06:35:14PM -0500, Mike D. Day wrote:
> Creates a module that exports Xen Hypervisor attributes to sysfs. The
> module has a tri-state configuration so it can be a loadable module.
> 
> Views the hypervisor as hardware device, uses sysfs as  a scripting
> interface for user space tools that need these attributes.
> 
> Some user space apps, particularly for systems management, need to
> know if their kernel is running in a virtual machine and if so in
> what type of virtual machine. This property is contained in the
> file /sys/hypervisor/type.
> 
> The file hypervisor_sysfs.c creates a generic  hypervisor subsystem
> that can be linked to by any hypervisor. The file xen_sysfs.c exports
> the xen-specific attributes.

Why put the file hypervisor_sysfs.c in a xen specific directory then if
you expect to share it with all hypervisors?

Also, if you want to make this generic and force everyone to have the
same public interface (a good idea), you need to make callbacks to this
file to provide the needed information, don't just create whatever file
you want in the xen specific file.  Otherwise it is guaranteed that we
will not have a uniform interface.

> signed-off-by: Mike D. Day <ncmike@us.ibm.com>
> 
> ---
> Initial directory = /sys/hypervisor
> +---compilation
> |   >---compile_date
> |   >---compiled_by
> |   >---compiler
> +---properties
> |   >---capabilities
> |   >---changeset
> |   >---virtual_start
> |   >---writable_pt
> >---type
> +---version
> |   >---extra
> |   >---major
> |   >---minor

Hint, 'tree' shows things a bit nicer :)

> 
> Some examples: 
> [mdday@athlon64 ~]$ cat /sys/hypervisor/type
> xen
> 
> [mdday@athlon64 ~]$ cat /sys/hypervisor/version/major
> 3
> 
> [mdday@athlon64 ~]$ cat /sys/hypervisor/properties/changeset
> Sun Mar 19 09:17:50 2006 +0100 9322:768936b2800a

That seems crazy to export, but hey, if you really think it's useful
(and what are you going to do when it becomes a git changeset, not a hg
one?)

> diff -r a8b1d4fad72d -r 508bf03c36ab linux-2.6-xen-sparse/drivers/xen/Kconfig
> --- a/linux-2.6-xen-sparse/drivers/xen/Kconfig	Mon Mar 20 12:01:32 2006 +0100
> +++ b/linux-2.6-xen-sparse/drivers/xen/Kconfig	Mon Mar 20 18:06:53 2006 -0500
> @@ -189,6 +189,14 @@ config XEN_DISABLE_SERIAL
>  	  Disable serial port drivers, allowing the Xen console driver
>  	  to provide a serial console at ttyS0.
>  
> +config XEN_SYSFS
> +	tristate "Export Xen attributes in sysfs"
> +	depends on XEN
> +	depends on SYSFS
> +	default y
> +	help
> +		Xen hypervisor attributes will show up under /sys/hypervisor/.
> +

You told Arjan that it is different depending on which type of kernel
you are running.  This config option does not show it.

Also, you don't need to depend on SYSFS, your code should build just
fine without that option enabled (it will not do anything, but that's a
different story...)  If not, please let me know.

>  config HAVE_ARCH_ALLOC_SKB
> diff -r a8b1d4fad72d -r 508bf03c36ab linux-2.6-xen-sparse/drivers/xen/core/Makefile
> --- a/linux-2.6-xen-sparse/drivers/xen/core/Makefile	Mon Mar 20 12:01:32 2006 +0100
> +++ b/linux-2.6-xen-sparse/drivers/xen/core/Makefile	Mon Mar 20 18:06:53 2006 -0500
> @@ -7,3 +7,5 @@ obj-$(CONFIG_PROC_FS) += xen_proc.o
>  obj-$(CONFIG_PROC_FS) += xen_proc.o
>  obj-$(CONFIG_NET)     += skbuff.o
>  obj-$(CONFIG_SMP)     += smpboot.o
> +obj-$(CONFIG_SYSFS)   += hypervisor_sysfs.o

Again, no, you don't need to depend on CONFIG_SYSFS

> +obj-$(CONFIG_XEN_SYSFS) += xen_sysfs.o
> diff -r a8b1d4fad72d -r 508bf03c36ab linux-2.6-xen-sparse/drivers/xen/core/hypervisor_sysfs.c
> --- /dev/null	Thu Jan  1 00:00:00 1970 +0000
> +++ b/linux-2.6-xen-sparse/drivers/xen/core/hypervisor_sysfs.c	Mon Mar 20 18:06:53 2006 -0500
> @@ -0,0 +1,58 @@
> +/*
> +    copyright (c) 2006 IBM Corporation
> +    Authored by: Mike D. Day <ncmike@us.ibm.com>
> +
> +    This program is free software; you can redistribute it and/or modify
> +    it under the terms of the GNU General Public License version 2 as
> +    published by the Free Software Foundation.
> +*/
> +
> +
> +#include <linux/config.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/kobject.h>
> +#include <xen/hypervisor_sysfs.h>

Why a xen specific file in a "generic" file?  That will break the build
for sure...

I don't think it's even needed here, do you?

> diff -r a8b1d4fad72d -r 508bf03c36ab linux-2.6-xen-sparse/include/xen/hypervisor_sysfs.h
> --- /dev/null	Thu Jan  1 00:00:00 1970 +0000
> +++ b/linux-2.6-xen-sparse/include/xen/hypervisor_sysfs.h	Mon Mar 20 18:06:53 2006 -0500
> @@ -0,0 +1,34 @@
> +/*
> +    copyright (c) 2006 IBM Corporation
> +    Authored by: Mike D. Day <ncmike@us.ibm.com>
> +
> +    This program is free software; you can redistribute it and/or modify
> +    it under the terms of the GNU General Public License version 2 as
> +    published by the Free Software Foundation.
> +*/
> +
> +
> +
> +#ifndef _HYP_SYSFS_H_
> +#define _HYP_SYSFS_H_
> +
> +#include <linux/kobject.h>
> +#include <linux/sysfs.h>
> +
> +#define HYPERVISOR_ATTR_RO(_name) \
> +static struct hyp_sysfs_attr  _name##_attr = __ATTR_RO(_name)
> +
> +#define HYPERVISOR_ATTR_RW(_name) \
> +static struct hyp_sysfs_attr _name##_attr = \
> +	__ATTR(_name, 0644, _name##_show, _name##_store)
> +
> +extern struct subsystem hypervisor_subsys;
> +
> +struct hyp_sysfs_attr {
> +	struct attribute attr;
> +	ssize_t (*show)(struct hyp_sysfs_attr *, char *);
> +	ssize_t (*store)(struct hyp_sysfs_attr *, const char *, size_t);
> +	void *hyp_attr_data;
> +};
> +
> +#endif /* _HYP_SYSFS_H_ */

Why is a .h file needed for this?

Is someone else going to include it?  I can see exporting the
hypervisor_subsys variable, but again, that better not be in a xen
specific file...

But those #defines and structure are not needed here.

thanks,

greg k-h
