Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVDBPzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVDBPzV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 10:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVDBPzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 10:55:21 -0500
Received: from [194.85.82.4] ([194.85.82.4]:6056 "EHLO mailer.campus.mipt.ru")
	by vger.kernel.org with ESMTP id S261585AbVDBPyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 10:54:43 -0500
Date: Sat, 2 Apr 2005 19:22:06 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       jlan@engr.sgi.com, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: Re: [1/1] CBUS: new very fast (for insert operations) message bus
 based on kenel connector.
Message-ID: <20050402192206.5e6f749f@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050401111134.49a8af5f.akpm@osdl.org>
References: <20050320112336.2b082e27@zanzibar.2ka.mipt.ru>
	<20050331162758.44aeaf44.akpm@osdl.org>
	<1112337814.9334.42.camel@uganda>
	<20050331232625.09057712.akpm@osdl.org>
	<1112341514.9334.103.camel@uganda>
	<20050331235927.6d104665.akpm@osdl.org>
	<1112345400.9334.157.camel@uganda>
	<20050401012547.68c26523.akpm@osdl.org>
	<1112350615.9334.194.camel@uganda>
	<20050401023004.2a83dbe5.akpm@osdl.org>
	<1112352955.9334.225.camel@uganda>
	<20050401032023.3d05d42f.akpm@osdl.org>
	<1112361177.12969.23.camel@uganda>
	<20050401111134.49a8af5f.akpm@osdl.org>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Sat, 02 Apr 2005 19:53:57 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Apr 2005 11:11:34 -0800
Andrew Morton <akpm@osdl.org> wrote:

> >  CBUS was designed to provide very fast _insert_ operation.
> 
> I just don't see any point in doing this.  If the aggregate system load is
> unchanged (possibly increased) then why is cbus desirable?
> 
> The only advantage I can see is that it permits irq-context messaging.

As one and not main advantage.

> >  It is needed not only for fork() accounting, but for any
> >  fast path, when we do not want to slow process down just to
> >  send notification about it, instead we can create such a notification,
> >  and deliver it later.
> 
> And when we deliver it later, we slow processes down!
> 
> >  Why do we defer all work from HW IRQ into BH context?
> 
> To enable more interrupts to come in while we're doing that work.

Exactly(!) for this reason CBUS was designed and implemented - 
to allow more inserts to arrive and process _them_, thus
do not slow down fast path, but not to make the whole delivering faster.
 
> >  Because while we are in HW IRQ we can not perform other tasks,
> >  so with connector and CBUS we have the same situation.
> 
> I agree that being able to send from irq context would be handy.  If we had
> any code which wants to do that, and at present we do not.

It is not main advantage.

> But I fail to see any advantage in moving work out of fork() context, into
> kthread context and incurring additional context switch overhead.  Apart
> from conceivably better CPU cache utilisation.

And not event that is the main reason.

> The fact that deferred delivery can cause an arbitrarily large backlog and,
> ultimately, deliberate message droppage or oom significantly impacts the
> reliability of the whole scheme and means that well-designed code must use
> synchronous delivery _anyway_.  The deferred delivery should only be used
> from IRQ context for low-bandwidth delivery rates.

Not at all, OOM can not happen with limited queue length.
CBUS will fallback to the direct cn_netlink_send() in that case.

Cache utilisation and ability to send events from any context are
significant issues, but not they are the most important reasons.
Ability to not slow down fast pathes - that is the main reason,
even with higher delivery price.
Concider situation when one may want to have notification 
of each new write system call - let's say without such
notification it took about 1 second to write one page from userspace,
now with notification sending, which is not so fast, it will take
1.5 seconds, but with CBUS write() still costs 1 second plus
later, when we do not care about writing performance and scheduler
decides to run CBUS thread, those notifications will take additional
0.7 seconds instead of 0.5 and will be delivered.
But if one requires not delayed fact of the notification, but
almost immediate event - one can still use direct connector's methods.

> >  While we are sending a low priority event, we stops actuall work,
> >  which is not acceptible in many situations.
> 
> Have you tested the average forking rate on a uniprocessor machine with
> this patch?  If the forking continues for (say) one second, does the patch
> provide any performance benefit?

Yes, as I said I run CBUS test with non-SMP machine too 
[it is still SMP with nosmp kernel option and SMP kernel].

On my the nearest test SMP machine it took ~930 - 950 msec average for fork
for both processors, so it is about 1850-1900 per processor 
[both with CBUS with fork connector and without fork connector compiled].
With CBUS and 1 CPU fork() + exit() time takes about 1780 - 1800 msec.

I can rerun test on Monday on diferent [and faster] machines, 
if you want.

	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
