Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275268AbRIZPan>; Wed, 26 Sep 2001 11:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275274AbRIZPab>; Wed, 26 Sep 2001 11:30:31 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:43510 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S275268AbRIZPaQ>; Wed, 26 Sep 2001 11:30:16 -0400
Date: Wed, 26 Sep 2001 15:43:11 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Mike Fedyk <mfedyk@matchmail.com>, Stephen Tweedie <sct@redhat.com>
Subject: Re: ReiserFS data corruption in very simple configuration
Message-ID: <20010926154311.C12560@redhat.com>
In-Reply-To: <200109221000.GAA11263@out-of-band.media.mit.edu> <15276.34915.301069.643178@beta.reiserfs.com> <20010925131304.I23320@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010925131304.I23320@mikef-linux.matchmail.com>; from mfedyk@matchmail.com on Tue, Sep 25, 2001 at 01:13:04PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 25, 2001 at 01:13:04PM -0700, Mike Fedyk wrote:

> > Stock reiserfs only provides meta-data journalling. It guarantees that
> > structure of you file-system will be correct after journal replay, not
> > content of a files. It will never "trash" file that wasn't accessed at
> > the moment of crash, though. Full data-journaling comes at cost. There
> > is patch by Chris Mason <Mason@Suse.COM> to support data journaling in
> > reiserfs. Ext3 supports it also.
 
> When files on a ReiserFS mount have data from other files, does that mean
> that it has recovered wrong meta-data, or is it because the meta-data was
> committed before the data?

It can be either, but the former can only be the result of a problem
(either hardware fault or a data-corrupting software bug of some
description).  In the normal case, only the latter scenario happens.

ext3 has a mode to flush all data before metadata gets committed.
That is its default mode, and it avoids this problem without having to
actually journal the data.

> So, if I write a file, does ReiserFS write the structures first, and if the
> data isn't written, whatever else was deleted from the block before will now
> be in the file?

Yep.  ext3 behaves in the same way in its fastest "writeback" data
mode.

> If that's so, then one way to keep old deleted data from getting into
> partially written files after a crash would be to zero out the blocks on
> unlink.  I can imagine that this would prevent undelete, and slow down
> deleting considerably.

Indeed.

> Another way, may be to keep a journal of which blocks have actually been
> committed.  Maybe a bitmap in the journal, or some other structure...

ext3 does exactly that.  It's necessary to keep things in sync if we
have blocks of data being deleted and reallocated as metadata, or
vice-versa.

> If you have data journaling, does that mean there is a possability of
> recovering a complete file -before- it was written?  i.e:

> echo a > test;
> sync;
> cat picture.tif > test
> (writing in progress, only partially in journal)
> power off
 
> Will "a" be in test upon recovery?

If you are using full data journaling (ext3's "journal" data mode) or
the default "ordered" data mode, then no, you never see such
behaviour.

In the ordered mode, it achieves this precisely because it is keeping
a record of which blocks have been committed (or, more accurately,
which *deleted* blocks have had the delete committed).  If you do a
"cat > file", then before the new data is written, the file gets
truncated and all its old data blocks deleted.  ext3 will then refuse
to reuse those blocks until the delete has been committed, so if we
crash and end up rolling back the delete transaction, we'll never see
new data blocks in the old file.

Cheers,
 Stephen
