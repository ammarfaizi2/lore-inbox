Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbTDNPjR (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 11:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263482AbTDNPjR (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 11:39:17 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49676 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263475AbTDNPjO (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 11:39:14 -0400
Date: Mon, 14 Apr 2003 16:50:57 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: seanlkml@rogers.com, felipe_alfaro@linuxmail.org,
       Dominik Brodowski <linux@brodo.de>
Subject: [CFT] Hopefully fix PCMCIA boot deadlocks
Message-ID: <20030414165057.C22754@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	seanlkml@rogers.com, felipe_alfaro@linuxmail.org,
	Dominik Brodowski <linux@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,

Here's my latest patch against 2.5.67 which introduces a proper state
machine into the PCMCIA layer for handling the sockets.  Unfortunately,
I fear that this isn't the answer for the following reasons:

* We create our own workqueue (which spawns N threads, one thread per CPU.)
  We need to use a separate thread from the keventd since we call
  PCI probe and remove methods from this thread, which are free to
  use flush_scheduled_work() - which would be another deadlock waiting
  to happen.  I think we need to go to a per-socket thread instead.

* The state machine isn't as readable as it should be.  To be quite frank,
  I think it was a mistake to code it as a state machine - IMO its
  completely unreadable.

* We allow cardbus cards to be suspended and reset as though they are
  normal PCMCIA cards.  Unfortunately, PCI drivers have no knowledge
  that these operations occur.  This also applies to older kernels, so
  this isn't really a problem that's created by this patch.

  This is even more true now that we have the capability to plug in a
  complete (possibly complex) PCI bus structure.

* There seems to be a whole bunch of setup stuff going on in
  pcmcia_register_client().  This is run each time a card device driver
  is inserted by cardmgr.  Although this has buggy for the case where
  all drivers are built in, this patch makes it more buggy; if a card
  is inserted at the time ds.ko is loaded, we kick off the asynchronous
  state machine to process the card and carry on regardless.

  However, we can not wait here - if we do wait for the state machine
  to complete, we will hit the same deadlock in the device model which
  we're hitting today.

  It appears that it would mainly affect multi-function PCMCIA cards.
  Unfortunately, I don't have any to test.

That said, it seems to work for me.

The patch can be found at

	http://patches.arm.linux.org.uk/pcmcia/pcmcia-1.diff

Now, thing is, I can't test this patch on its own; I can test it on ARM
boxen with yenta cardbus bridges, or statically mapped PCMCIA-only
sockets, but the former requires several other patches to the PCMCIA
resource subsystem to be functional.

Hence I need other peoples feedback on this patch before I push it
Linus-wards.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

