Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282867AbRLQUob>; Mon, 17 Dec 2001 15:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282860AbRLQUoV>; Mon, 17 Dec 2001 15:44:21 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:21523
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S282862AbRLQUoK>; Mon, 17 Dec 2001 15:44:10 -0500
Date: Mon, 17 Dec 2001 12:38:09 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Joel Becker <jlbec@evilplan.org>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT wierd behavior..
In-Reply-To: <20011217202056.L31706@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.10.10112171218530.17715-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You are asking for something that Linux is not capable of doing.
There is no means to send and error back from the disk flush to the
fs/appilcation period.  The current 2.4 can not even find the partition
when send an error back up to the block layer.  2.5 has a chance, but
currently none have the ablitity to notify or flush disk cache and recover
of there is a flushcache error.

Therefore it is potential a preferred model to preserve the entire request
for a retry than to do a partial validation of an incomplete attempt.

On Mon, 17 Dec 2001, Joel Becker wrote:

> On Mon, Dec 17, 2001 at 11:59:56AM -0800, Linus Torvalds wrote:
> > On Mon, 17 Dec 2001, Joel Becker wrote:
> > > 	/* Smart program handles partial writes */
> > > 	write(100k); = 50k
> > > 	write(remaining 50k); = -1/ENOSPC|EIO|etc
> > 
> > We do this, if the error is "hard". And "fatal" implies hardness, so we're
> > ok here.
> 
> 	Right.  "hard" is also synonymous with "non-transient".
> 
> > > 	/* Dumb program doesn't handle partial write */
> > > 	write(100k); = 50k
> > > 	close(fd); = -1/EIO
> > 
> > But we're not doing this.
> 
> 	IMHO we should be, and not just to comply with the letter of
> SUS/Unix98.  SUS specifies this behavior because a synchronous write()
> can return after copying data to the buffer cache.  However, the EIO can
> happen later when the buffer cache is trying to flush to disk.  The only
> way for an application to see this error is to either run O_SYNC or
> receive it upon close().


Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project


