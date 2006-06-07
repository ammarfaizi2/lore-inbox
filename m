Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWFGTe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWFGTe6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 15:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWFGTe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 15:34:58 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:6061 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932381AbWFGTe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 15:34:57 -0400
Date: Wed, 7 Jun 2006 15:34:56 -0400
To: Don Fry <brazilnut@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] pcnet32 driver NAPI support
Message-ID: <20060607193456.GN7857@csclub.uwaterloo.ca>
References: <20060607165225.GB7859@csclub.uwaterloo.ca> <20060607182040.GA12748@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060607182040.GA12748@us.ibm.com>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 11:20:40AM -0700, Don Fry wrote:
> I am also working on a NAPI version of the pcnet32 driver for many of
> the same reasons, and will compare what you have with my own
> implementation.  I probably won't be able to do much until Friday.  
> 
> Just a couple of comments.  I am adding netdev@vger.kernel.org to the cc
> list, as most network driver discussion is done here rather than lkml.
> linux-kernel (and linux-net) should be deleted in future replies.

I must have picked the wrong place to cc.

> The 2.6.17-rc6 would be the correct source to patch against.  Since this
> is an enhancement it will not come out till 2.6.18.

I thought so.  That is why I did it against both 2.6.17-rc6 and 2.6.16
(since I use it with 2.6.16).

> I would not change the driver name from pcnet32 to pcnet32napi, but I
> would changes the version from 1.32 to 1.33NAPI or something like that.

Hmm, perhaps.  I just wanted something that made it obvious in dmesg
which driver I was running.  I see tulip actually does put it in the
version instead.  I don't remember where I got the driver name change
idea from.

> Some areas of concern that you may have addressed already, I have not
> scanned your changes yet, are what happens if the ring size is changed
> without bringing down the interface (via ethtool), or if the loopback
> test is run in a similar fashion, or a tx timeout occurs.

The same thing as if it was done before enabling napi.  From a few
messages I have seen, it doesn't work right now, and it won't work any
better with my changes.  I have never tried changing the ring size on
the fly, so I don't know.

It appears that the port is stopped before the ring size change is done,
although I can't really tell how it handles things if the queue is not
empty when it stops the port.  Does it try to handle anything left in
the ring first or does it just toss those packets? (That I would
consider wrong).

> The lp->lock MUST be held whenever accessing the csr or bcr registers as
> this is a multi-step process, and has been the source of problems in the
> past.  Even on UP systems.

Hmm, I just followed what appeared to be in pcnet32_rx and how tulip and
a few other drivers had done their napi conversions.  It certainly works
for me the way I did it.  Haven't seen any lockups yet.  I do see that I
am not holding the lock when I acknowledge IRQs in pcnet32_poll, which
pcnet32_rx doesn't need to worry about since it is called from the
interrupt handler which already holds the lock.  That should be fixed
then.

So I can do:
        // Clear RX interrupts
        spin_lock(&lp->lock);
        lp->a.write_csr (ioaddr, 0, 0x1400);
        spin_unlock(&lp->lock);
That part seems simple enough to protect.

Is this safe without holding the lock?
    } while(lp->a.read_csr (ioaddr, 0) & 0x1400);
Not sure how to wrap a lock around that one without holding the lock for
way too long.

perhaps:
        spin_lock(&lp->lock);
	state=lp->a.read_csr (ioaddr, 0) & 0x1400;
        spin_unlock(&lp->lock);
    } while(state);
Does that seem more reasonable?

Len Sorensen
