Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262008AbTCQXRK>; Mon, 17 Mar 2003 18:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262013AbTCQXRK>; Mon, 17 Mar 2003 18:17:10 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:29602 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S262008AbTCQXPt>; Mon, 17 Mar 2003 18:15:49 -0500
Message-Id: <200303172325.h2HNPpGi015350@locutus.cmf.nrl.navy.mil>
To: Mitchell Blank Jr <mitch@sfgoth.com>
cc: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ATM] first pass at fixing atm spinlock 
In-reply-to: Your message of "Mon, 17 Mar 2003 15:01:44 PST."
             <20030317150144.F92155@sfgoth.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Mon, 17 Mar 2003 18:25:50 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030317150144.F92155@sfgoth.com>,Mitchell Blank Jr writes:
>Note that this patch also has lots of other stuff (he driver, ipv6 stuff)

that ipv6 stuff crept in there (due to a bad merge on my part).  i believe
i have that right now.

>> atm_dev_lock is now a
>> read/write lock that now protects the list of atm devices.
>
>Are you sure you're never sleeping while holding this lock while iterating
>device lists?  I haven't checked but we do a fair number of things there
>(like the proc stuff) so we really need to track those down.

fairly certain.  the only dangerous thing proc.c is snprintf().  i didnt
want to spend a lot of time on proc.c doing it the 'right' way (using
atm_dev_hold/release) since it will be change to a seq interface.

>sock/vcc combo can't go away while a processor's bh still is using a reference
>to the vcc.  I think this has been the result of many of the reported SMP
>crashes (it's probably not that hard to trigger; just close an ATM socket
>that's receiving a flood of traffic)

i dont know.  i believe all of the adapters do a synchronous close.  after
the close finishes, no more traffic should arrive for a particular vcc.
the bottom halfs (halves?) should not have references to vcc after a close()
for it finishes.

>You really need something like atm_dev_release_last() that waits for the
>reference count to hit "1" (via a completion or something) and then does
>the release stuff.

atm_dev_deregister() does that.  if a driver need to remove the atm
device (i suppose its being unplugged) it could close the vcc's and 
call atm_dev_register() which will wait the ref count to drop to 0.
