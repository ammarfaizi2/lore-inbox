Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269295AbUJVXqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269295AbUJVXqu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 19:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269292AbUJVXo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:44:56 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:43952 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269295AbUJVXn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:43:26 -0400
Date: Fri, 22 Oct 2004 16:43:44 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] pmac_cpufreq msleep cleanup/fixes
Message-ID: <20041022234344.GI18906@us.ibm.com>
References: <200410221906.i9MJ63Ai022889@hera.kernel.org> <1098484616.6028.80.camel@gaston> <Pine.LNX.4.58.0410221552320.2101@ppc970.osdl.org> <1098487053.6029.89.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098487053.6029.89.camel@gaston>
X-Operating-System: Linux 2.6.9-rc4 (i686)
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 09:17:33AM +1000, Benjamin Herrenschmidt wrote:
> On Sat, 2004-10-23 at 08:53, Linus Torvalds wrote:
> > On Sat, 23 Oct 2004, Benjamin Herrenschmidt wrote:
> > > 
> > > Please revert that change until we have made absolutely sure that msleep(1)
> > > on a HZ=1000 machine will actually sleep at least 1ms, this is really not
> > > clear since it will end up doing schedule_timeout(1) which, afaik, will
> > > only guarantee to sleep up to the next jiffie, which can be a lot shorter
> > > than the actual duration of a jiffie.
> > 
> > In that case I'd much prefer to revert the whole previous "cleanup" as 
> > well, since it obviously isn't really. Having
> > 
> > 	msleep(1 + jiffy_to_ms(1));
> > 
> > is just not a cleanup to me.
> 
> This wasn't a cleanup but a bug fix actually ... Oh well, I think we need
> to fix msleep() instead, what do you think ? If we keep Nishanth's latest
> cleanup and fix msleep to add +1 to the delay, that would work and potentially
> fix other users as well ... provided my theory is right in the first place
> and that schedule_timeout(1) will indeed only sleep until the next jiffy and
> not for at least one jiffy...
> 
> What about something like this ?
> 

Looks good to me... And makes quite a bit of sense, after I thought
about it. Does feel a little hacky, but I don't see a slicker way around
the problem...


Makes sure msleep() sleeps at least the amount provided, since
schedule_timeout() doesn't guarantee a full jiffy.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Nishanth Aravamudan <nacc@us.ibm.com>

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

