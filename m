Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbSKHOxw>; Fri, 8 Nov 2002 09:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262100AbSKHOxw>; Fri, 8 Nov 2002 09:53:52 -0500
Received: from ext-nj2gw-1.online-age.net ([216.35.73.163]:50603 "EHLO
	ext-nj2gw-1.online-age.net") by vger.kernel.org with ESMTP
	id <S262089AbSKHOxv>; Fri, 8 Nov 2002 09:53:51 -0500
Message-ID: <A9713061F01AD411B0F700D0B746CA6802FC1544@vacho6misge.cho.ge.com>
From: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>
To: "'Corey Minyard'" <cminyard@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: NMI handling rework
Date: Fri, 8 Nov 2002 10:00:16 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-- Snipped from the patch --

If the handler actually handles the NMI, it should return NOTIFY_OK.
If it did not handle the NMI, it should return NOTIFY_DONE.  It may "or"
on NOTIFY_STOP_MASK to the return value if it does not want other
handlers after it to be notified.

-- End snip --

> It is still possible, though unlikely, that two NMI sources could occur 
> at the same time.  Maybe that's not worth worrying about, and maybe for 
> the APICs it works fine.

Am I reading this correctly? As long as no one passes back NOTIFY_STOP_MASK,
all handlers are run. Assuming that all external NMI sources have a means of
checking whether they were the source, this would work like shared PCI
interrupts.

> Not on the i386 family.  Once an NMI is accepted by the CPU, it gets
> internally masked until an iret instruction gets executed.  If another NMI
> happens maenwhile, it's latched by the processor internally and dispatched
> as soon as NMIs are unmasked.  Further NMIs received when masked are lost.

So... We're running through the handler list servicing an NMI, two more NMIs
come in and we latch one (the other is dropped). It doesn't matter. Either
the
affected handlers have not run yet and will get run on the current pass, or
they will run on the next pass. You may have two handlers run on a single
pass
but you should not drop any. True??

This assumes i386 architecture and all handlers are run. I don't know about
other archs.
