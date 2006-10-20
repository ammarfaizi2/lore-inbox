Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946366AbWJTLrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946366AbWJTLrh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 07:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946374AbWJTLrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 07:47:37 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:2242 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1946366AbWJTLrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 07:47:37 -0400
Message-ID: <4538B689.2020909@aitel.hist.no>
Date: Fri, 20 Oct 2006 13:44:09 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Christopher Monty Montgomery <xiphmont@gmail.com>,
       Paolo Ornati <ornati@fastwebnet.it>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.19-rc1-mm1 - locks when using "dd bs=1M"
 from card reader
References: <Pine.LNX.4.44L0.0610191416470.8183-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0610191416470.8183-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
[...]
> After looking at the debugging output, no.  That "invalid opcode" is a red 
> herring.  What you encountered this time was a BUG() in the source code of 
> start_unlink_async() in drivers/usb/host/ehci-q.c:
>
> #ifdef DEBUG
> 	assert_spin_locked(&ehci->lock);
> 	if (ehci->reclaim
> 			|| (qh->qh_state != QH_STATE_LINKED
> 				&& qh->qh_state != QH_STATE_UNLINK_WAIT)
> 			)
> 		BUG ();
> #endif
>
> You could try putting a printk() just before the BUG() to display the 
> values of ehci->reclaim and qh->qh_state.  Maybe also change the BUG() to 
>   
ehci->reclaim=0
qh->qh_state=5
> WARN(), which might help prevent your system from crashing so badly.
>   
WARN didn't help much. I then got the warning twice, followed by
another BUG:
process klogd
ehci_irq
usb_hcd_irq
handle_IRQ_event
handle_fasteio_irq
do_IRQ

So I set it back to BUG. Crashing hard isn't so bad when I
know what is coming - I simply remount everything synchronously
before trying.

I hope these printk's help. I can add more of them too, if needed.
Big transfers seems to bring out the worst - I always get the
crash on the first megabyte now. 

During boot I get lots of those "Hardware error, end-of-data detected"
messages, but I've never seen it crash during bootup.

Helge Hafting
