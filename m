Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946308AbWJSSkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946308AbWJSSkU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946315AbWJSSkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:40:20 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:40460 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1946308AbWJSSkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:40:18 -0400
Date: Thu, 19 Oct 2006 14:40:17 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Helge Hafting <helge.hafting@aitel.hist.no>
cc: Christopher Monty Montgomery <xiphmont@gmail.com>,
       Paolo Ornati <ornati@fastwebnet.it>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.19-rc1-mm1 - locks when using "dd bs=1M"
 from card reader
In-Reply-To: <45376EC4.3080807@aitel.hist.no>
Message-ID: <Pine.LNX.4.44L0.0610191416470.8183-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006, Helge Hafting wrote:

> Alan Stern wrote:
> > On Wed, 18 Oct 2006, Helge Hafting wrote:
> >   
> [...]
> > That's why I asked for the USB debugging logs (which you forgot to include
> > here).
> >   
> Attached dmesg.gz with lots of usb messages.

But no messages from the time just before the BUG occurred.  :-(

> >> To bring it down:
> >>
> >> dd if=/dev/sdc of=sdc.dump bs=1M
> >>     
> This time, it seems to have crashed on the first megabyte.
> I mounted the filesystem synchronously, and still I had 0 bytes
> in the dumpfile.  The crash also came with no delay after
> pressing enter.
> 
> > It's possible that both of these are caused by something unrelated 
> > overwriting kernel memory.
> >   
> something like a function pointer mistaken for a data pointer?

After looking at the debugging output, no.  That "invalid opcode" is a red 
herring.  What you encountered this time was a BUG() in the source code of 
start_unlink_async() in drivers/usb/host/ehci-q.c:

#ifdef DEBUG
	assert_spin_locked(&ehci->lock);
	if (ehci->reclaim
			|| (qh->qh_state != QH_STATE_LINKED
				&& qh->qh_state != QH_STATE_UNLINK_WAIT)
			)
		BUG ();
#endif

You could try putting a printk() just before the BUG() to display the 
values of ehci->reclaim and qh->qh_state.  Maybe also change the BUG() to 
WARN(), which might help prevent your system from crashing so badly.

Monty has been making changes to this driver recently; maybe he has some 
ideas about the problem.

Alan Stern

