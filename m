Return-Path: <linux-kernel-owner+w=401wt.eu-S1755099AbWL2X7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755099AbWL2X7o (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 18:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965226AbWL2X7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 18:59:44 -0500
Received: from xenotime.net ([66.160.160.81]:44171 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755099AbWL2X7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 18:59:43 -0500
Date: Fri, 29 Dec 2006 15:48:02 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/6] UML - Console locking fixes
Message-Id: <20061229154802.b0768d6e.rdunlap@xenotime.net>
In-Reply-To: <200612292341.kBTNfR3s005529@ccure.user-mode-linux.org>
References: <200612292341.kBTNfR3s005529@ccure.user-mode-linux.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2006 18:41:27 -0500 Jeff Dike wrote:

>  arch/um/drivers/line.c          |  188 ++++++++++++++++++++++++++--------------
>  arch/um/drivers/stdio_console.c |    6 -
>  arch/um/include/line.h          |   14 +-
>  3 files changed, 135 insertions(+), 73 deletions(-)
> 
> Index: linux-2.6.18-mm/arch/um/drivers/line.c
> ===================================================================
> --- linux-2.6.18-mm.orig/arch/um/drivers/line.c	2006-12-29 15:12:45.000000000 -0500
> +++ linux-2.6.18-mm/arch/um/drivers/line.c	2006-12-29 17:26:26.000000000 -0500
> @@ -421,42 +420,84 @@ int line_setup_irq(int fd, int input, in
>  	return err;
>  }
>  
> +/* Normally, a driver like this can rely mostly on the tty layer

/*
 * Normally, ...

> + * locking, particularly when it comes to the driver structure.
> + * However, in this case, mconsole requests can come in "from the
> + * side", and race with opens and closes.
> + *
> + * The problem comes from line_setup not wanting to sleep if
> + * the device is open or being opened.  This can happen because the
> + * first opener of a device is responsible for setting it up on the
> + * host, and that can sleep.  The open of a port device will sleep
> + * until someone telnets to it.
> + *
> + * The obvious solution of putting everything under a mutex fails
> + * because then trying (and failing) to change the configuration of an
> + * open(ing) device will block until the open finishes.  The right
> + * thing to happen is for it to fail immediately.
> + *
> + * We can put the opening (and closing) of the host device under a
> + * separate lock, but that has to be taken before the count lock is
> + * released.  Otherwise, you open a window in which another open can
> + * come through and assume that the host side is opened and working.
> + *
> + * So, if the tty count is one, open will take the open mutex
> + * inside the count lock.  Otherwise, it just returns. This will sleep
> + * if the last close is pending, and will block a setup or get_config,
> + * but that should not last long.
> + *
> + * So, what we end up with is that open and close take the count lock.
> + * If the first open or last close are happening, then the open mutex
> + * is taken inside the count lock and the host opening or closing is done.
> + *
> + * setup and get_config only take the count lock.  setup modifies the
> + * device configuration only if the open count is zero.  Arbitrarily
> + * long blocking of setup doesn't happen because something would have to be
> + * waiting for an open to happen.  However, a second open with
> + * tty->count == 1 can't happen, and a close can't happen until the open
> + * had finished.
> + *
> + * We can't maintain our own count here because the tty layer doesn't
> + * match opens and closes.  It will call close if an open failed, and
> + * a tty hangup will result in excess closes.  So, we rely on
> + * tty->count instead.  It is one on both the first open and last close.
> + */
> +
>  int line_open(struct line *lines, struct tty_struct *tty)
>  {
> -	struct line *line;
> +	struct line *line = &lines[tty->index];
>  	int err = -ENODEV;
>  
> -	line = &lines[tty->index];
> -	tty->driver_data = line;
> +	spin_lock(&line->count_lock);
> +	if(!line->valid)

	if (
	(several of these)

> +		goto out_unlock;
> +
> +	err = 0;
> +	if(tty->count > 1)
> +		goto out_unlock;
>  
...

> +	if(!line->sigio){
> +		chan_enable_winch(&line->chan_list, tty);
> +		line->sigio = 1;
>  	}
>  
> -	err = 0;
>  }

> @@ -466,25 +507,38 @@ void line_close(struct tty_struct *tty, 
> +	if(line == NULL)
> +		return;

again.

>  
>  	/* We ignore the error anyway! */
>  	flush_buffer(line);
>  
> -	if(tty->count == 1){
> -		line->tty = NULL;
> -		tty->driver_data = NULL;
> -
> -		if(line->sigio){
> -			unregister_winch(tty);
> -			line->sigio = 0;
> -		}
> +	spin_lock(&line->count_lock);
> +	if(!line->valid)
> +		goto out_unlock;
> +
> +	if(tty->count > 1)
> +		goto out_unlock;
> +

ditto.  tritto.

> +	mutex_lock(&line->open_mutex);
> +	spin_unlock(&line->count_lock);
> +
> +	line->tty = NULL;
> +	tty->driver_data = NULL;
> +
> +	if(line->sigio){

again.

> +		unregister_winch(tty);
> +		line->sigio = 0;
>          }
>  
> -	spin_unlock_irq(&line->lock);
> +	mutex_unlock(&line->open_mutex);
> +	return;
> +
> +out_unlock:
> +	spin_unlock(&line->count_lock);
>  }
>  
>  void close_lines(struct line *lines, int nlines)


---
~Randy
