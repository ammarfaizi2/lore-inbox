Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422694AbWATAEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422694AbWATAEJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 19:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422695AbWATAEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 19:04:09 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:38705 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422694AbWATAEH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 19:04:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aEKiOJpe2uuos77m6P1Byaaw+Ixo2svI3cCJ55O/11bQTUQRWI67t6xlORJX2f9Wiu9/14jcWyI2eh4t5O1nKcgDygXdS2KCjpzsBiDzNSn9HDcZ5CPSkfjxJPDiuiXLbwNJ6ytW6hNQ+ez2QPUUpocirZG4mBx4r30g7HKGCpo=
Message-ID: <5c49b0ed0601191604p4fa53404r783b3a703e922b13@mail.gmail.com>
Date: Thu, 19 Jan 2006 16:04:06 -0800
From: Nate Diller <nate.diller@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: [PATCH] Default iosched fixes (was: Fall back io scheduler for 2.6.15?)
Cc: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com, seelam@cs.utep.edu,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My previous default iosched patch did a poor job dealing with the
'elevator=' boot-time option.  Jens' recent solution would fail if the
selected default were compiled as a module, and I find that scenario
useful for debugging.  This patch dynamically evaluates which default
to use, and emits suitable error messages when the requested scheduler
is not available.  It also indicates the compiled-in default scheduler
at registration time, and includes a version of Chuck Ebbert's 'as' ->
'anticipatory' compatability patch.

Tested for a range of boot options on 2.6.13-rc5-mm1, should apply to
any recent kernel.

Signed-off-by: Nate Diller <nate.diller@gmail.com>

--- drivers/block/elevator.c	2006-01-19 15:01:03.000000000 -0800
+++ drivers/block/elevator.c	2006-01-19 15:03:22.000000000 -0800
@@ -153,27 +153,16 @@ static int elevator_attach(request_queue

 static char chosen_elevator[16];

-static void elevator_setup_default(void)
+static int __init elevator_setup(char *str)
 {
-	struct elevator_type *e;
-
 	/*
-	 * If default has not been set, use the compiled-in selection.
+	 * Be backwards-compatible with previous kernels, so users
+	 * won't get the wrong scheduler.
 	 */
-	if (!chosen_elevator[0])
-		strcpy(chosen_elevator, CONFIG_DEFAULT_IOSCHED);
-
- 	/*
- 	 * If the given scheduler is not available, fall back to no-op.
- 	 */
- 	if (!(e = elevator_find(chosen_elevator)))
- 		strcpy(chosen_elevator, "noop");
-	elevator_put(e);
-}
-
-static int __init elevator_setup(char *str)
-{
-	strncpy(chosen_elevator, str, sizeof(chosen_elevator) - 1);
+	if (!strcmp(str, "as"))
+		strcpy(chosen_elevator, "anticipatory");
+	else
+		strncpy(chosen_elevator, str, sizeof(chosen_elevator) - 1);
 	return 0;
 }

@@ -185,14 +174,16 @@ int elevator_init(request_queue_t *q, ch
 	struct elevator_queue *eq;
 	int ret = 0;

-	elevator_setup_default();
+	if (name && !(e = elevator_get(name)))
+		return -EINVAL;

-	if (!name)
-		name = chosen_elevator;
+	if (!e && chosen_elevator[0] && !(e = elevator_get(chosen_elevator)))
+		printk("I/O scheduler %s not found\n", chosen_elevator);

-	e = elevator_get(name);
-	if (!e)
-		return -EINVAL;
+	if (!e && !(e = elevator_get(CONFIG_DEFAULT_IOSCHED))) {
+		e = elevator_get("noop");
+		printk("Default I/O scheduler not found, using no-op\n");
+	}

 	eq = kmalloc(sizeof(struct elevator_queue), GFP_KERNEL);
 	if (!eq) {
@@ -566,7 +557,9 @@ int elv_register(struct elevator_type *e
 	spin_unlock_irq(&elv_list_lock);

 	printk(KERN_INFO "io scheduler %s registered", e->elevator_name);
-	if (!strcmp(e->elevator_name, chosen_elevator))
+	if (!strcmp(e->elevator_name, chosen_elevator) ||
+			(!chosen_elevator[0] &&
+			 !strcmp(e->elevator_name, CONFIG_DEFAULT_IOSCHED)))
 		printk(" (default)");
 	printk("\n");
 	return 0;
