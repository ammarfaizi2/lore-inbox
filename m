Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968654AbWLETbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968654AbWLETbe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 14:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968658AbWLETbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 14:31:34 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44239 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968654AbWLETbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 14:31:33 -0500
Date: Tue, 5 Dec 2006 11:31:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
       Andy Fleming <afleming@freescale.com>,
       Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
Message-Id: <20061205113118.abec1a6a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612051003430.3542@woody.osdl.org>
References: <1165125055.5320.14.camel@gullible>
	<20061203011625.60268114.akpm@osdl.org>
	<Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
	<Pine.LNX.4.64.0612051003430.3542@woody.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006 10:07:21 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Tue, 5 Dec 2006, Maciej W. Rozycki wrote:
> >
> >  One way of avoiding it is calling flush_scheduled_work() from 
> > phy_stop_interrupts().  This is fine as long as a caller of 
> > phy_stop_interrupts() (not necessarily the immediate one calling into 
> > libphy) does not hold the netlink lock.
> > 
> >  If a caller indeed holds the netlink lock, then a driver effectively 
> > calling phy_stop_interrupts() may arrange for the function to be itself 
> > scheduled through the event queue.  This has the effect of avoiding the 
> > race as well, as the queue is processed in order, except it causes more 
> > hassle for the driver.
> 
> I would personally be ok with "flush_scheduled_work()" _itself_ noticing 
> that it is actually waiting to flush "itself", and just being a no-op in 
> that case.

It does do that:

static void flush_cpu_workqueue(struct cpu_workqueue_struct *cwq)
{
	if (cwq->thread == current) {
		/*
		 * Probably keventd trying to flush its own queue. So simply run
		 * it by hand rather than deadlocking.
		 */
		run_workqueue(cwq);

