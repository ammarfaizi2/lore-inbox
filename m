Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbVCIKgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbVCIKgD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 05:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbVCIKeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 05:34:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:7050 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262296AbVCIKa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 05:30:59 -0500
Date: Wed, 9 Mar 2005 11:30:53 +0100
From: Jens Axboe <axboe@suse.de>
To: "Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug: ll_rw_blk.c, elevator.c and displaying "default" IO Schedule r at boot-time (Cosmetic only)
Message-ID: <20050309103053.GK28855@suse.de>
References: <40BC5D4C2DD333449FBDE8AE961E0C330360F8E3@psexc03.nbnz.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BC5D4C2DD333449FBDE8AE961E0C330360F8E3@psexc03.nbnz.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09 2005, Roberts-Thomson, James wrote:
> Hi,
> 
> I've been trying to investigate an IO performance issue on my machine, as
> part of this I've noticed what is (presumably only a cosmetic) issue with
> the messages displayed at kernel boot-time.
> 
> In the "good old days" (i.e. older 2.6.x kernel versions), one of the many
> messages displayed at kernel boot-time was "elevator: using XXX as default
> io scheduler", where XXX was one of the IO schedulers (cfq, anticipatory,
> deadline, etc) depending on kernel .config at compile time.
> 
> I noticed in 2.6.11, this message has vanished (although this may have
> happened in an earlier kernel), and I now get some messages "io scheduler
> XXX registered".  Unfortunately, the "default" scheduler is no longer
> tagged.

Does this work?

--- 2.6.11/drivers/block/elevator.c	2005-01-22 15:22:55.000000000 +1100
+++ test/drivers/block/elevator.c	2005-01-31 22:38:36.000000000 +1100
@@ -180,6 +180,8 @@
 
 __setup("elevator=", elevator_setup);
 
+static int default_msg = 0;
+
 int elevator_init(request_queue_t *q, char *name)
 {
 	struct elevator_type *e = NULL;
@@ -195,6 +197,12 @@
 	if (!e)
 		return -EINVAL;
 
+	if (!default_msg && !strcmp(e->elevator_name, chosen_elevator)) {
+		printk(KERN_INFO "using %s as default io scheduler\n",
+						chosen_elevator);
+		default_msg = 1;
+	}
+
 	eq = kmalloc(sizeof(struct elevator_queue), GFP_KERNEL);
 	if (!eq) {
 		elevator_put(e->elevator_type);
@@ -513,10 +521,7 @@
 	list_add_tail(&e->list, &elv_list);
 	spin_unlock_irq(&elv_list_lock);
 
-	printk(KERN_INFO "io scheduler %s registered", e->elevator_name);
-	if (!strcmp(e->elevator_name, chosen_elevator))
-		printk(" (default)");
-	printk("\n");
+	printk(KERN_INFO "io scheduler %s registered\n", e->elevator_name);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(elv_register);

-- 
Jens Axboe

