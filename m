Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267709AbTAHEmQ>; Tue, 7 Jan 2003 23:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267712AbTAHEmP>; Tue, 7 Jan 2003 23:42:15 -0500
Received: from foursticks.link.internode.on.net ([150.101.16.181]:43392 "EHLO
	fuzzy.foursticks.com.au") by vger.kernel.org with ESMTP
	id <S267709AbTAHEmO>; Tue, 7 Jan 2003 23:42:14 -0500
Date: Wed, 8 Jan 2003 15:11:56 +1030
From: sbolderoff@foursticks.com
To: Paul Schulz <pschulz@foursticks.com>, linux-kernel@vger.kernel.org
Subject: Re: Broadcom Gigabit 5703 and Bridging
Message-ID: <20030108044155.GA1473@fuzzy.foursticks.com.au>
Reply-To: sbolderoff@foursticks.com
References: <E18W7jh-0001Co-00@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E18W7jh-0001Co-00@mars>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 02:52:37PM +1030, Paul Schulz wrote:
> Greetings,
> 
> I'm seeing 'TCP Checksum' Errors after packets pass through a host
> bridging TCP packets with:
> 
>  - Kernel 2.4.20
>  - Bridge code
>  - tg3 (Broadcom Gigabit 5703)
> 
>    eth0: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)]
>     (PCIX:100MHz:64-bit) 10/100/1000BaseT
>   (eth1 is similar)


The BCM95703A30 rev 1002 has issues with the hardware checksumming.

The following patch for the tg3 (linux-2.4.20-ac2/drivers/net/tg3.c)
driver, fixes the problem.

Note: I've tested this on the 2.4.20-ac2, but it should work OK with
2.4.20 too.

diff -u linux-2.4.20/drivers/net/tg3.c linux-2.4.20-ac2/drivers/net/tg3.c
--- linux-2.4.20/drivers/net/tg3.c	Fri Nov 29 10:23:14 2002
+++ linux-2.4.20-ac2/drivers/net/tg3.c	Wed Jan  8 14:34:44 2003
@@ -6161,6 +6161,10 @@
 	if (tp->pci_chip_rev_id == CHIPREV_ID_5700_B0)
 		tp->tg3_flags |= TG3_FLAG_BROKEN_CHECKSUMS;
 
+	/* 5703 A2 have issues with checksumming too. (sarah) */
+	if (tp->pci_chip_rev_id == CHIPREV_ID_5703_A2)
+		tp->tg3_flags |= TG3_FLAG_BROKEN_CHECKSUMS;
+
 	/* Regardless of whether checksums work or not, we configure
 	 * the StrongARM chips to not compute the pseudo header checksums
 	 * in either direction.  Because of the way Linux checksum support




Cheers,
Sarah Bolderoff
-- 
Foursticks Pty Ltd, http://www.foursticks.com
33 King William Street, ADELAIDE South Australia 5000
Phone +61 8 841114 309            Fax +61 8 841114 777
This message was brought to you by the numbers 0 and 1.
