Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVCGDg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVCGDg4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 22:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVCGDg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 22:36:56 -0500
Received: from fire.osdl.org ([65.172.181.4]:63618 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261540AbVCGDgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 22:36:31 -0500
Date: Sun, 6 Mar 2005 19:35:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: domen@coderock.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com,
       Mikael Starvik <mikael.starvik@axis.com>
Subject: Re: [patch 10/14] serial/crisv10: replace schedule_timeout() with
 msleep()
Message-Id: <20050306193548.1d0d6e44.akpm@osdl.org>
In-Reply-To: <20050306223647.3C19F1EDA4@trashy.coderock.org>
References: <20050306223647.3C19F1EDA4@trashy.coderock.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

domen@coderock.org wrote:
>
> Use msleep() instead of schedule_timeout() to guarantee the task
>  delays as expected. The current code uses TASK_INTERRUPTIBLE, but does not care
>  about signals, so I believe msleep() should be ok.
> 
>  Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
>  Signed-off-by: Domen Puncer <domen@coderock.org>
>  ---
> 
> 
>   kj-domen/drivers/serial/crisv10.c |    6 ++----
>   1 files changed, 2 insertions(+), 4 deletions(-)
> 
>  diff -puN drivers/serial/crisv10.c~msleep-drivers_serial_crisv10 drivers/serial/crisv10.c
>  --- kj/drivers/serial/crisv10.c~msleep-drivers_serial_crisv10	2005-03-05 16:10:52.000000000 +0100
>  +++ kj-domen/drivers/serial/crisv10.c	2005-03-05 16:10:52.000000000 +0100
>  @@ -3757,10 +3757,8 @@ rs_write(struct tty_struct * tty, int fr
>   		e100_enable_rx_irq(info);
>   #endif
>   
>  -		if (info->rs485.delay_rts_before_send > 0) {
>  -			set_current_state(TASK_INTERRUPTIBLE);
>  -			schedule_timeout((info->rs485.delay_rts_before_send * HZ)/1000);
>  -		}
>  +		if (info->rs485.delay_rts_before_send > 0)
>  +			msleep(info->rs485.delay_rts_before_send);

Behavioural change: we'll no longer break out of the sleep if a signal is
pending.  Which probably means you fixed a bug ;)

Please work it with Mikael.

