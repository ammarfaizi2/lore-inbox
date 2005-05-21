Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVEUGSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVEUGSK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 02:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVEUGRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 02:17:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:17287 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261675AbVEUGQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 02:16:03 -0400
Date: Fri, 20 May 2005 23:22:51 -0700
From: Greg KH <greg@kroah.com>
To: Reiner Sailer <sailer@watson.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@mail.wirex.com,
       kylene@us.ibm.com, emilyr@us.ibm.com, toml@us.ibm.com
Subject: Re: [PATCH 3 of 4] ima: Linux Security Module implementation
Message-ID: <20050521062251.GC24597@kroah.com>
References: <1116596614.8156.11.camel@secureip.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116596614.8156.11.camel@secureip.watson.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 09:43:34AM -0400, Reiner Sailer wrote:
> diff -uprN linux-2.6.12-rc4/security/ima/ima_sysfs.c linux-2.6.12-rc4-ima/security/ima/ima_sysfs.c
> --- linux-2.6.12-rc4/security/ima/ima_sysfs.c	1969-12-31 19:00:00.000000000 -0500
> +++ linux-2.6.12-rc4-ima/security/ima/ima_sysfs.c	2005-05-19 17:59:20.000000000 -0400
> @@ -0,0 +1,150 @@
> +/*
> + * Copyright (C) 2005 IBM Corporation
> + *
> + * Authors:
> + * Reiner Sailer <sailer@watson.ibm.com>
> + *
> + * Maintained by: TBD

Who is going to maintain this?  That needs to be answered before we can
even consider accepting this code.

> + * LSM IBM Integrity Measurement Architecture.		  
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation, version 2 of the
> + * License.
> + *
> + * File: ima_sysfs.c
> + *             sysfs interface to request measurements
> + *             through instrumented user applications
> + */
> +#include <linux/config.h>
> +#include <linux/module.h>
> +#include <linux/fs.h>
> +#include <linux/file.h>
> +#include <linux/init.h>
> +#include <linux/spinlock.h>
> +#include <linux/kmod.h>
> +#include <linux/kobj_map.h>

Why do you need this .h file?


> +#include <linux/sysfs.h>
> +#include "ima.h"
> +
> +static struct subsystem security_subsys;
> +
> +atomic_t global_count_sysfs;
> +atomic_t global_count_sysfs_measure;

bad bad bad global variable names.  Who initializes these atomic values?

> +
> +int measure_file_exec(struct file *, const struct measure_request *);

Lousy global function name.  And it should be in a header file
somewhere, right?

> +
> +static ssize_t security_attr_show(struct kobject *kobj,
> +				  struct attribute *attr, char *page)
> +{
> +	/* get security attribute */
> +	struct subsys_attribute *security_attr =
> +	    container_of(attr, struct subsys_attribute, attr);
> +
> +	if (security_attr->show)
> +		security_attr->show(&security_subsys, page);

Why does your show attribute not return the proper amount?

> +	else
> +		ima_error("Attr method >show< not defined.\n");
> +
> +	return (ssize_t) 0;
> +}

No, return the value of the show function.

> +static ssize_t security_attr_store(struct kobject *kobj,struct attribute *attr,
> +				   const char *page, size_t count)
> +{
> +	/* get security attribute */
> +	struct subsys_attribute *security_attr =
> +	    container_of(attr, struct subsys_attribute, attr);
> +	if (security_attr->store)
> +		security_attr->store(&security_subsys, page, count);
> +	else
> +		ima_error("Attr method >store< not defined.\n");
> +
> +	return (ssize_t) count;
> +}

Same issue here as above with the show attribute.

> +static struct sysfs_ops security_sysfs_ops = {
> +	.show = &security_attr_show,
> +	.store = &security_attr_store,
> +};
> +
> +static ssize_t measurements_read(struct subsystem *sub, char *page)
> +{
> +	char *msg = "Hi There! Read is not supported :-)\n";
> +	strncpy(page, msg, PAGE_SIZE);
> +	return (strlen(msg));
> +}

No, just don't provide a read function, and set the mode properly, and
you will not need this at all.


> +static ssize_t measurement_store(struct subsystem *sub, const char *page,
> +				 size_t count)
> +{
> +	struct measure_request *mr;
> +	struct file *file;
> +	int error = -EINVAL;
> +
> +	atomic_inc(&global_count_sysfs);
> +	if (count != sizeof(struct measure_request)) {
> +		ima_error("illegal request size (%d, expected %d).\n",
> +		       count, sizeof(struct measure_request));
> +		return -EIO;
> +	}

Free form text is going to fit into a specific size?

> +	mr = (struct measure_request *) page;
> +	if (mr->fd < 0)
> +		return -EBADF;

Woah!  You can't cast a structure to a ascii value.  And I thought I had
seen all of the ways you could abuse sysfs so far...

Please, sysfs is for:
	- ascii values
	- one value per file.

In fact, if you had read the sysfs documentation, it would have
explained this.  And people complain when there's no documentation, when
in reality, it's just simply ignored anyway...

Do not attempt to do this, it will be rejected.

> +	file = fget(mr->fd);
> +	if (!file)
> +		return -EACCES;
> +	mr->flags = ((mr->flags) & (~FLAG_HOOK_MASK)) || USER_MEASURE_FLAG;
> +	/* future: check inode->security to see if measure necessary */ 
> +	atomic_inc(&global_count_sysfs_measure);
> +	error = measure_file_exec(file, mr);
> +	fput(file);
> +	if (error)
> +		return error;
> +	else
> +		return (ssize_t) count;	/* length of written data */
> +}
> +
> +static struct subsys_attribute security_attr_measure = {
> +	.attr = {.name = "measure",.mode = S_IRUGO | S_IWUGO},
> +	.show = measurements_read,
> +	.store = measurement_store,
> +};

Use __ATTR() to properly set the module owner (right now you can open
the sysfs file, remove the module, and then read from it.  oops...)

> +static struct attribute *default_security_attrs[] = {
> +	&security_attr_measure.attr,
> +	NULL,
> +};

Ok, nice, but you got it wrong below...

> +static void security_object_release(struct kobject *kobj)
> +{
> +	return;
> +}

Um, no.  This is a HUGE RED FLAG that you did something wrong.

> +static struct kobj_type ktype_security = {
> +	.release = security_object_release,
> +	.sysfs_ops = &security_sysfs_ops,
> +	.default_attrs = default_security_attrs,
> +};
> +
> +/* declare security_subsys. */
> +static decl_subsys(security, &ktype_security, NULL);
> +
> +
> +int ima_sysfs_init(void)
> +{
> +	atomic_set(&global_count_sysfs, 0);
> +	atomic_set(&global_count_sysfs_measure, 0);
> +	subsystem_register(&security_subsys);
> +	subsys_create_file(&security_subsys, &security_attr_measure);

Wait, you create a default attribute array, which will be automatically
created, when you register a device in this subsystem.  And then you
create the same file again.  Good thing you never checked that return
value to catch the error the kernel is trying to tell you...

> +	return 0;
> +}
> +
> +int ima_sysfs_remove(void)
> +{
> +	subsys_remove_file(&security_subsys, &security_attr_measure);
> +	subsystem_unregister(&security_subsys);
> +	return 0;
> +}

Nope, that default attribute will take care of being removed
automatically, you don't have to try to do it again (but I appreciate
the effort.)

Wow, for such a small file, every single function was incorrect.  And
you abused sysfs in a new and intersting way that I didn't think was
even possible.  I think this is two new records you have set here,
congratulations.

greg k-h
