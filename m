Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWA1Ci0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWA1Ci0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWA1Ci0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:38:26 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:59835
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S964788AbWA1CiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:38:25 -0500
Date: Fri, 27 Jan 2006 18:38:28 -0800
From: Greg KH <greg@kroah.com>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: xen-devel@lists.xensource.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.12.6-xen] sysfs attributes for xen
Message-ID: <20060128023828.GA20881@kroah.com>
References: <43DAD4DB.4090708@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DAD4DB.4090708@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> linux-2.6-xen-sparse/arch/xen/kernel/xen_sysfs.c
> --- /dev/null	Fri Jan 27 11:48:32 2006
> +++ b/linux-2.6-xen-sparse/arch/xen/kernel/xen_sysfs.c	Fri Jan 27 14:28:42 
> 2006
> @@ -0,0 +1,73 @@
> +/* 
> +    copyright (c) 2006 IBM Corporation 
> +    Mike Day <ncmike@us.ibm.com>

Wrong copyright notice as per the IBM lawyers :)

> +
> +    This program is free software; you can redistribute it and/or modify
> +    it under the terms of the GNU General Public License as published by
> +    the Free Software Foundation; either version 2 of the License, or
> +    (at your option) any later version.

Are you sure about the version 2 or later?

> +
> +    This program is distributed in the hope that it will be useful,
> +    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +    GNU General Public License for more details.
> +
> +    You should have received a copy of the GNU General Public License
> +    along with this program; if not, write to the Free Software
> +    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  
> USA

These two paragraphs are not needed.

> +*/
> +
> +
> +
> +#include <linux/config.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/kobject.h>
> +#include <linux/sysfs.h>
> +
> +#include <asm-xen/xen_sysfs.h>
> +
> +
> +static struct subsystem hypervisor_subsys = {
> +	.kset = {
> +		.kobj = {
> +			 .name = "hypervisor",
> +		 },
> +	},
> +};

No, use the proper macros that define this for you.

> +
> +static struct kset xen_kset = {
> +
> +	.kobj = {
> +		.name = "xen",
> +	},
> +};

Why are you createing a xen kset?  You should not have to do this.

> +
> +struct subsystem * 
> +get_hyper_subsys(void) 
> +{
> +	return &hypervisor_subsys;
> +}

What does this do?  Just make the hypervisor subsystem structure global
like the rest of the kernel's subsystems are that need this.

> +
> +
> +struct kset *
> +get_xen_kset(void)
> +{
> +	return &xen_kset;
> +}

Again, not needed.

> +
> +int __init
> +hyper_sysfs_init(void)
> +{
> +	int err ;
> +	
> +	if( 0 ==  (err = subsystem_register(&hypervisor_subsys)) ) {
> +		xen_kset.subsys = &hypervisor_subsys;
> +		err = kset_register(&xen_kset);
> +	}

Is this the xen coding style?  If so, it's got to change before making
it into mainline...  Please fix this up.

Also, don't use a xen kset.  Make it a subsystem.  Life is much easier
that way.

> +/* xen version info */
> +static ssize_t xen_version_show(struct kobject * kobj, 
> +				struct attribute * attr, 
> +				char *page)

Trailing spaces here, and in a lot of other places in your patch.
Please clean them up (there are automatic tools that do this for you...)

> +{
> +	long version;
> +	long major, minor;
> +	char extra_version[16];
> +	
> +	if ( (version = HYPERVISOR_xen_version(XENVER_version, NULL)) ) {

Do not do assignments within if statments.  It's generally considered bad
form.  Also the spacing is wrong, but I know you will fix that up for
the rest of the patch too, so I'll just not mention it in every place.

> +		
> +		major = version >> 16;
> +		minor = version & 0xff;
> +		if( ! HYPERVISOR_xen_version(XENVER_extraversion, 
> +					    extra_version) ) {
> +			page[PAGE_SIZE - 1] = 0x00;

Not needed.

> +			return snprintf(page, PAGE_SIZE - 1, 
> +					"xen-%ld.%ld%s\n",
> +					major, minor, extra_version);
> +		}
> +	}
> +	return 0;

Why not return an error number if this isn't successful?

> +}
> +
> +static struct xen_attr xen_ver_attr = {
> +	.attr = {
> +		.name = "version", 
> +		.mode = 0444, 
> +		.owner = THIS_MODULE, 
> +	},
> +	.show = xen_version_show,
> +};

Please use the proper macros to create these, do NOT do it by hand.

> +
> +static struct kobject xen_ver_obj = {
> +	.name = "version",
> +};

Wow, a static kobject.  Hint, not a good thing to do for a dynamic
thing.  This is not how you create a new attribute.

> +
> +/* xen compile info */
> +static ssize_t xen_compile_show(struct kobject * kobj, 
> +				struct attribute * attr, 
> +				char * page)
> +{
> +	struct xen_compile_info info;
> +	
> +	if( 0 == HYPERVISOR_xen_version(XENVER_compile_info, &info) ) {
> +		page[PAGE_SIZE - 1] = 0x00;

I'll not point this out again...

> +		return snprintf(page, PAGE_SIZE - 1, 
> +				"compiled by %s, using %s, on %s\n", 
> +				info.compile_by, 
> +				info.compile_date, 
> +				info.compiler);
> +	}
> +	return 0;

Nor this...

> +static struct xen_attr xen_compile_attr = {
> +	.attr = {
> +		.name = "compilation", 
> +		.mode = 0444, 
> +		.owner = THIS_MODULE, 
> +	},
> +	.show = xen_compile_show,
> +};

Nor this...

> +static struct kobject xen_compile_obj = {
> +	.name = "compilation",
> +};

Or this...

> linux-2.6-xen-sparse/include/asm-xen/xen_sysfs.h
> --- /dev/null	Fri Jan 27 11:48:32 2006
> +++ b/linux-2.6-xen-sparse/include/asm-xen/xen_sysfs.h	Fri Jan 27 14:28:42 
> 2006
> @@ -0,0 +1,45 @@
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
> +    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  
> USA
> +*/
> +
> +
> +
> +#ifndef _XEN_SYSFS_H_
> +#define _XEN_SYSFS_H_
> +
> +#ifdef __KERNEL__ 

Is this really needed?  Would an userspace program ever need this?

> +
> +#include <linux/kobject.h>
> +#include <linux/sysfs.h>
> +#include <linux/module.h>

Not needed for this header file

> +#include <asm-xen/asm/hypercall.h>
> +#include <asm-xen/xen-public/version.h>

Nor these.

> +struct xen_attr {
> +	struct attribute attr;
> +	ssize_t (*show)(struct kobject *, struct attribute *, char *);
> +	ssize_t (*store)(struct kobject *, struct attribute *, char *);
> +};
> +
> +extern int HYPERVISOR_xen_version(int, void*);

Shouldn't this be declared somewhere else?

> +extern struct subsystem * get_hyper_subsys(void);
> +extern struct kset * get_xen_kset(void);

Not needed at all.

Hm, is this file even needed?

thanks,

greg k-h
