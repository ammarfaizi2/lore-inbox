Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261999AbTCQWvA>; Mon, 17 Mar 2003 17:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262000AbTCQWvA>; Mon, 17 Mar 2003 17:51:00 -0500
Received: from [63.205.85.133] ([63.205.85.133]:15877 "EHLO schmee.sfgoth.com")
	by vger.kernel.org with ESMTP id <S261999AbTCQWu6>;
	Mon, 17 Mar 2003 17:50:58 -0500
Date: Mon, 17 Mar 2003 15:01:44 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ATM] first pass at fixing atm spinlock
Message-ID: <20030317150144.F92155@sfgoth.com>
References: <OFAFD4106C.6053931B-ON85256CE0.004F1DD6@gdeb.com> <200303172224.h2HMO0Gi014874@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <200303172224.h2HMO0Gi014874@locutus.cmf.nrl.navy.mil>; from chas@locutus.cmf.nrl.navy.mil on Mon, Mar 17, 2003 at 05:24:00PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chas williams wrote:
> ftp://ftp.cmf.nrl.navy.mil/pub/chas/linux-atm/2_5_64_atm_dev_lock.patch

Note that this patch also has lots of other stuff (he driver, ipv6 stuff)

I'll try to look at the patch in depth later, but I'll make a few initial
comments.  First of all, thanks for taking this up - this is work I've wanted
to do for years and never found the time for.

> atm_dev_lock is now a
> read/write lock that now protects the list of atm devices.

Are you sure you're never sleeping while holding this lock while iterating
device lists?  I haven't checked but we do a fair number of things there
(like the proc stuff) so we really need to track those down.

> things are not set in stone yet, so i would like some advice -- the per 
> device vcc list will probably be traversed (read-only) in the bottom
> half of the kernel during receive for some adapters.

Yes, absolutely.

> is it simply
> enough to use list_for_each_safe() when traversing the list?  otherwise
> the per device spinlock will need to shared between the top and bottom half
> of the kernel.  the vcc's shouldnt need to be ref counted since they
> are rather tightly coupled to a struct sock which is.

Then you should implement functions to grab/release the "struct sock"'s
refernce count based on the atm_vcc.  Then you'd have 
  atm_vcc_find(dev, vpi, vci)
  atm_vcc_hold(vcc)
  atm_vcc_release(vcc)
Just like that atm_dev_*() functions.  Otherwise there's no reason that the
sock/vcc combo can't go away while a processor's bh still is using a reference
to the vcc.  I think this has been the result of many of the reported SMP
crashes (it's probably not that hard to trigger; just close an ATM socket
that's receiving a flood of traffic)

> i dont like
> the 'shutdown on last reference' in atm_dev_release().  you can only
> safely call release when you know you can sleep.  is shutdown_atm_dev()
> really that useful?

Yes, it's needed (especially if you want to support more complicated interfaces
like ADSL cards via the ATM stack in the future)

Really the dev release stuff should ONLY be called from the close() path.
You really need something like atm_dev_release_last() that waits for the
reference count to hit "1" (via a completion or something) and then does
the release stuff.

-Mitch
