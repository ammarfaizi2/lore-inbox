Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbTLQUmh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 15:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbTLQUmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 15:42:36 -0500
Received: from mail.kroah.org ([65.200.24.183]:4282 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264546AbTLQUme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 15:42:34 -0500
Date: Wed, 17 Dec 2003 12:41:00 -0800
From: Greg KH <greg@kroah.com>
To: Linda Xie <lxiep@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, scheel@us.ibm.com, wortman@us.ibm.com
Subject: Re: PATCPATCH -- add unlimited name lengths support to sysfs
Message-ID: <20031217204100.GA13305@kroah.com>
References: <3FDF902A.4000903@us.ltcfwd.linux.ibm.com> <20031216231447.GA4781@kroah.com> <3FE0BC4D.8080605@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE0BC4D.8080605@us.ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17, 2003 at 02:27:57PM -0600, Linda Xie wrote:
> Greg KH wrote:
> >On Tue, Dec 16, 2003 at 05:07:22PM -0600, Linda Xie wrote:
> >
> >>diff -Nru a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
> >>--- a/fs/sysfs/symlink.c	Sun Dec 14 21:19:29 2003
> >>+++ b/fs/sysfs/symlink.c	Sun Dec 14 21:19:29 2003
> >>@@ -42,7 +42,10 @@
> >>	struct kobject * p = kobj;
> >>	int length = 1;
> >>	do {
> >>-		length += strlen(p->name) + 1;
> >>+		if (p->k_name)
> >>+			length += strlen(p->k_name) + 1;
> >>+		else
> >>+			length += strlen(p->name) + 1;
> >
> >
> >Shouldn't this just be:
> >		length += strlen(kobject_name(p)) + 1;
> >
> 
> That is correct. But here is my concern: Some of the callers of 
> sysfs_create_link()
> set p->name instead of p->k_name. So for them, the length calculated 
> using kobject_name(p) will be incorrect. Correct me if I am wrong.

Well if a kobject only uses the .name field, .k_name will point to it
(see kobject_add()), so the kobject_name() call will work in the above
case (as it should always do.)  Actually that if (p->k_name) statement
will always be true because of this fact :)

This lets people like the edd driver which does:
	 snprintf(edev->kobj.name, EDD_DEVICE_NAME_SIZE, "int13_dev%02x", edd[i].device);
still work properly.  Ideally, callers like this should change to use
the kobject_set_name() function, but there's no rush.

thanks,

greg k-h
