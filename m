Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264211AbUEHJ5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264211AbUEHJ5T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 05:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264215AbUEHJ5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 05:57:18 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:33247 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264211AbUEHJ5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 05:57:14 -0400
Date: Fri, 9 May 2003 15:35:23 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC 1/2] kobject_set_name - error handling
Message-ID: <20030509153523.A20357@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040417082206.GM24997@parcelfarce.linux.theplanet.co.uk> <20040430101333.GB25296@in.ibm.com> <20040430101401.GC25296@in.ibm.com> <200404300748.14151.dtor_core@ameritech.net> <20040504053908.GA2900@in.ibm.com> <20040507222549.GB14660@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040507222549.GB14660@kroah.com>; from greg@kroah.com on Fri, May 07, 2004 at 03:25:49PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2004 at 03:25:49PM -0700, Greg KH wrote:
> On Tue, May 04, 2004 at 11:09:08AM +0530, Maneesh Soni wrote:
> > 
> > Greg, Are the patches fit for inclusion? I need to know this as my sysfs backing
> > store patches are taking back seats because of these changes, particulary the
> > one in second patch :-(.
> 
> I'm awash in different patches from you.  Can you try sending me the
> ones you think are good enough for inclusion right now?  We can work
> from there.
> 

Sorry Greg, for confusing you by sending multiple copies. Here we are talking 
about two patches which cleans up the kobject_set_name() usuage in the routines
as mentioned below. The first one is appended here and the second one in the 
next mail. I have complied and tested (booting) both the patches and hope they 
are good for inclusion.


1) kobject_set_name-cleanup-01.patch

This patch corrects the following by checking the reutrn code from 
kobject_set_name().

bus_add_driver()
bus_register()
sys_dev_register()



o The following patch cleansup the kobject_set_name() users. Basically checking
  return code from kobject_set_name(). There can be error returns like -ENOMEM
  or -EFAULT from kobject_set_name() if the name length exceeds KOBJ_NAME_LEN.


 drivers/base/bus.c |   14 +++++++++++---
 drivers/base/sys.c |    5 ++++-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff -puN drivers/base/sys.c~kobject_set_name-cleanup-01 drivers/base/sys.c
--- linux-2.6.6-rc3-mm2/drivers/base/sys.c~kobject_set_name-cleanup-01	2004-05-06 12:13:22.000000000 +0530
+++ linux-2.6.6-rc3-mm2-maneesh/drivers/base/sys.c	2004-05-06 12:13:22.000000000 +0530
@@ -180,8 +180,11 @@ int sysdev_register(struct sys_device * 
 
 	/* But make sure we point to the right type for sysfs translation */
 	sysdev->kobj.ktype = &ktype_sysdev;
-	kobject_set_name(&sysdev->kobj,"%s%d",
+	error = kobject_set_name(&sysdev->kobj,"%s%d",
 			 kobject_name(&cls->kset.kobj),sysdev->id);
+	if (error)
+		return error;
+
 	pr_debug("Registering sys device '%s'\n",kobject_name(&sysdev->kobj));
 
 	/* Register the object */
diff -puN drivers/base/bus.c~kobject_set_name-cleanup-01 drivers/base/bus.c
--- linux-2.6.6-rc3-mm2/drivers/base/bus.c~kobject_set_name-cleanup-01	2004-05-06 12:13:22.000000000 +0530
+++ linux-2.6.6-rc3-mm2-maneesh/drivers/base/bus.c	2004-05-06 12:13:42.000000000 +0530
@@ -451,7 +451,11 @@ int bus_add_driver(struct device_driver 
 
 	if (bus) {
 		pr_debug("bus %s: add driver %s\n",bus->name,drv->name);
-		kobject_set_name(&drv->kobj,drv->name);
+		error = kobject_set_name(&drv->kobj,drv->name);
+		if (error) {
+			put_bus(bus);
+			return error;
+		}
 		drv->kobj.kset = &bus->drivers;
 		if ((error = kobject_register(&drv->kobj))) {
 			put_bus(bus);
@@ -555,7 +559,11 @@ struct bus_type * find_bus(char * name)
  */
 int bus_register(struct bus_type * bus)
 {
-	kobject_set_name(&bus->subsys.kset.kobj,bus->name);
+	int error = 0;
+
+	error = kobject_set_name(&bus->subsys.kset.kobj,bus->name);
+	if (error)
+		return error;
 	subsys_set_kset(bus,bus_subsys);
 	subsystem_register(&bus->subsys);
 
@@ -569,7 +577,7 @@ int bus_register(struct bus_type * bus)
 	kset_register(&bus->drivers);
 
 	pr_debug("bus type '%s' registered\n",bus->name);
-	return 0;
+	return error;
 }
 
 

_


-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
