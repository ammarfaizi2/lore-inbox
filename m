Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261826AbTC0JIg>; Thu, 27 Mar 2003 04:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261825AbTC0JIf>; Thu, 27 Mar 2003 04:08:35 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54745 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261824AbTC0JIa>;
	Thu, 27 Mar 2003 04:08:30 -0500
Date: Thu, 27 Mar 2003 10:18:54 +0100
From: Jens Axboe <axboe@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@digeo.com>,
       dougg@torque.net, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [patch for playing] 2.5.65 patch to support > 256 disks
Message-ID: <20030327091854.GY30908@suse.de>
References: <200303211056.04060.pbadari@us.ibm.com> <3E8047C7.4070009@cyberone.com.au> <20030325123502.GW2371@suse.de> <200303261629.34868.pbadari@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303261629.34868.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26 2003, Badari Pulavarty wrote:
> On Tuesday 25 March 2003 04:35 am, Jens Axboe wrote:
> 
> > Only testing will tell, so yes you are very welcome to give it a shot.
> > Let me release a known working version first :)
> 
> Jens,
> 
>  I  found whats using 32MB out of 8192-byte slab.
> 
> size-8192       before:10 after:4012 diff:4002 size:8192 incr:32784384
> 
> It is deadline_init():
> 
>         dd->hash = kmalloc(sizeof(struct list_head)*DL_HASH_ENTRIES,GFP_KERNEL);
> 
> It is creating 8K hash table for each queue. Since we have 4000 queues,

Yes

> it used 32MB. I wonder why the current code needs 1024 hash buckets, 

Hmm actually that's a leftover from when we played with bigger queue
sizes, I inadvertently forgot to change it back when pushing the rbtree
deadline update to Linus. It used to be 256. We can shrink this to 2^7
or 2^8 instead, which will then only eat 1-2K.

> when maximum requests are only 256. And also, since you are making
> request allocation dynamic, can you change this too ? Any issues here ?

No real issues to shrinking it, bigger problem if we move to larger
queues. With the rq-dyn-alloc patch, we can make the max number of
requests ceiling a lot higher and then the hash needs to be bigger too.
But for now, 256 entry should be a good default and suffice for the
future, I'll push that change.

-- 
Jens Axboe

