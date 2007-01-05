Return-Path: <linux-kernel-owner+w=401wt.eu-S1030305AbXAEDpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbXAEDpE (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 22:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030316AbXAEDpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 22:45:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:7670 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030305AbXAEDpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 22:45:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent:from;
        b=CNYa0jRCrnG/+zpW3RZOXK7LK70N+Vj0jCM+t9xWkXeiKLz27h0BFcFITDonRZvGNWFl2ECzcuE7mvK/s2s7iX4Bg1siYQX/yRxQ14a+LN5GuOd3wZTnLDv7xr5zwnFVW9yoQE98/iIN+wPtgiDqLCem4f4MTFglNxojYUTOGCE=
Date: Fri, 5 Jan 2007 05:44:54 +0200
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
Subject: [PATCH 2.6.20-rc3] cpufreq: check sysfs_create_link return value
Message-ID: <20070105034454.GA5974@Ahmed>
Mail-Followup-To: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org,
	cpufreq@lists.linux.org.uk
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial patch to check sysfs_create_link return values. Fail gracefully 
if needed.

Signed-off-by: Ahmed Darwish <darwish.07@gmail.com>

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d913304..72ee576 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -722,8 +722,13 @@ static int cpufreq_add_dev (struct sys_device * sys_dev)
 			spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 			dprintk("CPU already managed, adding link\n");
-			sysfs_create_link(&sys_dev->kobj,
-					  &managed_policy->kobj, "cpufreq");
+			ret = sysfs_create_link(&sys_dev->kobj,
+						&managed_policy->kobj, 
+						"cpufreq");
+			if (ret) {
+				mutex_unlock(&policy->lock);
+				goto err_out_driver_exit;
+			}
 
 			cpufreq_debug_enable_ratelimit();
 			mutex_unlock(&policy->lock);
@@ -770,8 +775,12 @@ static int cpufreq_add_dev (struct sys_device * sys_dev)
 		dprintk("CPU %u already managed, adding link\n", j);
 		cpufreq_cpu_get(cpu);
 		cpu_sys_dev = get_cpu_sysdev(j);
-		sysfs_create_link(&cpu_sys_dev->kobj, &policy->kobj,
-				  "cpufreq");
+		ret = sysfs_create_link(&cpu_sys_dev->kobj, &policy->kobj,
+					"cpufreq");
+		if (ret) {
+			mutex_unlock(&policy->lock);
+			goto err_out_unregister;
+		}
 	}
 
 	policy->governor = NULL; /* to assure that the starting sequence is


-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
