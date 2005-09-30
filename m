Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbVI3Jzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbVI3Jzd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 05:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbVI3Jzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 05:55:33 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:60768 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965010AbVI3Jzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 05:55:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=OCluT7FYmc28p9teOahsh3Wpo3XLmCbHTteIHE4QOd3bEILnSlOsRWTPO5g2Ky8oLrTeijGNQjKQfXCtBgZnJYnmmSHbRnmmJTaMfkZRlpLTnmseH6cqQNw6r9pM9INjFfKyAJb178TC05PSxp9MD2NjzOe6otm52zy+UtkNi7o=
Date: Fri, 30 Sep 2005 14:06:39 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] s390: fix TIMER_MAGIC breakage
Message-ID: <20050930100639.GA6936@mipter.zuzino.mipt.ru>
References: <20050929143732.59d22569.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050929143732.59d22569.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sucker is remove-timer-debug-fields.patch

  CC      arch/s390/kernel/vtime.o
arch/s390/kernel/vtime.c: In function `init_virt_timer':
arch/s390/kernel/vtime.c:280: error: `TIMER_MAGIC' undeclared
----------------------------------------------------------------------------
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/s390/kernel/vtime.c |   18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

--- linux-2.6.14-rc2-mm2-vanilla/arch/s390/kernel/vtime.c
+++ linux-2.6.14-rc2-mm2-s390/arch/s390/kernel/vtime.c
@@ -24,7 +24,6 @@
 #include <asm/s390_ext.h>
 #include <asm/timer.h>
 
-#define VTIMER_MAGIC (TIMER_MAGIC + 1)
 static ext_int_info_t ext_int_info_timer;
 DEFINE_PER_CPU(struct vtimer_queue, virt_cpu_timer);
 
@@ -277,20 +276,12 @@ static void do_cpu_timer_interrupt(struc
 
 void init_virt_timer(struct vtimer_list *timer)
 {
-	timer->magic = VTIMER_MAGIC;
 	timer->function = NULL;
 	INIT_LIST_HEAD(&timer->entry);
 	spin_lock_init(&timer->lock);
 }
 EXPORT_SYMBOL(init_virt_timer);
 
-static inline int check_vtimer(struct vtimer_list *timer)
-{
-	if (timer->magic != VTIMER_MAGIC)
-		return -EINVAL;
-	return 0;
-}
-
 static inline int vtimer_pending(struct vtimer_list *timer)
 {
 	return (!list_empty(&timer->entry));
@@ -346,7 +337,7 @@ static void internal_add_vtimer(struct v
 
 static inline int prepare_vtimer(struct vtimer_list *timer)
 {
-	if (check_vtimer(timer) || !timer->function) {
+	if (!timer->function) {
 		printk("add_virt_timer: uninitialized timer\n");
 		return -EINVAL;
 	}
@@ -414,7 +405,7 @@ int mod_virt_timer(struct vtimer_list *t
 	unsigned long flags;
 	int cpu;
 
-	if (check_vtimer(timer) || !timer->function) {
+	if (!timer->function) {
 		printk("mod_virt_timer: uninitialized timer\n");
 		return	-EINVAL;
 	}
@@ -481,11 +472,6 @@ int del_virt_timer(struct vtimer_list *t
 	unsigned long flags;
 	struct vtimer_queue *vt_list;
 
-	if (check_vtimer(timer)) {
-		printk("del_virt_timer: timer not initialized\n");
-		return -EINVAL;
-	}
-
 	/* check if timer is pending */
 	if (!vtimer_pending(timer))
 		return 0;


