Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUDIUnb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 16:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbUDIUnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 16:43:31 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:32903 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261735AbUDIUnW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 16:43:22 -0400
Message-ID: <40770AD0.4000402@us.ibm.com>
Date: Fri, 09 Apr 2004 15:42:56 -0500
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] call_usermodehelper hang
References: <4072F2B7.2070605@us.ibm.com> <20040406172903.186dd5f1.akpm@osdl.org> <20040407061146.GA10413@kroah.com> <407487A6.8020904@us.ibm.com> <20040408224713.GD15125@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------060802000009080903040107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060802000009080903040107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Wed, Apr 07, 2004 at 05:58:46PM -0500, Brian King wrote:
> 
>>The following patch fixes a deadlock experienced when devices are
>>being added to a bus both from a user process and eventd process.
>>The eventd process was hung waiting on dev->bus->subsys.rwsem which
>>was held by another process, which was hung since it was calling 
>>call_usermodehelper directly which was hung waiting for work scheduled
>>on the eventd workqueue to complete. The patch fixes this by delaying
>>the kobject_hotplug work, running it from eventd if possible. 
> 
> 
> But why?  Will this not still cause the same deadlock eventually?  The
> call_usermodehelper function uses keventd, so what about users who call
> that function directly?

It fixes the problem as long as the rule of not holding locks/semaphores
when calling call_usermodehelper holds. I don't see how the deadlock can occur
for the scenario I hit with the fix, since the hotplug action runs completely
asynchronously without the semaphore that was causing the deadlock. Now, could
there be other places in the kernel today that call call_usermodehelper with
locks that could also have deadlock issues? Probably.

Would you prefer a fix in call_usermodehelper itself? It could certainly
be argued that calling call_usermodehelper with wait=0 should be allowed
even when holding locks. Although, fixing it here is less obvious to me
how to do because of the arguments to call_usermodehelper. I would imagine
it would consist of creating a kernel_thread to preserve the caller's stack.

> Also, you gratitously changed some of the whitespace in the file you
> were modifying, which isn't a nice thing to do :)

Sorry about that. Attached is a patch which fixes this. If call_usermodehelper
is the proper place to fix this, then I'll look into rolling a new patch.


Thanks

-Brian



-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

--------------060802000009080903040107
Content-Type: text/plain;
 name="kobject_hotplug_hang.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kobject_hotplug_hang.patch"


The following patch fixes a deadlock experienced when devices are
being added to a bus both from a user process and eventd process.
The eventd process was hung waiting on dev->bus->subsys.rwsem which
was held by another process, which was hung since it was calling 
call_usermodehelper directly which was hung waiting for work scheduled
on the eventd workqueue to complete. The patch fixes this by delaying
the kobject_hotplug work, running it from eventd if possible. 

Backtraces of the hang:

0xc0000000017df300        1        0  0    0   D  0xc0000000017df7b0
 swapper

          SP(esp)            PC(eip)      Function(args)
0xc00000003fc9f460  0x0000000000000000  NO_SYMBOL or Userspace
0xc00000003fc9f4f0  0xc000000000058c40  .schedule +0xb4
0xc00000003fc9f5c0  0xc00000000005a464  .wait_for_completion +0x138
0xc00000003fc9f6c0  0xc00000000007c594  .call_usermodehelper +0x104
0xc00000003fc9f810  0xc00000000022d3e8  .kobject_hotplug +0x3c4
0xc00000003fc9f900  0xc00000000022d67c  .kobject_add +0x134
0xc00000003fc9f9a0  0xc00000000012b3d8  .register_disk +0x70
0xc00000003fc9fa40  0xc00000000027dfe4  .add_disk +0x60
0xc00000003fc9fad0  0xc0000000002dc7dc  .sd_probe +0x290
0xc00000003fc9fb80  0xc00000000026fbe8  .bus_match +0x94
0xc00000003fc9fc10  0xc00000000026ff70  .driver_attach +0x8c
0xc00000003fc9fca0  0xc000000000270104  .bus_add_driver +0x110
0xc00000003fc9fd50  0xc000000000270a18  .driver_register +0x38
0xc00000003fc9fdd0  0xc0000000002cd8f8  .scsi_register_driver +0x28
0xc00000003fc9fe50  0xc0000000004941d8  .init_sd +0x8c
0xc00000003fc9fee0  0xc00000000000c720  .init +0x25c
0xc00000003fc9ff90  0xc0000000000183ec  .kernel_thread +0x4c


