Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWBRAoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWBRAoM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 19:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWBRAoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:44:11 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:26601 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750860AbWBRAoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:44:09 -0500
Subject: Re: Linux 2.6.16-rc3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jens Axboe <axboe@suse.de>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       "Yu, Luming" <luming.yu@intel.com>, Ben Castricum <lk@bencastricum.nl>,
       sanjoy@mrao.cam.ac.uk, Helge Hafting <helgehaf@aitel.hist.no>,
       "Carlo E. Prelz" <fluido@fluido.as>,
       Gerrit Bruchh?user <gbruchhaeuser@gmx.de>, Nicolas.Mailhot@LaPoste.net,
       Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>,
       Patrizio Bassi <patrizio.bassi@gmail.com>,
       Bj?rn Nilsson <bni.swe@gmail.com>, Andrey Borzenkov <arvidjaar@mail.ru>,
       "P. Christeas" <p_christ@hol.gr>, ghrt <ghrt@dial.kappa.ro>,
       jinhong hu <jinhong.hu@gmail.com>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>, linux-scsi@vger.kernel.org,
       Benjamin LaHaise <bcrl@kvack.org>
In-Reply-To: <20060216200138.GA4203@suse.de>
References: <20060212190520.244fcaec.akpm@osdl.org>
	 <20060213203800.GC22441@kroah.com>
	 <1139934883.14115.4.camel@mulgrave.il.steeleye.com>
	 <1140054960.3037.5.camel@mulgrave.il.steeleye.com>
	 <20060216171200.GD29443@flint.arm.linux.org.uk>
	 <1140112653.3178.9.camel@mulgrave.il.steeleye.com>
	 <20060216180939.GF29443@flint.arm.linux.org.uk>
	 <1140113671.3178.16.camel@mulgrave.il.steeleye.com>
	 <20060216181803.GG29443@flint.arm.linux.org.uk>
	 <1140116969.3178.24.camel@mulgrave.il.steeleye.com>
	 <20060216200138.GA4203@suse.de>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 16:42:43 -0800
Message-Id: <1140223363.3231.9.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-16 at 21:01 +0100, Jens Axboe wrote:
> That's what I suggested in the first place as well. I still think it's a
> good idea, fwiw :)

OK smarty pants ... some of us are a bit slower on the uptake.  How
about this then.  It won't solve the target problem, but it will solve
the device put.

James

[PATCH] add execute_in_process_context() API

We have several points in the SCSI stack (primarily for our device
functions) where we need to guarantee process context, but (given the
place where the last reference was released) we cannot guarantee this.

This API gets around the issue by executing the function directly if
the caller has process context, but scheduling a workqueue to execute
in process context if the caller doesn't have it.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

Index: BUILD-2.6/include/linux/workqueue.h
===================================================================
--- BUILD-2.6.orig/include/linux/workqueue.h	2006-02-17 13:02:00.000000000 -0600
+++ BUILD-2.6/include/linux/workqueue.h	2006-02-17 17:57:52.000000000 -0600
@@ -20,6 +20,12 @@
 	struct timer_list timer;
 };
 
+struct execute_work {
+	struct work_struct work;
+	void (*fn)(void *);
+	void *data;
+};
+
 #define __WORK_INITIALIZER(n, f, d) {				\
         .entry	= { &(n).entry, &(n).entry },			\
 	.func = (f),						\
@@ -74,6 +80,8 @@
 void cancel_rearming_delayed_work(struct work_struct *work);
 void cancel_rearming_delayed_workqueue(struct workqueue_struct *,
 				       struct work_struct *);
+int execute_in_process_context(void (*fn)(void *), void *,
+			       struct execute_work *);
 
 /*
  * Kill off a pending schedule_delayed_work().  Note that the work callback
Index: BUILD-2.6/kernel/workqueue.c
===================================================================
--- BUILD-2.6.orig/kernel/workqueue.c	2006-02-17 13:02:01.000000000 -0600
+++ BUILD-2.6/kernel/workqueue.c	2006-02-17 18:00:15.000000000 -0600
@@ -27,6 +27,7 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/kthread.h>
+#include <linux/hardirq.h>
 
 /*
  * The per-CPU workqueue (if single thread, we always use the first
@@ -476,6 +477,45 @@
 }
 EXPORT_SYMBOL(cancel_rearming_delayed_work);
 
+static void execute_in_process_context_work(void *data)
+{
+	void (*fn)(void *data);
+	struct execute_work *ew = data;
+
+	fn = ew->fn;
+	data = ew->data;
+
+	fn(data);
+}
+
+/**
+ * execute_in_process_context - reliably execute the routine with user context
+ * @fn:		the function to execute
+ * @data:	data to pass to the function
+ *
+ * Executes the function immediately if process context is available,
+ * otherwise schedules the function for delayed execution.
+ *
+ * Returns:	0 - function was executed
+ *		1 - function was scheduled for execution
+ */
+int execute_in_process_context(void (*fn)(void *data), void *data,
+			       struct execute_work *ew)
+{
+	if (!in_interrupt()) {
+		fn(data);
+		return 0;
+	}
+
+	INIT_WORK(&ew->work, execute_in_process_context_work, ew);
+	ew->fn = fn;
+	ew->data = data;
+	schedule_work(&ew->work);
+
+	return 1;
+}
+EXPORT_SYMBOL_GPL(execute_in_process_context);
+
 int keventd_up(void)
 {
 	return keventd_wq != NULL;


