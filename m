Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272388AbTGYXkj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 19:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272389AbTGYXkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 19:40:39 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:48559 "HELO
	develer.com") by vger.kernel.org with SMTP id S272388AbTGYXkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 19:40:33 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
To: Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] Make I/O schedulers optional (Was: Re: Kernel 2.6 size increase)
Date: Sat, 26 Jul 2003 01:55:15 +0200
User-Agent: KMail/1.5.9
Cc: Willy Tarreau <willy@w.ods.org>, Christoph Hellwig <hch@lst.de>,
       uClinux development list <uclinux-dev@uclinux.org>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jens Axboe <axboe@suse.de>
References: <200307232046.46990.bernie@develer.com> <200307242227.16439.bernie@develer.com> <20030725164649.A6557@infradead.org>
In-Reply-To: <20030725164649.A6557@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307260155.15099.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 July 2003 17:46, Christoph Hellwig wrote:
> On Thu, Jul 24, 2003 at 10:27:16PM +0200, Bernardo Innocenti wrote:
> > Some of the bigger 2.6 additions cannot be configured out.
> > I wish sysfs and the different I/O schedulers could be removed.
>
> Removing the I/O schedulers is pretty trivial, please come up with a
> patch to make both of them optional and maybe add a trivial noop one.

 Here it is, attached below. I've tested it on both i386 and m68knommu.

 Jens, could you please review this patch and push to Linus if you
like it?

> Removing sysfs should also be pretty trivial but I'm not sure whether
> you really want that.

 I really don't need sysfs on uClinux. I have no programs using it.
Removing sysfs appears to be a little bit more difficult, though.
I'll try tomorrow.

--------------------------------------------------------------------------

Add kconfig options to allow excluding either or both the I/O schedulers.
Mostly useful for embedded systems (save ~13KB):

With my desktop PC (i386) kernel:

   text    data     bss     dec     hex filename
   2210707  475856  150444 2837007  2b4a0f vmlinux_with_ioscheds
   2197763  473446  150380 2821589  2b0dd5 vmlinux_without_ioscheds

With my uClinux (m68knommu) kernel:

   text    data     bss     dec     hex filename
   807760   47384   78884  934028   e408c linux_without_ioscheds
   819276   52460   78896  950632   e8168 linux_with_ioscheds


diff -Nru linux-2.6.0-test1.orig/drivers/block/Kconfig linux-2.6.0-test1/drivers/block/Kconfig
--- linux-2.6.0-test1.orig/drivers/block/Kconfig	2003-07-14 05:31:51.000000000 +0200
+++ linux-2.6.0-test1/drivers/block/Kconfig	2003-07-25 18:59:19.000000000 +0200
@@ -4,6 +4,10 @@
 
 menu "Block devices"
 
+menu "I/O schedulers"
+source "drivers/block/Kconfig.iosched"
+endmenu
+
 config BLK_DEV_FD
 	tristate "Normal floppy disk support"
 	depends on !X86_PC9800
diff -Nru linux-2.6.0-test1.orig/drivers/block/Kconfig.iosched linux-2.6.0-test1/drivers/block/Kconfig.iosched
--- linux-2.6.0-test1.orig/drivers/block/Kconfig.iosched	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test1/drivers/block/Kconfig.iosched	2003-07-25 18:59:53.000000000 +0200
@@ -0,0 +1,8 @@
+config IOSCHED_AS
+	bool "Anticipatory I/O scheduler"
+	default y
+
+config IOSCHED_DEADLINE
+	bool "Deadline I/O scheduler"
+	default y
+
diff -Nru linux-2.6.0-test1.orig/drivers/block/Makefile linux-2.6.0-test1/drivers/block/Makefile
--- linux-2.6.0-test1.orig/drivers/block/Makefile	2003-07-14 05:37:16.000000000 +0200
+++ linux-2.6.0-test1/drivers/block/Makefile	2003-07-25 20:21:50.000000000 +0200
@@ -13,9 +13,10 @@
 # kblockd threads
 #
 
-obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o \
-	deadline-iosched.o as-iosched.o
+obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o
 
+obj-$(CONFIG_IOSCHED_AS)	+= as-iosched.o
+obj-$(CONFIG_IOSCHED_DEADLINE)	+= deadline-iosched.o
 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
 obj-$(CONFIG_BLK_DEV_FD98)	+= floppy98.o
diff -Nru linux-2.6.0-test1.orig/drivers/block/as-iosched.c linux-2.6.0-test1/drivers/block/as-iosched.c
--- linux-2.6.0-test1.orig/drivers/block/as-iosched.c	2003-07-14 05:28:54.000000000 +0200
+++ linux-2.6.0-test1/drivers/block/as-iosched.c	2003-07-25 20:19:44.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  linux/drivers/block/as-iosched.c
  *
