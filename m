Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbTI1QsK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 12:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbTI1QsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 12:48:10 -0400
Received: from ee.oulu.fi ([130.231.61.23]:44222 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S262615AbTI1QsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 12:48:07 -0400
Date: Sun, 28 Sep 2003 19:48:00 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4, b44 transmit timeout
Message-ID: <20030928164759.GA12560@ee.oulu.fi>
References: <200309081134.17013.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200309081134.17013.lkml@kcore.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 11:34:17AM +0200, Jan De Luyck wrote:
> On Tue, Sep 02, 2003 at 09:33:53AM +0200, Norbert Preining wrote:  
> 
> > A-ha! Thanks, I think this should be enough to figure out what the problem  
> > is... Looks like the driver doesn't even get the packets pump tries to send,  
> > pump is a bit special in the way it bounces the interface up and down when  
> > doing its work, that probably triggers a race in b44..
> 
> I can also easily recreate this by calling dhcpcd e.g. when the cable isn't in 
> the socket yet. If i attach the cable then I see the interface coming up, 
> going down, and then the NETDEV watchdog message.
> Unfortunatly this usually means that dhcpcd goes hanging. ifconfig hangs too 
> if I try to use it, and rebooting must be forced with sysrq and an oops a 
> alt-sysrq-o for poweroff...
This could help (tm) :-)

--- b44.c.orig  2003-09-28 19:36:48.000000000 +0300
+++ b44.c       2003-09-28 19:37:07.000000000 +0300
@@ -870,6 +870,7 @@

        spin_unlock_irq(&bp->lock);

+       b44_enable_ints(bp);
        netif_wake_queue(dev);
 }

at least I could do some pretty dirty things to the poor chip and it still
seems to recover after this patch.

rmmod still has some problems, occasionally I get a "usage count 2" thing
(currently running the rawhide 2.4.22-1.2061.nptl, I've seen similar with
2.6.0-test5ish too, I suspect ipv6 might be involved, but sometimes I can rmmod
it even with ipv6 loaded so it's a bit random).
