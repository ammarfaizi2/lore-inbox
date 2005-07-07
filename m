Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVGGJaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVGGJaW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 05:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVGGJaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 05:30:21 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:45462 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261243AbVGGJ3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 05:29:18 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Jon Schindler" <jonschindler@hotmail.com>
Subject: Re: Kernel Oops with dual core athlon 64
Date: Thu, 7 Jul 2005 11:29:38 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <BAY20-F42FDD187485A266D3988B6C4D80@phx.gbl>
In-Reply-To: <BAY20-F42FDD187485A266D3988B6C4D80@phx.gbl>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CYPzCK9dLnFHETU"
Message-Id: <200507071129.38714.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_CYPzCK9dLnFHETU
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Thursday, 7 of July 2005 07:58, Jon Schindler wrote:
> The dmesg is below.  After I get this Oops, I am unable to use my (PS/2) 
> keyboard, and had to ssh to my machine in order to save a copy of dmesg 
> before rebooting the machine.  I've seen a couple of other users of dual 
> core machings having this problem.  The suggestion so far has been to remove 
> the binary nvidia driver and repoducde the bug.  So, I went ahead and 
> removed the nvidia driver and used the deprecated nv driver that comes with 
> X11 and I still have this issue.  Does anyone have any ideas what might be 
> causing this?  Thanks in advance for the help.  I don't know my way around 
> the kernel, but I do have experience with C and should be able to apply any 
> SMP patches if you want me to test it

It seems to be a cpufreq issue.  You can try to apply the attached patch from
Mark Langsdorf.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--Boundary-00=_CYPzCK9dLnFHETU
Content-Type: text/x-diff;
  charset="utf-8";
  name="jhpn-2.6.12-rc6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="jhpn-2.6.12-rc6.patch"

--- linux-2.6.12-rc6/arch/i386/kernel/cpu/cpufreq/powernow-k8.c.old	2005-06-12 17:41:55.123651184 -0500
+++ linux-2.6.12-rc6/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2005-06-12 17:46:32.780440936 -0500
@@ -44,7 +44,7 @@
 
 #define PFX "powernow-k8: "
 #define BFX PFX "BIOS error: "
-#define VERSION "version 1.40.2"
+#define VERSION "version 1.40.4"
 #include "powernow-k8.h"
 
 /* serialize freq changes  */
@@ -978,7 +978,7 @@
 {
 	struct powernow_k8_data *data;
 	cpumask_t oldmask = CPU_MASK_ALL;
-	int rc;
+	int rc, i;
 
 	if (!check_supported_cpu(pol->cpu))
 		return -ENODEV;
@@ -1064,7 +1064,9 @@
 	printk("cpu_init done, current fid 0x%x, vid 0x%x\n",
 	       data->currfid, data->currvid);
 
-	powernow_data[pol->cpu] = data;
+	for_each_cpu_mask(i, cpu_core_map[pol->cpu]) {
+		powernow_data[i] = data;
+	}
 
 	return 0;
 

--Boundary-00=_CYPzCK9dLnFHETU--
