Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWCCQD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWCCQD4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 11:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWCCQD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 11:03:56 -0500
Received: from 66.239.25.20.ptr.us.xo.net ([66.239.25.20]:14014 "EHLO
	zoot.lnxi.com") by vger.kernel.org with ESMTP id S1030223AbWCCQD4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 11:03:56 -0500
Message-Id: <4408050A0200003600000CC8@zoot.lnxi.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Fri, 03 Mar 2006 08:57:46 -0700
From: "Doug Thompson" <dthompson@lnxi.com>
To: <arjan@infradead.org>
Cc: <bluesmoke-devel@lists.sourceforge.net>, <dsp@llnl.gov>, <hch@lst.de>,
       <alan@lxorguk.ukuu.org.uk>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/15] EDAC: switch to kthread_ API
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Originally we used a timeout, but when I added the PCI Parity scanning,
that broke while trying to get a PCI spinlock (via a PCI API call)
during the timer interrupt time. I then added the current kernel thread
model and a first attempt. We subsequently received input for the
kthread_* model which is were this patch came from.

Currently the timer event code performs two operations: 

  1) ECC polling and 
  2) PCI parity polling. 

I want to split those from each other, so each can have a seperate cycle
rate (also adding a sysfs cycle control for the PCI parity timing in
addition to the existing ECC cycle control).

One of the thoughts I have had in this refactoring is to utilize worker
queue processing to do the work (and bypass the spinlock issue) which is
triggered by the timer event for PCI parity polling and thus also the
ECC polling for uniformity.

Thoughts are welcome

doug thompson



On Fri, 2006-03-03 at 09:16 +0000, Arjan van de Ven  wrote:
> On Thu, 2006-03-02 at 18:30 -0800, Andrew Morton wrote:
> > Dave Peterson <dsp@llnl.gov> wrote:
> > >
> > >   		schedule_timeout((HZ * poll_msec) / 1000);
> > >   		try_to_freeze();
> > >  +		__set_current_state(TASK_RUNNING);
> > 
> > schedule() and schedule_timeout*() always return in state TASK_RUNNING, so
> > I'll take that out of there.
> > 
> > We might as well use schedule_timeout_interruptible(), too.  As a bonus, we
> > get to delete that spelling mistake ;)
> 
> 
> or even msleep variant ;)
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> bluesmoke-devel mailing list
> bluesmoke-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluesmoke-devel