0xc00000003fab3380        4        1  0    0   D  0xc00000003fab3830 
 events/0

          SP(esp)            PC(eip)      Function(args)
0xc00000003faaf6e0  0x0000000000000000  NO_SYMBOL or Userspace
0xc00000003faaf770  0xc000000000058c40  .schedule +0xb4
0xc00000003faaf840  0xc00000000022fa20  .rwsem_down_write_failed +0x14c
0xc00000003faaf910  0xc00000000026fed0  .bus_add_device +0x11c
0xc00000003faaf9b0  0xc00000000026e288  .device_add +0xd0
0xc00000003faafa50  0xc0000000002cdb00  .scsi_sysfs_add_sdev +0x8c
0xc00000003faafb00  0xc0000000002cbff8  .scsi_probe_and_add_lun +0xb04
0xc00000003faafc00  0xc0000000002ccca0  .scsi_add_device +0x90
0xc00000003faafcb0  0xc0000000002d9458  .ipr_worker_thread +0xc60
0xc00000003faafdc0  0xc00000000007cd9c  .worker_thread +0x268
0xc00000003faafee0  0xc0000000000839cc  .kthread +0x160
0xc00000003faaff90  0xc0000000000183ec  .kernel_thread +0x4c


---


diff -puN lib/kobject.c~kobject_hotplug_hang lib/kobject.c
--- linux-2.6.5/lib/kobject.c~kobject_hotplug_hang	Wed Apr  7 15:48:14 2004
+++ linux-2.6.5-bjking1/lib/kobject.c	Thu Apr  8 18:27:01 2004
@@ -103,8 +103,14 @@ static void fill_kobj_path(struct kset *
 static unsigned long sequence_num;
 static spinlock_t sequence_lock = SPIN_LOCK_UNLOCKED;
 
-static void kset_hotplug(const char *action, struct kset *kset,
-			 struct kobject *kobj)
+struct hotplug_work {
+	struct work_struct work;
+	const char *action;
+	struct kset *kset;
+	struct kobject *kobj;
+};
+
+static void kset_hotplug_work(void *data)
 {
 	char *argv [3];
 	char **envp = NULL;
@@ -116,22 +122,26 @@ static void kset_hotplug(const char *act
 	char *kobj_path = NULL;
 	char *name = NULL;
 	unsigned long seq;
+	struct hotplug_work *work = (struct hotplug_work *)data;
+	const char *action = work->action;
+	struct kset *kset = work->kset;
+	struct kobject *kobj = work->kobj;
 
 	/* If the kset has a filter operation, call it. If it returns
 	   failure, no hotplug event is required. */
 	if (kset->hotplug_ops->filter) {
 		if (!kset->hotplug_ops->filter(kset, kobj))
-			return;
+			goto exit;
 	}
 
 	pr_debug ("%s\n", __FUNCTION__);
 
 	if (!hotplug_path[0])
-		return;
+		goto exit;
 
 	envp = kmalloc(NUM_ENVP * sizeof (char *), GFP_KERNEL);
 	if (!envp)
-		return;
+		goto exit;
 	memset (envp, 0x00, NUM_ENVP * sizeof (char *));
 
 	buffer = kmalloc(BUFFER_SIZE, GFP_KERNEL);
@@ -193,10 +203,40 @@ static void kset_hotplug(const char *act
 			  __FUNCTION__, retval);
 
 exit:
+	kset_put(kset);
+	kobject_put(kobj);
 	kfree(kobj_path);
+	kfree(work);
 	kfree(buffer);
 	kfree(envp);
-	return;
+}
+
+static void kset_hotplug(const char *action, struct kset *kset,
+			 struct kobject *kobj)
+{
+	struct hotplug_work *work;
+
+	if (!(work = kmalloc(sizeof(*work), GFP_KERNEL)))
+		return;
+
+	work->action = action;
+	if (!(work->kset = kset_get(kset))) {
+		kfree(work);
+		return;
+	}
+
+	if (!(work->kobj = kobject_get(kobj))) {
+		kset_put(kset);
+		kfree(work);
+		return;
+	}
+
+	INIT_WORK(&work->work, kset_hotplug_work, work);
+
+	if (keventd_up())
+		schedule_work(&work->work);
+	else
+		kset_hotplug_work(work);
 }
 
 void kobject_hotplug(const char *action, struct kobject *kobj)

_

--------------060802000009080903040107--