- *  Anticipatory & deadline i/o scheduler.
+ *  Anticipatory i/o scheduler.
  *
  *  Copyright (C) 2002 Jens Axboe <axboe@suse.de>
  *                     Nick Piggin <piggin@cyberone.com.au>
@@ -1832,6 +1832,7 @@
 	.elevator_exit_fn =		as_exit,
 
 	.elevator_ktype =		&as_ktype,
+	.elevator_name =		"anticipatory scheduling",
 };
 
 EXPORT_SYMBOL(iosched_as);
diff -Nru linux-2.6.0-test1.orig/drivers/block/deadline-iosched.c linux-2.6.0-test1/drivers/block/deadline-iosched.c
--- linux-2.6.0-test1.orig/drivers/block/deadline-iosched.c	2003-07-14 05:37:15.000000000 +0200
+++ linux-2.6.0-test1/drivers/block/deadline-iosched.c	2003-07-25 20:20:53.000000000 +0200
@@ -941,6 +941,7 @@
 	.elevator_exit_fn =		deadline_exit,
 
 	.elevator_ktype =		&deadline_ktype,
+	.elevator_name =		"deadline",
 };
 
 EXPORT_SYMBOL(iosched_deadline);
diff -Nru linux-2.6.0-test1.orig/drivers/block/elevator.c linux-2.6.0-test1/drivers/block/elevator.c
--- linux-2.6.0-test1.orig/drivers/block/elevator.c	2003-07-14 05:36:48.000000000 +0200
+++ linux-2.6.0-test1/drivers/block/elevator.c	2003-07-25 19:27:41.000000000 +0200
@@ -409,6 +409,7 @@
 	.elevator_merge_req_fn		= elevator_noop_merge_requests,
 	.elevator_next_req_fn		= elevator_noop_next_request,
 	.elevator_add_req_fn		= elevator_noop_add_request,
+	.elevator_name			= "noop",
 };
 
 module_init(elevator_global_init);
diff -Nru linux-2.6.0-test1.orig/drivers/block/ll_rw_blk.c linux-2.6.0-test1/drivers/block/ll_rw_blk.c
--- linux-2.6.0-test1.orig/drivers/block/ll_rw_blk.c	2003-07-14 05:30:40.000000000 +0200
+++ linux-2.6.0-test1/drivers/block/ll_rw_blk.c	2003-07-25 19:27:02.000000000 +0200
@@ -1205,17 +1205,31 @@
 
 static int __make_request(request_queue_t *, struct bio *);
 
-static elevator_t *chosen_elevator = &iosched_as;
+static elevator_t *chosen_elevator =
+#if defined(CONFIG_IOSCHED_AS)
+	&iosched_as;
+#elif defined(CONFIG_IOSCHED_DEADLINE)
+	&iosched_deadline;
+#else
+	&elevator_noop;
+#endif
 
+#if defined(CONFIG_IOSCHED_AS) || defined(CONFIG_IOSCHED_DEADLINE)
 static int __init elevator_setup(char *str)
 {
+#ifdef CONFIG_IOSCHED_DEADLINE
 	if (!strcmp(str, "deadline"))
 		chosen_elevator = &iosched_deadline;
+#endif
+#ifdef CONFIG_IOSCHED_AS
 	if (!strcmp(str, "as"))
 		chosen_elevator = &iosched_as;
+#endif
 	return 1;
 }
+
 __setup("elevator=", elevator_setup);
+#endif /* CONFIG_IOSCHED_AS || CONFIG_IOSCHED_DEADLINE */
 
 /**
  * blk_init_queue  - prepare a request queue for use with a block device
@@ -1255,10 +1269,7 @@
 
 	if (!printed) {
 		printed = 1;
-		if (chosen_elevator == &iosched_deadline)
-			printk("deadline elevator\n");
-		else if (chosen_elevator == &iosched_as)
-			printk("anticipatory scheduling elevator\n");
+		printk("Using %s elevator\n", chosen_elevator->elevator_name);
 	}
 
 	if ((ret = elevator_init(q, chosen_elevator))) {
diff -Nru linux-2.6.0-test1.orig/include/linux/elevator.h linux-2.6.0-test1/include/linux/elevator.h
--- linux-2.6.0-test1.orig/include/linux/elevator.h	2003-07-14 05:29:27.000000000 +0200
+++ linux-2.6.0-test1/include/linux/elevator.h	2003-07-25 19:18:39.000000000 +0200
@@ -52,6 +52,7 @@
 
 	struct kobject kobj;
 	struct kobj_type *elevator_ktype;
+	const char *elevator_name;
 };
 
 /*


-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


