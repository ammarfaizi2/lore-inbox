Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316883AbSHaJJx>; Sat, 31 Aug 2002 05:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316880AbSHaJJx>; Sat, 31 Aug 2002 05:09:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:62186 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316614AbSHaJJu>;
	Sat, 31 Aug 2002 05:09:50 -0400
Date: Sat, 31 Aug 2002 11:14:01 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Patrick Mansfield <patmans@us.ibm.com>,
       Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org,
       Gerrit Huizenga <gerrit@us.ibm.com>,
       Hans-J Tannenberger <hjt@us.ibm.com>,
       Janet Morgan <janetmor@us.ibm.com>, Mike Anderson <andmike@us.ibm.com>,
       Martin Bligh <mjbligh@us.ibm.com>, linux-scsi@vger.kernel.org
Subject: Re: 2.5.32 IO performance issues
Message-ID: <20020831091401.GG1056@suse.de>
References: <3D6E6B64.66203783@zip.com.au> <200208292055.g7TKte224951@eng2.beaverton.ibm.com> <20020829145342.A25892@eng2.beaverton.ibm.com> <3D6E9EDC.ED1E546C@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D6E9EDC.ED1E546C@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29 2002, Andrew Morton wrote:
> > We want to allow high mem for block devices other than SCSI direct access
> > devices (TYPE_DISK), such as CD ROM (SDpnt->type TYPE_ROM), WORM devices
> > (TYPE_WORM), and optical disks (TYPE_MOD).
> > 
> > So it is better to patch scsi_initialize_merge_fn:
> > 
> > --- 1.16/drivers/scsi/scsi_merge.c      Fri Jul  5 09:43:00 2002
> > +++ edited/drivers/scsi/scsi_merge.c    Thu Aug 29 14:30:12 2002
> > @@ -140,7 +140,7 @@
> >          * Enable highmem I/O, if appropriate.
> >          */
> >         bounce_limit = BLK_BOUNCE_HIGH;
> > -       if (SHpnt->highmem_io && (SDpnt->type == TYPE_DISK)) {
> > +       if (SHpnt->highmem_io) {
> >                 if (!PCI_DMA_BUS_IS_PHYS)
> >                         /* Platforms with virtual-DMA translation
> >                          * hardware have no practical limit.
> > 
> 
> That will certainly fix it.  But who added the TYPE_DISK check,
> and why???

I guess that block-highmem has been around long enough, that I can use
the term 'historically' at least in the kernel sense :-)

This extra check was added for IDE because each device type driver
(ide-disk, ide-cd, etc) needed to be updated to not assume virtual
mappings of request data was valid. I only did that for ide-disk, since
this is the only one where bounce buffering really hurt performance
wise. So while ide-cd and ide-tape etc could have been updated, I deemed
it uninteresting and not worthwhile.

Now, this was just carried straight into the scsi counter parts,
conveniently, because of laziness. A quick glance at sr shows that it
too can aviod bouncing easily (no changes needed). st may need some
changes, though. So again, for scsi it was a matter of not impacting
existing code in 2.4 too much.

So TYPE_DISK check can be killed in 2.5 if someone does the work of
checking that it is safe. I'm not so sure it will make eg your SCSI
CD-ROM that much faster :-)

-- 
Jens Axboe

