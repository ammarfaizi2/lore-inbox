Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289556AbSCCWQW>; Sun, 3 Mar 2002 17:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289306AbSCCWQQ>; Sun, 3 Mar 2002 17:16:16 -0500
Received: from dsl-213-023-040-044.arcor-ip.net ([213.23.40.44]:21389 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289272AbSCCWQE>;
	Sun, 3 Mar 2002 17:16:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: James Bottomley <James.Bottomley@SteelEye.com>,
        Chris Mason <mason@suse.com>, "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Date: Sun, 3 Mar 2002 23:11:44 +0100
X-Mailer: KMail [version 1.3.2]
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain>
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16heCm-0000Q5-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 28, 2002 04:36 pm, James Bottomley wrote:
> Doug Gilbert prompted me to re-examine my notions about SCSI drive caching, 
> and sure enough the standard says (and all the drives I've looked at so far 
> come with) write back caching enabled by default.
> 
> Since this is a threat to the integrity of Journalling FS in power failure 
> situations now, I think it needs to be addressed with some urgency.
> 
> The "quick fix" would obviously be to get the sd driver to do a mode select at 
> probe time to turn off the WCE and RCD bits (this will place the cache into 
> write through mode), which would match the assumptions all the JFSs currently 
> make.  I'll see if I can code up a quick patch to do this.
> 
> A longer term solution might be to keep the writeback cache but send down a 
> SYNCHRONIZE CACHE command as part of the back end completion of a barrier 
> write, so the fs wouldn't get a completion until the write was done and all 
> the dirty cache blocks flushed to the medium.

I've been following the thread, I hope I haven't missed anything fundamental.
A better long term solution is to have ordered tags work as designed.  It's 
not broken by design is it, just implementation?

I have a standing offer from at least one engineer to make firmware changes 
to the drives if it makes Linux work better.  So a reasonable plan is: first 
know what's ideal, second ask for it.  Coupled with that, we'd need a way of 
identifying drives that don't work in the ideal way, and require a fallback.

In my opinion, the only correct behavior is a write barrier that completes
when data is on the platter, and that does this even when write-back is
enabled.  Surely this is not rocket science at the disk firmware level.  Is
this or is this not the way ordered tags were supposed to work?

> Clearly, there would also have to be a mechanism to flush the cache on 
> unmount, so if this were done by ioctl, would you prefer that the filesystem 
> be in charge of flushing the cache on barrier writes, or would you like the sd 
> device to do it transparently?

The filesystem should just say 'this request is a write barrier' and the 
lower layers, whether that's scsi or bio, should do what's necessary to make
it come true.

-- 
Daniel
