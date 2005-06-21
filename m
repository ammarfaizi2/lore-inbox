Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVFUJ7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVFUJ7o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 05:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVFUJ7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 05:59:02 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:1500 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262060AbVFUJ4l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 05:56:41 -0400
Date: Tue, 21 Jun 2005 11:58:22 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: domen@coderock.org
Cc: emoenke@gwdg.de, linux-kernel@vger.kernel.org,
       Nishanth Aravamudan <nacc@us.ibm.com>
Message-ID: <20050621095822.GA3942@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>, domen@coderock.org,
	emoenke@gwdg.de, linux-kernel@vger.kernel.org,
	Nishanth Aravamudan <nacc@us.ibm.com>
References: <20050620215148.561754000@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620215148.561754000@nd47.coderock.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 84.189.239.177
Subject: Re: [patch 2/4] cdrom/aztcd: remove sleep_on() usage
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

domen@coderock.org wrote:
> From: Nishanth Aravamudan <nacc@us.ibm.com>
> 
> 
> 
> Directly use wait-queues instead of the deprecated sleep_on().
> This required adding a local waitqueue. Patch is compile-tested.

IMHO this patch doesn't improve anything, it just makes the
code harder to read. sleep_on() is deprecated because there's
an inherent race between sleep_on() and wake_up(). To address
this you need to add a condition variable (e.g. AztStenLow) and
convert the code to use wait_event().
The timer trick used here makes it pretty hard to hit the
race, but with a preemptible kernel one could be preempted
between the SET_TIMER() and the sleep_on().

Johannes

> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> Signed-off-by: Domen Puncer <domen@coderock.org>
> ---
>  aztcd.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletion(-)
> 
> Index: quilt/drivers/cdrom/aztcd.c
> ===================================================================
> --- quilt.orig/drivers/cdrom/aztcd.c
> +++ quilt/drivers/cdrom/aztcd.c
> @@ -179,6 +179,7 @@
>  #include <linux/ioport.h>
>  #include <linux/string.h>
>  #include <linux/major.h>
> +#include <linux/wait.h>
>  
>  #include <linux/init.h>
>  
> @@ -429,9 +430,12 @@ static void dten_low(void)
>  #define STEN_LOW_WAIT   statusAzt()
>  static void statusAzt(void)
>  {
> +	DEFINE_WAIT(wait);
>  	AztTimeout = AZT_STATUS_DELAY;
>  	SET_TIMER(aztStatTimer, HZ / 100);
> -	sleep_on(&azt_waitq);
> +	prepare_to_wait(&azt_waitq, &wait, TASK_UNINTERRUPTIBLE);
> +	schedule();
> +	finish_wait(&azt_waitq, &wait);
>  	if (AztTimeout <= 0)
>  		printk("aztcd: Error Wait STEN_LOW_WAIT command:%x\n",
>  		       aztCmd);
> 
