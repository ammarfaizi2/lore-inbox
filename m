Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131613AbRCQLaa>; Sat, 17 Mar 2001 06:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131615AbRCQLaK>; Sat, 17 Mar 2001 06:30:10 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:58817 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131613AbRCQLaD>; Sat, 17 Mar 2001 06:30:03 -0500
Message-ID: <3AB34AF8.B09D69CA@uow.edu.au>
Date: Sat, 17 Mar 2001 22:31:04 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Seth Andrew Hallem <shallem@Stanford.EDU>
CC: linux-kernel@vger.kernel.org
Subject: Re: Potential free/use-after-free bugs
In-Reply-To: <20010316221730.B17586@elaine23.stanford.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seth Andrew Hallem wrote:
> 
> I also have some questions regarding skbs.  Our checker
> found a lot of instances where the skb is freed, then its length field is
> accessed.  I have included an example location below.  Is this a bug or
> not?

Yes, we should regard it as a bug.

A dev_kfree_skb_irq(skb) followed by a reference to *skb
is in fact safe, because the skb isn't freed until after the
interrupt function returns.  But it's cruddy code and should be
changed.

Arnaldo recently went through a whole bunch of drivers fixing
a similar problem:

	netif_rx(skb);
	diddle_with(skb);

This is poor form because netif_rx() "gives away"
the skb and it's no longer yours to diddle with.  In theory,
netif_rx() could have kfree'ed it on the spot.


With regard to the "16 potential locking bugs" email: nice
one.  They all appear to be complete box-busting shockers.

If there was anyone around to send patches to, I'd fix em :)
But I'll hang on to that email and make sure everything is ticked
off next month.  So: ack and thanks.

-
