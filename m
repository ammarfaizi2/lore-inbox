Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266679AbUHONZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266679AbUHONZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 09:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266686AbUHONZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 09:25:57 -0400
Received: from baikonur.stro.at ([213.239.196.228]:56734 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266679AbUHONZw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 09:25:52 -0400
Date: Sun, 15 Aug 2004 15:25:48 +0200
From: maximilian attems <janitor@sternwelten.at>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kj <kernel-janitors@osdl.org>
Subject: Re: Add msleep_interruptible() function to kernel/timer.c
Message-ID: <20040815132548.GF1799@stro.at>
References: <20040815121805.GA15111@stro.at> <1092570891.17605.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092570891.17605.1.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2004, Alan Cox wrote:

> On Sul, 2004-08-15 at 13:18, maximilian attems wrote:
> > + * msleep_interruptible - sleep waiting for waitqueue interruptions
> > + * @msecs: Time in milliseconds to sleep for
> > + */
> > +void msleep_interruptible(unsigned int msecs)
> > +{
> > +	unsigned long timeout = msecs_to_jiffies(msecs);
> > +
> > +	while (timeout) {
> 
> You want to have while(timeout && !signal_pending(current))
> 
> A signal will wake the timeout which will then loop. It might also
> be good to add
> 
> > +		set_current_state(TASK_INTERRUPTIBLE);
> > +		timeout = schedule_timeout(timeout);
> > +	}
> 
> return timeout;
> 
> so that the caller knows more about how long the timer ran for before
> the interrupt and if it was interrupted.

belows patches returns timeout in msecs 
as the function is also called with that unit, 
added definition in include/linux/delay.h



this function is equivalent to:
	current->state = TASK_INTERRUPTIBLE;
	schedule_timeout(timeout);

idea from Ingo Molnar:
well, aboves is not 100% equivalent because msleep() is uninterruptible so
stoppage of the md thread (upon shutdown) will occur with only a 250 msec
delay. Someone should add a msleep_interruptible() function to kernel/timer.c.

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.8-max/kernel/timer.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+)


this function is equivalent to:
	current->state = TASK_INTERRUPTIBLE;
	schedule_timeout(timeout);

idea from Ingo Molnar:
well, aboves is not 100% equivalent because msleep() is uninterruptible so
stoppage of the md thread (upon shutdown) will occur with only a 250 msec
delay. Someone should add a msleep_interruptible() function to kernel/timer.c.

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.8-max/include/linux/delay.h |    1 +
 linux-2.6.8-max/kernel/timer.c        |   16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff -puN kernel/timer.c~add-msleep_interruptible kernel/timer.c
--- linux-2.6.8/kernel/timer.c~add-msleep_interruptible	2004-08-15 15:15:01.000000000 +0200
+++ linux-2.6.8-max/kernel/timer.c	2004-08-15 15:18:56.000000000 +0200
@@ -1503,3 +1503,19 @@ void msleep(unsigned int msecs)
 
 EXPORT_SYMBOL(msleep);
 
+/**
+ * msleep_interruptible - sleep waiting for waitqueue interruptions
+ * @msecs: Time in milliseconds to sleep for
+ */
+unsigned int msleep_interruptible(unsigned int msecs)
+{
+       unsigned long timeout = msecs_to_jiffies(msecs);
+
+       while (timeout && !signal_pending(current)) {
+               set_current_state(TASK_INTERRUPTIBLE);
+               timeout = schedule_timeout(timeout);
+       }
+       return jiffies_to_msecs(timeout);
+}
+
+EXPORT_SYMBOL(msleep_interruptible);
diff -puN include/linux/delay.h~add-msleep_interruptible include/linux/delay.h
--- linux-2.6.8/include/linux/delay.h~add-msleep_interruptible	2004-08-15 15:15:01.000000000 +0200
+++ linux-2.6.8-max/include/linux/delay.h	2004-08-15 15:17:56.000000000 +0200
@@ -39,5 +39,6 @@ extern unsigned long loops_per_jiffy;
 #endif
 
 void msleep(unsigned int msecs);
+unsigned int msleep_interruptible(unsigned int msecs);
 
 #endif /* defined(_LINUX_DELAY_H) */

_
