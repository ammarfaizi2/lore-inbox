Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262592AbSI0Syb>; Fri, 27 Sep 2002 14:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262591AbSI0SyZ>; Fri, 27 Sep 2002 14:54:25 -0400
Received: from packet.digeo.com ([12.110.80.53]:60036 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262589AbSI0SyT>;
	Fri, 27 Sep 2002 14:54:19 -0400
Message-ID: <3D94AA96.8E29FC2A@digeo.com>
Date: Fri, 27 Sep 2002 11:59:34 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: James Bottomley <James.Bottomley@steeleye.com>, Jens Axboe <axboe@suse.de>,
       Matthew Jacob <mjacob@feral.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doingfile  
 transfers
References: <200209271426.g8REQ3228125@localhost.localdomain> <2441376224.1033144007@aslan.btc.adaptec.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2002 18:59:27.0843 (UTC) FILETIME=[00EC3330:01C26658]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin T. Gibbs" wrote:
> 
> ...
> The OS elevator will never know all of the device characteristics that
> the device knows.  This is why the device's elevator will always out
> perform the OSes assuming the OS isn't stupid about overcommitting writes.
> That's what the argument is here.  Linux is agressively committing writes
> when it shouldn't.

The VM really doesn't want to strangle itself because it might be
talking to a braindead SCSI drive.

I have a Fujitsu disk which allows newly submitted writes to
bypass already-submitted reads.  A read went in, and did not
come back for three seconds.  Ninety megabytes of writes went
into the disk during those three seconds.

>From a whole-system performance viewpoint that is completely
broken behaviour.  It's unmanageable from the VM point of view.
At least, I don't want to have to manage it at that level.

We may be able to work around it by adding kludges to the IO
scheduler but it's easier to just set the tag depth to zero and
mutter rude words about clueless firmware developers.

> > I guess, however, that this issue will evaporate substantially once the
> > aic7xxx driver uses ordered tags to represent the transaction integrity
> > since  the barriers will force the drive seek algorithm to follow the tag
> > transmission order much more closely.
> 
> Hooks for sending ordered tags have been in the aic7xxx driver, at least
> in FreeBSD's version, since '97.  As soon as the Linux cmd blocks have
> such information it will be trivial to have the aic7xxx driver issue
> the appropriate tag types.  But this misses the point.  Andrew's original
> speculation was that writes were "passing reads" once the read was
> submitted to the drive.  I would like to understand the evidence behind
> that assertion since all drive's I've worked with automatically give
> a higher priority to read traffic than writes since writes can be buffered
> but reads cannot.

Could be that the Fujitsu is especially broken.  I observed the three
second read latency with 253 tags (OK, that's 128 megabytes worth).
But with the driver limited to four tags, latency was two seconds.
Hence my speculation.

>  Ordered tags only help if the driver is already not
> doing what you want or if your writes must have a specific order for
> data integrity.

Is it possible to add a tag to a read which says "may not be bypassed
by writes"?  That would be OK, as long as the driver is only set up
to use a tag depth of four or so.

To use larger tag depths, we'd need to be able to tag newly incoming
reads with a "do this before servicing already-submitted writes"
attribute.  Is anything like that available?
