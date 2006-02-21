Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161381AbWBUF0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161381AbWBUF0X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 00:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161379AbWBUF0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 00:26:23 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:52367 "EHLO
	biscayne-one-station.mit.edu") by vger.kernel.org with ESMTP
	id S1161381AbWBUF0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 00:26:22 -0500
Subject: Re: snd-cs4236 (possibly all isa-pnp cards or all alsa isa-pnp
	cards) broken in 2.6.16-rc4
From: Adam Belay <abelay@MIT.EDU>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       alsa-devel@alsa-project.org
In-Reply-To: <43F9F9F2.4070203@keyaccess.nl>
References: <43F9F9F2.4070203@keyaccess.nl>
Content-Type: text/plain
Date: Tue, 21 Feb 2006 00:27:26 -0500
Message-Id: <1140499646.21116.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 5.114
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-20 at 18:18 +0100, Rene Herman wrote:
> I stuck a few printks in cs4236.c. From "snd_cs423x_unregister_all",
> "pnp_unregister_card_driver(&cs423x_pnpc_driver)" is indeed being called
> but the card driver's own remove method, snd_cs423x_pnpc_remove, is not.
> 
> I started looking, but ran into the next issue again -- when snd-cs4236
> is not card1 but card0, modprobe -r oopses in snd_timer_free (attached)
> meaning debugging this wants someone with more of an overview of recent
> damage done^W^Wchanges made.
> 
> Given that calling pnp_unregister_card_driver() is not cs4236 specific,
> I assume the problem is more general. Possibly all ALSA ISA-PnP drivers.
> Or, given that pnp_unregister_card_driver is not an ALSA function, maybe
> even all ISA-PnP drivers using the card_driver interface.
> 
> The more general this problem turns out, the more reason there would be
> for fixing this pre 2.6.16, obviously. I can test patches...
> 
> Rene.

Hi Rene,

Hopefully this email account will work better.  In any case, thanks for
bringing this bug to my attention.  I may have stumbled across it a
couple days ago, and would appreciate if you would try this patch:
(there may be some fuzz)

--- a/drivers/pnp/card.c        2006-01-02 22:21:10.000000000 -0500
+++ b/drivers/pnp/card.c        2006-02-17 00:45:37.123525896 -0500
@@ -302,13 +302,11 @@
        down_write(&dev->dev.bus->subsys.rwsem);
        dev->card_link = clink;
        dev->dev.driver = &drv->link.driver;
-       if (drv->link.driver.probe) {
-               if (drv->link.driver.probe(&dev->dev)) {
-                       dev->dev.driver = NULL;
-                       dev->card_link = NULL;
-                       up_write(&dev->dev.bus->subsys.rwsem);
-                       return NULL;
-               }
+       if (pnp_bus_type.probe(&dev->dev)) {
+               dev->dev.driver = NULL;
+               dev->card_link = NULL;
+               up_write(&dev->dev.bus->subsys.rwsem);
+               return NULL;
        }
        device_bind_driver(&dev->dev);
        up_write(&dev->dev.bus->subsys.rwsem);


It's possible that the attach mechanism isn't working correctly because
of recent driver model changes.  If this is the case, it would also
explain the detach-not-called issues.

Thanks,
Adam


