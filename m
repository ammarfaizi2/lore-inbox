Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267597AbUIUMLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267597AbUIUMLK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 08:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267612AbUIUMLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 08:11:10 -0400
Received: from styx.suse.cz ([82.119.242.94]:19330 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S267597AbUIUMKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 08:10:19 -0400
Date: Tue, 21 Sep 2004 14:10:40 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] New input patches
Message-ID: <20040921121040.GA1603@ucw.cz>
References: <200409162358.27678.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409162358.27678.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 11:58:27PM -0500, Dmitry Torokhov wrote:
> Hi Vojtech,
> 
> I have some more input patches that I would like you to review:
> 
> 01-libps2.patch
>         - move common code from atkbd and psmouse into one place, create
>           ps2dev structure that should be used to build drivers for hardware
>           attached to a PS/2 port.

Very nice.

>           I think that command processing is now race free - instead of using
>           bit operations on flags the ps2_command and ps2_send_byte simply
>           take serio->lock (via serio_pause/continue_rx). Since serio->lock
>           is also taken by interrupt handler anyway it gives us desired
>           serialization. As wakeup routines take a spinlock as well and
>           spinlock is guaranteed to be a barrier we should not miss wake up
>           events either.

I hope the wait_event* functions also use memory barriers properly, but
they probably must, otherwise they won't be useful, because there we're
accessing the flags variable without a lock.

> 02-serio-pin-driver.patch
>         - Add drv_sem to serio structure and implement serio_[un]pin_driver()
>           functions. The main purpose is to pin a driver bound to serio port
>           when accessing driver's data from sysfs attribute handler; otherwise
>           other thread could unbind/unload driver in a middle of processing.

This one looks fine.

> 03-atkbd-sysfs-attr.patch
>         - Export extra, scroll, set, softrepeat and softraw atkbd properties
>           via sysfs and allow them to be controlled at run time, independently
>           for each keyboard.

This bit looks wrong in the patch:

-       input_event(&atkbd->dev, EV_MSC, MSC_RAW, code);
+       if (atkbd->softraw)
+               input_event(&atkbd->dev, EV_MSC, MSC_RAW, code);

... we definitely want the RAW codes to be sent when we're not in
softraw mode, because that's when they're passed through keyboard.c to
the console.

So the condition needs to be inverted. However, it's not necessary at
all, since the input layer will not pass the RAW events when the MSC_RAW
bit is not set.

> Now that Linus pulled all pending changes the patches should apply cleanly to
> all trees (his, yours and Andrew's). 

Great.

> Please let me know if they are ok and I will push them into my bkbits tree.

I think they're fine except for the above minor bug.
 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
