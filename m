Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264870AbTFYSne (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 14:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264940AbTFYSne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 14:43:34 -0400
Received: from dm2-55.slc.aros.net ([66.219.220.55]:22201 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S264870AbTFYSnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 14:43:19 -0400
Message-ID: <3EF9F094.3030506@aros.net>
Date: Wed, 25 Jun 2003 12:57:24 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul.Clements@steeleye.com
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Pavel Machek <pavel@ucw.cz>, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC][PATCH] nbd driver for 2.5+: fix locking issues with ioctl
 UI
References: <Pine.LNX.4.10.10306251251410.11076-100000@clements.sc.steeleye.com>
In-Reply-To: <Pine.LNX.4.10.10306251251410.11076-100000@clements.sc.steeleye.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Clements wrote:

>. . .
>This patch introduces a locking hierarchy between the lo->tx_lock and
>lo->queue_lock. The existing driver does not have this limitation.
>I would feel a lot better about this patch if you were to recode it
>to avoid this.
>
Did Al's statements regarding this make this feel better? The code could 
be redone so that the queuelist is added to before the down but then 
more often it will have to be removed from since the lo->sock check 
wouldn't have been done yet. On the other hand I've been thinking that I 
might be able to take advantage of the irq locked condition imposed by 
the q->queue_lock and just use nbd_lock to replace q->queue_lock then. 
Al and Andrew seem to have a much deeper understanding though for 
spinlocking though so I'll defer to there comments on this idea (of 
replacing lo->queue_lock by use of nbd_lock). This has the added 
attraction of already having nbd_lock locked when in do_nbd_request.

>Also, I noticed that you've removed the forcible shutdown of the
>socket at the end of NBD_DO_IT. Was there a particular reason for
>that?
>
Yes. The forcible shutdown that was put in place (while closing one race 
condition) still left a panicable race condition with the nbd-client 
tool. I forget exactly what this was at the moment. Suffice it to say 
that since the user space tool opened the socket to begin with, it seems 
a better design to have the user space tool do the close as well. When 
nbd-client exits, it'd effect close of this socket anyway even if 
killed. What still needs to be done though, is to have the 
implementation of the NBD_DISCONNECT ioctl in the driver wait until 
nbd_do_it sets lo->sock back to NULL. That way the NBD_CLEAR_QUE ioctl 
can return -EBUSY if lo->sock, while not getting called by nbd-client 
till lo->sock == NULL so that the que clear works.

>>... the new NBD_DO_IT style interface 
>>could be introduced instead as another ioctl completely and these 3 
>>ioctls could be maintained for backward compatibility for a while 
>>longer. 
>>    
>>
>
>It would be really nice if the driver remained (as much as
>possible) compatible with the 2.4 version...unless you have
>a really good reason to break things... :)
>  
>
So you'd prefer to have a new ioctl then to do this rolled together 
NBD_DO_IT function? Say NBD_RUN or something that takes the sock 
argument. That will require the nbd_device structure to maintain that 
file pointer again and possibly leave open the races that seem inherent 
to having the three seperate ioctl's. Someone else long ago commented in 
the driver "possible FIXME: make set_sock / set_blksize / set_size / 
do_it one syscall. Why not: would need verify_area and friends, would 
share yet another structure with userland". So it seems someone was long 
ago realizing there were problems having the three seperate ioctls for 
set_sock, do_it, and clear_sock. Of course this doesn't address 
set_size, set_blksize, but I don't see them as problematic w.r.t. 
locking once set_sock, do_it, and clear_sock are rolled together.

Seems like we're better off deprecating at least the set_sock and 
clear_sock ioctls to return some error code and having the nbd-client 
tool runtime switch off of something like their return value (or a 
release level value as was also suggested). It's maybe more painful in 
requiring people to update their nbd-client's but we  live with those 
kinds of required updates all the time (example mod-utils insmod, rmmod, 
from Rusty to boot 2.5 kernels). The benefit will be memory saving and 
better kernel stability. I'm more torn between the idea of deprecating 
all three ioctls and adding a NBD_RUN versus just deprecating 
NBD_SET_SOCK and NBD_CLEAR_SOCK and changing the NBD_DO_IT ioctl to 
require the socket descriptor.

Comments?

