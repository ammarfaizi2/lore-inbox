Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262348AbVAJR5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbVAJR5Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbVAJRz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:55:59 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:53434 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262348AbVAJRjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:39:52 -0500
Date: Mon, 10 Jan 2005 09:39:45 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, kj <kernel-janitors@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, bcollins@debian.org
Subject: Re: [UPDATE PATCH] ieee1394/sbp2: use ssleep() instead of schedule_timeout()
Message-ID: <20050110173945.GB3099@us.ibm.com>
References: <20050107213400.GD2924@us.ibm.com> <17a9eec54394ded0a28295a6548a5c65@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17a9eec54394ded0a28295a6548a5c65@localhost>
X-Operating-System: Linux 2.6.10 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2005 at 10:01:21AM +0100, Stefan Richter wrote:
> Nishanth Aravamudan wrote:
> >Description: Use ssleep() instead of schedule_timeout() to guarantee 
> >the task
> >delays as expected. The existing code should not really need to run in
> >TASK_INTERRUPTIBLE, as there is no check for signals (or even an 
> >early return
> >value whatsoever). ssleep() takes care of these issues.
> 
> >--- 2.6.10-v/drivers/ieee1394/sbp2.c	2004-12-24 13:34:00.000000000 
> >-0800
> >+++ 2.6.10/drivers/ieee1394/sbp2.c	2005-01-05 14:23:05.000000000 -0800
> >@@ -902,8 +902,7 @@ alloc_fail:
> >	 * connected to the sbp2 device being removed. That host would
> >	 * have a certain amount of time to relogin before the sbp2 device
> >	 * allows someone else to login instead. One second makes sense. */
> >-	set_current_state(TASK_INTERRUPTIBLE);
> >-	schedule_timeout(HZ);
> >+	ssleep(1);
> 
> Maybe the current code is _deliberately_ accepting interruption by 
> signals but trying to complete sbp2_probe() anyway. However it seems 
> more plausible to me to abort the device probe, for example like this:
> if (msleep_interruptible(1000)) {
> 	sbp2_remove_device(scsi_id);
> 	return -EINTR;
> }

You might be right, but I'd like to get Ben's input on this, as I honeslty am
unsure. To be fair, I am trying to audit all usage of schedule_timeout() and the
semantic interpretation (to me) of using TASK_INTERRUPTIBLE is that you wish to
sleep a certain amount of time, but also are prepared for an early return on
either signals or wait-queue events. msleep_interruptible() cleanly removes this
second issue, but still requires the caller to respond appropriately if there is
a return value. Hence, I like your change. I think it makes the most sense.
Since I didn't/don't know how the device works, I was not able to make the
change myself. Thanks for your input!

> Anyway, signal handling does not appear to be critical there.

Just out of curiousity, doesn't that run the risk, though, of
signal_pending(current) being true for quite a bit of time following the
timeout?

Thanks,
Nish
