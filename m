Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVAIKjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVAIKjt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 05:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVAIKjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 05:39:49 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1043 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262039AbVAIKjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 05:39:46 -0500
Date: Sun, 9 Jan 2005 10:39:41 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Michael Ryan <lkml@lacklustre.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: STRIP Starmode Patch
Message-ID: <20050109103941.A5362@flint.arm.linux.org.uk>
Mail-Followup-To: Michael Ryan <lkml@lacklustre.net>,
	linux-kernel@vger.kernel.org
References: <20050108174525.2cad37b1.lkml@lacklustre.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050108174525.2cad37b1.lkml@lacklustre.net>; from lkml@lacklustre.net on Sat, Jan 08, 2005 at 05:45:25PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 05:45:25PM -0800, Michael Ryan wrote:
> The Linux kernel STRIP module was updated to support the newer series of
> Ricochet modems in January of 2002 by a person about whom I can find
> nothing more than a username of `abelits'. Anyway, he wasn't smart about
> it and didn't submit his patch to the LKML. When the existing drivers
> were migrated to the 2.6 tree, the old version of the module was migrated,
> and that's where the problems began.

strip also has other problems - it violates the layering of the kernel
subsystems and drivers in the get_baud() function:

        if ((tty->termios->c_cflag & CBAUD) == B38400 && tty->driver_data) {
                struct async_struct *info =
                    (struct async_struct *) tty->driver_data;	/* XXX */
                if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
                        return (B57600);
                if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
                        return (B115200);

There is no guarantee what tty->driver_data points at, and in fact
today the above code will be broken.

The best thing to happen here is to ignore the B38400 "hack" for fast
baud rates, and use the helper functions in the tty layer to get the
_numeric_ baud rate, which seems to be what the driver wants anyway:

        /* If the user has selected a baud rate above 38.4 see what magic we have to do */
        if (strip_info->user_baud > B38400) {

So, I don't think that this patch will be sufficient to resurect strip,
but I also don't think that it's an impossible task.  I'm just wondering
if it's really worth the effort given that we now have the vastly more
popular 802.11.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
