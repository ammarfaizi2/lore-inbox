Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263135AbTCSRAL>; Wed, 19 Mar 2003 12:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263139AbTCSRAL>; Wed, 19 Mar 2003 12:00:11 -0500
Received: from smtp5.wanadoo.fr ([193.252.22.29]:60020 "EHLO
	mwinf0203.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S263135AbTCSRAJ>; Wed, 19 Mar 2003 12:00:09 -0500
From: Duncan Sands <duncan.sands@wanadoo.fr>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>,
       Mitchell Blank Jr <mitch@sfgoth.com>
Subject: Re: [Linux-ATM-General] Re: [ATM] first pass at fixing atm spinlock
Date: Wed, 19 Mar 2003 18:11:00 +0100
User-Agent: KMail/1.5.1
Cc: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200303172325.h2HNPpGi015350@locutus.cmf.nrl.navy.mil>
In-Reply-To: <200303172325.h2HNPpGi015350@locutus.cmf.nrl.navy.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303191811.00337.duncan.sands@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> atm_dev_lock is now a
>> read/write lock that now protects the list of atm devices.
>
>Are you sure you're never sleeping while holding this lock while iterating
>device lists?  I haven't checked but we do a fair number of things there
>(like the proc stuff) so we really need to track those down.

[I hope the following comments are not misplaced: I picked up this
thread half way through, and I didn't read the code...]

Presumably the only reason you want a spin lock is because drivers
may be walking the list in interrupt context when the time comes
to add/remove a member.  My first comment is: what are drivers
doing walking this list anyway?  Shouldn't it be private to the ATM
layer?  Drivers can maintain their own list if they need one.  My
second comment is that the ATM layer should never need to take
the spinlock itself when walking the list (I'm guessing it always
walks the list in process context).  You could have the following
setup: list protected by a semaphore and a spinlock.

Deleting a member does the following:
	acquire the semaphore
	...
	take the spinlock
	delete the member
	release the spinlock
	...
	release the semaphore

Adding a member does the following:
	acquire the semaphore
	...
	take the spinlock
	add the member
	release the spinlock
	...
	release the semaphore

Walking the list in process context does:
	acquire the semaphore
	walk the list doing stuff
	release the semaphore

Walking the list in interrupt context does:
	acquire the spinlock
	walk the list doing stuff that can't sleep
	release the spinlock

Of course the semaphore could be used as a "big device lock",
not just a list lock.

Duncan.
