Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264212AbUEDDQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264212AbUEDDQo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 23:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264214AbUEDDQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 23:16:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:32646 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264212AbUEDDQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 23:16:41 -0400
Date: Mon, 3 May 2004 20:16:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: mixxel@cs.auc.dk, linux-kernel@vger.kernel.org
Subject: Re: workqueue and pending
Message-Id: <20040503201616.6f3b8700.akpm@osdl.org>
In-Reply-To: <1083639081.20092.294.camel@gaston>
References: <40962F75.8000200@cs.auc.dk>
	<20040503162719.54fb7020.akpm@osdl.org>
	<1083639081.20092.294.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> 
> >  
> > @@ -75,8 +76,11 @@ extern void init_workqueues(void);
> >   */
> >  static inline int cancel_delayed_work(struct work_struct *work)
> >  {
> > -	return del_timer_sync(&work->timer);
> > +	int ret;
> > +
> > +	ret = del_timer_sync(&work->timer);
> > +	clear_bit(0, &work->pending);
> > +	return ret;
> >  }
> >  
> 
> Looks wrong to me. The time may have fired already and queued the
> work. Clearing pending is an error in this case since the work is
> indeed pending for execution.... 

OK...

--- 25/include/linux/workqueue.h~cancel_delayed_work-fix	2004-05-03 20:14:26.796321416 -0700
+++ 25-akpm/include/linux/workqueue.h	2004-05-03 20:15:41.010039216 -0700
@@ -7,6 +7,7 @@
 
 #include <linux/timer.h>
 #include <linux/linkage.h>
+#include <linux/bitops.h>
 
 struct workqueue_struct;
 
@@ -75,8 +76,12 @@ extern void init_workqueues(void);
  */
 static inline int cancel_delayed_work(struct work_struct *work)
 {
-	return del_timer_sync(&work->timer);
+	int ret;
+
+	ret = del_timer_sync(&work->timer);
+	if (ret)
+		clear_bit(0, &work->pending);
+	return ret;
 }
 
 #endif
-

_

