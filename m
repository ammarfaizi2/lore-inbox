Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTFPD0e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 23:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbTFPD0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 23:26:33 -0400
Received: from b.smtp-out.sonic.net ([208.201.224.39]:6786 "HELO
	b.smtp-out.sonic.net") by vger.kernel.org with SMTP id S263277AbTFPD0c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 23:26:32 -0400
X-envelope-info: <dhinds@sonic.net>
Date: Sun, 15 Jun 2003 20:40:19 -0700
From: David Hinds <dhinds@sonic.net>
To: hugang <hugang@soulinfo.com>, dahinds@users.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Pcmcia GPRS cards not works in linux.
Message-ID: <20030615204019.C10594@sonic.net>
References: <20030615104322.496279e1.hugang@soulinfo.com> <20030615103456.B27533@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030615103456.B27533@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 10:34:56AM +0100, Russell King wrote:
> 
> I suspect that the card voltage sense pins are indicating that the
> card requires 5V, but we're trying to use the 0x30 configuration.
> Since we don't allow the socket voltage to be altered, we error out
> and never try the second configuration.
>
> David, I think it would make sense to allow the PCMCIA subsystem to
> lower VCC in these circumstances, but obviously never allow it to be
> raised above the value reported by the voltage sense pins?

Changing Vcc on the fly turns out to be pretty complicated: you are
required to power down the socket, and power it up again from scratch,
which takes several seconds.  In practice it is essentially never
useful since the card should always be operable at the voltage it
indicated at power-up time.

The pcmcia-cs package and the 2.4 kernel PCMCIA subsystem already do
the right thing.  The 2.5 8250_cs driver had been sufficiently altered
(reindented, line breaks moved around, etc) that applying patches is
quite inconvenient and I had not gotten around to going through line
by line and figuring out what changes needed to be applied.

Probably, the best thing would be for cs.c in the kernel to do what
the pcmcia-cs package now does: just print a warning and ignore Vcc
values that don't match the power-up voltage.

The only useful case I could come up with for changing the power-up
voltage, is that some cards (compact flash I know, perhaps more) run
faster at 5V than at 3.3V, and the user might want to choose between
higher performance or better battery life.

-- Dave
