Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266922AbUAXMtd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 07:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266925AbUAXMtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 07:49:33 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:10762 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S266922AbUAXMtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 07:49:31 -0500
Subject: Re: APM and ACPI sleep issues with 2.6 (2.6.2pre1-mm1 vs mm2)
From: Ross Burton <ross@burtonini.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040121015903.0b4198b0.sfr@canb.auug.org.au>
References: <1073232351.21389.111.camel@localhost>
	 <20040105140057.096c77f9.sfr@canb.auug.org.au>
	 <1074520065.32688.9.camel@carados.180sw.com>
	 <20040121015903.0b4198b0.sfr@canb.auug.org.au>
Content-Type: text/plain
Message-Id: <1074948379.1368.11.camel@localhost.localnet>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 24 Jan 2004 12:46:20 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-20 at 14:59, Stephen Rothwell wrote:
> > I've been told that building 2.6.1-mm4, making i8042 and atkdb modules
> > and unloading them before sleeping should fix this problem.  Is that the
> > blessed solution?  Unloading the modules for the keyboard controller
> > does seem a little too much like brute-force for me, especially since
> > 2.4.x managed fine. :)
> 
> I am not sure if you need to build i8042 and atkb as modules amy more, I
> thought there was a fix applied (in 2.6.1?).  However it would be
> interesting to the results of removing the modules before suspending.

After some frantic kernel building I've more interesting data (with
i8042 and atkbd built into the kernel).

2.6.2-rc1-mm1 will APM suspend and resume fine at first with the
following log:

atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Found IRQ 5 for device 0000:00:1f.5
PCI: Sharing IRQ 5 with 0000:00:1f.3
PCI: Sharing IRQ 5 with 0000:02:03.1
PCI: Setting latency timer of device 0000:00:1f.5 to 64
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
hda: completing PM request, resume
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 1: f200000000000095

The atkbd lines are interesting as I was not running X at the time.  The
MCE line slightly worries me, is this normal?

However, I cannot sleep once I've used PCMCIA (with yenta_socket). 
Instead of sleeping it locks up.  I didn't notice this the first time
and came back to a very warm laptop, it felt like it had been
busy-looping.


I was very excited by the changelog for 2.6.2-rc1-mm2 with its "updated
ACPI" so I tried that.  ACPI still hard-crashes (grey screen, power
button dead, I had to remove the battery) and APM also crashes: it looks
like it is suspending (screen turns off and there is some disk activity)
but it never sleeps and I can't resume without holding the power button
(so at least *something* is still running).

Summary: something regressed over mm1 to mm2 with APM suspending, and
yenta_socket or cs isn't handling the suspend correctly.  Does anyone
have any ideas where I can look for these?

However, I did manage to use 2.6.2-pre1-mm1 for a day before I used my
wifi card, and did like what I saw -- the new scheduler makes GNOME more
responsive when I've a compile going.

Ross
-- 
Ross Burton                                 mail: ross@burtonini.com
                                          jabber: ross@burtonini.com
                                     www: http://www.burtonini.com./
 PGP Fingerprint: 1A21 F5B0 D8D0 CFE3 81D4 E25A 2D09 E447 D0B4 33DF


