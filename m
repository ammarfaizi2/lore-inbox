Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264370AbRFGIcE>; Thu, 7 Jun 2001 04:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264371AbRFGIbn>; Thu, 7 Jun 2001 04:31:43 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:9743 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S264370AbRFGIbd>; Thu, 7 Jun 2001 04:31:33 -0400
Date: Thu, 7 Jun 2001 01:31:26 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Tom Sightler <ttsig@tuxyturvy.com>
cc: <linux-kernel@vger.kernel.org>, <arjan@fenrus.demon.nl>
Subject: Re: xircom_cb problems
In-Reply-To: <991884643.3b1ef5637fca7@eargle.com>
Message-ID: <Pine.LNX.4.33.0106070118320.22593-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001, Tom Sightler wrote:

> At home where I have a 10Mb half-duplex hub connection all of the drivers work
> properly.

All right, that's expected.

> At work where I have a 10/100Mb full-duplex switch connection the drivers work
> exactly as I described before:
> 
> 2.4.4-ac11 -- mostly works fine -- minor problems awaking from sleep

Can you run some performance testing with this driver, though? The speed
of ftp transfers in both directions would be a good measure. The reason
I'm asking is because we saw really poor performance on 100Mb full-duplex,
something like 200-300KB/s when receiving.

> 2.4.5-ac9 -- keeps logging "Link is absent" then "Linux is 100 mbit" over and
> over when trying to pull an IP address via dhcp using pump or dhcpcd. 

pump likes to bring the interface up and down and up and down, so those 
messages are not necessarily unusual.

Hmm. I have an idea though. In set_half_duplex, we shouldn't touch the MII 
if the new autoneg value is the same as the old one. It should certainly 
help with things like pump. Arjan, what do you think?

> Interestingly manually setting an IP address seems to work fine with
> this driver.

That's very good to know. So most likely the repeated up/down that pump's 
doing is upsetting the card.

> I'll do this tomorrow morning when I get in and report back.  Thanks
> for the help, I'd really like to see this card get stable as we have
> it in a lot of our laptops here at work.

And we'd like to thank you for your patience and for your help diagnosing 
the problem. Let's hope we can solve it quickly..

I'm attaching a small patch that does what I proposed above -- can you 
give it a try as well?

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
------------------------
--- linux-2.4-ac/drivers/net/pcmcia/xircom_cb.c.old	Thu Jun  7 01:27:07 2001
+++ linux-2.4-ac/drivers/net/pcmcia/xircom_cb.c	Thu Jun  7 01:28:13 2001
@@ -1092,13 +1092,15 @@
 
 	/* tell the MII not to advertise 10/100FDX */
 	tmp = mdio_read(card, 0, 4);
-	printk("xircom_cb: capabilities changed from %#x to %#x\n",
-	       tmp, tmp & ~0x140);
-	tmp &= ~0x140;
-	mdio_write(card, 0, 4, tmp);
-	/* restart autonegotiation */
-	tmp = mdio_read(card, 0, 0);
-	mdio_write(card, 0, 0, tmp | 0x1200);
+	if (tmp != tmp & ~0x140) {
+		printk("xircom_cb: capabilities changed from %#x to %#x\n",
+		       tmp, tmp & ~0x140);
+		tmp &= ~0x140;
+		mdio_write(card, 0, 4, tmp);
+		/* restart autonegotiation */
+		tmp = mdio_read(card, 0, 0);
+		mdio_write(card, 0, 0, tmp | 0x1200);
+	}
 
 	if (rx)
 		activate_receiver(card);

