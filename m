Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbTFORvL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 13:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbTFORvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 13:51:11 -0400
Received: from ossipee.unh.edu ([132.177.137.39]:44505 "EHLO ossipee.unh.edu")
	by vger.kernel.org with ESMTP id S262488AbTFORuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 13:50:52 -0400
Date: Sun, 15 Jun 2003 14:04:36 -0400
From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
To: Dominik Brodowski <linux@brodo.de>, torvalds@transmeta.com
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: [2.5 PATCH] bug if cpufreq driver initialization fails
Message-ID: <20030615180435.GC686@bouh.unh.edu>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
Mail-Followup-To: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>,
	Dominik Brodowski <linux@brodo.de>, torvalds@transmeta.com,
	cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
References: <20021108092241.A1636@brodo.de> <20030614084611.GA10182@bouh.unh.edu> <20030614095646.GA1702@brodo.de> <20030614214943.GA4073@bouh.unh.edu> <20030615095044.GD2009@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030615095044.GD2009@brodo.de>
User-Agent: Mutt/1.4i-nntp
X-MailScanner-Information: http://pubpages.unh.edu/notes/mailfiltering.html
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-8.8, required 5,
	BAYES_10, IN_REP_TO, PATCH_UNIFIED_DIFF, QUOTED_EMAIL_TEXT,
	REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_MUTT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le dim 15 jun 2003 11:50:44 GMT, Dominik Brodowski a tapoté sur son clavier :
> > However, my 440BX chipset is still not supported, and I couldn't find
> > anything in Intel's documentation...
> 
> Do you know of Bruno Ducrot's work? 
> 
> http://www.poupinou.org/cpufreq/

I read the list archive yesterday, and tried this work. I got the results
http://youpibouh.thefreecat.org/speedstep/ac
http://youpibouh.thefreecat.org/speedstep/battery
and hence tried my gpo_hilo=11, and it works... Sometimes.

I seems like the hardware si sometimes slow to get to the low speed. My
PIII is a 800Mhz/650Mhz, but initialization sometimes shows 800 and 800,
as if the speed measure was done before the hardware actually achieved
the slow down.

As a result, speedstep_cpu_init() fails, hence cpufreq_add_dev() fails,
which is ignored by sysdev_driver_register(). In the end, the module is
kept loaded (since speedstep_init() successes, since
cpufreq_register_driver successes()), and I have to unload it by hand,
which entails kobject badness warning of course, since cpufreq then
tries to remove entries which were actually never added to /sys!

I hence modified drivers/base/sys.c to have sysdev_driver_register()
fail as well, and then I also had to modify kernel/cpufreq.c, because
this failure did not imply a setting cpufreq_driver to NULL (preventing
me from reinsmoding speedstep-ich: EBUSY)

I'd also suggest that the speedstep drivers printks something if
everything went ok (including the cpufreq_frequency_table_cpuinfo()
call), the low & high speed for instance, just to be sure everything
went ok

Regards,
Samuel Thibault

--- linux-2.5.71-orig/drivers/base/sys.c	2003-06-14 17:12:52.000000000 -0400
+++ linux-2.5.71-perso/drivers/base/sys.c	2003-06-15 13:47:45.000000000 -0400
@@ -116,6 +116,7 @@
 int sysdev_driver_register(struct sysdev_class * cls, 
 			   struct sysdev_driver * drv)
 {
+	int ret = 0;
 	down_write(&system_subsys.rwsem);
 	if (cls && kset_get(&cls->kset)) {
 		list_add_tail(&drv->entry,&cls->drivers);
@@ -123,13 +124,16 @@
 		/* If devices of this class already exist, tell the driver */
 		if (drv->add) {
 			struct sys_device *dev;
-			list_for_each_entry(dev, &cls->kset.list, kobj.entry)
-				drv->add(dev);
+			list_for_each_entry(dev, &cls->kset.list, kobj.entry) {
+				ret = drv->add(dev);
+				if (ret) goto out;
+			}
 		}
 	} else
 		list_add_tail(&drv->entry,&global_drivers);
+out:
 	up_write(&system_subsys.rwsem);
-	return 0;
+	return ret;
 }
 
 
--- linux-2.5.71-orig/kernel/cpufreq.c	2003-06-14 17:13:39.000000000 -0400
+++ linux-2.5.71-perso/kernel/cpufreq.c	2003-06-15 13:55:36.000000000 -0400
@@ -811,6 +811,8 @@
  */
 int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 {
+	int ret;
+
 	if (!driver_data || !driver_data->verify || !driver_data->init ||
 	    ((!driver_data->setpolicy) && (!driver_data->target)))
 		return -EINVAL;
@@ -825,13 +827,17 @@
 
 	cpufreq_driver->policy = kmalloc(NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
 	if (!cpufreq_driver->policy) {
-		cpufreq_driver = NULL;
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 
 	memset(cpufreq_driver->policy, 0, NR_CPUS * sizeof(struct cpufreq_policy));
 
-	return sysdev_driver_register(&cpu_sysdev_class,&cpufreq_sysdev_driver);
+	ret = sysdev_driver_register(&cpu_sysdev_class,&cpufreq_sysdev_driver);
+out:
+	if (ret)
+		cpufreq_driver = NULL;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(cpufreq_register_driver);
 
