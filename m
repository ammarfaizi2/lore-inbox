Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbTFYWDa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 18:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbTFYWDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 18:03:30 -0400
Received: from dm2-55.slc.aros.net ([66.219.220.55]:58050 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S265091AbTFYWD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 18:03:26 -0400
Message-ID: <3EFA1F7E.2080602@aros.net>
Date: Wed, 25 Jun 2003 16:17:34 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul.Clements@steeleye.com
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Pavel Machek <pavel@ucw.cz>, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC][PATCH] nbd driver for 2.5+: fix locking issues with ioctl
 UI
References: <Pine.LNX.4.10.10306251516570.11076-100000@clements.sc.steeleye.com>
In-Reply-To: <Pine.LNX.4.10.10306251516570.11076-100000@clements.sc.steeleye.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Clements wrote:

>. . . I guess I was just wondering why the
>tx_lock was pulled out of nbd_send_req(). It just seems to make the
>code harder to follow with the overlapping locking, the duplicated
>checks for sock == NULL, and it also means the tx_lock gets held
>(a little bit) longer...
>
Reviewing the code some more, I'm not sure why I moved the tx_lock out 
from nbd_send_req(). Some possible explanations are:

   1. nbd_send_req() was big enough without the locking in it.
   2. keeps the locking at the same level as the spin_unlock_irq() which
      makes lock analysis a little easier. it's also a more consistant
      level to have at for consistantly locking accross all the ioctl
      handling.
   3. the next patch I had done (patch 7) implements a default blocking
      strategy and having the lock be outside nbd_send_req made analysis
      a little easier again. as in the last reason, the locking then
      fell into place more consistantly level wise.
   4. in order to have the locking inside nbd_send_req it would seem
      it'd help to make nbd_send_req return a value that could be checked.

I'm not convinced by any of my own reasons though. Maybe it should be 
inside. There aren't duplicated checks for sock == null except in 
different execution paths so it doesn't get checked twice in a row if 
that's what you mean. Just larger executable size as any inlining causes.

>>that since the user space tool opened the socket to begin with, it seems 
>>a better design to have the user space tool do the close as well.
>>    
>>
>
>I agree, but I thought that the shutdown was causing different behavior...
>  
>
What behavior would the shutdown cause that close doesn't also cause?

>>When
>>nbd-client exits, it'd effect close of this socket anyway even if
>>killed.
>>    
>>
>
>Does the socket close at exit have the same effect as a socket shutdown?
>If so, then I guess the shutdown is unnecessary...
>
I believe so. I thought someone from steeleye put the call in to begin 
with just in order to close up a race condition gap and that's better 
handled by not having the three seperate ioctls. My understanding is 
that the shutdown is analogous to calling the shutdown() system call on 
the socket which is just a way to individually shutdown the read side or 
write side of the socket no? In anycase, I believe close (once really 
finished) has the same net effect.

>>So you'd prefer to have a new ioctl then to do this rolled together 
>>NBD_DO_IT function? Say NBD_RUN or something that takes the sock 
>>    
>>
>
>I do like the combined ioctl, as it seems to make the code a little bit
>cleaner and safer. But, it would also be nice to maintain compatibility
>with the existing userland tools. Maybe if the driver could support both
>new and old interfaces (at least for now), then users could gradually
>move over to the new interface(s)?
>
Agreed then. That's what I'd done in my original jumbo nbd patch 
(maintain suport for old and new ioctls). So I'll work on that next 
week. In the meantime, the nbd-client tool currently can't correctly set 
the size of the device and either that needs to be worked around in the 
driver (I'd done that in the original jumbo patch), or the nbd-client 
tool needs to be updated (the patch I'd mailed out for nbd-client works 
around the sizing issue by re-opening the nbd). To be clear, that's not 
something any of the changes that have gone in so far broke nor address. 
It's a consequence of how bd_set_size() is called in fs/block_dev.c 
do_open(). One of the other drivers (in drivers/block I believe) works 
around the problem by updating the info in the inode but it seems kind 
of like a hack. Will someone who has worked on the fs/block_dev.c file 
recently chime in on this issue of how to properly effect size?

Thanks for your input on this!!!

