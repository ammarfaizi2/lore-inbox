Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWBURPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWBURPk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 12:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWBURPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 12:15:40 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:11160 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932333AbWBURPk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 12:15:40 -0500
Subject: Re: [ PATCH 2.6.16-rc3-xen 3/3] sysfs: export Xen hypervisor
	attributes to sysfs
From: Dave Hansen <haveblue@us.ibm.com>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: xen-devel@lists.xensource.com, lkml <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <43FB2642.7020109@us.ibm.com>
References: <43FB2642.7020109@us.ibm.com>
Content-Type: text/plain
Date: Tue, 21 Feb 2006 09:15:30 -0800
Message-Id: <1140542130.8693.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-21 at 09:40 -0500, Mike D. Day wrote:
> Module that exports Xen Hypervisor attributes to /sys/hypervisor. 

This set is looking much better.  The functions are all quite small.

> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Mike D. Day <ncmike@us.ibm.com>");
> +
> +decl_subsys(hypervisor, NULL, NULL);
> +
> +struct kset xen_kset = {
> +	.subsys = &hypervisor_subsys,
> +	.kobj = {
> +		.name = "xen",
> +	},
> +};

I'm wondering if this information couldn't be laid out in a slightly
more generic way so that other hypervisors could use the same layout.
Instead of:

+---sys
        +---hypervisor
                +---xen
                        +---version
                        +---major
                        +---minor
                        +---extra

It could be:

+---sys
        +---hypervisor
                +---type
		+---version
                        +---major
                        +---minor
                        +---extra

Where cat /sys/hypervisor/type is 'xen'.  That way, if there are generic
things about hypervisors to export here, any generic tools can find them
without having to know exactly which hypervisor is running.

You can also set the standard that any other hypervisor has to
follow! :)

> +static ssize_t xen_show(struct kobject * kobj,
> +			struct attribute * attr,
> +			char * page)
> +{
> +	struct xen_attr * xattr;

The usual kernel coding style is to put the '*' next to the variable
name:

	struct xen_attr *xattr;

I'd probably take a good look through the driver and get rid of those.

Another minor nit: your "page" variable could become a very bad name if
we ever decide to give sysfs more or less than a page of buffer space
for its attributes.

> +static void kobj_release(struct kobject * kobj)
> +{
> +	kfree(kobj);
> +}

This is a pretty generic function name.  I know it is static, but it
might be useful to give it a slightly more descriptive name.  It is
possible that there may be a global function named kobj_release() at
some point in the future, and you don't want a conflict.

> +static struct sysfs_ops xen_ops = {
> +
> +	.show = xen_show,
> +};
> +
> +/* xen version attributes */
> +
> +static ssize_t major_show(struct kobject * kobj,
> +			  struct attribute * attr,
> +			  char * page)
> +{
> +	int version = HYPERVISOR_xen_version(XENVER_version, NULL);
> +	if (version)
> +		return sprintf(page, "%d\n", version >> 16);
> +	return 0;
> +}
> +
> +static struct xen_attr major = __ATTR_RO(major);
> +
> +static ssize_t minor_show(struct kobject * kobj,
> +			  struct attribute * attr,
> +			  char * page)
> +{
> +	int version = HYPERVISOR_xen_version(XENVER_version, NULL);
> +	if (version)
> +		return sprintf(page, "%d\n", version & 0xff);
> +	return 0;
> +}
> +
> +static struct xen_attr minor = __ATTR_RO(minor);
> +
> +static ssize_t extra_show(struct kobject * kobj,
> +			  struct attribute * attr,
> +			  char * page)
> +{
> +	char extra_ver[XENVER_EXTRAVERSION_LEN];

At 1k, this is a wee bit too big to be on the stack.  I'd just kmalloc
it instead.

> +	int err = HYPERVISOR_xen_version(XENVER_extraversion, extra_ver);
> +	if (0 == err)
> +		return sprintf(page, "%s\n", extra_ver);
> +	return 0;
> +}

Again, these names are a bit generic, but it probably isn't too harmful.
I'd mostly be worried that they would be hard to find if you were
cscope'ing.

> +/* xen compilation attributes */
> +
> +static ssize_t compiler_show(struct kobject * kobj,
> +			     struct attribute * attr,
> +			     char * page)
> +{
> +	int err = 0;
> +	struct xen_compile_info * info =
> +		kmalloc(sizeof(struct xen_compile_info), GFP_KERNEL);
> +	if (info ) {
> +		if (0 == HYPERVISOR_xen_version(XENVER_compile_info, info))
> +			err = sprintf(page, "%s\n", info->compiler);
> +		kfree(info);
> +	}
> +	return err;
> +}
> +
> +static struct xen_attr compiler = __ATTR_RO(compiler);
> +
> +static ssize_t by_show(struct kobject * kobj,
> +		       struct attribute * attr,
> +		       char * page)
> +{

OK, one last thing about the function names:

xen_compiled_by_show() is a _lot_ more informative than by_show().  I
had to think about what this did, I didn't quite know just from the
name.

> +	int err = 0;
> +	struct xen_compile_info * info =
> +		kmalloc(sizeof(struct xen_compile_info), GFP_KERNEL);
> +	if (info ) {
> +		if (0 == HYPERVISOR_xen_version(XENVER_compile_info, info))
> +			return sprintf(page, "%s\n", info->compile_by);

I think this was mentioned last time, but the '0 ==' stuff is a little
non-conventional.  I'd probably kill it just for readability-sake.

> +static struct attribute * xen_compile_attrs[] = {
> +	&compiler.attr,
> +	&compiled_by.attr,
> +	&compiled_date.attr,
> +	NULL
> +};

I like this variable name.  A bit more complete than the function names.

> +static struct kobject * c_kobj;
> +
> +

Little bit of extra whitespace here.  

> +int __init
> +static xen_compilation_init(void)
> +{
> +	int err = -ENOMEM;
> +	c_kobj = kcalloc(sizeof(struct kobject), sizeof(char), GFP_KERNEL);
> +	if (c_kobj) {
> +		kobject_set_name(c_kobj, "compilation");
> +		c_kobj->ktype = &xen_compilation_type;
> +		kobject_init(c_kobj);
> +		c_kobj->dentry = xen_kset.kobj.dentry;
> +		err = sysfs_create_group(c_kobj, &xen_compilation_group);
> +	}
> +	return err;
> +}
> +
> +static void xen_compilation_destroy(void)
> +{
> +	sysfs_remove_group(c_kobj, &xen_compilation_group);
> +	kobject_put(c_kobj);
> +	return;
> +}

Yup, this is another excellent function name.

-- Dave

