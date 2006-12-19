Return-Path: <linux-kernel-owner+w=401wt.eu-S932921AbWLSTsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932921AbWLSTsR (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 14:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932923AbWLSTsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 14:48:17 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:52686 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932921AbWLSTsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 14:48:16 -0500
X-Greylist: delayed 1239 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 14:48:15 EST
Message-ID: <45883D25.1000300@mvista.com>
Date: Tue, 19 Dec 2006 13:27:33 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Tilman Schmidt <tilman@imap.cc>, linux-serial@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Hansjoerg Lipp <hjlipp@web.de>, Russell Doty <rdoty@redhat.com>
Subject: Re: [PATCH] Add the ability to layer another driver over the serial
 driver
References: <4533B8FB.5080108@mvista.com>	<20061210201438.tilman@imap.cc>	<Pine.LNX.4.60.0612102117590.9993@poirot.grange>	<457CB32A.2060804@mvista.com>	<20061211102016.43e76da2@localhost.localdomain>	<457D70A4.1000000@mvista.com> <20061211151943.2bbc720e@localhost.localdomain>
In-Reply-To: <20061211151943.2bbc720e@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a continuation of a previous discussion.  There are
serial interfaces to IPMI chips that I need to support and
I need a way to access these at panic time or when the
system is in a state where it can't schedule.

I have written a layered driver for the serial core, but Alan
says that a line discipline is the right way to have a driver
access a serial port.  That seems rather unnatural to me
(none of the other layered drivers do this), but it's not the
end of the world, and the serial driver is "special" in some
regards.

Alan and I discussed this some and he suggested I look at a
way to unify all the various "raw" users of serial ports, things
like kgdb, serial console, and the IPMI driver.  That sounded
like a good idea at the time, so I've been working on that.

Unfortunately, it hasn't turned out so well.  A line discipline
won't work for kgdb or consoles; the driver needs some
mechanism to register the serial port so kgdb can find it.
Consoles need some special registration, too.

This is what I would like to propose:  Keep the concept of
a layered driver like I have already done, but modify the
code so the uart can register very early, in time for kgdb
and consoles.  Add a uart poll routine, poll setup and
poll quit routine, and a few other things needed by
consoles.  kgdb can use this, and the serial_core code
can use it to do a console.

This would eliminate most of the console code from the
individual drivers.  The normal write buffering could be
used by the serial console (though it would have to
insert its own info structure when it did a console write).
The console also needs routines to get the default values
for systems that get defaults through things like open
firmware.  And maybe a routine for polling CTS.

The poll routines could be propagated up to the tty
layer fairly easily, if required, for use by other drivers.
I really don't like having to have two mechanisms for
a driver to do a write, one normal and one when the
system can't schedule.  And a poll routine reduces
code duplication, the driver works with all the normal
routines.  No special read or write operations.

Anyway, this is what I think works best for all parties.
I'll continue down this path for now.

Thanks,

-Corey
