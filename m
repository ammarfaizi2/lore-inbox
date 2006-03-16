Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752314AbWCPLlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314AbWCPLlW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 06:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752321AbWCPLlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 06:41:22 -0500
Received: from [84.204.75.166] ([84.204.75.166]:12758 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP
	id S1752314AbWCPLlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 06:41:21 -0500
Subject: [Bug? Report] kref problem
From: "Artem B. Bityutskiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Greg KH <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Content-Type: multipart/mixed; boundary="=-Lb3wi5Z0vBsjZaDDhzJS"
Organization: MTD
Date: Thu, 16 Mar 2006 14:41:19 +0300
Message-Id: <1142509279.3920.31.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Lb3wi5Z0vBsjZaDDhzJS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello Greg,

I've hit on a kref problem Please, glance at the attached test module.

The idea of the test is to create 2 kobjects (a and b), create dir A
with kobject A, and dir B with kobject B, so that A is B's parent. E.g.,
we'll have /sys/A/B.

I see the following output of the test:

a inited, kref 1
b inited, kref 1
dir A created, A kref 1, B kref 1
dir B created, A kref 1, B kref 1
b_release
a_release
kobj B put, A kref 0, B kref 0
kobj A put, A kref -1, B kref 0


So what I don't like is this "A kref -1". Why when I remove directory B,
kobj a is released? For me it looks like a bug.

The kernel is 2.6.16-rc6.

Thanks.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

--=-Lb3wi5Z0vBsjZaDDhzJS
Content-Disposition: attachment; filename=kreftest.c
Content-Type: text/x-csrc; name=kreftest.c; charset=KOI8-R
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

	kobject_put(&b.kobj);
	printk("kobj B put, A kref %d, B kref %d\n",
	       atomic_read(&a.kobj.kref.refcount), atomic_read(&b.kobj.kref.refcount));

	kobject_put(&a.kobj);
	printk("kobj A put, A kref %d, B kref %d\n",
	       atomic_read(&a.kobj.kref.refcount), atomic_read(&b.kobj.kref.refcount));

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

--=-Lb3wi5Z0vBsjZaDDhzJS--

