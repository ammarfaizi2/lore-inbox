Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316276AbSEOIcA>; Wed, 15 May 2002 04:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316302AbSEOIb7>; Wed, 15 May 2002 04:31:59 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:40774 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316276AbSEOIb6>; Wed, 15 May 2002 04:31:58 -0400
Message-Id: <5.1.0.14.2.20020515085358.01fd8580@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 15 May 2002 09:32:23 +0100
To: Jens Axboe <axboe@suse.de>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] 2.5.15 IDE 61
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Conway <nconway.list@ukaea.org.uk>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020515061654.GC11948@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:16 15/05/02, Jens Axboe wrote:
>On Tue, May 14 2002, Anton Altaparmakov wrote:
> > instead of having per channel queue, you could have per device queue, but
> > use the same lock for both, i.e. don't make the lock part of "struct 
> queue"
> > (or whatever it is called) but instead make the address of the lock be
> > attached to "struct queue".
>
>See request_queue_t, the lock can already be shared.

/me looks.

So it can. And I thought I had come up with a clever idea... (-;

>And in fact the ide layer used a global ide_lock shared between all queues 
>until just
>recently.
>
> > Further if a controller is truly broken and you need to synchronize
> > multiple channels you could share the lock among those.
>
>Again, this is not enough! The lock will only, at best, serialize direct
>queue actions. So I can share a lock between queue A and B and only one
>of them will start a request at any given time, but as soon as request X
>is started for queue A, then we can happily start request Y for queue B.
>
>This is what the hwgroup busy flag protects right now, only one queue is
>allowed to mark the hwgroup busy naturally. So only when request X for
>queue A completes will the hwgroup busy flag be cleared, and queue B can
>start request Y.

Yes, I understand that, could you not extend the shared lock idea to a 
shared flags idea? The two could even be in the same memory allocated block 
as both the lock and the flags would always be shared by the same users. 
That would just now contain only QUEUE_SHARED_FLAG_BUSY but could be 
extended later if the need arises.

 From what I gather from the posts on this topic, this would be entirely 
sufficient to fully lock both request queue handling and request submission 
to the hardware while maintaining per-device queues.

I may be way off base but I would think that per-device queues are 
desirable to improve the request merging abilities of the elevator. (Again, 
code I haven't looked at so it may well be intelligent enough to 
resort/merge requests with different destinations on the same queue but I 
am sure you will tell me if this is the case. (-;)

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

