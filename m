Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261284AbSJUIul>; Mon, 21 Oct 2002 04:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261283AbSJUIul>; Mon, 21 Oct 2002 04:50:41 -0400
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:34492 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261284AbSJUIuk>; Mon, 21 Oct 2002 04:50:40 -0400
To: "Andrey V.Savochkin" <saw@saw.sw.com.sg>
Cc: linux-kernel@vger.kernel.org
Subject: eepro100 -- Sending a multicast list set command from a timer routine
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 21 Oct 2002 17:56:35 +0900
Message-ID: <buo4rbgw4os.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with 2.5.44 I'm getting tons of messages like the following
printed on the console:

   eth0: Sending a multicast list set command from a timer routine, m=0, j=50143, l=49360.

Here's the associated code in drivers/net/eepro100.c:

	if (sp->rx_mode < 0  ||
		(sp->rx_bug  && jiffies - sp->last_rx_time > 2*HZ)) {
		/* We haven't received a packet in a Long Time.  We
		   might have been bitten by the receiver hang bug.
		   This can be cleared by sending a set multicast list
		   command. */
		if (netif_msg_rx_err(sp))
			printk(KERN_DEBUG "%s: Sending a ...", ...);
		set_rx_mode(dev);
        }

The behavior I'm seeing seems to match the above code: it prints a
message about every 2 seconds if I'm not using the network.  On this
machine, I'm quite often not using the network, so this repetitive
message is quite annoying.

In 2.5.44, the test used to decide whether to print a message changed,
which I guess is why I'm suddenly seeing all these messages:

   -		if (speedo_debug > 3)
   +		if (netif_msg_rx_err(sp))

So I guess either the test used to print the message, or the test used
to do the reset should be changed (probably the former).

Thanks,

-Miles
-- 
We live, as we dream -- alone....
