Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273305AbRIRKRi>; Tue, 18 Sep 2001 06:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273304AbRIRKRT>; Tue, 18 Sep 2001 06:17:19 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:36336 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S273299AbRIRKRM>; Tue, 18 Sep 2001 06:17:12 -0400
Date: Tue, 18 Sep 2001 11:17:02 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brian <hiryuu@envisiongames.net>, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: Disk errors and Reiserfs
Message-ID: <20010918111702.A12248@redhat.com>
In-Reply-To: <200109162329.f8GNTY918084@demai05.mw.mediaone.net> <E15imSi-00068f-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15imSi-00068f-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Sep 17, 2001 at 01:40:36AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 17, 2001 at 01:40:36AM +0100, Alan Cox wrote:
> > My issue, though, is Linux did not handle it well.  Userspace actually has 
> > an 'EIO' error code for this situation but, instead, any program touching 
> > the mounted partition hung in a D state.
> 
> Thats a reiserfs property and one you'll find in pretty much any other
> fs.

No --- ext2 and ext3 will propagate EIO up to the application.  We've
also spent a lot of effort making sure that ext2 won't ever panic even
if the IO succeeds but returns bogus data (disk, cable or controller
faults).  Disk failures should never cause process kernel hangs, any
more than bogus network packets should.

> Killing the process isnt neccessary, its been halted in its tracks. As to
> a clean shutdown - no chance. You've just hit a disk failure, the on disk
> state is not precisely known, writes have been lost. Nothing is going to
> make a clean shutdown possible under such circumstances.

Why not?  ext2 lets you select between three behaviours on detecting
such an error: continue (the fs is marked as having errors and will be
fscked on the next boot, as long as we can write the error flag to the
superblock); remount-readonly (we fail the IO and force the fs
readonly, but otherwise continue as above); or panic immediately.  As
long as you've selected continue or continue-ro, you should be able to
unmount the disk as soon as you've killed any processes still
accessing it.  I've also spent a lot of effort making sure that the
backoff-and-remount-readonly code in ext3 is solid, too.  I don't 
regard a kernel lockup as a necessary response to disk failure.

Cheers,
 Stephen
