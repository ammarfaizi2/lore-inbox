Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWHAEOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWHAEOk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 00:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWHAEOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 00:14:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:25574 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932407AbWHAEOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 00:14:39 -0400
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Tony Luck <tony.luck@intel.com>, Jack Steiner <steiner@sgi.com>,
       Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       Dan Higgins <djh@sgi.com>
Date: Mon, 31 Jul 2006 21:14:33 -0700
Message-Id: <20060801041433.23919.69026.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] ia64: panic if topology_init kzalloc fails
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

There really is no sense trying to continue if the kzalloc of
sysfs_cpus[] fails in ia64 topology_init.  The code calling
into here doesn't check errors very well, and one ends up with
a nonobvious boot failure that wastes peoples time debugging.

See for example the lkml thread at:
  http://lkml.org/lkml/2006/3/2/215

Since the system is totally dead when this kzalloc fails, not
having yet even booted, might as well announce one's death
boldly and plainly.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 arch/ia64/kernel/topology.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- 2.6.18-rc2-mm1.orig/arch/ia64/kernel/topology.c	2006-07-31 17:18:04.921717318 -0700
+++ 2.6.18-rc2-mm1/arch/ia64/kernel/topology.c	2006-07-31 21:12:08.950508732 -0700
@@ -67,10 +67,8 @@ static int __init topology_init(void)
 #endif
 
 	sysfs_cpus = kzalloc(sizeof(struct ia64_cpu) * NR_CPUS, GFP_KERNEL);
-	if (!sysfs_cpus) {
-		err = -ENOMEM;
-		goto out;
-	}
+	if (!sysfs_cpus)
+		panic("kzalloc in topology_init failed - NR_CPUS too big?");
 
 	for_each_present_cpu(i) {
 		if((err = arch_register_cpu(i)))

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
