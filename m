Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264156AbTDOXYE (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 19:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264157AbTDOXYE 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 19:24:04 -0400
Received: from [12.47.58.203] ([12.47.58.203]:433 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S264156AbTDOXYC convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 19:24:02 -0400
Date: Tue, 15 Apr 2003 16:34:56 -0700
From: Andrew Morton <akpm@digeo.com>
To: Philippe =?ISO-8859-1?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: 2.5.67-mm3: Bad: scheduling while atomic with IEEE1394 then
 hard freeze ( lockup on CPU0)
Message-Id: <20030415163456.020f83c1.akpm@digeo.com>
In-Reply-To: <20030416011728.196d66ca.philippe.gramoulle@mmania.com>
References: <20030416000501.342c216f.philippe.gramoulle@mmania.com>
	<20030415160530.2520c61c.akpm@digeo.com>
	<20030416011728.196d66ca.philippe.gramoulle@mmania.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 15 Apr 2003 23:35:47.0339 (UTC) FILETIME=[BDB085B0:01C303A7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Gramoullé <philippe.gramoulle@mmania.com> wrote:
>
> I'll wait for the fix and will happily try it once it's available.

Something like this...

diff -puN lib/kobject.c~kobj_lock-fix lib/kobject.c
--- 25/lib/kobject.c~kobj_lock-fix	Tue Apr 15 16:31:28 2003
+++ 25-akpm/lib/kobject.c	Tue Apr 15 16:34:33 2003
@@ -336,12 +336,14 @@ void kobject_unregister(struct kobject *
 struct kobject * kobject_get(struct kobject * kobj)
 {
 	struct kobject * ret = kobj;
-	spin_lock(&kobj_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&kobj_lock, flags);
 	if (kobj && atomic_read(&kobj->refcount) > 0)
 		atomic_inc(&kobj->refcount);
 	else
 		ret = NULL;
-	spin_unlock(&kobj_lock);
+	spin_unlock_irqrestore(&kobj_lock, flags);
 	return ret;
 }
 
@@ -371,10 +373,15 @@ void kobject_cleanup(struct kobject * ko
 
 void kobject_put(struct kobject * kobj)
 {
-	if (!atomic_dec_and_lock(&kobj->refcount, &kobj_lock))
-		return;
-	spin_unlock(&kobj_lock);
-	kobject_cleanup(kobj);
+	unsigned long flags;
+
+	local_irq_save(flags);
+	if (atomic_dec_and_lock(&kobj->refcount, &kobj_lock)) {
+		spin_unlock_irqrestore(&kobj_lock, flags);
+		kobject_cleanup(kobj);
+	} else {
+		local_irq_restore(flags);
+	}
 }
 
 

_

