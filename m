Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275083AbTHMNoc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 09:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275086AbTHMNoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 09:44:32 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:6625 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S275083AbTHMNo0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 09:44:26 -0400
Date: Wed, 13 Aug 2003 15:44:10 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Andries Brouwer <aebr@win.tue.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pete Zaitcev <zaitcev@redhat.com>, Chris Heath <chris@heathens.co.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i8042 problem
In-Reply-To: <20030812204625.GB23011@ucw.cz>
Message-ID: <Pine.GSO.3.96.1030813152344.25530E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Aug 2003, Vojtech Pavlik wrote:

> >  Wrt polling vs IRQ-driven probing and setup: using IRQ is a natural
> > choice as you have to do keyboard detection in the IRQ handler anyway to
> > properly support hot plugging of a PC/AT or a PS/2 keyboard. 
> 
> The only problem there is that it results in a damn complex state
> machine. Look at the PS/2 mouse probing and imagine how the state
> machine would look.

 Well, I don't think a complex state machine is needed.  What's the
variable part of the initialization?  Essentially the keyboard type (two
options available) and the scancode mode selected (three options
available).  Everything else is constant.  So besides the current
initialization step, you only need to record these two variables.  And the
good news is the more complicated setup scenarios are simply a superset of
the simpler ones, so you do not have multiple paths in the initialization
-- there's only one, of which parts are skipped, depending on the
configuration.  Specifically, for a PC/AT keyboard you don't select a
scancode mode and for the PS/2 keyboard you don't set up key
up/down/repeat characteristics in modes #1 and #2.

 Still if you go beyond the standard PC/XT compatibility mode, you need to
handle run-time keyboard switching, i.e. if I boot with a PS/2 keyboard,
unplug it and later use a PC/AT one, it should just work.  I have a
similar problem with the LK201 keyboard driver (that's a standard DEC
keyboard implementation for a lot of their systems).  There are different
keyboards having the same interface as the LK201 -- programming them is
the same, but their features differ, including the interpretation of some
keys and LEDs (the number of LEDs varies from 2 to 4 and they may have
different labels).  For 2.4, the driver does a reasonable job of run-time
configuration, but it may still be improved (e.g. it doesn't yet do a
handshake I'm thinking of; unfortunately not all LK201 commands return an
ACK) and I'm planning to do that for 2.6.  While looking at it, I may look
at the PS/2 driver and see how it can be improved. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

