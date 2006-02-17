Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWBQWnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWBQWnL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 17:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWBQWnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 17:43:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2572 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751028AbWBQWnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 17:43:10 -0500
Date: Fri, 17 Feb 2006 22:39:39 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: linux@horizon.com
Cc: paulkf@microgate.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SIIG 8-port serial boards support
Message-ID: <20060217223938.GA24170@flint.arm.linux.org.uk>
Mail-Followup-To: linux@horizon.com, paulkf@microgate.com,
	linux-kernel@vger.kernel.org
References: <20060217222529.14155.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217222529.14155.qmail@science.horizon.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 05:25:29PM -0500, linux@horizon.com wrote:
> >> - conventional RTS/CTS
> > RTS active = ready to receive
> > CTS active = allowed to send
> > 
> >> - alternative RTS/CTS
> > RTS active = on before send, off after send
> > CTS active = allowed to send
> > 
> >> - RS485
> > RTS active = on before send, off after send (RTS enables driver)
> > CTS ignored (2 wire mode, no CTS)
> > 
> > So maybe the extra control fields would be:
> > CRTSONTX - RTS on before send, off after send
> > CTXONCTS - wait for CTS before sending
> 
> As someone who's actually used both kinds of modems, here are
> the issues:
> 
> - For RS-485, you have a half-duplex wire, and the response is triggered
>   by the serial data.  And some of those industrial controllers respond in
>   less than a character time.  You MUST disable the transmitter promptly
>   when finished sending so you can hear the response.
> 
>   It's also helpful if the receiver is disabled while the transmitter
>   is enabled, but that's negotible.
> 
> - For Classic half-duplex RTS/CTS, the DTE (computer) must always accept
>   data, but raises RTS when it wants to send.  When it gets CTS, it's
>   allowed to actually send.  There are still single-frequency VHF radio
>   modems floating around that work this way.  When a modem receives
>   RTS and is not receiving a carrier (CD is deasserted), it enables its
>   transmitter, and waits a programmed receiver-acquisition delay before
>   asserting CTS.
> 
> Both of these are variants on the same theme, and I'd suggest expressing
> them with one additional bit along with the existing CRTSCTS.  I'll call
> it CRTSHDX (RTS half-duplex).  It means "assert RTS when we have data
> to send, and deassert it when we don't".  When it's not set, RTS is
> asserted when we can accept data and deasserted when we can't.
> 
> All four combinations are sensible:
> 
> CRTSCTS	CRTSHDX	Handshaking
> off	off	None.  (Computer might as well send RTS< but ignores CTS)
> on	off	Full-duplex RTS/CTS
> off	on	RS-485.  CTS ignored, RTS enables transmitter.
> on	on	RS-232 half-duplex.  RTS is request, CTS is grant.
> 
> The upshot is that CRTSCTS controls whether CTS is listened to, and the
> new CRTSHDX controls the interpretation of RTS.  For a three-wire hookup,
> CRTSRCS must be off and CRTSHDX has no real effect.

We need to preserve CRTSCTS off = no modem control activity - I'm
sure things like old serial mice do not take kindly to having the
modem control lines changing state, especially the ones they use to
power themselves.

Also, !CRTSCTS is most likely the state used by any existing userspace
RS485 implementations which would be using TIOCMBIC/TIOCMBIS to
manipulate the RTS signal, so having RTS manipulated in this state
would be an undesirable change of behaviour.

Hence, I'm very much in favour of having the default flow control
method to preserve in as many ways as possible existing behaviour
for CRTSCTS.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
