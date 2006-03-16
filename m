Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752386AbWCPRUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbWCPRUp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752438AbWCPRUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:20:44 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:47753
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1752386AbWCPRUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:20:44 -0500
Date: Thu, 16 Mar 2006 09:20:39 -0800
From: Greg KH <greg@kroah.com>
To: "Artem B. Bityutskiy" <dedekind@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Bug? Report] kref problem
Message-ID: <20060316172039.GB5624@kroah.com>
References: <1142509279.3920.31.camel@sauron.oktetlabs.ru> <20060316165323.GA10197@kroah.com> <1142528877.3920.64.camel@sauron.oktetlabs.ru> <1142529004.3920.66.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142529004.3920.66.camel@sauron.oktetlabs.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 08:10:04PM +0300, Artem B. Bityutskiy wrote:
> On Thu, 2006-03-16 at 20:07 +0300, Artem B. Bityutskiy wrote:
> > On Thu, 2006-03-16 at 08:53 -0800, Greg KH wrote: 
> > > > static void a_release(struct kobject *kobj)
> > > > {
> > > > 	struct my_obj_a *a;
> > > > 	
> > > > 	printk("%s\n", __FUNCTION__);
> > > > 	a = container_of(kobj, struct my_obj_a, kobj);
> > > > 	sysfs_remove_dir(&a->kobj);
> > > 
> > > Woah, don't do that here, the kobject core already does this.  A release
> > > function is for you to release the memory you have created with this
> > > kobject, not to mess with sysfs.
> > So do you mean this (attached) ? Anyway I end up with -1 kref.
> > 
> Pardon, forgot to attach.

> #include <linux/kernel.h>
> #include <linux/init.h>
> #include <linux/module.h>
> #include <linux/kobject.h>
> #include <linux/stat.h>
> 
> static void a_release(struct kobject *kobj);
> 
> static struct kobj_type a_ktype = {
>         .release   = a_release
> };
> 
> static void b_release(struct kobject *kobj);
> 
> static struct kobj_type b_ktype = {
>         .release   = b_release
> };
> 
> struct my_obj_a
> {
> 	struct kobject kobj;
> } a;
> 
> struct my_obj_b
> {
> 	struct kobject kobj;
> } b;
> 
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

Again, why are you trying to call the sysfs raw functions?  You are not
registering the kobject with the kobject core, so bad things are
happening.  Why not call kobject_register() or kobject_add(), like it is
documented to do so?

Because of this, you are seeing odd things happen.

thanks,

greg k-h
