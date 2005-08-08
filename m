Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVHHC36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVHHC36 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 22:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbVHHC36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 22:29:58 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:9377 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750701AbVHHC35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 22:29:57 -0400
Subject: Re: lockups with netconsole on e1000 on media insertion
From: Steven Rostedt <rostedt@goodmis.org>
To: John =?ISO-8859-1?Q?B=E4ckstrand?= <sandos@home.se>
Cc: Matt Mackall <mpm@selenic.com>, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <42F6792D.4030608@home.se>
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel>
	 <p73ek987gjw.fsf@bragg.suse.de>
	 <1123249743.18332.16.camel@localhost.localdomain>
	 <42F6792D.4030608@home.se>
Content-Type: text/plain; charset=ISO-8859-1
Organization: Kihon Technologies
Date: Sun, 07 Aug 2005 22:29:38 -0400
Message-Id: <1123468178.18332.150.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-07 at 23:12 +0200, John Bäckstrand wrote:
> Steven Rostedt wrote:
> > I don't have the card, so I can't test it. But if this works (after
> > removing the previous patch) then this is the better solution. 
> 
> I can confirm that this alone does not work for the simple 
> unplug/re-plug cycle I described, it still locks up hard. Tried this 
> alone on -rc6.

Darn it.  If I had a e1000 I could debug it. I have other methods of
logging than printks in all there varieties (see relayfs and friends).
I still believe that the e1000_netpoll is not turning on the queue for
some reason and the netpoll_send_skb is locking up because of that.
Especially since Andi's patch fixes the problem.

In e1000_clean_tx_irq, which I added to the e1000_netpoll call, has the
following lines:

        if(unlikely(cleaned && netif_queue_stopped(netdev) &&
                    netif_carrier_ok(netdev)))
                netif_wake_queue(netdev);


The netif_queue_stopped is true, since that causes the looping in
netpoll_send_pkt.  So either it didn't clean any buffers (cleaned is
false) or netif_carrier_ok is false.  I don't know what the e1000 does
when you pull the cable while it's transmitting, does it call the
e1000_down? If so it could cause the carrier_ok to fail.

Oh well, someone with a e1000 card will need to look into this. The
problem should be easily found.  Good luck.

-- Steve


