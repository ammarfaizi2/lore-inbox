Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130692AbQKTAtZ>; Sun, 19 Nov 2000 19:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130865AbQKTAtP>; Sun, 19 Nov 2000 19:49:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21539 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130692AbQKTAtJ>; Sun, 19 Nov 2000 19:49:09 -0500
Subject: Re: 2.4.0-test11-pre7: isapnp hang
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 20 Nov 2000 00:19:43 +0000 (GMT)
Cc: twaugh@redhat.com (Tim Waugh), linux-kernel@vger.kernel.org
In-Reply-To: <E13xeWC-0003AP-00@the-village.bc.nu> from "Alan Cox" at Nov 20, 2000 12:09:06 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13xegT-0003An-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is it the network card's fault (probably), or is there a less invasive
> > probe that isapnp could use (unlikely, I guess)?
> 
> 
> That shouldnt be possible - we are supposed to start at 0x203 and skip the
> problem area.

And a quick read of the code I pasted instead of just pasting suggests instead
we should be using the patch below. Question however is who stole port 0x279
which is the normal port to use. It shouldnt be lp since lp is supposed to 
init after pnp.

--- drivers/pnp/isapnp.c.old	Tue Oct 31 20:29:59 2000
+++ drivers/pnp/isapnp.c	Sun Nov 19 23:43:15 2000
@@ -270,17 +270,16 @@
 {
 	int rdp = isapnp_rdp;
 	while (rdp <= 0x3ff) {
-		if (!check_region(rdp, 1)) {
-			isapnp_rdp = rdp;
-			return 0;
-		}
-		rdp += RDP_STEP;
 		/*
 		 *	We cannot use NE2000 probe spaces for ISAPnP or we
 		 *	will lock up machines.
 		 */
-		if(rdp >= 0x280 && rdp <= 0x380)
-			continue;
+		if ((rdp < 0x280 || rdp >  0x380) && !check_region(rdp, 1)) 
+		{
+			isapnp_rdp = rdp;
+			return 0;
+		}
+		rdp += RDP_STEP;
 	}
 	return -1;
 }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
