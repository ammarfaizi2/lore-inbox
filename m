Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272069AbTHDR4y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 13:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272068AbTHDR4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 13:56:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:60349 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272066AbTHDR4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 13:56:51 -0400
Date: Mon, 4 Aug 2003 11:01:41 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: ffrederick@prov-liege.be
cc: greg@kroah.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]shm to sysfs ready (?)
In-Reply-To: <S275200AbTHAG7J/20030801065910Z+2647@vger.kernel.org>
Message-ID: <Pine.LNX.4.44.0308041041420.23977-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   Summary :
> 
>       -shm destruction moved to kobject release function
>       -id seek was trivial.Attrshow rewritten.
>       -Tested against recursive fgreps-kde-personal benchmark program
>       -Patched might_sleep problem
>       -Checking release code in front of all shm_destroy calls
>       -No more MAJ charset for attributes
>       -Adding EOL to attr values.
>       -Working against 2.6.0.test2
> 
>       Is it ok for you ?

A few comments below. 

> +#include <linux/kobj_map.h>

You shouldn't need to include this. 

> +	strcpy(shm_ids.kobj.name, "shm");
> +	shm_ids.kobj.parent = NULL;
> +	shm_ids.kobj.kset = NULL;
> +	shm_ids.kobj.ktype = NULL;
> +	kobject_register(&shm_ids.kobj);

The kobject internals rely on the entire kobject being zero-filled. You 
should be memset'ing it (and probably the entire object) earlier, which 
saves you from manually initializing the fields above to 0, and prevents 
you from missing any in the future. 

> +static ssize_t shm_attr_show(struct kobject *kobj, struct attribute *attr, char *buf)
> +{
> +	unsigned int id=simple_strtoul(kobj->name,NULL,10)%SEQ_MULTIPLIER;
> +	struct shmid_kernel *shp;
> +	down (&shm_ids.sem);
> +	shp=shm_lock(id);
> +	if(!strcmp(attr->name,"key"))
> +		snprintf(buf, PAGE_SIZE,"%ld\n", (long)shp->shm_perm.key);
	...

If you're going to do it this way, I suggest declaring the attributes 
before the show method, so you can do a pointer comparison, rather than a 
string compare: 

+	if(attr == &shm_attr_key))
+		snprintf(buf, PAGE_SIZE,"%ld\n", (long)shp->shm_perm.key);
	...

> +#define SHM_ATTR(_name) \
> +static struct attribute shm_attr_##_name={ \
> +	.name=__stringify(_name), \
> +	.mode=0444, \
> +}; \

Also, you should declare all the attributes here, rather than in the 
registration function. They will only be defined once, and will not put 
unnecessary pressure on the stack. 

struct kobj_type::default_attrs is designed to hold an array of attributes
that are added to each kobject registered of that type. This is done
automatically for you, so you don't have to do it manually. (It also
checks the errors as it adds each attribute). I suggest using that. 

Thanks,


	-pat


