Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbTIEHwb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 03:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbTIEHwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 03:52:31 -0400
Received: from [139.30.44.2] ([139.30.44.2]:45767 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S261625AbTIEHwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 03:52:30 -0400
Date: Fri, 5 Sep 2003 09:51:59 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: john stultz <johnstul@us.ibm.com>
cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Dave H <haveblue@us.ibm.com>
Subject: Re: [RFC] NR_CPUS=8 on a 32 cpu box
In-Reply-To: <1062725220.1307.1562.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.33.0309050943240.15467-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (num_processors > NR_CPUS){
> +		printk(KERN_WARNING "NR_CPUS limit of %i reached. Cannot boot CPU(apicid 0x%d).\n", NR_CPUS, m->mpc_apicid);

I'm no expert in this field at all, but doesnt this need to check for '>=' ?

Also, the code following the check could get some reordering for
readability. How about the following:

--- linux-2.6.0-test4/arch/i386/kernel/mpparse.c.orig	Fri Sep  5 09:40:07 2003
+++ linux-2.6.0-test4/arch/i386/kernel/mpparse.c	Fri Sep  5 09:50:11 2003
@@ -167,15 +167,18 @@
 		boot_cpu_logical_apicid = apicid;
 	}

-	num_processors++;
-
 	if (MAX_APICS - m->mpc_apicid <= 0) {
 		printk(KERN_WARNING "Processor #%d INVALID. (Max ID: %d).\n",
 			m->mpc_apicid, MAX_APICS);
-		--num_processors;
 		return;
 	}
 	ver = m->mpc_apicver;
+
+	if (num_processors >= NR_CPUS){
+		printk(KERN_WARNING "NR_CPUS limit of %i reached. Cannot boot CPU(apicid 0x%d).\n", NR_CPUS, m->mpc_apicid);
+		return;
+	}
+	num_processors++;

 	tmp = apicid_to_cpu_present(apicid);
 	physids_or(phys_cpu_present_map, phys_cpu_present_map, tmp);

Tim

