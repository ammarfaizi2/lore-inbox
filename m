Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbWBQGQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbWBQGQU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 01:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWBQGQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 01:16:20 -0500
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:22149 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S932518AbWBQGQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 01:16:20 -0500
Date: Fri, 17 Feb 2006 01:17:01 -0500
From: Adam Belay <ambx1@neo.rr.com>
To: Lz <elezeta@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Problems with sound on latest kernels.
Message-ID: <20060217061701.GA17208@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, Lz <elezeta@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <cde01ae70602140558g6440af40mf59e3e1992088d3b@mail.gmail.com> <1139934640.11659.95.camel@mindpipe> <20060214232222.1016fe87.akpm@osdl.org> <cde01ae70602150542m1b57aa83l62508927276241b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cde01ae70602150542m1b57aa83l62508927276241b@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 02:42:05PM +0100, Lz wrote:
> On 2/15/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > Poor guy - that's rocket science.  It looks like it's due to breakage in
> > the pnp code anwyay.
> 
> Yeah, it seemed that to me, alsa wasn't even loaded at that time.

This patch may solve your problem.  Could you send a new dmesg output with it
applied?

Thanks,
Adam

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
