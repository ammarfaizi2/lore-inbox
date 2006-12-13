Return-Path: <linux-kernel-owner+w=401wt.eu-S1751816AbWLNAQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbWLNAQa (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 19:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbWLNAQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 19:16:30 -0500
Received: from mga07.intel.com ([143.182.124.22]:47624 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751816AbWLNAQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 19:16:28 -0500
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 19:16:28 EST
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,164,1165219200"; 
   d="scan'208"; a="157946433:sNHT77477057"
Date: Wed, 13 Dec 2006 15:34:08 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: gregkh@suse.de, Andrew Morton <akpm@osdl.org>
Cc: Arjan <arjan@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: kref refcnt and false positives
Message-ID: <20061213153408.A13049@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With WARN_ON addition to kobject_init()
[ http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19/2.6.19-mm1/dont-use/broken-out/gregkh-driver-kobject-warn.patch ]

I started seeing following WARNING on CPU offline followed by online on my
x86_64 system.

WARNING at lib/kobject.c:172 kobject_init()

Call Trace:
 [<ffffffff8020ab45>] dump_trace+0xaa/0x3ef
 [<ffffffff8020aec4>] show_trace+0x3a/0x50
 [<ffffffff8020b0f6>] dump_stack+0x15/0x17
 [<ffffffff80350abc>] kobject_init+0x3f/0x8a
 [<ffffffff80350be1>] kobject_register+0x1a/0x3e
 [<ffffffff803bbd89>] sysdev_register+0x5b/0xf9
 [<ffffffff80211d0b>] mce_create_device+0x77/0xf4
 [<ffffffff80211dc2>] mce_cpu_callback+0x3a/0xe5
 [<ffffffff805632fd>] notifier_call_chain+0x26/0x3b
 [<ffffffff8023f6f3>] raw_notifier_call_chain+0x9/0xb
 [<ffffffff802519bf>] _cpu_up+0xb4/0xdc
 [<ffffffff80251a12>] cpu_up+0x2b/0x42
 [<ffffffff803bef00>] store_online+0x4a/0x72
 [<ffffffff803bb6ce>] sysdev_store+0x24/0x26
 [<ffffffff802baaa2>] sysfs_write_file+0xcf/0xfc
 [<ffffffff8027fc6f>] vfs_write+0xae/0x154
 [<ffffffff80280418>] sys_write+0x47/0x6f
 [<ffffffff8020963e>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83
Leftover inexact backtrace:

This is a false positive as mce.c is unregistering/registering sysfs
interfaces cleanly on hotplug.

kref_put() and conditional decrement of refcnt seems to be the root cause
for this and the patch below resolves the issue for me.

Original comment seemed to indicate that this conditional thing was
performance related. Is it really? If not, we should consider the below patch.

Thanks,
Venki





Now that kobject_init has a WARN_ON for refcnt, change below is needed
to avoid false positives.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.19-rc-mm/lib/kref.c
===================================================================
--- linux-2.6.19-rc-mm.orig/lib/kref.c
+++ linux-2.6.19-rc-mm/lib/kref.c
@@ -52,12 +52,7 @@ int kref_put(struct kref *kref, void (*r
 	WARN_ON(release == NULL);
 	WARN_ON(release == (void (*)(struct kref *))kfree);
 
-	/*
-	 * if current count is one, we are the last user and can release object
-	 * right now, avoiding an atomic operation on 'refcount'
-	 */
-	if ((atomic_read(&kref->refcount) == 1) ||
-	    (atomic_dec_and_test(&kref->refcount))) {
+	if (atomic_dec_and_test(&kref->refcount)) {
 		release(kref);
 		return 1;
 	}
