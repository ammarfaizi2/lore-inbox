Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262887AbSKHXTS>; Fri, 8 Nov 2002 18:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262914AbSKHXTS>; Fri, 8 Nov 2002 18:19:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34323 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262887AbSKHXTR>; Fri, 8 Nov 2002 18:19:17 -0500
Date: Fri, 8 Nov 2002 23:25:55 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Martin Diehl <lists@mdiehl.de>
Cc: Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Serial 2.5]: packet drop problem (FE ?)
Message-ID: <20021108232555.E24905@flint.arm.linux.org.uk>
Mail-Followup-To: Martin Diehl <lists@mdiehl.de>,
	Jean Tourrilhes <jt@bougret.hpl.hp.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20021108024058.GA1266@bougret.hpl.hp.com> <Pine.LNX.4.44.0211081308190.1320-100000@notebook.home.mdiehl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211081308190.1320-100000@notebook.home.mdiehl.de>; from lists@mdiehl.de on Fri, Nov 08, 2002 at 11:34:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 11:34:18PM +0100, Martin Diehl wrote:
> The next to know is whether irtty_receive_buf() reports any "Framing or 
> parity error"? IIRC with IGNPAR set we should neither get parity nor 
> framing errors reported and it seems this is how serial8250_change_speed()
> deals with ignore_status_mask. But wait - yes, 8250's receive_chars() 
> seems to accept the character,

Correct.

> but set TTY_FRAME anyway.

Only if INPCK is set.  If it's clear, then it will ignore framing and
parity errors.  (Irrespective of this, it will still internally count
them for statistical purposes, just like 2.4 used to.)

However, since INPCK is clear (from the info Jean's already sent) you'll
receive the character a TTY_NORMAL flag, even though the hardware flagged
an error.

> Ok, I think what might happen is you are receiving some kind of IR-noise 
> (maybe environment, maybe reflected, maybe dongle echo) causing bytes with 
> framing errors to get passed to and handled by irtty in one go with the 
> beginning of the first byte(s) from the next incoming frame. Thus we 
> discard the BOF and the whole frame is missed :-(

Maybe the problem is that you want to discard the bad byte (by flagging
it with a non-TTY_NORMAL flag.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

