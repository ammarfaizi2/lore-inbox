Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319075AbSH1XQu>; Wed, 28 Aug 2002 19:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319074AbSH1XQt>; Wed, 28 Aug 2002 19:16:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44553 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319075AbSH1XQq>; Wed, 28 Aug 2002 19:16:46 -0400
Date: Thu, 29 Aug 2002 00:21:03 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andrew Morton <akpm@zip.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] mysterious tty deadlock
Message-ID: <20020829002103.B28455@flint.arm.linux.org.uk>
References: <20020828220114.GA878@holomorphy.com> <3D6D4DD0.1900B894@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D6D4DD0.1900B894@zip.com.au>; from akpm@zip.com.au on Wed, Aug 28, 2002 at 03:25:20PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 03:25:20PM -0700, Andrew Morton wrote:
> William Lee Irwin III wrote:
> > 
> > One such stuck process had the following backtrace:
> > 
> > #0  schedule_timeout (timeout=-150765944) at timer.c:864
> 
> schedule_timeout is FASTCALL, which confuses gdb's stack crawler
> somewhat.
> 
> > #1  0xc01a28a3 in uart_wait_until_sent (tty=0xf7669000, timeout=2147483647)
> >     at core.c:1320
> 
> Might be a bit racy?
> 
> --- 2.5.32/drivers/serial/core.c~serial-race	Wed Aug 28 15:22:22 2002
> +++ 2.5.32-akpm/drivers/serial/core.c	Wed Aug 28 15:22:26 2002
> @@ -1315,13 +1315,14 @@ static void uart_wait_until_sent(struct 
>  	 * 'timeout' / 'expire' give us the maximum amount of time
>  	 * we wait.
>  	 */
> +	set_current_state(TASK_INTERRUPTIBLE);
>  	while (!port->ops->tx_empty(port)) {
> -		set_current_state(TASK_INTERRUPTIBLE);
>  		schedule_timeout(char_time);
>  		if (signal_pending(current))
>  			break;
>  		if (time_after(jiffies, expire))
>  			break;
> +		set_current_state(TASK_INTERRUPTIBLE);
>  	}
>  	set_current_state(TASK_RUNNING); /* might not be needed */
>  }

Patch looks good, as far as correctness goes.  However, since char_time
will be the amount of time for one character, we should never sleep long
enough for the user to notice this slip-up.

If people are seeing deadlocks, I agree with wli that there's something
very wrong elsewhere.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

