Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTLHTyW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 14:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbTLHTyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 14:54:21 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:65236 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261965AbTLHTyG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 14:54:06 -0500
From: Duncan Sands <baldrick@free.fr>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Mon, 8 Dec 2003 20:53:25 +0100
User-Agent: KMail/1.5.4
Cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312081328270.1043-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0312081328270.1043-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312082053.25541.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> But usbfs may suffer from complications as a result of its unorthodox
> approach to device ownership.

Yes, you have put your finger on it.

> >  Currently ps->dev is set to NULL in
> > the devio.c usbfs disconnect method (if some interface is claimed) or in
> > inode.c on device disconnect, making it hard to lock with
> > ps->dev->serialize :) Thus disconnect should no longer be signalled by
> > setting ps->dev to NULL.
>
> If you would keep the ps->devsem lock, would there be any problem in
> setting ps->dev to NULL to indicate disconnection?

You can't keep the ps->devsem lock and use ps->dev->serialize, because it
leads to deadlock.  Actually, simply replacing ps->devsem with ps->dev->serialize
cannot lead to any new deadlocks, it makes deadlocks that could occasionally
happen always happen (such deadlocks exist right now in usbfs).  Some of the
current deadlocks can be eliminated without giving up ps->devsem, but not all.
So the question is: must ps->dev->serialize be used?

> Are they any reasons for not keeping ps->devsem?  Since usbfs generally
> acts as a driver and drivers generally don't have to concern themselves
> with usbdev->serialize (the core handles it for them), shouldn't usbfs
> also be able to ignore ps->dev->serialize?

No, because it needs to do operations on interfaces it hasn't claimed (such
as looking them up and claiming them).  This is why it needs to protect
itself, at least momentarily, against configurations shifting under it.  This
can be done by using the BKL more.  However it can be done more simply
using ps->dev->serialize (in fact it is simpler than what is there now).

By the way, if it is somehow fatal to do usb_put_dev after disconnect,
what is the point of referencing counting at all?  You might as well
free up the usb_device structure immediately after disconnect, since
there is sure to be a reference before disconnect, and (apparently)
there had better not be a reference after disconnect...

All the best,

Duncan.
