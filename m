Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268379AbUJVX0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268379AbUJVX0S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 19:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269245AbUJVXZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:25:31 -0400
Received: from gate.crashing.org ([63.228.1.57]:24251 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268379AbUJVXSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:18:50 -0400
Subject: Re: [PATCH] pmac_cpufreq msleep cleanup/fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.58.0410221552320.2101@ppc970.osdl.org>
References: <200410221906.i9MJ63Ai022889@hera.kernel.org>
	 <1098484616.6028.80.camel@gaston>
	 <Pine.LNX.4.58.0410221552320.2101@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1098487053.6029.89.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 23 Oct 2004 09:17:33 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 08:53, Linus Torvalds wrote:
> On Sat, 23 Oct 2004, Benjamin Herrenschmidt wrote:
> > 
> > Please revert that change until we have made absolutely sure that msleep(1)
> > on a HZ=1000 machine will actually sleep at least 1ms, this is really not
> > clear since it will end up doing schedule_timeout(1) which, afaik, will
> > only guarantee to sleep up to the next jiffie, which can be a lot shorter
> > than the actual duration of a jiffie.
> 
> In that case I'd much prefer to revert the whole previous "cleanup" as 
> well, since it obviously isn't really. Having
> 
> 	msleep(1 + jiffy_to_ms(1));
> 
> is just not a cleanup to me.

This wasn't a cleanup but a bug fix actually ... Oh well, I think we need
to fix msleep() instead, what do you think ? If we keep Nishanth's latest
cleanup and fix msleep to add +1 to the delay, that would work and potentially
fix other users as well ... provided my theory is right in the first place
and that schedule_timeout(1) will indeed only sleep until the next jiffy and
not for at least one jiffy...

What about something like this ?

  ---

Makes sure msleep() sleeps at least the amount provided, since
schedule_timeout() doesn't guarantee a full jiffy.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== kernel/timer.c 1.100 vs edited =====
--- 1.100/kernel/timer.c	2004-10-19 19:40:28 +10:00
+++ edited/kernel/timer.c	2004-10-23 09:16:10 +10:00
@@ -1605,7 +1605,7 @@
  */
 void msleep(unsigned int msecs)
 {
-	unsigned long timeout = msecs_to_jiffies(msecs);
+	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
 
 	while (timeout) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
@@ -1621,7 +1621,7 @@
  */
 unsigned long msleep_interruptible(unsigned int msecs)
 {
-	unsigned long timeout = msecs_to_jiffies(msecs);
+	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
 
 	while (timeout && !signal_pending(current)) {
 		set_current_state(TASK_INTERRUPTIBLE);


