Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVHCHMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVHCHMQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 03:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVHCHJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 03:09:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57311 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262155AbVHCHI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 03:08:57 -0400
Date: Wed, 3 Aug 2005 00:07:52 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Daniel Drake <dsd@gentoo.org>,
       davej@redhat.com, Mark Langsdorf <mark.langsdorf@amd.com>
Subject: [13/13] Fix powernow oops on dual-core athlon
Message-ID: <20050803070752.GB7762@shell0.pdx.osdl.net>
References: <20050803064439.GO7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803064439.GO7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

powernow-k8 requires that a data structure for
each core be created in the _cpu_init function
call.  The cpufreq infrastructure doesn't call
_cpu_init for the second core in each processor.
Some systems crashed when _get was called with
an odd-numbered core because it tried to
dereference a NULL pointer since the data
structure had not been created.

The attached patch solves the problem by
initializing data structures for all shared
cores in the _cpu_init function.  It should
apply to 2.6.12-rc6 and has been tested by
AMD and Sun.

Signed-off-by: Mark Langsdorf <mark.langsdorf@amd.com>
Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---

--- a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
+++ b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
@@ -44,7 +44,7 @@
 
 #define PFX "powernow-k8: "
 #define BFX PFX "BIOS error: "
-#define VERSION "version 1.40.2"
+#define VERSION "version 1.40.4"
 #include "powernow-k8.h"
 
 /* serialize freq changes  */
@@ -978,7 +978,7 @@ static int __init powernowk8_cpu_init(st
 {
 	struct powernow_k8_data *data;
 	cpumask_t oldmask = CPU_MASK_ALL;
-	int rc;
+	int rc, i;
 
 	if (!check_supported_cpu(pol->cpu))
 		return -ENODEV;
@@ -1064,7 +1064,9 @@ static int __init powernowk8_cpu_init(st
 	printk("cpu_init done, current fid 0x%x, vid 0x%x\n",
 	       data->currfid, data->currvid);
 
-	powernow_data[pol->cpu] = data;
+	for_each_cpu_mask(i, cpu_core_map[pol->cpu]) {
+		powernow_data[i] = data;
+	}
 
 	return 0;
 
