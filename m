Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbWD0K4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWD0K4s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 06:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWD0K4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 06:56:48 -0400
Received: from pproxy.gmail.com ([64.233.166.181]:29103 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964931AbWD0K4r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 06:56:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Z1itoDKeBjLfshThICUVv7zBL/oHwKArETrx26PE4A+TObEJNOJdkrEsWK6SdhFgqzmQi8oc4pAFVNYXG4v2mVZUm4uVHH8hJPquOem1W5DsIsJE854cqmkRA3RQgmYEYTg+qZmK//iaADueSJUbtwPyWTG+HtC99jO1NRyXbLw=
Message-ID: <9570b4cc0604270356m36b48173sf443d04ecfa528ec@mail.gmail.com>
Date: Thu, 27 Apr 2006 18:56:44 +0800
From: Porpoise <porpoise.chiang@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: When CONFIG_BASE_SAMLL=1, the kernel 2.6.16.11 (cascade() in kernel/timer.c) may enter the infinite loop.
Cc: "Alan Cox" <alan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

   I found a bug. When CONFIG_BASE_SAMLL=1,
the kernel 2.6.16.11 (cascade() in kernel/timer.c) may enter the infinite loop.
Because of CONFIG_BASE_SMALL=1(TVR_BITS=6 and TVN_BITS=4),
the list base->tv5 may cascade into base->tv5.
So, the kernel enters the infinite loop in the function cascade() .
And I created a test module to verify this bug,
and a patch file to fix it.

Regards,
Porpoise

=== test module  =================
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/timer.h>
#if 0
#include <linux/kdb.h>
#else
#define kdb_printf printk
#endif

#define TVN_BITS (CONFIG_BASE_SMALL ? 4 : 6)
#define TVR_BITS (CONFIG_BASE_SMALL ? 6 : 8)
#define TVN_SIZE (1 << TVN_BITS)
#define TVR_SIZE (1 << TVR_BITS)
#define TVN_MASK (TVN_SIZE - 1)
#define TVR_MASK (TVR_SIZE - 1)

#define TV_SIZE(N)  (N*TVN_BITS  + TVR_BITS)

struct timer_list timer0;
struct timer_list dummy_timer1;
struct timer_list dummy_timer2;

void dummy_timer_fun(unsigned long data) {
}
unsigned long j=0;
void check_timer_base(unsigned long data)
{
        kdb_printf("check_timer_base %08x\n",jiffies);
        mod_timer(&timer0,(jiffies & (~0xFFF)) + 0x1FFF);
}


int init_module(void)
{
        init_timer(&timer0);
        timer0.data = (unsigned long)0;
        timer0.function = check_timer_base;
        mod_timer(&timer0,jiffies+1);

        init_timer(&dummy_timer1);
        dummy_timer1.data = (unsigned long)0;
        dummy_timer1.function = dummy_timer_fun;

        init_timer(&dummy_timer2);
        dummy_timer2.data = (unsigned long)0;
        dummy_timer2.function = dummy_timer_fun;

        j=jiffies;
        j&=(~((1<<TV_SIZE(3))-1));
        j+=(1<<TV_SIZE(3));
        j+=(1<<TV_SIZE(4));

        kdb_printf("mod_timer %08x\n",j);

        mod_timer(&dummy_timer1, j );
        mod_timer(&dummy_timer2, j );

        return 0;
}

void cleanup_module()
{
        del_timer_sync(&timer0);
        del_timer_sync(&dummy_timer1);
        del_timer_sync(&dummy_timer2);
}



=== patch file =================

--- linux-2.6.16.11/kernel/timer.c      2006-04-25 04:20:24.000000000 +0800
+++ linux-2.6.16.11mod/kernel/timer.c   2006-04-27 14:30:02.000000000
+0800
@@ -394,6 +394,34 @@
 EXPORT_SYMBOL(del_timer_sync);
 #endif

+#ifdef CONFIG_BASE_SMALL
+static int cascade_safe(tvec_base_t *base, tvec_t *tv, int index)
+{
+       /* cascade all the timers from tv up one level */
+       struct list_head *head, *curr;
+       struct list_head dummy_head;
+
+       head = tv->vec + index;
+
+       list_add(&dummy_head,head);
+       list_del_init(head);
+
+       curr = dummy_head.next;
+       while (curr != &dummy_head) {
+               struct timer_list *tmp;
+
+               tmp = list_entry(curr, struct timer_list, entry);
+               BUG_ON(tmp->base != &base->t_base);
+               curr = curr->next;
+               internal_add_timer(base, tmp);
+       }
+
+       return index;
+}
+#else
+#define cascade_safe(base,tv,index) cascade(base,tv,index)
+#endif
+
 static int cascade(tvec_base_t *base, tvec_t *tv, int index)
 {
        /* cascade all the timers from tv up one level */
@@ -444,7 +472,7 @@
                        (!cascade(base, &base->tv2, INDEX(0))) &&
                                (!cascade(base, &base->tv3, INDEX(1))) &&
                                        !cascade(base, &base->tv4, INDEX(2)))
-                       cascade(base, &base->tv5, INDEX(3));
+                       cascade_safe(base, &base->tv5, INDEX(3));
                ++base->timer_jiffies;
                list_splice_init(base->tv1.vec + index, &work_list);
                while (!list_empty(head)) {
