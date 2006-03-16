Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752418AbWCPQx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbWCPQx3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 11:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752416AbWCPQx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 11:53:28 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:5570 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1752415AbWCPQx1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 11:53:27 -0500
Date: Thu, 16 Mar 2006 08:53:23 -0800
From: Greg KH <greg@kroah.com>
To: "Artem B. Bityutskiy" <dedekind@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Bug? Report] kref problem
Message-ID: <20060316165323.GA10197@kroah.com>
References: <1142509279.3920.31.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142509279.3920.31.camel@sauron.oktetlabs.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 02:41:19PM +0300, Artem B. Bityutskiy wrote:
> struct my_obj_a
> {
> 	struct kobject kobj;
> } a;
> 
> struct my_obj_b
> {
> 	struct kobject kobj;
> } b;

Don't statically create kobjects, it's not nice.  But the real problem
is below...

> static __init int test_init(void)
> {
> 	int err;
> 
> 	kobject_init(&a.kobj);
> 	a.kobj.ktype = &a_ktype;
> 	err = kobject_set_name(&a.kobj, "A");
> 	if (err)
> 		return err;
> 	printk("a inited, kref %d\n", atomic_read(&a.kobj.kref.refcount));
> 	
> 	kobject_init(&b.kobj);
> 	b.kobj.ktype = &b_ktype;
> 	b.kobj.parent = &a.kobj;
> 	err = kobject_set_name(&b.kobj, "B");
> 	if (err)
> 		goto out_a;
> 	printk("b inited, kref %d\n", atomic_read(&b.kobj.kref.refcount));
> 
> 	err = sysfs_create_dir(&a.kobj);
> 	if (err)
> 		goto out_b;
> 	printk("dir A created, A kref %d, B kref %d\n",
> 	       atomic_read(&a.kobj.kref.refcount), atomic_read(&b.kobj.kref.refcount));
> 	
> 	err = sysfs_create_dir(&b.kobj);
> 	if (err)
> 		goto out_a_dir;
> 	printk("dir B created, A kref %d, B kref %d\n",
> 	       atomic_read(&a.kobj.kref.refcount), atomic_read(&b.kobj.kref.refcount));
> 
> 	kobject_put(&b.kobj);
> 	printk("kobj B put, A kref %d, B kref %d\n",
> 	       atomic_read(&a.kobj.kref.refcount), atomic_read(&b.kobj.kref.refcount));
> 
> 	kobject_put(&a.kobj);
> 	printk("kobj A put, A kref %d, B kref %d\n",
> 	       atomic_read(&a.kobj.kref.refcount), atomic_read(&b.kobj.kref.refcount));
> 
> 	return 0;
> 
> out_a_dir:
> 	sysfs_remove_dir(&a.kobj);
> out_b:
> 	kobject_put(&b.kobj);
> out_a:
> 	kobject_put(&a.kobj);
> 	return err;
> }
> module_init(test_init);
> 
> static void a_release(struct kobject *kobj)
> {
> 	struct my_obj_a *a;
> 	
> 	printk("%s\n", __FUNCTION__);
> 	a = container_of(kobj, struct my_obj_a, kobj);
> 	sysfs_remove_dir(&a->kobj);

Woah, don't do that here, the kobject core already does this.  A release
function is for you to release the memory you have created with this
kobject, not to mess with sysfs.

So, don't do this and everything should work just fine.

thanks,

greg k-h
