Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286925AbSAIOf3>; Wed, 9 Jan 2002 09:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286942AbSAIOfT>; Wed, 9 Jan 2002 09:35:19 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:21492 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S286925AbSAIOfL>; Wed, 9 Jan 2002 09:35:11 -0500
Date: Wed, 9 Jan 2002 15:34:37 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: cw@f00f.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, swsnyder@home.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "APIC error on CPUx" - what does this mean?
In-Reply-To: <E67476B613D@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.3.96.1020109143542.4719B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002, Petr Vandrovec wrote:

> I have an idea that with outb() spurious IRQ happens some time 
> after Promise deasserts IRQ, while with outb_p() it happens when 
> we mask it. Unfortunately stack traces at arrival of spurious 
> IRQ (available on request, 120KB uncompressed) do not agree with 
> this idea - they always lead to default_idle. It is possible that 
> it always arrives in default_idle because of my CPU is so fast 
> that even endless stream of IRQs from 8259 arrives always when 
> CPU is in default_idle, but I have some doubts that 1GHz is fast 
> enough to see such effect.

 Note that if you are observing a spurious IRQ due to the trailing
interval of a level-triggered interrupt signal it's quite reasonable you
see a stack trace back to default_idle().  Such an IRQ happens just after
do_IRQ() (actually code following ret_from_intr) for the prevously
delivered real IRQ returns.  If your system is not heavy loaded (little
time spent in the userland) most IRQs arrive in idle(), thus spurious ones
do so as well.  A backtrace for a spurious IRQ and for the preceding real
one should point to the same root.

 If you see spurious IRQs due to glitches the backtraces may differ.  It
should be possible to observe under a load. 

 Still it's weird for *all* the devices you have to deassert their IRQ
lines so late.  It would be worth verifying if that is the case, e.g. by
adding an udelay() just after code that is meant to cause a device to
deassert its IRQ line.  If the problem persists regardless of the delays,
chances are there is an erratum in the APIC or in the chipset.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

