Return-Path: <linux-kernel-owner+w=401wt.eu-S1030352AbWLTUEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWLTUEa (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 15:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbWLTUEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 15:04:30 -0500
Received: from ns.suse.de ([195.135.220.2]:48913 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030343AbWLTUE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 15:04:29 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 1/3] kref refcnt and false positives
Date: Wed, 20 Dec 2006 12:03:55 -0800
Message-Id: <11666450372548-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.2
In-Reply-To: <20061220200151.GC1698@kroah.com>
References: <20061220200151.GC1698@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

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

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 lib/kref.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/lib/kref.c b/lib/kref.c
index 4a467fa..0d07cc3 100644
--- a/lib/kref.c
+++ b/lib/kref.c
@@ -52,12 +52,7 @@ int kref_put(struct kref *kref, void (*release)(struct kref *kref))
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
-- 
1.4.4.2

