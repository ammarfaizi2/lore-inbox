Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262503AbSIZMQK>; Thu, 26 Sep 2002 08:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262504AbSIZMQJ>; Thu, 26 Sep 2002 08:16:09 -0400
Received: from unthought.net ([212.97.129.24]:24213 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S262503AbSIZMQI>;
	Thu, 26 Sep 2002 08:16:08 -0400
Date: Thu, 26 Sep 2002 14:21:24 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: Re: jbd bug(s) (?)
Message-ID: <20020926122124.GS2442@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	"Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@zip.com.au>
References: <20020924072117.GD2442@unthought.net> <20020925173605.A12911@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020925173605.A12911@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 05:36:05PM +0100, Stephen C. Tweedie wrote:
> Hi,
..
> > Isn't this a problem ?
> 
> Nah.  In fact I should just remove the loop entirely.  For commit
> processing, only the header at the very, very start of a commit block
> is cared about --- that way, we get atomic commits even if the commit
> block is partially written out-of-order on disk.  As long as sector
> writes within the fs block are atomic, the header remains intact.

Ok, fair enough.

The loop (which performs a number of repeated identical writes to the
*same* location) along with the comment does look pretty scary though

  8)

> 
> > The jbd superblocks contains an index into the journal for the first
> > transaction - but there is only *one* copy of the index, and there is no
> > reasonable way to detect if it got written correctly to disk.
> > 
> > If the system loses power while updating the superblock, and only *half*
> > of this index is written correctly, we have a journal which we cannot
> > reach.
> 
> Again, only the data in the first sector matters there, and we assume
> that disks write individual sectors atomically, or return IO failure
> if things get messed up.

Yep - so does Reiser. I originally believed that this was not the case
with modern disks, but I think I was corrected on that one in the Reiser
bug thread   :)

...
> > Sort of removes the point of having the journal in the first place. (If
> > my above assertion is true).
> 
> Actually, the number of single points of failure in a filesystem is
> huge.
[snip]

Originally it was my impression that the index was written fairly
frequently, *and* that you did not have the atomic-sector-write
guarantee.

That's why I was very worried.

> So if we detect incomplete sector writes, we can recover by forcing a
> fsck, but if you want to be able to survive actual data loss, you need
> raid.

RAID wouldn't save me in the case where the journal index is screwed due
to a partial sector write and a power loss.

But anyway, that is a moot point  :)


Thank you for explaining,

(/me hopes the scary-loop dies  ;)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
