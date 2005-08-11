Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbVHKFgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVHKFgj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 01:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbVHKFgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 01:36:39 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:28827 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932178AbVHKFgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 01:36:38 -0400
Date: Thu, 11 Aug 2005 11:04:45 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Keith Owens <kaos@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, sonny@burdell.org, airlied@gmail.com,
       miles.lane@gmail.com
Subject: Re: 2.6.13-rc4 use after free in class_device_attr_show
Message-ID: <20050811053445.GA4656@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20050802080422.GA32556@in.ibm.com> <15242.1123655211@kao2.melbourne.sgi.com> <20050810100636.GB5334@in.ibm.com> <20050810223552.GB6045@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050810223552.GB6045@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 03:35:53PM -0700, Greg KH wrote:
> On Wed, Aug 10, 2005 at 03:36:36PM +0530, Maneesh Soni wrote:
> > On Wed, Aug 10, 2005 at 04:26:51PM +1000, Keith Owens wrote:
> > > FYI, the intermittent free after use in sysfs is still there in
> > > 2.6.13-rc6.
> > > 
> > 
> > The race condition is known here. It is some thing in the upper layer. 
> > In this case "driver/base/class.c" which frees the kobject's attributes 
> > even if there are live references to kobject.
> > 
> > 
> > open sysfs file				unregister class device
> > sysfs_open_file()			class_device_del()
> >   -> takes a ref on kobject		  -> kfree attribute struct
> >      -> accesses attributes		  -> kobject_del()
> > 					      -> kref_put()	
> > close sysfs file				  
> > sysfs_release()				    
> >   -> acesses attributes using s_element
> >   -> drops ref to kobject
> > 
> > Solution could be either we have reference counting for attributes also
> > or keep attributes alive till the last reference to the kobject. Both these
> > needs changes in the driver core.
> > 
> > Greg, will the following patch make sense? This postpones the kfree() of
> > devt_attr till class_dev_release() is called. 
> 
> Yes, that patch looks good, if you fix up the space vs. tabs issue :)
> 

yuk.. sorry for that.. I corrected that now.

> But will that really fix this race?  I was under the impression the oops
> didn't come from trying to access the devt_attr, but the sysfs s_element
> pointer?

I am not able to recreate the race with or without the patch though. As per
the stack traces, and the debug messages from antother thread also,
I could see that it is use after free for attribute structure. s_element
is a pointer to the attribute structure in case of sysfs "files". Most of
the times this attribute structure is not allocated/freed dynamically unlike
/sys/class/vc/vcs*/dev, so we don't see any crashes.


> > Please check this patch out, if this helps or not.
> 
> I'd be interested in seeing if this fixes it.
> 

I just cc-ed others also who reported similar oops.

Thanks
Maneesh




o following patch moves the code to free devt_attr from class_device_del()
  to class_dev_release() which is called after the last reference to the
  corresponding kobject() is gone. This allows to keep the devt_attr 
  alive while the corresponding sysfs file is open.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
---

 linux-2.6.13-rc6-maneesh/drivers/base/class.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff -puN drivers/base/class.c~fix-class-attributes-race drivers/base/class.c
--- linux-2.6.13-rc6/drivers/base/class.c~fix-class-attributes-race	2005-08-10 12:35:06.000000000 +0530
+++ linux-2.6.13-rc6-maneesh/drivers/base/class.c	2005-08-11 09:27:17.202081088 +0530
@@ -299,6 +299,11 @@ static void class_dev_release(struct kob
 
 	pr_debug("device class '%s': release.\n", cd->class_id);
 
+	if (cd->devt_attr) {
+		kfree(cd->devt_attr);
+		cd->devt_attr = NULL;
+	}
+
 	if (cls->release)
 		cls->release(cd);
 	else {
@@ -591,11 +596,10 @@ void class_device_del(struct class_devic
 
 	if (class_dev->dev)
 		sysfs_remove_link(&class_dev->kobj, "device");
-	if (class_dev->devt_attr) {
-		class_device_remove_file(class_dev, class_dev->devt_attr);
-		kfree(class_dev->devt_attr);
-		class_dev->devt_attr = NULL;
-	}
+
+	if (class_dev->devt_attr)
+                class_device_remove_file(class_dev, class_dev->devt_attr);
+
 	class_device_remove_attrs(class_dev);
 
 	kobject_hotplug(&class_dev->kobj, KOBJ_REMOVE);
_

-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
