Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLKCz1>; Sun, 10 Dec 2000 21:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLKCzR>; Sun, 10 Dec 2000 21:55:17 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:16282 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129226AbQLKCy7>; Sun, 10 Dec 2000 21:54:59 -0500
Date: Sun, 10 Dec 2000 18:21:45 +0000
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] [patch] hotplug fixes
To: linux-usb-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <andrewm@uow.edu.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        David Woodhouse <dwmw2@infradead.org>
Message-id: <02ad01c062d6$408ed600$6600000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
In-Reply-To: <3A337727.FDED61E3@uow.edu.au>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - We have been getting deadlocks at hotplug time because
>   call_usermodehelper is synchronous: it returns control after the
>   usermode application has exited.  But in some places (esp. 
>   [un]register_netdevice) this happens with a lock held (rtnl_lock). 
>   This cause `ifconfig' to get stuck.

The /sbin/hotplug script I sent around last week avoids this by doing
its work in the background.

I see the underlying problem here as being that network hotplug hooks
are called at the wrong time ... because they are piggybacking onto
existing APIs, which weren't designed for hotplug support.  Different
aspects of that root cause were all over your list of problems (seeming
to trigger all the nastiest ones :-).

To my way of thought (I don't claim expertise in Linux networking!)
the _clean_ fix here is accept that the network driver API needs an
update for hotplugging.  Not a big one, I suspect.  Likely we can
start with a "ready to open this device!" call, which hotplug-ready
network drivers call at the end of their PCI or USB probe routines.

We've needed such changes in both PCI and USB driver APIs ... suggesting
that such changes are to be expected as new subsystems start to learn
how to autoconfigure themselves.


> - Add a check for an empty executable path string in
>   call_usermodehelper.  (This check can probably be removed from the
>   USB code now?)

Sure.

- Dave




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
