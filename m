Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWBCLCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWBCLCr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 06:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWBCLCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 06:02:47 -0500
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:2027 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932257AbWBCLCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 06:02:46 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: adding swap workarounds oom - was: Re: Out of Memory: Killed
	process 16498 (java).
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, AChittenden@bluearc.com, davej@redhat.com,
       linux-kernel@vger.kernel.org, lwoodman@redhat.com
In-Reply-To: <20060203012607.0a9d6730.akpm@osdl.org>
References: <89E85E0168AD994693B574C80EDB9C2703556694@uk-email.terastack.bluearc.com>
	 <20060127142146.GN4311@suse.de>
	 <1138372797.22112.44.camel@imp.csi.cam.ac.uk>
	 <1138958409.3828.9.camel@imp.csi.cam.ac.uk>
	 <20060203012607.0a9d6730.akpm@osdl.org>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Fri, 03 Feb 2006 11:01:44 +0000
Message-Id: <1138964504.3828.18.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-03 at 01:26 -0800, Andrew Morton wrote:
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> > On Fri, 2006-01-27 at 14:39 +0000, Anton Altaparmakov wrote:
> > > A colleague has a server (which does backups) that is incapable of doing
> > > a backup due to the backup process being killed due to OOM after
> > > anywhere between 30s and a few minutes of running...  And the backup
> > > process is just a simple program that does the equivalent of "dd with
> > > one source but two destinations" where the source is an lvm/dm snapshot
> > > and the two destinations are two different tape drives attached via
> > > scsi.  That is pretty critical, admittedly only to us and that system...
> > 
> > We found a workaround for the OOM problems on above server yesterday.  
> > 
> > Add a 1MiB swap file:
> > 
> > dd if=/dev/zero of=/var/swapfile bs=1024 count=1024
> > mkswap /var/swapfile
> > swapon /var/swapfile
> > 
> > Run backup script and no problems!
> > 
> > Note: This is a suse SLES9 system and the problem is not present on
> > kernel kernel-smp-2.6.5-7.193.i586.rpm and all earlier kernels and it is
> > present on kernel-smp-2.6.5-7.201.i586.rpm and all later kernels
> > including the latest kernel (2.6.5-7.244).
> > 
> > Seems like a definite VM bug...  Interestingly on the .244 kernel the
> > OOM conditions print out a lot of debug information to dmesg about the
> > memory use in the system and AFAICS none of the memory is exhausted!  So
> > it seems the system goes OOM without it actually being OOM because it
> > detects that "free swap == 0" or something along those lines...
> 
> It does sound like that.  Does it still happen if there's 1MB of swap
> online and it's all full?
> 
> > Or do we nowadays require swap to be present?
> 
> Shouldn't be the case.
> 
> > The machine has 6GiB RAM so swap was turned off on it.  (In our
> > experience if a machine with a lot of concurrent connections starts
> > swapping the system goes down the drain (it becomes too slow) so swap is
> > not something we want on servers with 40000+ users...)
> 
> 1MB of swap isn't likely to cause a lot of swapping.   
> 
> > If the above is not enough information to find/fix the problem please
> > let me know what more you would like to know...
> 
> It'd be nice to see the oom-killer output.
> 
> I don't recall a problem like this.  I wonder if there are any suse changes
> which might have triggered it.

Yes, I think it is suse.  I just diffed /mm of both the above kernels
(.193 and .201) and I think there is a little typo which probably causes
the problem.  It is mm/vmscan.c::shrink_zone():

@@ -845,19 +845,38 @@ shrink_zone(struct zone *zone, int max_s
        }

        atomic_add(scan_active + 1, &zone->nr_scan_active);
-       count = atomic_read(&zone->nr_scan_active);
-       if (count >= SWAP_CLUSTER_MAX) {
+       nr_active = atomic_read(&zone->nr_scan_active);
+       if (nr_active >= SWAP_CLUSTER_MAX)
                atomic_set(&zone->nr_scan_active, 0);
-               refill_inactive_zone(zone, count, ps, can_free_mapped);
-       }
+       else
+               nr_active = 0;

        atomic_add(max_scan, &zone->nr_scan_inactive);
-       count = atomic_read(&zone->nr_scan_inactive);
-       if (count >= SWAP_CLUSTER_MAX) {
+       nr_inactive = atomic_read(&zone->nr_scan_inactive);
+       if (nr_active >= SWAP_CLUSTER_MAX)
            ^^^^^^^^^ Should be nr_inactive I think.

Comparing to code in current linux-2.6.git/mm/vmscan.c confirms that it
should be nr_inactive.

                atomic_set(&zone->nr_scan_inactive, 0);
-               return shrink_cache(zone, gfp_mask, count, total_scanned, can_free_mapped);
+       else
+               nr_inactive = 0;

Jens, given you have an @suse email address, do you want to kick whoever
deals with this in novel/suse so it gets fixed in the next sles9 kernel
update?

Don't know if this fixes our OOM problem but it is a typo in any case.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

