Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262823AbREVU61>; Tue, 22 May 2001 16:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262820AbREVU6R>; Tue, 22 May 2001 16:58:17 -0400
Received: from teranet244-12-200.monarch.net ([24.244.12.200]:60676 "HELO
	lustre.us.mvd") by vger.kernel.org with SMTP id <S262818AbREVU6J>;
	Tue, 22 May 2001 16:58:09 -0400
Date: Tue, 22 May 2001 14:59:32 -0600 (MDT)
From: "Peter J. Braam" <braam@mountainviewdata.com>
X-X-Sender: <braam@lustre.us.mvd>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Edgar Toernig <froese@gmx.de>,
        Ben LaHaise <bcrl@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-lvm@vger.kernel.org>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <200105222010.f4MKAWZk011755@webber.adilger.int>
Message-ID: <Pine.LNX.4.33.0105221415540.2271-100000@lustre.us.mvd>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andreas,


I think that the issue is something different.  Suppose the snapshot has
been created. I know that this can be done safely with the API's you
allude to. Life goes on and the journal FS keeps changing the file system
and if the system doesn't crash, everything is fine: blocks get copied
correctly from the primary volume to the snapshot volume.

Now consider a crash -- not during snapshot creation, but way after that
when "life is going on".  Suppose there is a two block transaction that
has made it to the journal and after writing one block to the fs location
the system crashes.  The journal replay will try to write that block
again.

But during recovery, LVM cannot possibly know if the whole process of
copying out the data from the current to the snapshot area completed
during the previous run. Yes, LVM updates the redirection table first and
then copies, but, still, you don't know _where exactly_ the writes stopped
happening and in particular you don't know if the block was copied already
or not.

So during replay it is quite possible that LVM corrupts the snapshot.

It's better to keep the snapshot in the old volume and write the new data
to a separate area (that's what most commercial systems do I think).  It
avoid redirections and copying upon write.  When you delete the snapshot
you have to copy, but you can do that as a low priority process.
Finally, as you pointed out a full volume is handled better too in that
way, since you don't terminate the snapshot but you tell the current
volume that it is full.

Hmm, I was expecting a storm of email explaining what I have
misunderstood, but it has in fact been rather quiet...

- Peter -






On Tue, 22 May 2001, Andreas Dilger wrote:

> Peter Braam writes:
> > On Tue, 22 May 2001, Andreas Dilger wrote:
> > > Actually, the LVM snapshot
> > > interface has (optional) hooks into the filesystem to ensure that it
> > > is consistent at the time the snapshot is created.
> >
> > File system journal recovery can corrupt a snapshot, because it copies
> > data that needs to be preserved in a snapshot. During journal replay such
> > data may be copied again, but the source can have new data already.
>
> The way it is implemented in reiserfs is to wait for existing transactions
> to complete, entirely flush the journal and block all new transactions from
> starting.  Stephen implemented a journal flush API to do this for ext3, but
> the hooks to call it from LVM are not in place yet.  This way the journal is
> totally empty at the time the snapshot is done, so the read-only copy does
> not need to do journal recovery, so no problems can arise.
>
> Cheers, Andreas
>

-- 

