Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSFTStm>; Thu, 20 Jun 2002 14:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315458AbSFTStl>; Thu, 20 Jun 2002 14:49:41 -0400
Received: from hera.cwi.nl ([192.16.191.8]:14313 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315457AbSFTStl>;
	Thu, 20 Jun 2002 14:49:41 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 20 Jun 2002 20:49:36 +0200 (MEST)
Message-Id: <UTC200206201849.g5KInaK27367.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, david-b@pacbell.net
Subject: Re: [linux-usb-devel] [PATCHlet] 2.5.23 usb, ide
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: David Brownell <david-b@pacbell.net>

    > Earlier, I reported an oops at shutdown. I just looked at
    > what causes the oops and find that the call
    >     hcd->driver->stop()
    > is executed while hcd->driver->stop is NULL.
    > 
    > ...
    > USB people may worry whether hcd->driver->stop should
    > have been non-NULL.

    Not supposed to be possible.  All those hc_driver structures
    are declared "static const", with non-null stop().  Looks like
    something was zeroing some driver's readonly data segment while
    it was still in use.  (And who knows that else!)

Now wild pointers happen, and it took me some effort a few
weeks ago to catch one.  But at first one should look at
simpler explanations.

Now that you tell me that these things are set at initialization
and never changed, the initialization must be wrong. And indeed,
it says "__devexit_p(uhci_stop)" and this yields NULL.

So, my previous stopoops patch can be replaced by

diff -r linux-2.5.23/linux/drivers/usb/host/uhci-hcd.c linux-2.5.23a/linux/drivers/usb/host/uhci-hcd.c
2431c2431
< static void __devexit uhci_stop(struct usb_hcd *hcd)
---
> static void uhci_stop(struct usb_hcd *hcd)
2512c2512
<       stop:                   __devexit_p(uhci_stop),
---
>       stop:                   uhci_stop,

(pasted from another window).

Andries
