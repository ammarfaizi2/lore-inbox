Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947201AbWKKMjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947201AbWKKMjh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 07:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947204AbWKKMjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 07:39:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43153 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1947201AbWKKMjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 07:39:36 -0500
Subject: Re: Userspace process may be able to DoS kernel
From: Arjan van de Ven <arjan@infradead.org>
To: jplatte@naasa.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200611111329.17206.lists@naasa.net>
References: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com>
	 <200611100803.03958.lists@naasa.net>
	 <20061109231958.f18cd1ef.akpm@osdl.org>
	 <200611111329.17206.lists@naasa.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 11 Nov 2006 13:39:33 +0100
Message-Id: <1163248773.3293.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-11-11 at 13:29 +0100, Joerg Platte wrote:
> Am Freitag, 10. November 2006 08:19 schrieb Andrew Morton:
> 
> > OK, thanks.
> >
> > It'd be useful if you could grab a kernel profile when the system load is
> > high:
> 
> > Or, if oprofile is working:
> >
> >
> > #!/bin/sh
> > sudo opcontrol --stop
> > sudo opcontrol --shutdown
> > sudo rm -rf /var/lib/oprofile
> > sudo opcontrol --vmlinux=/boot/vmlinux-$(uname -r)
> > sudo opcontrol --start-daemon
> > sudo opcontrol --start
> > sleep 10
> > sudo opcontrol --stop
> > sudo opcontrol --shutdown
> > sudo opreport -l /boot/vmlinux-$(uname -r) | head -50
> 
> Here is the oprofile log. Seems to be acpi related?
> 
> CPU: CPU with timer interrupt, speed 0 MHz (estimated)
> Profiling through timer interrupt
> samples  %        symbol name
> 709      44.2848  acpi_pm_read



this isn't per se acpi related: This is reading the PM timer from your
chipset. The PMTimer is a clock on your chipset that the kernel can use
to read a stable incrementing clock to find out what time it is right
now, usually as part of userspace asking the kernel what time it is via
the gettimeofday() system call. ACPI is just the component that does the
actual (slow) hardware access... eg the messenger.

Normally systems have better/faster clocks than the pmtimer, but there
are circumstances where those can't be used.

1) HPET. The HPET is a lot faster than pmtimer, and very reliable. Most
of the systems sold in the last 3 years have an hpet, but unfortunately,
many bioses turn this off by default. If your BOOS has a "Multimedia
timer" setting, make sure it's set to "On". 
2) TSC. This is a super fast method of finding how much time has passed,
since it's inside the CPU. However there are many reasons why this
method may be unreliable, for example certain powermanagement features
on laptops cause this clock to stop when idle (not useful), or to vary
in frequency (also not useful if you want to find out what time it is).
Also on AMD Opteron SMP systems or extreme Intel big honking NUMA
systems, this timer is not synchronized between the various processors
and that breaks the current time keeping in Linux, and so Linux doesn't
use it in that case.

So my advice is
1) Check the bios to see if you have the HPET enabled. If not, enable
it.
2) Check the kernel config to see if you have HPET enabled there, if not
enable it.
3) Check dmesg to see if there's a reason the kernel doesn't use TSC;
there is probably nothing you can do but at least you know why :)

 
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

