Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273487AbRIYUNE>; Tue, 25 Sep 2001 16:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273488AbRIYUMx>; Tue, 25 Sep 2001 16:12:53 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:4850
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S273487AbRIYUMo>; Tue, 25 Sep 2001 16:12:44 -0400
Date: Tue, 25 Sep 2001 13:13:04 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS data corruption in very simple configuration
Message-ID: <20010925131304.I23320@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200109221000.GAA11263@out-of-band.media.mit.edu> <15276.34915.301069.643178@beta.reiserfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15276.34915.301069.643178@beta.reiserfs.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2001 at 04:47:31PM +0400, Nikita Danilov wrote:
> foner-reiserfs@media.mit.edu writes:
>  > [Please CC me on any replies; I'm not on linux-kernel.]
>  > I thought the whole point of a journalling file system was to
>  > -prevent- corruption due to an unexpected failure!  This seems to be
>  > -far- worse than a normal filesystem---ext2fs would at least choke and
>  > force fsck to be run, which might actually fix the problem, but this
>  > is ridiculous---it just silently trashes random files.
> 
> Stock reiserfs only provides meta-data journalling. It guarantees that
> structure of you file-system will be correct after journal replay, not
> content of a files. It will never "trash" file that wasn't accessed at
> the moment of crash, though. Full data-journaling comes at cost. There
> is patch by Chris Mason <Mason@Suse.COM> to support data journaling in
> reiserfs. Ext3 supports it also.
> 

When files on a ReiserFS mount have data from other files, does that mean
that it has recovered wrong meta-data, or is it because the meta-data was
committed before the data?

So, if I write a file, does ReiserFS write the structures first, and if the
data isn't written, whatever else was deleted from the block before will now
be in the file?

If that's so, then one way to keep old deleted data from getting into
partially written files after a crash would be to zero out the blocks on
unlink.  I can imagine that this would prevent undelete, and slow down
deleting considerably.

Another way, may be to keep a journal of which blocks have actually been
committed.  Maybe a bitmap in the journal, or some other structure...

If you have data journaling, does that mean there is a possability of
recovering a complete file -before- it was written?  i.e:

echo a > test;
sync;
cat picture.tif > test
(writing in progress, only partially in journal)
power off

Will "a" be in test upon recovery?
