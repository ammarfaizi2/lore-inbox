Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293452AbSCKSAC>; Mon, 11 Mar 2002 13:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293487AbSCKR7r>; Mon, 11 Mar 2002 12:59:47 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:7186 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S292593AbSCKR7X>; Mon, 11 Mar 2002 12:59:23 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A76EC@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Henrique Gobbi'" <henrique@cyclades.com>
Cc: linux-kernel@vger.kernel.org,
        "'linux-serial'" <linux-serial@vger.kernel.org>
Subject: RE: Char devices drivers
Date: Mon, 11 Mar 2002 09:59:14 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002, Henrique Gobbi wrote:
> 
> Can anyone explain what is the utility of the callout devices 
> in the char drivers ???

Historically, under various Uni*, the idea was that the callout devices
would ignore DCD so open would complete regardless of the state of the
CLOCAL cflag bit. This allowed dialing on modems that either did not assert
DCD or bobbled DCD (causing hang-up on connect) while switching to online
mode. One would choose to configure modems to assert DCD only when in
connect state to assure local DTR drop (local hang up) if the link got
disconnected. Many phone systems were implemented such that the caller would
remain connected from the point of view of the telephone company and
continue to be billed for time if the called party hung up unexpectedly, or
the phone company dropped the link. Of course, if the modem were configured
to not assert DCD while offline (dialing) then the normal series of tty
devices could not be opened. So, the callout devices were to be used to
"call out" from automatic communication programs such as UUCP. 

The other series of devices, sometimes called "call-in", open with CLOCAL
off and wait in open for DCD to be asserted. This is what you would use for
a getty to listen for an auto answer connection. Most vendors provided an
interlock so a single port could be used for call-in and call-out traffic
without conflict. This almost worked. There was always the rare case where
the call-out devices was being opened at the same moment that a call came
in. Not very secure. 

There was even a third series of devices that were used to dial out on
hardware separate from the modem in the days before Hayes modems when
dinosaurs roamed the parking lot. :) 

Just to confuse things, the vendors noticed that customers were complaining
about not being able to open local connections to directly connected devices
through 3-wire RS-232 and 2-pair RS-422 connections that did not contain the
DCD line. They provided "software carrier" options, not specified via
termio(s) or sgtty that could be set to allow the tty port to act as if DCD
were always asserted. For example, on Solaris this is the default for the
normal tty ports. 

To further confuse things, most vendors have a "back door" port
configuration mechanism outside of termio(s)/sgtty. For example, Linux has
the setserial command. There is less need for separate callout devices when
the user can set a port to open with the desired flag values.

In summary, that's why they exist. Don't expect there to still be a
compelling reason to use them.

Enjoy,

---------------------------------------------------------------- 
Ed Vance              serial24@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------

