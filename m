Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbTHUPAO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 11:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbTHUPAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 11:00:13 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:55011 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262697AbTHUPAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 11:00:07 -0400
Subject: Re: CPU boot problem on 2.6.0-test3-bk8
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Theurer <habanero@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <200308210910.07722.habanero@us.ibm.com>
References: <200308201658.05433.habanero@us.ibm.com>
	 <200308202013.51702.habanero@us.ibm.com>
	 <1061437329.15363.92.camel@nighthawk>
	 <200308210910.07722.habanero@us.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1061477929.18883.1633.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 21 Aug 2003 07:58:50 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-21 at 07:10, Andrew Theurer wrote:
> So we only loop for the actual number processors found in mpparse.c?  This 
> seems to work for me.

I think there's a reason it was done that way.  I think your patch 
breaks the visws subarch, too.

Could you mark up that loop a bit and printk a bit, so we can see which
continue you're missing?

<pasting patch lazily in email because I can't be bothered to actually copy it from the machine I"m working on>
diff -urp linux-2.6.0-test3-clean/arch/i386/kernel/smpboot.c linux-2.6.0-test3-work/arch/i386/kernel/smpboot.c
--- linux-2.6.0-test3-clean/arch/i386/kernel/smpboot.c  Wed Aug 20 19:54:29 2003
+++ linux-2.6.0-test3-work/arch/i386/kernel/smpboot.c   Wed Aug 20 20:19:41 2003
@@ -1020,24 +1020,30 @@ static void __init smp_boot_cpus(unsigne
        Dprintk("CPU present map: %lx\n", physids_coerce(phys_cpu_present_map));

        kicked = 1;
-       for (bit = 0; kicked < NR_CPUS && bit < MAX_APICS; bit++) {
+       for (bit = 0; kicked < NR_CPUS && bit < MAX_APICS; bit++, kicked++) {
                apicid = cpu_present_to_apicid(bit);
                /*
                 * Don't even attempt to start the boot CPU!
                 */
-               if ((apicid == boot_cpu_apicid) || (apicid == BAD_APICID))
+               printk("smp_boot_cpus() bit: %d\n", bit);
+               if ((apicid == boot_cpu_apicid) || (apicid == BAD_APICID)) {
+                       printk("(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)\n");
+                       printk("apicid: %08lx boot_cpu_apicid: %08lx BAD_APICID: %08lx\n", apicid, boot_cpu_apicid, BAD_APICID);
                        continue;
+               }

-               if (!check_apicid_present(bit))
+               if (!check_apicid_present(bit)) {
+                       printk("!check_apicid_present(bit)\n");
                        continue;
-               if (max_cpus <= cpucount+1)
+               }
+               if (max_cpus <= cpucount+1) {
+                       printk("(max_cpus <= cpucount+1)\n");
                        continue;
+               }

                if (do_boot_cpu(apicid))
                        printk("CPU #%d not responding - cannot use it.\n",
                                                                apicid);
-               else
-                       ++kicked;
        }

        /*
-- 
Dave Hansen
haveblue@us.ibm.com

