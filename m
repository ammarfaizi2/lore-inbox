Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbUCDHew (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 02:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbUCDHew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 02:34:52 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:6 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261531AbUCDHeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 02:34:50 -0500
Date: Thu, 4 Mar 2004 08:22:25 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Armin Schindler <aml@melware.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Armin Schindler <armin@melware.de>
Subject: Re: [PATCH 2.4] sys_select() return error on bad file
Message-ID: <20040304072225.GA20915@alpha.home.local>
References: <Pine.LNX.4.31.0403030936570.9608-100000@phoenix.one.melware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0403030936570.9608-100000@phoenix.one.melware.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 03, 2004 at 09:46:54AM +0100, Armin Schindler wrote:
> --- linux/fs/select.c_orig	2004-03-02 19:06:44.000000000 +0100
> +++ linux/fs/select.c	2004-03-03 09:25:24.000000000 +0100
> @@ -183,6 +183,8 @@
>  		wait = NULL;
>  	retval = 0;
>  	for (;;) {
> +		int file_err = 1;
> +

Just a thought, select() is often performance-critical, and adding one more
variable inside the loop can slow it down a bit. Wouldn't it be cheaper to
set retval to -EBADF above and avoid using file_err ?

>  		set_current_state(TASK_INTERRUPTIBLE);
>  		for (i = 0 ; i < n; i++) {
>  			unsigned long bit = BIT(i);
> @@ -199,6 +201,7 @@
>  						  i /*  The fd*/,
>  						  __timeout,
>  						  NULL);
> +				file_err = 0;

There you would put retval=0

>  				mask = DEFAULT_POLLMASK;
>  				if (file->f_op && file->f_op->poll)
>  					mask = file->f_op->poll(file, wait);
> @@ -227,6 +230,10 @@
>  			retval = table.error;
>  			break;
>  		}
> +		if (file_err) {
> +			retval = -EBADF;
> +			break;
> +		}

And there : if (retval == -EBADF) break;

>  		__timeout = schedule_timeout(__timeout);
>  	}
>  	current->state = TASK_RUNNING;

Just a thought anyway, I've not read the complete function.

Cheers,
Willy

