Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273705AbRI3QGY>; Sun, 30 Sep 2001 12:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273747AbRI3QGQ>; Sun, 30 Sep 2001 12:06:16 -0400
Received: from colorfullife.com ([216.156.138.34]:37643 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S273705AbRI3QGB>;
	Sun, 30 Sep 2001 12:06:01 -0400
Message-ID: <3BB742FB.86AB06A5@colorfullife.com>
Date: Sun, 30 Sep 2001 18:06:19 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Oliver Seemann <oseemann@cs.tu-berlin.de>
Subject: Re: rtl8139 nic dies with load (2.4.10, kt266)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Content-Type: multipart/mixed;
 boundary="------------E6DF444F67EB539614CC6DDF"

This is a multi-part message in MIME format.
--------------E6DF444F67EB539614CC6DDF
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> 
> > Recompile, reboot, load eth0 until it locks up, and send us the dmesg
> > output.
> 
> ok done.
> 
> i've attached the zipped log (>200k).
> the most interesting part ist maybe the following:
> 
> rtl8139_rx_err: eth0: Ethernet frame had errors, status 194f4571.
> rtl8139_set_rx_mode: ENTER
> rtl8139_set_rx_mode: eth0:   rtl8139_set_rx_mode(1003) done -- Rx config
> 00000000.
> ether_crc: ENTER
> ether_crc: EXIT, returning 2141400475
> rtl8139_set_rx_mode: EXIT
> 
> hmm faulty ethernet frame, nic broken ?

No - a few frame errors are acceptable. Lots of electical noise, long
cable, bad cable, whatever.
The driver must recover from such errors.

But I think I found the error:
* set_rx_mode optimizes away the configuration change if it thinks that
the configuration didn't change.
* rtl_8139_rx_err changes the configuration of the NIC chip without
updating tp->rx_config.

Could you try the attached patch?

--
	Manfred
--------------E6DF444F67EB539614CC6DDF
Content-Type: text/plain; charset=us-ascii;
 name="patch-8139-rx_start"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-8139-rx_start"

--- 2.4/drivers/net/8139too.c	Sun Sep 23 21:20:35 2001
+++ build-2.4/drivers/net/8139too.c	Sun Sep 30 17:57:40 2001
@@ -1865,6 +1865,7 @@
 
 	/* disable receive */
 	RTL_W8 (ChipCmd, CmdTxEnb);
+	tp->rx_config = 0;
 
 	/* A.C.: Reset the multicast list. */
 	rtl8139_set_rx_mode (dev);

--------------E6DF444F67EB539614CC6DDF--

