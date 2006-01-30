Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWA3QTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWA3QTE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 11:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWA3QTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 11:19:04 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:11160 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932361AbWA3QTC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 11:19:02 -0500
Subject: Re: [PATCH 2.6.12.6-xen] sysfs attributes for xen
From: Dave Hansen <haveblue@us.ibm.com>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: xen-devel@lists.xensource.com, lkml <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <43DAD4DB.4090708@us.ibm.com>
References: <43DAD4DB.4090708@us.ibm.com>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 08:18:51 -0800
Message-Id: <1138637931.19801.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks much more sound than the /proc version.  Nice work.

On Fri, 2006-01-27 at 21:20 -0500, Mike D. Day wrote:
> +int __init
> +hyper_sysfs_init(void)
> +{
> +	int err ;
> +	
> +	if( 0 ==  (err = subsystem_register(&hypervisor_subsys)) ) {
> +		xen_kset.subsys = &hypervisor_subsys;
> +		err = kset_register(&xen_kset);
> +	}
> +	return err;
> +}

As Greg said, we like to see assignments taken out of 'if' statements.
I also like to see the main flow of code stay at the top level of a
function, with _exceptions_ being the things that go inside of 'if'
blocks.  I think it makes functions much easier to follow, but it's
completely personal preference.  Something like this, maybe?

hyper_sysfs_init(void)
{
	int err ;
	
	err = subsystem_register(&hypervisor_subsys);
	if(err)
		return err;

	xen_kset.subsys = &hypervisor_subsys;
	err = kset_register(&xen_kset);
	return err;	
}

> +/* xen version info */
> +static ssize_t xen_version_show(struct kobject * kobj, 
> +				struct attribute * attr, 
> +				char *page)
> +{
> +	long version;
> +	long major, minor;
> +	char extra_version[16];
> +	
> +	if ( (version = HYPERVISOR_xen_version(XENVER_version, NULL)) ) {
> +		
> +		major = version >> 16;
> +		minor = version & 0xff;
> +		if( ! HYPERVISOR_xen_version(XENVER_extraversion, 
> +					    extra_version) ) {
> +			page[PAGE_SIZE - 1] = 0x00;
> +			return snprintf(page, PAGE_SIZE - 1, 
> +					"xen-%ld.%ld%s\n",
> +					major, minor, extra_version);
> +		}
> +	}
> +	return 0;
> +}

What are the actual types of the values that come back from the

	HYPERVISOR_xen_version(XENVER_version, NULL)

call?  If they are really 8-bit or 16-bit values, it might be nice to
call that out and use some of the kernel types like u8 or u16.  In fact,
it might even be worth it to have a function wrap that up.

Silly idea: you _could_ have separate files for the major and minor.
Are they something that a userspace program might commonly have to parse
out?  Is the patch trying to save a potential hcall by outputting them
both at once?

> +/* xen compile info */
> +static ssize_t xen_compile_show(struct kobject * kobj, 
> +				struct attribute * attr, 
> +				char * page)
> +{
> +	struct xen_compile_info info;
> +	
> +	if( 0 == HYPERVISOR_xen_version(XENVER_compile_info, &info) ) {
> +		page[PAGE_SIZE - 1] = 0x00;
> +		return snprintf(page, PAGE_SIZE - 1, 
> +				"compiled by %s, using %s, on %s\n", 
> +				info.compile_by, 
> +				info.compile_date, 
> +				info.compiler);
> +	}
> +	return 0;
> +}

I think this one breaks the "one value per file" sysfs rule.  Perhaps
instead of 'cat compilation' you need:

	greo . compilation/*

Where compilation contains:

	|-- compilation
	|   |-- user
	|   |-- date
	|   |-- compiler

> +/* xen capabilities info */
> +static ssize_t xen_cap_show(struct kobject * kobj, 
> +				struct attribute * attr, 
> +				char * page)
> +{
> +	char info[1024];
> +	
> +	if( 0 == HYPERVISOR_xen_version(XENVER_capabilities, &info) ) {
> +		page[PAGE_SIZE - 1] = 0x00;
> +		return snprintf(page, PAGE_SIZE - 1, 
> +				"%s\n", info);
> +	}
> +	return 0;
> +}

Where does that 1024 come from?  Is it a guarantee from Xen that it will
never fill more than 1k?  I know it is a long shot, but what if the page
size is less than 1k?  Would this function have strange results?

Also, please don't declare large variables on the stack.  If you really
need a buffer that large, simply dynamically allocate it.  We have a
really speedy allocator.

> +int __init
> +sysfs_xen_version_init(void)
> +{
> +	__label__  out;
> +	
> +	struct kset * parent = get_xen_kset();
> +	if ( parent != NULL ) {
> +		kobject_init(&xen_ver_obj);
> +		xen_ver_obj.parent = &parent->kobj;		
> +		xen_ver_obj.dentry = parent->kobj.dentry;
> +		kobject_get(&parent->kobj);
> +		if ( sysfs_create_file(&xen_ver_obj, &xen_ver_attr.attr) )
> +			goto out;
...
> +out:
> +	return 1;
> +}

Instead of embedding all of the kobject() initializations, this could
also just do the following:

	if ( parent == NULL )
		goto out;

	kobject_init(&xen_ver_obj);
	...

I know the kset stuff might be going away, but you might run into a
similar construct later down the road.

There are quite a few references to PAGE_SIZE in the patch.  I think
most of them have to do with trying to make sure that the buffer
returned to the sysfs functions is NULL-terminated.  I'm not sure that
is really an issue.

Many sysfs users simply sprintf() right into the buffer, as long as
they're writing reasonably short stuff.  We assume that we're not going
to overflow, especially with single integer values.  This makes the code
quite a bit more simple.

If overflow is a real worry, we might want to come up with a specialized
sysfs sprintf which encapsulates the PAGE_SIZE restriction.  It seems a
little silly to have each driver going through all this trouble of
worrying about buffer sizing and NULL termination.

-- Dave

