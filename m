Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWCPQuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWCPQuR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 11:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752404AbWCPQuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 11:50:17 -0500
Received: from [84.204.75.166] ([84.204.75.166]:3288 "EHLO shelob.oktetlabs.ru")
	by vger.kernel.org with ESMTP id S1751241AbWCPQuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 11:50:15 -0500
Subject: Re: [Bug? Report] kref problem
From: "Artem B. Bityutskiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Greg KH <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20060316164712.GA10167@kroah.com>
References: <1142509279.3920.31.camel@sauron.oktetlabs.ru>
	 <20060316164712.GA10167@kroah.com>
Content-Type: text/plain
Organization: MTD
Date: Thu, 16 Mar 2006 19:50:13 +0300
Message-Id: <1142527813.3920.57.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 08:47 -0800, Greg KH wrote:
> Sample code please?
> 
> Also, creating sysfs directories does not change the reference count on
> kobjects, they are two separate things.

Err, didn't I attache the test module?

Here it goes:


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
	       atomic_read(&a.kobj.kref.refcount),
atomic_read(&b.kobj.kref.refcount));
	
	err = sysfs_create_dir(&b.kobj);
	if (err)
		goto out_a_dir;
	printk("dir B created, A kref %d, B kref %d\n",
	       atomic_read(&a.kobj.kref.refcount),
atomic_read(&b.kobj.kref.refcount));

	kobject_put(&b.kobj);
	printk("kobj B put, A kref %d, B kref %d\n",
	       atomic_read(&a.kobj.kref.refcount),
atomic_read(&b.kobj.kref.refcount));

	kobject_put(&a.kobj);
	printk("kobj A put, A kref %d, B kref %d\n",
	       atomic_read(&a.kobj.kref.refcount),
atomic_read(&b.kobj.kref.refcount));

	return 0;

out_a_dir:
	sysfs_remove_dir(&a.kobj);
out_b:
	kobject_put(&b.kobj);
out_a:
	kobject_put(&a.kobj);
	return err;
}
module_init(test_init);

static void a_release(struct kobject *kobj)
{
	struct my_obj_a *a;
	
	printk("%s\n", __FUNCTION__);
	a = container_of(kobj, struct my_obj_a, kobj);
	sysfs_remove_dir(&a->kobj);
}

static void b_release(struct kobject *kobj)
{
	struct my_obj_b *b;

	printk("%s\n", __FUNCTION__);
	b = container_of(kobj, struct my_obj_b, kobj);
	sysfs_remove_dir(&b->kobj);
}

static __exit void test_exit(void)
{
}
module_exit(test_exit);

MODULE_VERSION("1");
MODULE_DESCRIPTION("kref test");
MODULE_AUTHOR("Artem B. Bityutskiy");
MODULE_LICENSE("GPL");


