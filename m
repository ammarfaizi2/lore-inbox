Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262956AbTCSKqn>; Wed, 19 Mar 2003 05:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262966AbTCSKqn>; Wed, 19 Mar 2003 05:46:43 -0500
Received: from [63.205.85.133] ([63.205.85.133]:12305 "EHLO schmee.sfgoth.com")
	by vger.kernel.org with ESMTP id <S262956AbTCSKqm>;
	Wed, 19 Mar 2003 05:46:42 -0500
Date: Wed, 19 Mar 2003 02:57:34 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ATM] first pass at fixing atm spinlock
Message-ID: <20030319025734.C35024@sfgoth.com>
References: <20030317150144.F92155@sfgoth.com> <200303172325.h2HNPpGi015350@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <200303172325.h2HNPpGi015350@locutus.cmf.nrl.navy.mil>; from chas@locutus.cmf.nrl.navy.mil on Mon, Mar 17, 2003 at 06:25:50PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chas williams wrote:
> fairly certain.  the only dangerous thing proc.c is snprintf().  i didnt
> want to spend a lot of time on proc.c doing it the 'right' way (using
> atm_dev_hold/release) since it will be change to a seq interface.

Great!

> >sock/vcc combo can't go away while a processor's bh still is using a reference
> >to the vcc.  I think this has been the result of many of the reported SMP
> >crashes (it's probably not that hard to trigger; just close an ATM socket
> >that's receiving a flood of traffic)
> 
> i dont know.  i believe all of the adapters do a synchronous close.

I'm really not sure it's that safe.  At the very least the drivers all
need to make sure that their ->close() excludes their interrupt/bh work
from happening.  That would probably be possible but it seems that it
would be better to just build a robust refcount system at the lower layer.
This should make it quite a bit easier to ensure that the drivers are safe.

Also remember that some drivers have a common area that incoming PDUs
get put in (especially for AAL0 traffic) so there might be stuff in there
even after a close.

So I think you're right that it's possible to get by without vcc refcounting
I think the best method would be to implement an atm_vcc_{find,hold,release}
that uses the sock's refcount so we can cleanly and 100% safely take a
reference to a vcc from a bh.

> >You really need something like atm_dev_release_last() that waits for the
> >reference count to hit "1" (via a completion or something) and then does
> >the release stuff.
> 
> atm_dev_deregister() does that.  if a driver need to remove the atm
> device (i suppose its being unplugged) it could close the vcc's and 
> call atm_dev_register() which will wait the ref count to drop to 0.

Great - now we just have to do the same thing for vcc's :-)

-Mitch
