Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752434AbWCPRSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbWCPRSK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752435AbWCPRSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:18:10 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:46217
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1752434AbWCPRSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:18:09 -0500
Date: Thu, 16 Mar 2006 09:18:03 -0800
From: Greg KH <greg@kroah.com>
To: "Artem B. Bityutskiy" <dedekind@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Bug? Report] kref problem
Message-ID: <20060316171803.GA5624@kroah.com>
References: <1142509279.3920.31.camel@sauron.oktetlabs.ru> <20060316165323.GA10197@kroah.com> <1142528877.3920.64.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142528877.3920.64.camel@sauron.oktetlabs.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 08:07:57PM +0300, Artem B. Bityutskiy wrote:
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

No file was attached :(

Care to try again?

> My real task is: I have sysfs directory /sys/A which corresponds to my
> module, to my subsystem. There I want to create subdirectories
> like /sys/A/B/ and delete them from time to time.

What kind of subsystem are you creating that you are using raw kobjects?

> So the problem is that whenver I remove B I end up with A's kref
> decremented.

And does A go away?  Or is it still there in sysfs?

> The attached test
> demonstrates this. P;ease, look at its output:
> 
> a inited, kref 1
> b inited, kref 1
> dir A created, A kref 1, B kref 1
> dir B created, A kref 1, B kref 1
> dir B removed, A kref 1, B kref 1
> b_release
> a_release       <--- What is this? I removed B, not A ???
> kobj B put, A kref 0, B kref 0
> dir A removed, A kref 0, B kref 0
> kobj A put, A kref -1, B kref 0

-ENOFILE :(

thanks,

greg k-h
