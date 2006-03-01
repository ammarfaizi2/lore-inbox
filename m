Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWCAUCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWCAUCl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 15:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWCAUCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 15:02:41 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41656 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750885AbWCAUCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 15:02:41 -0500
Date: Wed, 1 Mar 2006 20:00:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH] Convert serial_core oopses to BUG_ON
Message-ID: <20060301190049.GA1697@elf.ucw.cz>
References: <20060227162827.GC2389@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227162827.GC2389@ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> With reference to these two bugs:
> 
> 	http://bugzilla.kernel.org/show_bug.cgi?id=5958
> 	http://bugzilla.kernel.org/show_bug.cgi?id=6131
> 
> it seems that folk are under the impression that serial_core is
> responsible for these bugs.  It isn't.
> 
> Calling serial functions to flush buffers, or try to send more data
> after the port has been closed or hung up is a bug in the code doing
> the calling, not in the serial_core driver.
> 
> Make this explicitly obvious by adding BUG_ON()'s.

They did not trigger for me, altrough my own traps do.

> diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
> --- a/drivers/serial/serial_core.c
> +++ b/drivers/serial/serial_core.c
> @@ -521,6 +532,12 @@ static void uart_flush_buffer(struct tty
>  	struct uart_port *port = state->port;
>  	unsigned long flags;
>  
> +	/*
> +	 * This means you called this function _after_ the port was
> +	 * closed.  No cookie for you.
> +	 */
> +	BUG_ON(!state);
> +
>  	DPRINTK("uart_flush_buffer(%d) called\n", tty->index);
>  
>  	spin_lock_irqsave(&port->lock, flags);
> 

This is one I'm hitting. Actually I'm hitting my own check few lines
down:

        if (!state->info)
                printk(KERN_CRIT "no state->info\n");
        else uart_circ_clear(&state->info->xmit);
        spin_unlock_irqrestore(&port->lock, flags);
        tty_wakeup(tty);

... simply not doing uart_circ_clear() at all makes system
survive... so this could be made into WARN()...

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
