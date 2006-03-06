Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752033AbWCFWed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbWCFWed (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752452AbWCFWec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:34:32 -0500
Received: from [194.90.237.34] ([194.90.237.34]:11932 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1751673AbWCFWeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:34:31 -0500
Date: Tue, 7 Mar 2006 00:34:38 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: netdev@vger.kernel.org, openib-general@openib.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       Matt Leininger <mlleinin@hpcn.ca.sandia.gov>
Subject: TSO and IPoIB performance degradation
Message-ID: <20060306223438.GA18277@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 06 Mar 2006 22:36:49.0328 (UTC) FILETIME=[7516E300:01C6416E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Dave!
As you might know, the TSO patches merged into mainline kernel
since 2.6.11 have hurt performance for the simple (non-TSO)
high-speed netdevice that is IPoIB driver.

This was discussed at length here
http://openib.org/pipermail/openib-general/2005-October/012271.html

I'm trying to figure out what can be done to improve the situation.
In partucular, I'm looking at the Super TSO patch
http://oss.sgi.com/archives/netdev/2005-05/msg00889.html

merged into mainline here

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=314324121f9b94b2ca657a494cf2b9cb0e4a28cc

There, you said:

	When we do ucopy receive (ie. copying directly to userspace
	during tcp input processing) we attempt to delay the ACK
	until cleanup_rbuf() is invoked.  Most of the time this
	technique works very well, and we emit one ACK advertising
	the largest window.

	But this explodes if the ucopy prequeue is large enough.
	When the receiver is cpu limited and TSO frames are large,
	the receiver is inundated with ucopy processing, such that
	the ACK comes out very late.  Often, this is so late that
	by the time the sender gets the ACK the window has emptied
	too much to be kept full by the sender.

	The existing TSO code mostly avoided this by keeping the
	TSO packets no larger than 1/8 of the available window.
	But with the new code we can get much larger TSO frames.

So I'm trying to get a handle on it: could a solution be to simply
look at the frame size, and call tcp_send_delayed_ack from
if the frame size is no larger than 1/8?

Does this make sense?

Thanks,


-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
