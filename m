Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbUKJWYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbUKJWYp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 17:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbUKJWYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 17:24:07 -0500
Received: from fmr03.intel.com ([143.183.121.5]:18088 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262040AbUKJWYD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 17:24:03 -0500
Date: Wed, 10 Nov 2004 14:19:23 -0800
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Greg KH <greg@kroah.com>
Cc: Hotplug List <linux-hotplug-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] kobject: fix double kobject_put in kobject_unregister()
Message-ID: <20041110141923.A13668@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
	
This patch fixes the problem where in kobject resources were getting
freed when those kobject were still in use due to double kobject_put()
getting called in the kobject_unregister() code path.

With out this patch kobject_unregister() will have some serious side effects.

Please apply.

signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>


 linux-2.6.10-rc1-mm4-askeshav/lib/kobject.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN lib/kobject.c~kobject_unregister_fix lib/kobject.c
--- linux-2.6.10-rc1-mm4/lib/kobject.c~kobject_unregister_fix	2004-11-10 13:43:42.243877455 -0800
+++ linux-2.6.10-rc1-mm4-askeshav/lib/kobject.c	2004-11-10 13:46:30.788797265 -0800
@@ -301,6 +301,8 @@ void kobject_del(struct kobject * kobj)
 {
 	kobject_hotplug(kobj, KOBJ_REMOVE);
 	sysfs_remove_dir(kobj);
+
+	/* unlink does kobject_put() for us */
 	unlink(kobj);
 }
 
@@ -313,7 +315,6 @@ void kobject_unregister(struct kobject *
 {
 	pr_debug("kobject %s: unregistering\n",kobject_name(kobj));
 	kobject_del(kobj);
-	kobject_put(kobj);
 }
 
 /**
_
