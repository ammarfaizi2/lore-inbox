Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTGKNCV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 09:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTGKNCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 09:02:21 -0400
Received: from 69-55-72-150.ppp.netsville.net ([69.55.72.150]:30663 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S262123AbTGKNCT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 09:02:19 -0400
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
From: Chris Mason <mason@suse.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, Peter Lojkin <ia6432@inbox.ru>,
       green@namesys.com, lkml <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <Pine.LNX.4.55L.0307101458490.25229@freak.distro.conectiva>
References: <E19ae9K-000Nas-00.ia6432-inbox-ru@f7.mail.ru>
	 <20030710191254.093354d2.skraw@ithnet.com>
	 <Pine.LNX.4.55L.0307101458490.25229@freak.distro.conectiva>
Content-Type: multipart/mixed; boundary="=-NToGWHD4VjRrnGS0VQYn"
Organization: 
Message-Id: <1057929320.13317.26.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Jul 2003 09:15:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NToGWHD4VjRrnGS0VQYn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2003-07-10 at 14:01, Marcelo Tosatti wrote:
> On Thu, 10 Jul 2003, Stephan von Krawczynski wrote:
> 
> > On Thu, 10 Jul 2003 20:20:02 +0400
> > "Peter Lojkin" <ia6432@inbox.ru> wrote:
> >
> > > Hello,
> > >
> > > here is exact patch i've used. i made it by cutting pre2-pre3 diff,
> > > so apply it o top of 2.4.22-pre3 with -R option to patch...
> >
> > Hello Peter
> > Hello Marcelo
> >
> > I can confirm that pre3 works when reversing the attached patch. Thanks very
> > much, Peter.
> 
> Fine Stephan. Now can youplease get us the task backtraces from sysrq when
> the hang happens?
> 
> Andrea, Chris, any idea of why this is happening?

My first guess is that blk_oversized_queue is false but there aren't any
requests left.  That will pretty much spin in __get_request_wait with
irqs off, which sounds similar to what he's hitting.

I think we need this hunk even if it doesn't fix his problem.

Stephan, if this patch doesn't help, could you please boot with
nmi_watchdog=1?  An earlier email said sysrq wasn't working, so we'll
probably need the nmi_watchdog to get a backtrace.

-chris


--=-NToGWHD4VjRrnGS0VQYn
Content-Disposition: attachment; filename=io-stalls-11-inc.diff
Content-Type: text/plain; name=io-stalls-11-inc.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/block/ll_rw_blk.c 1.46 vs edited =====
--- 1.46/drivers/block/ll_rw_blk.c	Fri Jul  4 13:35:08 2003
+++ edited/drivers/block/ll_rw_blk.c	Fri Jul 11 08:30:54 2003
@@ -618,7 +618,7 @@
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		spin_lock_irq(&io_request_lock);
-		if (blk_oversized_queue(q)) {
+		if (blk_oversized_queue(q) || q->rq.count == 0) {
 			__generic_unplug_device(q);
 			spin_unlock_irq(&io_request_lock);
 			schedule();

--=-NToGWHD4VjRrnGS0VQYn--

