Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265293AbSJRQhd>; Fri, 18 Oct 2002 12:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265299AbSJRQhc>; Fri, 18 Oct 2002 12:37:32 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:28435 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S265293AbSJRQha> convert rfc822-to-8bit; Fri, 18 Oct 2002 12:37:30 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] 2.5.43 cciss rescan disk ioctl
Date: Fri, 18 Oct 2002 11:43:25 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E10640167D06B@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.5.43 cciss rescan disk ioctl
Thread-Index: AcJ2wEes8RxkwzOoSRyEYb5BzVboPAAAKJ1g
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Alexander Viro" <viro@math.psu.edu>
Cc: <linux-kernel@vger.kernel.org>, "Linus Torvalds" <torvalds@transmeta.com>,
       "Patrick Mochel" <mochel@osdl.org>, "Jens Axboe" <axboe@suse.de>
X-OriginalArrivalTime: 18 Oct 2002 16:43:26.0566 (UTC) FILETIME=[7B18E860:01C276C5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:

> On Fri, 18 Oct 2002, Stephen Cameron wrote:
> 
[...]
> 
> > +		if (minor(inode->i_rdev) != 0) {
> > +			/* if not node 0 make sure it is a 
> partition = 0 */	
> > +			if (minor(inode->i_rdev) & 0x0f)
> > +				return -ENXIO;
> 
> That's bogus.  We call ->open() only for entire disk.

Ok. 

> 
> > +	kdev = mk_kdev(MAJOR_NR + ctlr, disk->first_minor);
> > +	bdev = bdget(kdev_t_to_nr(kdev));
> > +	rescan_partitions(disk, bdev);
> 
> ... and that is (a) obvious leak and 

Ok.  I thought it might be, but I wasn't sure.  
(I was able to imagine a way it might work
and not be a leak, as bdget appears to search through a list and only
alloc if it doesn't find it already there.)  But I don't have
anything like a complete understanding of bdget(), to state the
obvious.

< (b) broken unless disk is already open - it will try to do IO on bdev.

Hmm. It worked when I tried it (apart from the leak).  
Maybe the disk was already open.  The situation was that the
disk is there, (will respond to inquiry) but is reserved by
another host so read capacity will fail.  Maybe I was just
(un)lucky.  Anyway, I think you're saying there are situations
that I didn't try that don't work.  Ok, forget this patch.

> More interesting issue, though, is whether we need to bother with
> complications coming from that interface anymore.  Notice that
> comment re "too many device nodes" doesn't hold these days - that
> sort of stuff looks like a candidate for "write command into node
> on driverfs" - especially when we are talking about configuring
> the device, shutting disks down/starting them up, etc.  Linus, Pat?
> Unless I'm mistaken that's precisely the sort of work that is
> supposed to live in driverfs...
>

I haven't looked into driverfs too much yet.  (too much time
spent keeping up with the latest redhat/suse kernel, etc.)

Is there anything written up about it to help out driver
writers?  I'm not much looking forward to telling our ACU
and CIM guys they need to change all their apps to use
driverfs interfaces.  Also, I'm hoping driverfs is better
than /proc, in the sense that /proc tends to be read-only,
or write-only, unlike ioctl() where you can put in a complex 
input and get back a corresponding output.  With the likes of
/proc, you can write something in there, but how do you get
back a corresponding output?  Read it?  Some other thread
can race you for it?  (And if you're talking about shell 
scripts using it, then processes could race.) 

An ioctl-ish interface is superior for some applications.  
(not that the one that this patch
lamely attempts to implement is necessarily such an application,
but the array config utility definitely is.)  Hopefully
driverfs provides that kind of interface.

-- steve
