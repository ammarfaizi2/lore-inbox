Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266891AbUJTF0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266891AbUJTF0j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 01:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266768AbUJTFWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 01:22:09 -0400
Received: from gate.ebshome.net ([64.81.67.12]:55014 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S266891AbUJTFVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 01:21:09 -0400
Date: Tue, 19 Oct 2004 22:21:08 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com,
       Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [PATCH] I2C update for 2.6.9
Message-ID: <20041020052108.GA14871@gate.ebshome.net>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	sensors@stimpy.netroedge.com, Nishanth Aravamudan <nacc@us.ibm.com>
References: <10982315061975@kroah.com> <1098231506495@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098231506495@kroah.com>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 05:18:26PM -0700, Greg Kroah-Hartman wrote:
> ChangeSet 1.2072, 2004/10/19 15:21:15-07:00, nacc@us.ibm.com
> 
> [PATCH] I2C: replace schedule_timeout() with msleep_interruptible() in i2c-ibm_iic.c
> 
> Use msleep_interruptible() instead of schedule_timeout() to
> guarantee the task delays as expected. Remove the unnecessary
> set_current_state() following the if, as schedule_timeout() [and thus,
> mlseep_interruptible()] is guaranteed to return in TASK_RUNNING.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>
> 
> 
>  drivers/i2c/busses/i2c-ibm_iic.c |    4 +---
>  1 files changed, 1 insertion(+), 3 deletions(-)
> 
> 
> diff -Nru a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
> --- a/drivers/i2c/busses/i2c-ibm_iic.c	2004-10-19 16:53:58 -07:00
> +++ b/drivers/i2c/busses/i2c-ibm_iic.c	2004-10-19 16:53:58 -07:00
> @@ -416,10 +416,8 @@
>      		init_waitqueue_entry(&wait, current);
>  		
>  		add_wait_queue(&dev->wq, &wait);
> -		set_current_state(TASK_INTERRUPTIBLE);
>  		if (in_8(&iic->sts) & STS_PT)
> -			schedule_timeout(dev->adap.timeout * HZ);
> -		set_current_state(TASK_RUNNING);
> +			msleep_interruptible(dev->adap.timeout * 1000);
>  		remove_wait_queue(&dev->wq, &wait);
>  		
>  		if (unlikely(signal_pending(current))){

It looks like this change added race I tried to avoid here.

This code is modeled after __wait_event_interruptible_timeout, where 
"prepare_to_wait" is done _before_ checking completion status. This 
change breaks this, e.g. if IRQ happens right after we check iic->sts, 
but before calling msleep_interruptible(). In this case we'll sleep 
much more than required (seconds instead of microseconds)

Greg, if my analysis is correct, please rollback this change.

Nishanth, I'd be nice if you CC'ed me with this patch, my e-mail is at 
the top of that source file.

--
Eugene


