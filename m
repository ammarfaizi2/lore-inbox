Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUJESZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUJESZZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 14:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUJESZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 14:25:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:60333 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261169AbUJESZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 14:25:08 -0400
Date: Tue, 5 Oct 2004 11:23:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: jeffpc@optonline.net, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       trivial@rustcorp.com.au, rusty@rustcorp.com.au, greg@kroah.com
Subject: Re: [PATCH 2.6][resend] Add DEVPATH env variable to hotplug helper
 call
Message-Id: <20041005112309.1215b350.akpm@osdl.org>
In-Reply-To: <20041005110112.B27795@unix-os.sc.intel.com>
References: <20041003100857.GB5804@optonline.net>
	<20041003162012.79296b37.akpm@osdl.org>
	<20041004102220.A3304@unix-os.sc.intel.com>
	<20041004123725.58f1e77c.akpm@osdl.org>
	<20041004124355.A17894@unix-os.sc.intel.com>
	<20041005012556.A22721@unix-os.sc.intel.com>
	<20041005101823.223573d9.akpm@osdl.org>
	<20041005102706.A27795@unix-os.sc.intel.com>
	<20041005104744.59177aea.akpm@osdl.org>
	<20041005110112.B27795@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com> wrote:
>
>  	I am attaching the second one, just to make sure you and I have the same one.
>  If this is different than what you are having let me know.

yes, it's different from the one I'm using.  I'm using the below, which I
sent you an hour ago.

>  By the way I am testing on IA64 box, with 2.6.9-rc3 + just bk-driver-core.patch from 
>  your 2.6.9-rc3-mm2-broken-out.tar.
>  I had to go for just above as I was seeing some out of memory messages on my IA64 box
>  with complete rc3-mm2 patch.

yes, my ia64 box goes oom during boot too.  Something's broken in Tony's
ia64 tree.




Make kobject_hotplug() work even if the kobject's kset doesn't implement any
hotplug_ops.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/lib/kobject_uevent.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff -puN lib/kobject_uevent.c~kobject_hotplug-no-hotplug_ops lib/kobject_uevent.c
--- 25/lib/kobject_uevent.c~kobject_hotplug-no-hotplug_ops	2004-10-05 10:11:59.404291240 -0700
+++ 25-akpm/lib/kobject_uevent.c	2004-10-05 10:13:59.132089848 -0700
@@ -191,6 +191,8 @@ void kobject_hotplug(struct kobject *kob
 	u64 seq;
 	struct kobject *top_kobj = kobj;
 	struct kset *kset;
+	static struct kset_hotplug_ops null_hotplug_ops;
+	struct kset_hotplug_ops *hotplug_ops = &null_hotplug_ops;
 
 	if (!top_kobj->kset && top_kobj->parent) {
 		do {
@@ -198,15 +200,18 @@ void kobject_hotplug(struct kobject *kob
 		} while (!top_kobj->kset && top_kobj->parent);
 	}
 
-	if (top_kobj->kset && top_kobj->kset->hotplug_ops)
+	if (top_kobj->kset)
 		kset = top_kobj->kset;
 	else
 		return;
 
+	if (kset->hotplug_ops)
+		hotplug_ops = kset->hotplug_ops;
+
 	/* If the kset has a filter operation, call it.
 	   Skip the event, if the filter returns zero. */
-	if (kset->hotplug_ops->filter) {
-		if (!kset->hotplug_ops->filter(kset, kobj))
+	if (hotplug_ops->filter) {
+		if (!hotplug_ops->filter(kset, kobj))
 			return;
 	}
 
@@ -225,8 +230,8 @@ void kobject_hotplug(struct kobject *kob
 	if (!buffer)
 		goto exit;
 
-	if (kset->hotplug_ops->name)
-		name = kset->hotplug_ops->name(kset, kobj);
+	if (hotplug_ops->name)
+		name = hotplug_ops->name(kset, kobj);
 	if (name == NULL)
 		name = kset->kobj.name;
 
@@ -260,9 +265,9 @@ void kobject_hotplug(struct kobject *kob
 	envp [i++] = scratch;
 	scratch += sprintf(scratch, "SUBSYSTEM=%s", name) + 1;
 
-	if (kset->hotplug_ops->hotplug) {
+	if (hotplug_ops->hotplug) {
 		/* have the kset specific function add its stuff */
-		retval = kset->hotplug_ops->hotplug (kset, kobj,
+		retval = hotplug_ops->hotplug (kset, kobj,
 				  &envp[i], NUM_ENVP - i, scratch,
 				  BUFFER_SIZE - (scratch - buffer));
 		if (retval) {
_

