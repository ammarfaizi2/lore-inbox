Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265303AbTFUUJh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 16:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265304AbTFUUJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 16:09:37 -0400
Received: from dm4-159.slc.aros.net ([66.219.220.159]:8834 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S265303AbTFUUJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 16:09:33 -0400
Message-ID: <3EF4BEC5.1060301@aros.net>
Date: Sat, 21 Jun 2003 14:23:33 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Steven Whitehouse <steve@chygwyn.com>, akpm@digeo.com
Subject: Re: [RFC][PATCH] nbd driver for 2.5.72
References: <3EF3F08B.5060305@aros.net> <20030621073224.GJ6754@parcelfarce.linux.theplanet.co.uk> <3EF48A30.3010203@aros.net> <20030621193124.GK6754@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030621193124.GK6754@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:

>On Sat, Jun 21, 2003 at 10:39:12AM -0600, Lou Langholtz wrote:
>  
>
>>>Why not put these into nbd_device?
>>>
>>>      
>>>
>>I'd considered that and I'm reconsidering it again now. Not convinced 
>>which way to go... Putting something as large as struct request_queue 
>>within the nbd_device seems unbalanced somehow. Then again, until 2.5 
>>the request_queue was typically shared by multiple devices of the same 
>>MAJOR so part of the way the code is has to do with the legacy code. 
>>Like the nbd_lock spinlock array and the struct request_queue queue_lock 
>>field. Along the lines you're pushing for, why not have struct 
>>requests_queue's queue_lock field then be the spinlock itself instead of 
>>just being a pointer to a spinlock???
>>    
>>
>
>Because often that lock protects driver-internal objects that are used
>by all queues.
>
Not sure I understand what you're saying... I was going by the kernel 
blk_init_queue(q, rfn, lock) source that assigns q->queue_lock to the 
given lock pointer. Given how big struct request_queue was compared to a 
spinlock_t and since we require all disks to have there very own 
seperate struct request_queue (by virtue of all the sysfs stuff imbedded 
now in there), I'm pursauded to find requiring each request_queue to 
have its very own lock (by making queue_lock a spinlock_t rather than a 
pointer to such) a relatively low weighted addition for worthwhile gain. 
I don't doubt that I've missed something though. So unless some more 
experienced folks chime in for having queue_lock become a spinlock_t 
instead of spinlock_t *, I'll just not say anymore about queue_lock.

>Prefered variant (actually, we'll have to do it in 2.5 anyway) is to
>allocate request_queue dynamically.  Just put a pointer to it into nbd_device.
>
The best suggestion I've gotten so far was from Andrew Morton who 
rightfully said this patch was enormous. His comment was that it should 
be broken into separate logical patches which I'm working on now as the 
highest priority. I'm about to send out a comparitively miniscule patch 
that is meant as a start toward breaking this all down. It's probably 
the most critical changes currently needed by nbd anyway just to get it 
back to a usable state in 2.5 (for example try to rmmod nbd in 2.5.72 
and earlier - the result corrupts memory). The reason I mention this is 
because putting a pointer to the request_queue struct probably wouldn't 
happen then for a while till I get through enough incremental patches.

>BTW, could you please kill the ..._t silliness?  There is nothing wroung
>with using 'struct nbd_device' directly.
> 
>
Will do. Personally, I like the _t silliness, but then I can see the 
value enough either way and agree that consistancy tips any possible 
balance. ;-)

>. . .
>htonl() honours constants.  If it doesn't, we are in for much more serious
>problems, simply because a lot of codepaths in networking are using it.
>A lot.  IOW, you are obfuscating code for no good reason (and add an extra
>memory access, thus giving actually worse code - it's not an optimisation
>at all).
>  
>
Okay. I'll definately change this too. Thanks again for all your 
feedback!!!!

