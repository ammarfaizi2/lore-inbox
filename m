Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268845AbUIXQyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268845AbUIXQyT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268922AbUIXQmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:42:21 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:51943 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268914AbUIXQcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:32:33 -0400
Subject: Re: ldisc writes during tty release_dev() causing problems.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ryan Arnold <rsa@us.ibm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1096042734.3355.51.camel@localhost.localdomain>
References: <1095273835.3294.278.camel@localhost>
	 <20040915204107.GA26776@thunk.org>
	 <1095988521.3372.240.camel@localhost.localdomain>
	 <1096029621.9790.8.camel@localhost.localdomain>
	 <1096042734.3355.51.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096039802.10145.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 24 Sep 2004 16:30:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-24 at 17:18, Ryan Arnold wrote:
> I think I see what you mean.  The ldisc write_chan code is actually
> invoked from the terminal process and if this is I/O blocked then the
> terminal process cannot invoke release_dev().  So why did I experience
> calls to hvc_write() after the final open instance was closed with
> release_dev()?

At the moment if the user types a character and the line discipline
echoes it then you can get a write call to the driver. N_TTY tends to do
this one. When we close the ldisc first this should go away, but we
aren't quite there yet.

> > I had assumed would have to come from the serial side because if the
> > last owner is executing close() they can't be executing vhangup on the
> > same but given a rapid close/re-open/vhangup on a new fd it might be
> > a dangerous assumption. Added to the TODO pile
> 
> In hvc_console we don't have a serial side, but I do have the device
> side which will invoke a tty_hangup() if an hvc adapter was hotplug
> removed.  This doesn't happen for the actual console adapter (hvc0)
> because it isn't allowed in firmware.

Ok so this probably is a close v open->hangup race. In which case it
shouldn't be too hard to fix now the first locking work is done. Until
then the change you suggest makes sense. I'll investigate that race in
more detail however because close() v open() and close cancelling the
workqueue for hangup ought to be stopping it.

