Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTETIoE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 04:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbTETIoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 04:44:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59917 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263632AbTETIoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 04:44:02 -0400
Date: Tue, 20 May 2003 09:56:54 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>,
       BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
       viro@ftp.uk.linux.org, linux-kernel@vger.kernel.org
Subject: Re: rfcomm-tty driver->put_char
Message-ID: <20030520095654.A4491@flint.arm.linux.org.uk>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Marcel Holtmann <marcel@rvs.uni-bielefeld.de>,
	BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
	viro@ftp.uk.linux.org, linux-kernel@vger.kernel.org
References: <1053199887.9218.50.camel@imladris.demon.co.uk> <1053379016.1475.66.camel@pegasus> <1053381250.21582.14.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1053381250.21582.14.camel@imladris.demon.co.uk>; from dwmw2@infradead.org on Mon, May 19, 2003 at 10:54:10PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 10:54:10PM +0100, David Woodhouse wrote:
> Note that I recommend this for 2.4 _only_. For 2.5 the correct fix is to
> fix the tty_driver API, so you can perhaps let this 'bug' remain there
> for a while. I seem to be the only person using an rfcomm modem for
> dialin anyway, and 2.5 doesn't even get as far as a login prompt on that
> box, let alone support V.110 dialin over ISDN which is also required, so
> I really won't miss it :)
> 
> The write_room() function is documented to return the number of
> characters which can _currently_ be pushed to the tty driver. The n_tty
> code has no business thinking that the value returned from write_room()
> will be valid at _any_ point in the future, and the fact that put_char()
> is not permitted to return any success/failure indication like write()
> can is just bizarre.

It is up to the line discipline to ensure that there is only a single
thread running between write_room() and the write() or put_char() call
(which is currently done thanks to lock_kernel().  If it isn't, the
tty locking broke and we have bigger problems.)

Without this guarantee, how do you propose to handle the following case:

- we have a "\n" character from user space.
- we have O_ONLCR set.
- we have only one character available in the output buffer in the driver.

This means we need to write two characters "\r\n" to the driver.  If we
try to write "\r\n" using your proposed solution, we'd write "\r".  How
do we remember that we need to write a "\n" (or some other string of
characters for that matter) ?

Now consider if we could remember we've only written half the string.
What happens if we've written "\r", then some tty echo occurs, then
we write "\n" ?

If these cases don't work with a new API, the new API is even more buggy
than the existing one.

(For user output, n_tty currently guarantees that we will not drop any
characters written from user space, as long as we remain single-threaded
between write_room() and put_char() or write() methods.)

Looking at rfcomm, this is probably part of your problem:

        return dlc->mtu * (dlc->tx_credits ? : 10);

Also, rfcomm should be fixed to use the put_char / flush_buffer methods.
These are there to batch up single chars to make things more efficient,
and I wouldn't be surprised if a stream of single chars were eating up
all your tx credits.

I'm surprised that rfcomm, being a packet based communication system,
doesn't implement put_char.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

