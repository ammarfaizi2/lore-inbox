Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751777AbWBQWZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbWBQWZb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 17:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbWBQWZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 17:25:31 -0500
Received: from science.horizon.com ([192.35.100.1]:49707 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751476AbWBQWZa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 17:25:30 -0500
Date: 17 Feb 2006 17:25:29 -0500
Message-ID: <20060217222529.14155.qmail@science.horizon.com>
From: linux@horizon.com
To: paulkf@microgate.com, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH] SIIG 8-port serial boards support
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> - conventional RTS/CTS
> RTS active = ready to receive
> CTS active = allowed to send
> 
>> - alternative RTS/CTS
> RTS active = on before send, off after send
> CTS active = allowed to send
> 
>> - RS485
> RTS active = on before send, off after send (RTS enables driver)
> CTS ignored (2 wire mode, no CTS)
> 
> So maybe the extra control fields would be:
> CRTSONTX - RTS on before send, off after send
> CTXONCTS - wait for CTS before sending

As someone who's actually used both kinds of modems, here are
the issues:

- For RS-485, you have a half-duplex wire, and the response is triggered
  by the serial data.  And some of those industrial controllers respond in
  less than a character time.  You MUST disable the transmitter promptly
  when finished sending so you can hear the response.

  It's also helpful if the receiver is disabled while the transmitter
  is enabled, but that's negotible.

- For Classic half-duplex RTS/CTS, the DTE (computer) must always accept
  data, but raises RTS when it wants to send.  When it gets CTS, it's
  allowed to actually send.  There are still single-frequency VHF radio
  modems floating around that work this way.  When a modem receives
  RTS and is not receiving a carrier (CD is deasserted), it enables its
  transmitter, and waits a programmed receiver-acquisition delay before
  asserting CTS.

Both of these are variants on the same theme, and I'd suggest expressing
them with one additional bit along with the existing CRTSCTS.  I'll call
it CRTSHDX (RTS half-duplex).  It means "assert RTS when we have data
to send, and deassert it when we don't".  When it's not set, RTS is
asserted when we can accept data and deasserted when we can't.

All four combinations are sensible:

CRTSCTS	CRTSHDX	Handshaking
off	off	None.  (Computer might as well send RTS< but ignores CTS)
on	off	Full-duplex RTS/CTS
off	on	RS-485.  CTS ignored, RTS enables transmitter.
on	on	RS-232 half-duplex.  RTS is request, CTS is grant.

The upshot is that CRTSCTS controls whether CTS is listened to, and the
new CRTSHDX controls the interpretation of RTS.  For a three-wire hookup,
CRTSRCS must be off and CRTSHDX has no real effect.
