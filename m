Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284254AbRLRQ5A>; Tue, 18 Dec 2001 11:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284258AbRLRQ4z>; Tue, 18 Dec 2001 11:56:55 -0500
Received: from zeus.kernel.org ([204.152.189.113]:45214 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S284254AbRLRQ4g>;
	Tue, 18 Dec 2001 11:56:36 -0500
Date: Tue, 18 Dec 2001 16:55:46 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Telford002@aol.com, linux-kernel@vger.kernel.org
Subject: Re: TTY Driver Open and Close Logic
Message-ID: <20011218165546.C13126@flint.arm.linux.org.uk>
In-Reply-To: <e5.10e6703a.29509786@aol.com> <200112181416.fBIEGZM15494@pinkpanther.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200112181416.fBIEGZM15494@pinkpanther.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Dec 18, 2001 at 02:16:35PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 02:16:35PM +0000, Alan Cox wrote:
> Possibly so. But everyone who sent me a 2.2 patch to redo it broke stuff and
> caused crashes and panics. Its worth doing for 2.5.x tho - along with proper
> refcounting and killing the BKL

The module use accounting for the tty layer are *disgusting* beyond
belief, caused by the fact that if an open fails, the close method
is called.  Let me paste the following code from the replacement
serial drivers open method (note that the old driver only has to
worry about itself):

        /*
         * tty->driver.num won't change, so we won't fail here with
         * tty->driver_data set to something non-NULL (and therefore
         * we won't get caught by uart_close()).
         */
        retval = -ENODEV;
        if (line >= tty->driver.num)
                goto fail;

        /*
         * If we fail to increment the module use count, we can't have
         * any other users of this tty (since this implies that the module
         * is about to be unloaded).  Therefore, it is safe to set
         * tty->driver_data to be NULL, so uart_close() doesn't bite us.
         */
        if (!try_inc_mod_count(drv->owner)) {
                tty->driver_data = NULL;
                goto fail;
        }

        /*
         * FIXME: This one isn't fun.  We can't guarantee that the tty isn't
         * already in open, nor can we guarantee the state of tty->driver_data
         */
        info = uart_get(drv, line);
        retval = -ENOMEM;
        if (!info) {
                if (tty->driver_data)
                        goto out;
                else
                        goto fail;
        }

I don't like the second entry because it the potential to cause a null
pointer dereference on a SMP machine.

I definitely don't like the third either.

However, to add to the dilemas, what if tty->driver_data has been set,
the module unloaded, reloaded (with a different port configuration - ie,
smaller tty->driver.num).  tty->driver_data may not be NULL.

rs_close/uart_close use tty->driver_data to indicate whether the port has
been opened, and whether we need to therefore decrement the count.  It's
broken, but I regard the tty layer as broken for calling the driver close
method when the open method has failed.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

