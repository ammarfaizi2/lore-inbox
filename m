Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269079AbUJERVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269079AbUJERVK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 13:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269093AbUJERVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 13:21:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:22250 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269079AbUJERVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 13:21:05 -0400
Date: Tue, 5 Oct 2004 10:18:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: jeffpc@optonline.net, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       trivial@rustcorp.com.au, rusty@rustcorp.com.au, greg@kroah.com
Subject: Re: [PATCH 2.6][resend] Add DEVPATH env variable to hotplug helper
 call
Message-Id: <20041005101823.223573d9.akpm@osdl.org>
In-Reply-To: <20041005012556.A22721@unix-os.sc.intel.com>
References: <20041003100857.GB5804@optonline.net>
	<20041003162012.79296b37.akpm@osdl.org>
	<20041004102220.A3304@unix-os.sc.intel.com>
	<20041004123725.58f1e77c.akpm@osdl.org>
	<20041004124355.A17894@unix-os.sc.intel.com>
	<20041005012556.A22721@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com> wrote:
>
> 	Here is what I have come up with(please take a look at this patch).
>  I was successfully able to get rid of cpu_run_sbin_hotplug() function, but
>  when I call kobject_hotplug() function, it is finding 
>  top_kobj->kset->hotplug_ops set to NULL and hence returns without calling
>  call_usermodehelper(). Not sure if this is a bug in kobject_hotplug(), 
>  I feel kobject_hotplug() function should continue even if 
>  top_kobj->kset-hotplug_ops is NULL.

Yes, it doesn't seem necessary.  We could give cpu_sysdev_class a
valid-but-empty hotplug_ops but it seems simpler and more general to do it
in kobject_hotplug().



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

