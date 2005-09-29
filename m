Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbVI2Whr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbVI2Whr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 18:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbVI2Whq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 18:37:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58323 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932304AbVI2Whq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 18:37:46 -0400
Date: Fri, 30 Sep 2005 00:37:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: marcel@holtmann.org, bluez-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Problems with CF bluetooth (fwd) (fwd)
Message-ID: <20050929223736.GF2180@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Thanks, Russell. Marcel, this is probably solution to that oops.

							Pavel

----- Forwarded message from Russell King

X-Original-To: pavel@atrey.karlin.mff.cuni.cz
To: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Problems with CF bluetooth (fwd)
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	atrey.karlin.mff.cuni.cz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
X-CRM114-Status: Good  ( pR: 34.1646 )

On Fri, Sep 30, 2005 at 12:04:28AM +0200, Pavel Machek wrote:
> (I had to hack serial driver a bit to default to 921600 bitrate; it
> does not have setserial).
> 
> # hciattach -s 921600 /dev/ttyS0 bcsp
> BCSP initialization timed out
> 								Pavel
> 
> Sep 29 15:42:34 amd kernel: EIP:    0060:[<c02d4e2c>]    Not tainted
> VLI
> Sep 29 15:42:34 amd kernel: EFLAGS: 00010082   (2.6.14-rc2-g5fb2493e)
> Sep 29 15:42:34 amd kernel: EIP is at uart_flush_buffer+0xc/0x30

Ok, you're in uart_flush_buffer(), and we got there through the
ldisc being closed.

> Sep 29 15:42:34 amd kernel: Call Trace:
> Sep 29 15:42:34 amd kernel:  [<c03f9df6>] hci_uart_flush+0x66/0x80
> Sep 29 15:42:34 amd kernel:  [<c03f9e27>] hci_uart_close+0x17/0x20
> Sep 29 15:42:34 amd kernel:  [<c03f9f86>] hci_uart_tty_close+0x26/0x60
> Sep 29 15:42:34 amd kernel:  [<c02a5ed7>] release_dev+0x587/0x670

Looking at release_dev(), it does things in the following order:

1. various sanity checks
2. close the driver
3. more sanity checks and other housekeeping
4. close the ldisc
5. reset the ldisc for the tty to N_TTY

This means that bluetooth is calling into a TTY driver with a tty
for which the driver has already shut down.  No surprise it oopses.
Bluetooth should not call the driver during it's closedown.

(There also appears to be an interesting race condition between the
driver shutting down and the ldisc write functions getting to know
about it... Alan?)

-- 
Russell King

----- End forwarded message -----

-- 
if you have sharp zaurus hardware you don't need... you know my address
