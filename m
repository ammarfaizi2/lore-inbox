Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWBWSpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWBWSpM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 13:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWBWSpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 13:45:11 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:52680 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751253AbWBWSpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 13:45:08 -0500
Subject: Re: [linux-usb-devel] Re: Linux 2.6.16-rc3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Jens Axboe <axboe@suse.de>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>,
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
In-Reply-To: <1140359458.3103.11.camel@mulgrave.il.steeleye.com>
References: <1139934883.14115.4.camel@mulgrave.il.steeleye.com>
	 <1140054960.3037.5.camel@mulgrave.il.steeleye.com>
	 <20060216171200.GD29443@flint.arm.linux.org.uk>
	 <1140112653.3178.9.camel@mulgrave.il.steeleye.com>
	 <20060216180939.GF29443@flint.arm.linux.org.uk>
	 <1140113671.3178.16.camel@mulgrave.il.steeleye.com>
	 <20060216181803.GG29443@flint.arm.linux.org.uk>
	 <1140116969.3178.24.camel@mulgrave.il.steeleye.com>
	 <20060216200138.GA4203@suse.de>
	 <1140223363.3231.9.camel@mulgrave.il.steeleye.com>
	 <20060218100344.GA8532@procyon.home>
	 <1140359458.3103.11.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 12:43:43 -0600
Message-Id: <1140720224.2809.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-19 at 08:30 -0600, James Bottomley wrote:
> Yes, thanks ... although I think there's still value to wrappering
> work_struct (a bit like kref wrappers atomic_t).

OK, so how about this?

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
--- BUILD-2.6.orig/include/linux/workqueue.h	2006-02-20 08:57:43.000000000 -0600
+++ BUILD-2.6/include/linux/workqueue.h	2006-02-20 08:58:34.000000000 -0600
@@ -20,6 +20,10 @@
 	struct timer_list timer;
 };
 
+struct execute_work {
+	struct work_struct work;
+};
+
 #define __WORK_INITIALIZER(n, f, d) {				\
         .entry	= { &(n).entry, &(n).entry },			\
 	.func = (f),						\
@@ -74,6 +78,8 @@
 void cancel_rearming_delayed_work(struct work_struct *work);
 void cancel_rearming_delayed_workqueue(struct workqueue_struct *,
 				       struct work_struct *);
+int execute_in_process_context(void (*fn)(void *), void *,
+			       struct execute_work *);
 
 /*
  * Kill off a pending schedule_delayed_work().  Note that the work callback
Index: BUILD-2.6/kernel/workqueue.c
===================================================================
--- BUILD-2.6.orig/kernel/workqueue.c	2006-02-20 08:57:43.000000000 -0600
+++ BUILD-2.6/kernel/workqueue.c	2006-02-20 08:59:18.000000000 -0600
@@ -27,6 +27,7 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/kthread.h>
+#include <linux/hardirq.h>
 
 /*
  * The per-CPU workqueue (if single thread, we always use the first
@@ -476,6 +477,34 @@
 }
 EXPORT_SYMBOL(cancel_rearming_delayed_work);
 
+/**
+ * execute_in_process_context - reliably execute the routine with user context
+ * @fn:		the function to execute
+ * @data:	data to pass to the function
+ * @ew:		guaranteed storage for the execute work structure (must
+ *		be available when the work executes)
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
+	INIT_WORK(&ew->work, fn, data);
+	schedule_work(&ew->work);
+
+	return 1;
+}
+EXPORT_SYMBOL_GPL(execute_in_process_context);
+
 int keventd_up(void)
 {
 	return keventd_wq != NULL;


