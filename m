Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVASG1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVASG1y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 01:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVASG1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 01:27:54 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:18145 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261599AbVASG1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 01:27:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=TS0ITlxkgxRQRvw0RLX4pm6igxL42ulIJr/oaWjAbfLfV9JjHgP2G7j78GQIOb3Q+MNMdXM9FKy/+5X6Mq7hfK1Gr26fk4qVhGVAuE4FycY81uqcPb3y77f3SVaOU2JhsxP0TOeGP5loHDTa25xRC+UhhuOZ88pM93I8uV8b6u0=
Message-ID: <29495f1d0501182227739e369f@mail.gmail.com>
Date: Tue, 18 Jan 2005 22:27:18 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Dan Dennedy <dan@dennedy.org>
Subject: Re: [KJ] Re: [UPDATE PATCH] ieee1394/sbp2: use ssleep() instead of schedule_timeout()
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, kj <kernel-janitors@lists.osdl.org>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Ben Collins <bcollins@debian.org>
In-Reply-To: <1105678375.7830.81.camel@kino.dennedy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050107213400.GD2924@us.ibm.com>
	 <17a9eec54394ded0a28295a6548a5c65@localhost>
	 <20050110173945.GB3099@us.ibm.com>
	 <1105678375.7830.81.camel@kino.dennedy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2005 23:52:55 -0500, Dan Dennedy <dan@dennedy.org> wrote:
> On Mon, 2005-01-10 at 09:39 -0800, Nishanth Aravamudan wrote:
> > On Sun, Jan 09, 2005 at 10:01:21AM +0100, Stefan Richter wrote:
> > > Nishanth Aravamudan wrote:
> > > >Description: Use ssleep() instead of schedule_timeout() to guarantee
> > > >the task
> > > >delays as expected. The existing code should not really need to run in
> > > >TASK_INTERRUPTIBLE, as there is no check for signals (or even an
> > > >early return
> > > >value whatsoever). ssleep() takes care of these issues.
> > >
> > > >--- 2.6.10-v/drivers/ieee1394/sbp2.c       2004-12-24 13:34:00.000000000
> > > >-0800
> > > >+++ 2.6.10/drivers/ieee1394/sbp2.c 2005-01-05 14:23:05.000000000 -0800
> > > >@@ -902,8 +902,7 @@ alloc_fail:
> > > >    * connected to the sbp2 device being removed. That host would
> > > >    * have a certain amount of time to relogin before the sbp2 device
> > > >    * allows someone else to login instead. One second makes sense. */
> > > >-  set_current_state(TASK_INTERRUPTIBLE);
> > > >-  schedule_timeout(HZ);
> > > >+  ssleep(1);
> > >
> > > Maybe the current code is _deliberately_ accepting interruption by
> > > signals but trying to complete sbp2_probe() anyway. However it seems
> > > more plausible to me to abort the device probe, for example like this:
> > > if (msleep_interruptible(1000)) {
> > >     sbp2_remove_device(scsi_id);
> > >     return -EINTR;
> > > }
> >
> > You might be right, but I'd like to get Ben's input on this, as I honeslty am
> 
> Don't hold your breath waiting for Ben's input. However, I would like to
> get one of the two proposed committed and tested by more users as this
> is a sore spot. I am not in a position at this time to fully research
> and test to make a call.
> 
> > unsure. To be fair, I am trying to audit all usage of schedule_timeout() and the
> > semantic interpretation (to me) of using TASK_INTERRUPTIBLE is that you wish to
> > sleep a certain amount of time, but also are prepared for an early return on
> > either signals or wait-queue events. msleep_interruptible() cleanly removes this
> > second issue, but still requires the caller to respond appropriately if there is
> > a return value. Hence, I like your change. I think it makes the most sense.
> > Since I didn't/don't know how the device works, I was not able to make the
> > change myself. Thanks for your input!
> 
> Sounds like a sign-off. Any other input before I request Stefan to make
> the final decision?

Yes, this is an ACK for Stefan's change. Although the exact code he
produced is not quite accurate. It would be most accurate to use

msleep_interruptible(1000);
if (signals_pending(current) {
       sbp2_remove_device(scsi_id);
       return -EINTR;
}

This accounts for the corner case when the sleep times out and a
signal comes between the second-to-last and last jiffies. Thanks for
both of your input! If you'd prefere me sending a new patch I can do
so from work tomorrow.
 
> > > Anyway, signal handling does not appear to be critical there.
> >
> > Just out of curiousity, doesn't that run the risk, though, of
> > signal_pending(current) being true for quite a bit of time following the
> > timeout?
> 
> How much of this is "curiosity" vs a real risk?

I think it should be ok, actually, the -EINTR should get passed back
to userspace, where it would be handled appropriately. I hope :)

-Nish
