Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbSJ3VIs>; Wed, 30 Oct 2002 16:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264934AbSJ3VIr>; Wed, 30 Oct 2002 16:08:47 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:42903 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264932AbSJ3VIo>; Wed, 30 Oct 2002 16:08:44 -0500
Date: Wed, 30 Oct 2002 16:17:06 -0500
From: Doug Ledford <dledford@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] SCSI and FibreChannel Hotswap for linux 2.5.44-bk2
Message-ID: <20021030211706.GA23217@redhat.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Steven Dake <sdake@mvista.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-scsi@vger.kernel.org
References: <1036007128.5141.119.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0210301127170.7614-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210301127170.7614-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 11:29:18AM -0800, Linus Torvalds wrote:
> 
> On 30 Oct 2002, Alan Cox wrote:
> >
> > On Wed, 2002-10-30 at 18:54, Steven Dake wrote:
> > > This patch has been reviewed by Alan Cox, Greg KH, Christoph Hellwig, 
> > > Patrick Mansfield, Rob Landly, Jeff Garzik, Scott Murray, James 
> > 
> > Glanced at briefly once, not reviewed.
> 
> I'm going to leave the merging of this to the scsi people, in particular 
> James and Doug. My personal feeling right now is that it's not going in 
> the feature freeze, but as a driver thing I'm also convinced that 
> especially if vendors need it, they'll add it anyway - and drivers tend to 
> be less "frozen" than core code anyway (by necessity: we've always had to 
> accept new drivers even in stable series).

My personal view is that it might be a candidate for inclusion in the 
future, but not in the current version.  Several valid points have been 
raised by other people, so I'll not rehash those.  Some of my own points 
include the fact that I detest the locking scheme this thing uses.

If you look at scsi_hotswap_insert_by_scsi_id() you see this:

down_interruptible (&scsi_host->host_queue_sema)
  walk scsi_host->host_queue looking for a device with same id
up (&scsi_host->host_queue_sema)
did we find a device?  If so, return, else call scan_scsis()

The problem is that scan_scsis() is where we would actually add the device 
to the scsi_host->host_queue and it's not inside the lock, so putting the 
check inside of a lock is a total waste of time.  To prevent against races 
on insertion, you would need to, in the case that no device was present, 
add a device to the host_queue *while still holding the lock* in order to 
keep a second invocation of insert_by_scsi_id() from attempting to add the 
same device twice.  Specifically, I'm thinking that a fiber channel 
controller that has a device flutter on and off the fiber bus can easily 
hit this problem.  Imagine if you will:

fiber loop notices new device come up
  driver calls insert_by_scsi_id to add drive
    insert calls scan_scsis() to scan device
before scan completes drive flutters back off the fiber
  driver calls remove_by_scsi_id
    remove code doesn't find a valid device because original scan_scsis 
    hasn't added it yet
drive comes back on fiber
  driver calls insert_by_scsi_id
    the check for drive present shows us clear because original scan_scsis
    hasn't added drive yet, so we call scan_scsis() again
we are now trying to scan drive in two different threads of execution, no 
locking against double addition of the same device, boom.

Nope, it's not there yet.


-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
