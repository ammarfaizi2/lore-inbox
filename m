Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424370AbWKJG2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424370AbWKJG2p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 01:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424372AbWKJG2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 01:28:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27569 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1424371AbWKJG2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 01:28:44 -0500
Date: Thu, 9 Nov 2006 22:28:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: eric@buddington.net, Eric Buddington <ebuddington@verizon.net>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Kay Sievers <kay.sievers@novell.com>, Jaroslav Kysela <perex@suse.cz>,
       Takashi Iwai <tiwai@suse.de>
Subject: Re: 2.6.19-rc4-mm2: BUG modprobeing sound driver
Message-Id: <20061109222829.fe9de523.akpm@osdl.org>
In-Reply-To: <20061109220515.7a127070.akpm@osdl.org>
References: <20061109142208.GA4291@pool-70-109-251-157.wma.east.verizon.net>
	<20061109220515.7a127070.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2006 22:05:15 -0800
Andrew Morton <akpm@osdl.org> wrote:

> Yup, trivial to reproduce: modprobe snd_serial_u16550 -> splat.
> 
> Bisection indicates that this oops is triggered by
> gregkh-driver-sound-device.patch.
> 
> snd_serial_probe() never got to call snd_card_register(), so card->dev is
> NULL.
> 
> snd_serial_probe() calls snd_card_free(card) on the error path and
> snd_card_do_free() does device_del(card->dev) which oopses over the null
> pointer it got.  

I suppose doing this is legit:

diff -puN sound/core/init.c~fix-gregkh-driver-sound-device sound/core/init.c
--- a/sound/core/init.c~fix-gregkh-driver-sound-device
+++ a/sound/core/init.c
@@ -361,7 +361,8 @@ static int snd_card_do_free(struct snd_c
 		snd_printk(KERN_WARNING "unable to free card info\n");
 		/* Not fatal error */
 	}
-	device_unregister(card->dev);
+	if (card->dev)
+		device_unregister(card->dev);
 	kfree(card);
 	return 0;
 }
_

