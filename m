Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285165AbRL2Rwi>; Sat, 29 Dec 2001 12:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285161AbRL2Rw3>; Sat, 29 Dec 2001 12:52:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60433 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285150AbRL2RwQ>; Sat, 29 Dec 2001 12:52:16 -0500
Subject: Re: AX25/socket kernel PATCHes
To: henk.de.groot@hetnet.nl (Henk de Groot)
Date: Sat, 29 Dec 2001 18:02:53 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20011229174504.00a291b0@pop.hetnet.nl> from "Henk de Groot" at Dec 29, 2001 06:27:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16KNor-00059i-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The message doesn't seem to matter but I frequently get messages about this since using the DIGI_NED digipeater provokes a lot of these messages. I attached the code segment I use to interface below (the complete code is available through http://www.qsl.net/digi_ned/).
> My proposal is either to fix the drivers to set skb->nh correctly (no idea where and how this should be done, otherwise I would have supplied a patch) or to remove the message (at least for AX.25 use). There must be a reason why this printk is done so the first would be preferred. If there is something I could do at application level than that would be okay to, but I don't see how I could set skb->nh from the application.

On the receive path skb->nh.raw is set by the kernel core in 2.2 so that
should be ok providing skb->mac.raw is sane. It looks like the ax25 transmit
code isnt setting skb->nh.raw somewhere, or we have an off by one error
handling control messages (which looking at the code seems to be the case)

If you change

                        if (skb2->nh.raw < skb2->data || skb2->nh.raw >= skb2->...
                                if (net_ratelimit())

So that it checks
			< skb2->data || nh.raw > ..

Let me know if that fixes it. It shouldn't but it would be good to know if
we are picking up header only frames somewhere, or nh.raw has accidentally
been pushed on one header too far.

		
