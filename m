Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVANEzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVANEzk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 23:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVANEzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 23:55:39 -0500
Received: from smtp.nuvox.net ([64.89.70.9]:16212 "EHLO
	smtp04.gnvlscdb.sys.nuvox.net") by vger.kernel.org with ESMTP
	id S261894AbVANEzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 23:55:20 -0500
Subject: Re: [UPDATE PATCH] ieee1394/sbp2: use ssleep() instead of
	schedule_timeout()
From: Dan Dennedy <dan@dennedy.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>,
       kj <kernel-janitors@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Ben Collins <bcollins@debian.org>
In-Reply-To: <20050110173945.GB3099@us.ibm.com>
References: <20050107213400.GD2924@us.ibm.com>
	 <17a9eec54394ded0a28295a6548a5c65@localhost>
	 <20050110173945.GB3099@us.ibm.com>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 23:52:55 -0500
Message-Id: <1105678375.7830.81.camel@kino.dennedy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-10 at 09:39 -0800, Nishanth Aravamudan wrote:
> On Sun, Jan 09, 2005 at 10:01:21AM +0100, Stefan Richter wrote:
> > Nishanth Aravamudan wrote:
> > >Description: Use ssleep() instead of schedule_timeout() to guarantee 
> > >the task
> > >delays as expected. The existing code should not really need to run in
> > >TASK_INTERRUPTIBLE, as there is no check for signals (or even an 
> > >early return
> > >value whatsoever). ssleep() takes care of these issues.
> > 
> > >--- 2.6.10-v/drivers/ieee1394/sbp2.c	2004-12-24 13:34:00.000000000 
> > >-0800
> > >+++ 2.6.10/drivers/ieee1394/sbp2.c	2005-01-05 14:23:05.000000000 -0800
> > >@@ -902,8 +902,7 @@ alloc_fail:
> > >	 * connected to the sbp2 device being removed. That host would
> > >	 * have a certain amount of time to relogin before the sbp2 device
> > >	 * allows someone else to login instead. One second makes sense. */
> > >-	set_current_state(TASK_INTERRUPTIBLE);
> > >-	schedule_timeout(HZ);
> > >+	ssleep(1);
> > 
> > Maybe the current code is _deliberately_ accepting interruption by 
> > signals but trying to complete sbp2_probe() anyway. However it seems 
> > more plausible to me to abort the device probe, for example like this:
> > if (msleep_interruptible(1000)) {
> > 	sbp2_remove_device(scsi_id);
> > 	return -EINTR;
> > }
> 
> You might be right, but I'd like to get Ben's input on this, as I honeslty am

Don't hold your breath waiting for Ben's input. However, I would like to
get one of the two proposed committed and tested by more users as this
is a sore spot. I am not in a position at this time to fully research
and test to make a call.

> unsure. To be fair, I am trying to audit all usage of schedule_timeout() and the
> semantic interpretation (to me) of using TASK_INTERRUPTIBLE is that you wish to
> sleep a certain amount of time, but also are prepared for an early return on
> either signals or wait-queue events. msleep_interruptible() cleanly removes this
> second issue, but still requires the caller to respond appropriately if there is
> a return value. Hence, I like your change. I think it makes the most sense.
> Since I didn't/don't know how the device works, I was not able to make the
> change myself. Thanks for your input!

Sounds like a sign-off. Any other input before I request Stefan to make
the final decision?

> > Anyway, signal handling does not appear to be critical there.
> 
> Just out of curiousity, doesn't that run the risk, though, of
> signal_pending(current) being true for quite a bit of time following the
> timeout?

How much of this is "curiosity" vs a real risk?


