Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbULCJyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbULCJyG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 04:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbULCJyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 04:54:06 -0500
Received: from aun.it.uu.se ([130.238.12.36]:41675 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262133AbULCJwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 04:52:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16816.14159.597170.829515@alkaid.it.uu.se>
Date: Fri, 3 Dec 2004 10:52:15 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.10-rc2-mm4] perfctr sysfs update 1/4: core
In-Reply-To: <20041202185918.GA8264@kroah.com>
References: <200412021010.iB2AAORk004531@alkaid.it.uu.se>
	<20041202185918.GA8264@kroah.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:
 > On Thu, Dec 02, 2004 at 11:10:24AM +0100, Mikael Pettersson wrote:
 > > +static int __init perfctr_class_init(void)
 > > +{
 > > +	int ret;
 > > +
 > > +	ret = class_register(&perfctr_class);
 > > +	if (ret)
 > > +		return ret;
 > > +	ret |= class_create_file(&perfctr_class, &class_attr_driver_version);
 > > +	ret |= class_create_file(&perfctr_class, &class_attr_cpu_type);
 > > +	ret |= class_create_file(&perfctr_class, &class_attr_cpu_features);
 > > +	ret |= class_create_file(&perfctr_class, &class_attr_cpu_khz);
 > > +	ret |= class_create_file(&perfctr_class, &class_attr_tsc_to_cpu_mult);
 > > +	ret |= class_create_file(&perfctr_class, &class_attr_cpus_online);
 > > +	ret |= class_create_file(&perfctr_class, &class_attr_cpus_forbidden);
 > > +	if (ret)
 > > +		class_unregister(&perfctr_class);
 > > +	return ret;
 > 
 > It's easier to use sysfs_create_group() instead of registering all of
 > the individual files.

Thanks for the hint. While looking around I noticed I can simplify
it even further by having perfctr_class.class_attrs point to an array
of attributes at class_register() time.

Perfctr sysfs update:
- Simplify perfctr sysfs code.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/init.c |   58 ++++++++++++++++++-------------------------------
 1 files changed, 22 insertions(+), 36 deletions(-)

diff -rupN linux-2.6.10-rc2-mm4/drivers/perfctr/init.c linux-2.6.10-rc2-mm4.perfctr-core-update2/drivers/perfctr/init.c
--- linux-2.6.10-rc2-mm4/drivers/perfctr/init.c	2004-12-03 01:52:19.000000000 +0100
+++ linux-2.6.10-rc2-mm4.perfctr-core-update2/drivers/perfctr/init.c	2004-12-03 01:51:37.000000000 +0100
@@ -22,81 +22,67 @@ struct perfctr_info perfctr_info = {
 	.driver_version = VERSION,
 };
 
-static struct class perfctr_class = {
-	.name		= "perfctr",
-};
-
 static ssize_t
-perfctr_show_driver_version(struct class *class, char *buf)
+driver_version_show(struct class *class, char *buf)
 {
 	return sprintf(buf, "%s\n", perfctr_info.driver_version);
 }
-static CLASS_ATTR(driver_version,0444,perfctr_show_driver_version,NULL);
 
 static ssize_t
-perfctr_show_cpu_type(struct class *class, char *buf)
+cpu_type_show(struct class *class, char *buf)
 {
 	return sprintf(buf, "%#x\n", perfctr_info.cpu_type);
 }
-static CLASS_ATTR(cpu_type,0444,perfctr_show_cpu_type,NULL);
 
 static ssize_t
-perfctr_show_cpu_features(struct class *class, char *buf)
+cpu_features_show(struct class *class, char *buf)
 {
 	return sprintf(buf, "%#x\n", perfctr_info.cpu_features);
 }
-static CLASS_ATTR(cpu_features,0444,perfctr_show_cpu_features,NULL);
 
 static ssize_t
-perfctr_show_cpu_khz(struct class *class, char *buf)
+cpu_khz_show(struct class *class, char *buf)
 {
 	return sprintf(buf, "%u\n", perfctr_info.cpu_khz);
 }
-static CLASS_ATTR(cpu_khz,0444,perfctr_show_cpu_khz,NULL);
 
 static ssize_t
-perfctr_show_tsc_to_cpu_mult(struct class *class, char *buf)
+tsc_to_cpu_mult_show(struct class *class, char *buf)
 {
 	return sprintf(buf, "%u\n", perfctr_info.tsc_to_cpu_mult);
 }
-static CLASS_ATTR(tsc_to_cpu_mult,0444,perfctr_show_tsc_to_cpu_mult,NULL);
 
 static ssize_t
-perfctr_show_cpus_online(struct class *class, char *buf)
+cpus_online_show(struct class *class, char *buf)
 {
 	int ret = cpumask_scnprintf(buf, PAGE_SIZE-1, cpu_online_map);
 	buf[ret++] = '\n';
 	return ret;
 }
-static CLASS_ATTR(cpus_online,0444,perfctr_show_cpus_online,NULL);
 
 static ssize_t
-perfctr_show_cpus_forbidden(struct class *class, char *buf)
+cpus_forbidden_show(struct class *class, char *buf)
 {
 	int ret = cpumask_scnprintf(buf, PAGE_SIZE-1, perfctr_cpus_forbidden_mask);
 	buf[ret++] = '\n';
 	return ret;
 }
-static CLASS_ATTR(cpus_forbidden,0444,perfctr_show_cpus_forbidden,NULL);
 
-static int __init perfctr_class_init(void)
-{
-	int ret;
+static struct class_attribute perfctr_class_attrs[] = {
+	__ATTR_RO(driver_version),
+	__ATTR_RO(cpu_type),
+	__ATTR_RO(cpu_features),
+	__ATTR_RO(cpu_khz),
+	__ATTR_RO(tsc_to_cpu_mult),
+	__ATTR_RO(cpus_online),
+	__ATTR_RO(cpus_forbidden),
+	__ATTR_NULL
+};
 
-	ret = class_register(&perfctr_class);
-	if (ret)
-		return ret;
-	ret |= class_create_file(&perfctr_class, &class_attr_driver_version);
-	ret |= class_create_file(&perfctr_class, &class_attr_cpu_type);
-	ret |= class_create_file(&perfctr_class, &class_attr_cpu_features);
-	ret |= class_create_file(&perfctr_class, &class_attr_cpu_khz);
-	ret |= class_create_file(&perfctr_class, &class_attr_tsc_to_cpu_mult);
-	ret |= class_create_file(&perfctr_class, &class_attr_cpus_online);
-	ret |= class_create_file(&perfctr_class, &class_attr_cpus_forbidden);
-	if (ret)
-		class_unregister(&perfctr_class);
-	return ret;
-}
+static struct class perfctr_class = {
+	.name		= "perfctr",
+	.class_attrs	= perfctr_class_attrs,
+};
 
 char *perfctr_cpu_name __initdata;
 
@@ -112,7 +98,7 @@ static int __init perfctr_init(void)
 	err = vperfctr_init();
 	if (err)
 		return err;
-	err = perfctr_class_init();
+	err = class_register(&perfctr_class);
 	if (err) {
 		printk(KERN_ERR "perfctr: class initialisation failed\n");
 		return err;
