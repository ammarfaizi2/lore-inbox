Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264530AbRFMEEn>; Wed, 13 Jun 2001 00:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264540AbRFMEEd>; Wed, 13 Jun 2001 00:04:33 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:53509 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264530AbRFMEEZ>; Wed, 13 Jun 2001 00:04:25 -0400
Date: Tue, 12 Jun 2001 21:00:17 -0700 (PDT)
From: Patrick Mochel <mochel@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New PCI PM
In-Reply-To: <3B26D739.944618E4@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10106122048520.13607-100000@nobelium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Jun 2001, Jeff Garzik wrote:

> 
> What is are the guarantees about the order of calls to
> pci_driver::suspend and pci_driver::resume?
> 
> Will a driver get calls like
> 	suspend(D3)
> 	suspend(D2)
> 	suspend(D1)

Not possible, according to the PCI PM Spec. 

These are the possible state transitions:

+---------------------------+
| Current State | New State |
+---------------------------+
| D0            | D1, D2, D3|
+---------------------------+
| D1            | D2, D3    |
+---------------------------+
| D2            | D3        |
+---------------------------+
| D1, D2, D3    | D0        |
+---------------------------+

(note the last would be ::resume() from any state)

> or just one suspend call?

Calls to lower power states are possible, but never to higher, except D0.

> What effect does the return value have on the rest of the system?  On
> the order of succeeding calls to pci_driver::suspend functions?

On system suspend, it should be ignored. It sounds bad, but there is
justification. With a two-stage suspension, drivers will get a call to
::save_state before suspend. It is then that they should fail, if they're
going to. That way, nothing will be powered off yet, and a graceful
recovery is much more likely.

However, if you're gradually bringing the device down to lower and lower
power states, you may want to know if it fails (e.g. if it can't enter D1
or D2).

> And where is that patch to Documentation/pci.txt young man?  :)

It should be in -pre4. Quick Draw Torvalds couldn't wait an extra 15
minutes to release -pre3. 

	-pat

