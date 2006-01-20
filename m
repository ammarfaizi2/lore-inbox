Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWATXRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWATXRg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 18:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWATXRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 18:17:36 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:19121 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751187AbWATXRf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 18:17:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=apkX17rSqZndp7lQkOs4h7aAOFUa/vCn89LfgrtqBCC18peP+tSLwu0R0JAdJoxYEAxiGxV0fqu66yX/fIYl7lRt9ccki92QiISjq8I7LVu9pl7fZ5AERitfLAThoHbuTxwFq+y+Jzb/b3Y7VZtdo9Ujr7XGKWPAz1d/OuK0DQA=
Message-ID: <5c49b0ed0601201517h3126ac8dp931bab93a85bf9c5@mail.gmail.com>
Date: Fri, 20 Jan 2006 15:17:34 -0800
From: Nate Diller <nate.diller@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: [PATCH 1/2][RESEND] Default iosched fixes (was: Fall back io scheduler for 2.6.15?)
Cc: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com, seelam@cs.utep.edu,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <20060120081145.GD4213@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5c49b0ed0601191604p4fa53404r783b3a703e922b13@mail.gmail.com>
	 <20060120081145.GD4213@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My previous default iosched patch did a poor job dealing with the
'elevator=' boot-time option.  The old behavior falls back to the
compiled-in default if the requested one is not registered at boot
time.  This patch dynamically evaluates which default
to use, and emits a suitable error message when the requested scheduler
is not available.  It also does the 'as' -> 'anticipatory' conversion
before elevator registration, which along with a modified registration
function, allows it to correctly indicate which default scheduler is
in use.

Tested for a range of boot options on 2.6.16-rc1-mm2.

Signed-off-by: Nate Diller <nate.diller@gmail.com>

---

Jens: i'm submitting this seperately from the objectionable 'modular
default scheduler' check.  Is there anything else I should change?

--- ./block/elevator.c	2006-01-20 13:47:16.000000000 -0800
+++ ./block/elevator.c	2006-01-20 14:52:53.000000000 -0800
@@ -140,35 +140,16 @@ static int elevator_attach(request_queue

 static char chosen_elevator[16];

-static void elevator_setup_default(void)
+static int __init elevator_setup(char *str)
 {
-	struct elevator_type *e;
-
-	/*
-	 * If default has not been set, use the compiled-in selection.
-	 */
-	if (!chosen_elevator[0])
-		strcpy(chosen_elevator, CONFIG_DEFAULT_IOSCHED);
-
 	/*
 	 * Be backwards-compatible with previous kernels, so users
 	 * won't get the wrong elevator.
 	 */
-	if (!strcmp(chosen_elevator, "as"))
+	if (!strcmp(str, "as"))
 		strcpy(chosen_elevator, "anticipatory");
-
- 	/*
- 	 * If the given scheduler is not available, fall back to the default
- 	 */
- 	if ((e = elevator_find(chosen_elevator)))
-		elevator_put(e);
 	else
- 		strcpy(chosen_elevator, CONFIG_DEFAULT_IOSCHED);
-}
-
-static int __init elevator_setup(char *str)
-{
-	strncpy(chosen_elevator, str, sizeof(chosen_elevator) - 1);
+		strncpy(chosen_elevator, str, sizeof(chosen_elevator) - 1);
 	return 0;
 }

@@ -185,15 +166,15 @@ int elevator_init(request_queue_t *q, ch
 	q->end_sector = 0;
 	q->boundary_rq = NULL;

-	elevator_setup_default();
-
-	if (!name)
-		name = chosen_elevator;
-
-	e = elevator_get(name);
-	if (!e)
+	if (name && !(e = elevator_get(name)))
 		return -EINVAL;

+	if (!e && !(e = elevator_get(chosen_elevator))) {
+		e = elevator_get(CONFIG_DEFAULT_IOSCHED);
+		if (*chosen_elevator)
+			printk("I/O scheduler %s not found\n", chosen_elevator);
+	}
+
 	eq = kmalloc(sizeof(struct elevator_queue), GFP_KERNEL);
 	if (!eq) {
 		elevator_put(e);
@@ -681,8 +662,10 @@ int elv_register(struct elevator_type *e
 	spin_unlock_irq(&elv_list_lock);

 	printk(KERN_INFO "io scheduler %s registered", e->elevator_name);
-	if (!strcmp(e->elevator_name, chosen_elevator))
-		printk(" (default)");
+	if (!strcmp(e->elevator_name, chosen_elevator) ||
+			(!*chosen_elevator &&
+			 !strcmp(e->elevator_name, CONFIG_DEFAULT_IOSCHED)))
+				printk(" (default)");
 	printk("\n");
 	return 0;
 }
