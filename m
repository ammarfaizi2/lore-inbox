Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279040AbRJ2GeM>; Mon, 29 Oct 2001 01:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279051AbRJ2GeC>; Mon, 29 Oct 2001 01:34:02 -0500
Received: from calais.pt.lu ([194.154.192.52]:8117 "EHLO calais.pt.lu")
	by vger.kernel.org with ESMTP id <S279040AbRJ2Gdu>;
	Mon, 29 Oct 2001 01:33:50 -0500
Message-Id: <200110290634.f9T6YJD07642@hitchhiker.org.lu>
To: Alexander Viro <viro@math.psu.edu>
cc: ptb@it.uc3m.es, linux kernel <linux-kernel@vger.kernel.org>
Reply-To: alain@linux.lu
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Re: Poor floppy performance in kernel 2.4.10 
In-Reply-To: Your message of "Mon, 29 Oct 2001 01:07:23 EST."
             <Pine.GSO.4.21.0110290101230.26445-100000@weyl.math.psu.edu> 
Date: Mon, 29 Oct 2001 07:34:18 +0100
From: Alain Knaff <Alain.Knaff@hitchhiker.org.lu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>On Mon, 29 Oct 2001, Alain Knaff wrote:
>
>> Problem number 2 is not yet addressed, Alex Viro is working on a patch
>> (probably by having a variant of invalidate_bdev that just stops
>> transfers in progress, loudly warn about dirty pages, but without
>> killing clean cached pages)
>> 
>> Number 3 is fixed by making struct block_device "long
>> lived". Formerly, it only existed as long as there were active open
>> descriptors using it; now it exists as long as there are frontend
>> inodes referencing it.
>
>IMO that's bogus.

As far as I understood, the same logic is used for all other kinds of
inodes, isn't it? I agree that it is suboptimal (might stay around
longer than its pages), but at least it works in simple cases
(i.e. stays cached normally, and is evicted from cache under memory
pressure).

>Correct test is "do we have any data in page cache
>for this guy?" (combined with "... and if driver says that it goes
>away, we'd better drop them all").  See the patch I've just sent to you
>and Linus - right now I consider it as too dangerous for public testing, so...

Got the patch... but only after I sent that mail to Peter. I'll have a
look at it, and try to test it. But due to other activities, I'm
afraid I'll only be able to get around to it tomorrow evening.

>Notice that it _doesn't_ trust check_media_change() - it still has
>both detach_metadata() (needed in all cases) and truncate_inode_pages()
>(kills cache, needed only for drivers with b0rken ->check_media_change())
>in blkdev_put().  You'll need to make the latter call conditional

With your patch, will making that call conditional still correctly
stop any transfers which are already in progress? (a problem that has
existed with my patches)? Or does this problem need to be addressed
separately?

>to
>actually keep the cache around, but I'd really like to make sure that
>infrastructure changes are sane before doing that step.

Ok, I'll give it a spin tomorrow evening.



Btw, the more I think about the check_media_change issue, the more I
come to the conclusion that the cases of broken media change detection
are best dealt with from within the driver. Indeed, firstly why
encumber the vast majority of drivers, which are non-broken, or which
already deal with the situation, just in order to handle a few bad
apples? Secondly, the broken drivers might have internal caches (track
buffers, etc.), and just ignoring check_media_change _outside_ the
driver won't fix all of the problem, as the internal caches will not
be invalidated.

Thus, may I suggest the following course of action in case a missed
media change detection problem with a driver: make a good-faith effort
to contact its maintainer, and have the problem fixed _in_the_driver_
rather than to have media change ignored centrally. Same goes for
other issues as well: work _with_ the device drivers, rather than
_against_ them. I think, in the long run this will save all of us lots
of grief.

Yes, we can have can_trust_media_change type functions, but it just
makes all drivers more complex, and eventually it will lead to a
situation where bad device drivers might unconditionnally return true
to it anyways, and we'd be back to square one.

Alain
