Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030444AbVLGXjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030444AbVLGXjS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 18:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbVLGXjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 18:39:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22537 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964936AbVLGXjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 18:39:17 -0500
Date: Wed, 7 Dec 2005 23:39:11 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [RFC] [PATCH] Adding ctrl-o sysrq hack support to 8250 driver
Message-ID: <20051207233911.GP6793@flint.arm.linux.org.uk>
Mail-Followup-To: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org,
	Sachin Sant <sachinp@in.ibm.com>
References: <438D8A3A.9030400@in.ibm.com> <20051130130429.GB25032@flint.arm.linux.org.uk> <43953440.9070102@in.ibm.com> <20051206171633.GB19664@flint.arm.linux.org.uk> <20051207222246.GA22558@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207222246.GA22558@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 11:22:46PM +0100, Olaf Hering wrote:
>  On Tue, Dec 06, Russell King wrote:
> 
> > I'm still highly concerned about this whole idea.  Applying this patch
> > _will_ without doubt inconvenience a lot of people who expect ^O to be
> > received as normal.
> 
> If one boots with 'console=ttyS0', the 'ctrl o' should be handled only
> on ttyS0. However, I'm not sure if anyone uses ^O in this situation via
> the system console. In our case, ttyS0 is automatically activated via
> add_preferred_console in arch/powerpc/kernel/setup-common.c.
> If there is a clever way to handle ^O only for the system console, would
> such a patch be accepted? I'm currently looking through the code to see
> how it could be done.

Easily.  Have a look at the internals of uart_handle_break() in
include/linux/serial_core.h

However, please be aware that ^O is the default control character for
"flush output" which I think is something you may want to use with a
serial console.  Eg:

speed 38400 baud; rows 0; columns 0; line = 1;
intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = <undef>;
eol2 = <undef>; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R; werase = ^W;
lnext = ^V; flush = ^O; min = 1; time = 0;
            ^^^^^^^^^^^

Hence it's a poor choice.  Maybe picking a character which isn't
already used by default for another purpose would be appropriate?
'^]', the classic telnet escape character maybe?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
