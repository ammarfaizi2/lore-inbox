Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752424AbWCPRH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424AbWCPRH7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752423AbWCPRH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:07:59 -0500
Received: from [84.204.75.166] ([84.204.75.166]:10200 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP
	id S1752421AbWCPRH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:07:58 -0500
Subject: Re: [Bug? Report] kref problem
From: "Artem B. Bityutskiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Greg KH <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20060316165323.GA10197@kroah.com>
References: <1142509279.3920.31.camel@sauron.oktetlabs.ru>
	 <20060316165323.GA10197@kroah.com>
Content-Type: text/plain
Organization: MTD
Date: Thu, 16 Mar 2006 20:07:57 +0300
Message-Id: <1142528877.3920.64.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 08:53 -0800, Greg KH wrote: 
> > static void a_release(struct kobject *kobj)
> > {
> > 	struct my_obj_a *a;
> > 	
> > 	printk("%s\n", __FUNCTION__);
> > 	a = container_of(kobj, struct my_obj_a, kobj);
> > 	sysfs_remove_dir(&a->kobj);
> 
> Woah, don't do that here, the kobject core already does this.  A release
> function is for you to release the memory you have created with this
> kobject, not to mess with sysfs.
So do you mean this (attached) ? Anyway I end up with -1 kref.

My real task is: I have sysfs directory /sys/A which corresponds to my
module, to my subsystem. There I want to create subdirectories
like /sys/A/B/ and delete them from time to time. So the problem is that
whenver I remove B I end up with A's kref decremented. The attached test
demonstrates this. P;ease, look at its output:

a inited, kref 1
b inited, kref 1
dir A created, A kref 1, B kref 1
dir B created, A kref 1, B kref 1
dir B removed, A kref 1, B kref 1
b_release
a_release       <--- What is this? I removed B, not A ???
kobj B put, A kref 0, B kref 0
dir A removed, A kref 0, B kref 0
kobj A put, A kref -1, B kref 0

Thanks.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

