Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbWD0LVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWD0LVq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 07:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWD0LVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 07:21:46 -0400
Received: from pproxy.gmail.com ([64.233.166.178]:30177 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964954AbWD0LVq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 07:21:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Nk/TjkK295rMSni9UaKkxr92dcwKFc8BilAO8+fddI4ILPaR5y9wanWdntx6nH+hmp9iS6uGoxJ2f1MxDdMpOuB3uf7yTBqIMDcf8cppaYQnCBisXZ0CIoylRf9I2RRq+tGWOxKlF2Bg3JwB8QsyJ+owUF2tSB5A03EORLzAO/w=
Message-ID: <9570b4cc0604270421n37caa3eeq51475ee5b9ce76cc@mail.gmail.com>
Date: Thu, 27 Apr 2006 19:21:45 +0800
From: Porpoise <porpoise.chiang@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: When CONFIG_BASE_SAMLL=1, the kernel 2.6.16.11 (cascade() in kernel/timer.c) may enter the infinite loop.
Cc: "Alan Cox" <alan@redhat.com>
In-Reply-To: <9570b4cc0604270356m36b48173sf443d04ecfa528ec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9570b4cc0604270356m36b48173sf443d04ecfa528ec@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

  Sorry. There is a typo.
  The patch should be "#if CONFIG_BASE_SMALL!=0",
  not "#ifdef CONFIG_BASE_SMALL".

Regards,
Porpoise

============================
--- linux-2.6.16.11org/kernel/timer.c	2006-04-25 04:20:24.000000000 +0800
+++ linux-2.6.16.11/kernel/timer.c	2006-04-27 18:49:55.000000000 +0800
@@ -394,6 +394,34 @@
 EXPORT_SYMBOL(del_timer_sync);
 #endif

+#if CONFIG_BASE_SMALL!=0
+static int cascade_safe(tvec_base_t *base, tvec_t *tv, int index)
+{
+	/* cascade all the timers from tv up one level */
+	struct list_head *head, *curr;
+	struct list_head dummy_head;
+	
+	head = tv->vec + index;
+
+	list_add(&dummy_head,head);
+	list_del_init(head);
+
+	curr = dummy_head.next;
+	while (curr != &dummy_head) {
+		struct timer_list *tmp;
+
+		tmp = list_entry(curr, struct timer_list, entry);
+		BUG_ON(tmp->base != &base->t_base);
+		curr = curr->next;
+		internal_add_timer(base, tmp);
+	}
+
+	return index;
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
-			cascade(base, &base->tv5, INDEX(3));
+			cascade_safe(base, &base->tv5, INDEX(3));
 		++base->timer_jiffies;
 		list_splice_init(base->tv1.vec + index, &work_list);
 		while (!list_empty(head)) {
