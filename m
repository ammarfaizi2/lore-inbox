Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWJTPzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWJTPzq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 11:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWJTPzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 11:55:46 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:16 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932261AbWJTPzq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 11:55:46 -0400
Date: Fri, 20 Oct 2006 11:55:44 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Helge Hafting <helge.hafting@aitel.hist.no>
cc: Christopher Monty Montgomery <xiphmont@gmail.com>,
       Paolo Ornati <ornati@fastwebnet.it>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.19-rc1-mm1 - locks when using "dd bs=1M"
 from card reader
In-Reply-To: <4538B689.2020909@aitel.hist.no>
Message-ID: <Pine.LNX.4.44L0.0610201133110.7060-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006, Helge Hafting wrote:

> Alan Stern wrote:
> [...]
> > After looking at the debugging output, no.  That "invalid opcode" is a red 
> > herring.  What you encountered this time was a BUG() in the source code of 
> > start_unlink_async() in drivers/usb/host/ehci-q.c:
> >
> > #ifdef DEBUG
> > 	assert_spin_locked(&ehci->lock);
> > 	if (ehci->reclaim
> > 			|| (qh->qh_state != QH_STATE_LINKED
> > 				&& qh->qh_state != QH_STATE_UNLINK_WAIT)
> > 			)
> > 		BUG ();
> > #endif
> >
> > You could try putting a printk() just before the BUG() to display the 
> > values of ehci->reclaim and qh->qh_state.  Maybe also change the BUG() to 
> >   
> ehci->reclaim=0
> qh->qh_state=5

5 is QH_STATE_COMPLETING.  That explains why the BUG() fires.

At this point it's beyond me.  Monty will have to take it from here.


> During boot I get lots of those "Hardware error, end-of-data detected"
> messages, but I've never seen it crash during bootup.

Those messages are from the card reader.  It doesn't seem to be working 
right.  It returns the "end-of-data" error in response to a PREVENT MEDIUM 
REMOVAL command and it returns a phase error in response to a READ 
command.  In spite of the fact that it claims to have a 256 MB card 
present.

Alan Stern

