Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264131AbUEDFfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264131AbUEDFfy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 01:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264208AbUEDFfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 01:35:54 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:53917 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264131AbUEDFft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 01:35:49 -0400
Date: Tue, 4 May 2004 11:09:08 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       Greg KH <greg@kroah.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC 1/2] kobject_set_name - error handling
Message-ID: <20040504053908.GA2900@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040417082206.GM24997@parcelfarce.linux.theplanet.co.uk> <20040430101333.GB25296@in.ibm.com> <20040430101401.GC25296@in.ibm.com> <200404300748.14151.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404300748.14151.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 07:48:13AM -0500, Dmitry Torokhov wrote:
> On Friday 30 April 2004 05:14 am, Maneesh Soni wrote:
> 
> > diff -puN drivers/base/bus.c~kobject_set_name-cleanup-01 drivers/base/bus.c
> > --- linux-2.6.6-rc2-mm2/drivers/base/bus.c~kobject_set_name-cleanup-01	2004-04-30 15:14:03.000000000 +0530
> > +++ linux-2.6.6-rc2-mm2-maneesh/drivers/base/bus.c	2004-04-30 15:14:03.000000000 +0530
> > @@ -451,7 +451,9 @@ int bus_add_driver(struct device_driver 
> >  
> >  	if (bus) {
> >  		pr_debug("bus %s: add driver %s\n",bus->name,drv->name);
> > -		kobject_set_name(&drv->kobj,drv->name);
> > +		error = kobject_set_name(&drv->kobj,drv->name);
> > +		if (error)
> > +			return error;
> 
> Hi, I think you are leaking a reference here, put_bus() is needed.
> 
> >  		drv->kobj.kset = &bus->drivers;
> >  		if ((error = kobject_register(&drv->kobj))) {
> >  			put_bus(bus);
> 

Thanks for spotting it. Corrected patch is appended.

Greg, Are the patches fit for inclusion? I need to know this as my sysfs backing
store patches are taking back seats because of these changes, particulary the
one in second patch :-(.

Thanks
Maneesh


o The following patch cleans up the kobject_set_name() users. Basically checking
  return code from kobject_set_name(). There can be error returns like -ENOMEM
  or -EFAULT from kobject_set_name() if the name length exceeds KOBJ_NAME_LEN.


 drivers/base/bus.c |   14 +++++++++++---
 drivers/base/sys.c |    5 ++++-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff -puN drivers/base/sys.c~kobject_set_name-cleanup-01 drivers/base/sys.c
--- linux-2.6.6-rc3-mm1/drivers/base/sys.c~kobject_set_name-cleanup-01	2004-04-30 16:07:32.000000000 +0530
+++ linux-2.6.6-rc3-mm1-maneesh/drivers/base/sys.c	2004-04-30 16:07:32.000000000 +0530
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
--- linux-2.6.6-rc3-mm1/drivers/base/bus.c~kobject_set_name-cleanup-01	2004-04-30 16:07:32.000000000 +0530
+++ linux-2.6.6-rc3-mm1-maneesh/drivers/base/bus.c	2004-05-04 11:01:52.000000000 +0530
@@ -451,7 +451,11 @@ int bus_add_driver(struct device_driver 
 
 	if (bus) {
 		pr_debug("bus %s: add driver %s\n",bus->name,drv->name);
-		kobject_set_name(&drv->kobj,drv->name);
+		error = kobject_set_name(&drv->kobj,drv->name);
+		if (error) {
+			put_bus(bus)
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
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
