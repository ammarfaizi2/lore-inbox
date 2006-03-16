Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752426AbWCPRKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbWCPRKI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752428AbWCPRKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:10:08 -0500
Received: from [84.204.75.166] ([84.204.75.166]:11224 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP
	id S1752426AbWCPRKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:10:06 -0500
Subject: Re: [Bug? Report] kref problem
From: "Artem B. Bityutskiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Greg KH <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1142528877.3920.64.camel@sauron.oktetlabs.ru>
References: <1142509279.3920.31.camel@sauron.oktetlabs.ru>
	 <20060316165323.GA10197@kroah.com>
	 <1142528877.3920.64.camel@sauron.oktetlabs.ru>
Content-Type: multipart/mixed; boundary="=-Up4ekQhvkJINaNsLkZBV"
Organization: MTD
Date: Thu, 16 Mar 2006 20:10:04 +0300
Message-Id: <1142529004.3920.66.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Up4ekQhvkJINaNsLkZBV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2006-03-16 at 20:07 +0300, Artem B. Bityutskiy wrote:
> On Thu, 2006-03-16 at 08:53 -0800, Greg KH wrote: 
> > > static void a_release(struct kobject *kobj)
> > > {
> > > 	struct my_obj_a *a;
> > > 	
> > > 	printk("%s\n", __FUNCTION__);
> > > 	a = container_of(kobj, struct my_obj_a, kobj);
> > > 	sysfs_remove_dir(&a->kobj);
> > 
> > Woah, don't do that here, the kobject core already does this.  A release
> > function is for you to release the memory you have created with this
> > kobject, not to mess with sysfs.
> So do you mean this (attached) ? Anyway I end up with -1 kref.
> 
Pardon, forgot to attach.

--=-Up4ekQhvkJINaNsLkZBV
Content-Disposition: attachment; filename=kreftest1.c
Content-Type: text/x-csrc; name=kreftest1.c; charset=KOI8-R
Content-Transfer-Encoding: 7bit

#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/kobject.h>
#include <linux/stat.h>

static void a_release(struct kobject *kobj);

static struct kobj_type a_ktype = {
        .release   = a_release
};

static void b_release(struct kobject *kobj);

static struct kobj_type b_ktype = {
        .release   = b_release
};

struct my_obj_a
{
	struct kobject kobj;
} a;

struct my_obj_b
{
	struct kobject kobj;
} b;

static __init int test_init(void)
{
	int err;

	kobject_init(&a.kobj);
	a.kobj.ktype = &a_ktype;
	err = kobject_set_name(&a.kobj, "A");
	if (err)
		return err;
	printk("a inited, kref %d\n", atomic_read(&a.kobj.kref.refcount));
	
	kobject_init(&b.kobj);
	b.kobj.ktype = &b_ktype;
	b.kobj.parent = &a.kobj;
	err = kobject_set_name(&b.kobj, "B");
	if (err)
		goto out_a;
	printk("b inited, kref %d\n", atomic_read(&b.kobj.kref.refcount));

	err = sysfs_create_dir(&a.kobj);
	if (err)
		goto out_b;
	printk("dir A created, A kref %d, B kref %d\n",
	       atomic_read(&a.kobj.kref.refcount), atomic_read(&b.kobj.kref.refcount));
	
	err = sysfs_create_dir(&b.kobj);
	if (err)
		goto out_a_dir;
	printk("dir B created, A kref %d, B kref %d\n",
	       atomic_read(&a.kobj.kref.refcount), atomic_read(&b.kobj.kref.refcount));

	sysfs_remove_dir(&b.kobj);
	printk("dir B removed, A kref %d, B kref %d\n",
	       atomic_read(&a.kobj.kref.refcount), atomic_read(&b.kobj.kref.refcount));

	kobject_put(&b.kobj);
	printk("kobj B put, A kref %d, B kref %d\n",
	       atomic_read(&a.kobj.kref.refcount), atomic_read(&b.kobj.kref.refcount));

	sysfs_remove_dir(&a.kobj);
	printk("dir A removed, A kref %d, B kref %d\n",
	       atomic_read(&a.kobj.kref.refcount), atomic_read(&b.kobj.kref.refcount));

	kobject_put(&a.kobj);
	printk("kobj A put, A kref %d, B kref %d\n",
	       atomic_read(&a.kobj.kref.refcount), atomic_read(&b.kobj.kref.refcount));

	return 0;

out_a_dir:
	sysfs_remove_dir(&a.kobj);
	printk("dir A removed, A kref %d, B kref %d\n",
	       atomic_read(&a.kobj.kref.refcount), atomic_read(&b.kobj.kref.refcount));
out_b:
	kobject_put(&b.kobj);
	printk("kobj B put, A kref %d, B kref %d\n",
	       atomic_read(&a.kobj.kref.refcount), atomic_read(&b.kobj.kref.refcount));
out_a:
	kobject_put(&a.kobj);
	printk("kobj A put, A kref %d, B kref %d\n",
	       atomic_read(&a.kobj.kref.refcount), atomic_read(&b.kobj.kref.refcount));
	return err;
}
module_init(test_init);

static void a_release(struct kobject *kobj)
{
	struct my_obj_a *a;
	
	a = container_of(kobj, struct my_obj_a, kobj);
	printk("%s\n", __FUNCTION__);
}

static void b_release(struct kobject *kobj)
{
	struct my_obj_b *b;

	b = container_of(kobj, struct my_obj_b, kobj);
	printk("%s\n", __FUNCTION__);
}

static __exit void test_exit(void)
{
}
module_exit(test_exit);

MODULE_VERSION("1");
MODULE_DESCRIPTION("kref test");
MODULE_AUTHOR("Artem B. Bityutskiy");
MODULE_LICENSE("GPL");

--=-Up4ekQhvkJINaNsLkZBV--

