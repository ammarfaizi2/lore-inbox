Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317911AbSG2EFC>; Mon, 29 Jul 2002 00:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317924AbSG2EFC>; Mon, 29 Jul 2002 00:05:02 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:25989 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317911AbSG2EFB>;
	Mon, 29 Jul 2002 00:05:01 -0400
Date: Mon, 29 Jul 2002 14:08:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@lists.linuxppc.org
Subject: Serial core problems on embedded PPC
Message-ID: <20020729040824.GA2351@zax>
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org, linuxppc-embedded@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to get the new serial core stuff working on a PPC 4xx
machine (an EP405 board, specifically).  This is proving more
difficult than I expected.

In 8250.c, it appears that in order for a port to be used for the
serial console it must be defined "old style" with SERIAL_PORT_DFNS,
rather than being registered with register_serial() (because
serial8250_console_setup() indexs into the serial8250_ports array)).
This presents a small problem for 4xx, since it's serial ports are
memory mapped and the new old_serial_port structure can't represent
these.  I added support for these into 8250.c, but ran into further
troubles.

The kernel now gets into an infinite loop when trying to open
/dev/console in init().  The loop is occuring in tty_open() - the open
fails and it loops back to the retry_open: label.  This seems to be
happening because the uart_port structure is ending up with the type
field set to PORT_UNKNOWN.  However, I'm getting confused attempting
to work out where this field ought to be set, and why it isn't.

The current plethora of similar-but-not-the-same structures describing
serial ports (serial_state, serial_struct, uart_port, old_serial_port)
is also rather confusing.  I'm guessing some of these are deprecated
and remain only as an aid to transition, but I'm not sure which.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
