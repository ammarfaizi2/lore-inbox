Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265008AbTFYTrd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 15:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265014AbTFYTrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 15:47:33 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:40454 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265008AbTFYTrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 15:47:31 -0400
Date: Wed, 25 Jun 2003 16:00:02 -0400 (EDT)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: Lou Langholtz <ldl@aros.net>
cc: Paul.Clements@steeleye.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>, Pavel Machek <pavel@ucw.cz>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC][PATCH] nbd driver for 2.5+: fix locking issues with ioctl
 UI
In-Reply-To: <3EF9F094.3030506@aros.net>
Message-ID: <Pine.LNX.4.10.10306251516570.11076-100000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jun 2003, Lou Langholtz wrote:

> Did Al's statements regarding this make this feel better? The code could 
> be redone so that the queuelist is added to before the down but then 
> more often it will have to be removed from since the lo->sock check 

It wasn't that I was worried about someone calling down() under
spinlock, obviously that'd be a problem. However, if the queue_lock were
to be changed back to a semaphore (as it used to be, pre-2.4.16 or so)
this could lead to problems. I guess I was just wondering why the
tx_lock was pulled out of nbd_send_req(). It just seems to make the
code harder to follow with the overlapping locking, the duplicated
checks for sock == NULL, and it also means the tx_lock gets held
(a little bit) longer...


> that since the user space tool opened the socket to begin with, it seems 
> a better design to have the user space tool do the close as well.

I agree, but I thought that the shutdown was causing different behavior...

> When
> nbd-client exits, it'd effect close of this socket anyway even if
> killed.

Does the socket close at exit have the same effect as a socket shutdown?
If so, then I guess the shutdown is unnecessary...


> So you'd prefer to have a new ioctl then to do this rolled together 
> NBD_DO_IT function? Say NBD_RUN or something that takes the sock 

I do like the combined ioctl, as it seems to make the code a little bit
cleaner and safer. But, it would also be nice to maintain compatibility
with the existing userland tools. Maybe if the driver could support both
new and old interfaces (at least for now), then users could gradually
move over to the new interface(s)?

--
Paul

