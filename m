Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274508AbRJADiW>; Sun, 30 Sep 2001 23:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274509AbRJADiM>; Sun, 30 Sep 2001 23:38:12 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:60411
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S274508AbRJADiJ>; Sun, 30 Sep 2001 23:38:09 -0400
Date: Sun, 30 Sep 2001 20:38:31 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS data corruption in very simple configuration
Message-ID: <20010930203831.A25387@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200109221000.GAA11263@out-of-band.media.mit.edu> <15276.34915.301069.643178@beta.reiserfs.com> <20010925131304.I23320@mikef-linux.matchmail.com> <20010926154311.C12560@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010926154311.C12560@redhat.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 26, 2001 at 03:43:11PM +0100, Stephen C. Tweedie wrote:
> On Tue, Sep 25, 2001 at 01:13:04PM -0700, Mike Fedyk wrote:
> > If you have data journaling, does that mean there is a possability of
> > recovering a complete file -before- it was written?  i.e:
> 
> > echo a > test;
> > sync;
> > cat picture.tif > test
> > (writing in progress, only partially in journal)
> > power off
>  
> > Will "a" be in test upon recovery?
> 
> If you are using full data journaling (ext3's "journal" data mode) or
> the default "ordered" data mode, then no, you never see such
> behaviour.
>

At this point, it looks like I'm going to get a partial picture.tif in test
after recovery...

> In the ordered mode, it achieves this precisely because it is keeping
> a record of which blocks have been committed (or, more accurately,
> which *deleted* blocks have had the delete committed).  If you do a
> "cat > file", then before the new data is written, the file gets
> truncated and all its old data blocks deleted.  ext3 will then refuse
> to reuse those blocks until the delete has been committed, so if we
> crash and end up rolling back the delete transaction, we'll never see
> new data blocks in the old file.
>

Now, it looks like I'll end up with "a" in test...  

>From what you're describing, it looks like the contents of test after a
truncate won't be overwritten by another transaction until the deletion of
those blocks has made it to disk...  So, while in ordered, or journal mode,
I'd end up with "a" in test, but with writeback mode there is no such
guarantee.

Am I missing something?

Are there any known cases where ext3 will not be able to recover pervious
data when a write wasn't able to complete?

> Cheers,
>  Stephen

Mike
