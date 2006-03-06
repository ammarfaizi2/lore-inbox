Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752452AbWCFWvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452AbWCFWvF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752455AbWCFWvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:51:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59840 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752452AbWCFWvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:51:01 -0500
Date: Mon, 6 Mar 2006 14:50:41 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: netdev@vger.kernel.org, openib-general@openib.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       Matt Leininger <mlleinin@hpcn.ca.sandia.gov>
Subject: Re: TSO and IPoIB performance degradation
Message-ID: <20060306145041.320d4dd3@localhost.localdomain>
In-Reply-To: <20060306223438.GA18277@mellanox.co.il>
References: <20060306223438.GA18277@mellanox.co.il>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2006 00:34:38 +0200
"Michael S. Tsirkin" <mst@mellanox.co.il> wrote:

> Hello, Dave!
> As you might know, the TSO patches merged into mainline kernel
> since 2.6.11 have hurt performance for the simple (non-TSO)
> high-speed netdevice that is IPoIB driver.
> 
> This was discussed at length here
> http://openib.org/pipermail/openib-general/2005-October/012271.html
> 
> I'm trying to figure out what can be done to improve the situation.
> In partucular, I'm looking at the Super TSO patch
> http://oss.sgi.com/archives/netdev/2005-05/msg00889.html
> 
> merged into mainline here
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=314324121f9b94b2ca657a494cf2b9cb0e4a28cc
> 
> There, you said:
> 
> 	When we do ucopy receive (ie. copying directly to userspace
> 	during tcp input processing) we attempt to delay the ACK
> 	until cleanup_rbuf() is invoked.  Most of the time this
> 	technique works very well, and we emit one ACK advertising
> 	the largest window.
> 
> 	But this explodes if the ucopy prequeue is large enough.
> 	When the receiver is cpu limited and TSO frames are large,
> 	the receiver is inundated with ucopy processing, such that
> 	the ACK comes out very late.  Often, this is so late that
> 	by the time the sender gets the ACK the window has emptied
> 	too much to be kept full by the sender.
> 
> 	The existing TSO code mostly avoided this by keeping the
> 	TSO packets no larger than 1/8 of the available window.
> 	But with the new code we can get much larger TSO frames.
> 
> So I'm trying to get a handle on it: could a solution be to simply
> look at the frame size, and call tcp_send_delayed_ack from
> if the frame size is no larger than 1/8?
> 
> Does this make sense?
> 
> Thanks,
> 
> 


More likely you are getting hit by the fact that TSO prevents the congestion
window from increasing properly. This was fixed in 2.6.15 (around mid of Nov 2005).
