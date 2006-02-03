Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWBCJUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWBCJUd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 04:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWBCJUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 04:20:33 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:60806 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932156AbWBCJUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 04:20:32 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: adding swap workarounds oom - was: Re: Out of Memory: Killed
	process 16498 (java).
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Andy Chittenden <AChittenden@bluearc.com>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, linux-kernel@vger.kernel.org, lwoodman@redhat.com
In-Reply-To: <1138372797.22112.44.camel@imp.csi.cam.ac.uk>
References: <89E85E0168AD994693B574C80EDB9C2703556694@uk-email.terastack.bluearc.com>
	 <20060127142146.GN4311@suse.de>
	 <1138372797.22112.44.camel@imp.csi.cam.ac.uk>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Fri, 03 Feb 2006 09:20:09 +0000
Message-Id: <1138958409.3828.9.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-01-27 at 14:39 +0000, Anton Altaparmakov wrote:
> A colleague has a server (which does backups) that is incapable of doing
> a backup due to the backup process being killed due to OOM after
> anywhere between 30s and a few minutes of running...  And the backup
> process is just a simple program that does the equivalent of "dd with
> one source but two destinations" where the source is an lvm/dm snapshot
> and the two destinations are two different tape drives attached via
> scsi.  That is pretty critical, admittedly only to us and that system...

We found a workaround for the OOM problems on above server yesterday.  

Add a 1MiB swap file:

dd if=/dev/zero of=/var/swapfile bs=1024 count=1024
mkswap /var/swapfile
swapon /var/swapfile

Run backup script and no problems!

Note: This is a suse SLES9 system and the problem is not present on
kernel kernel-smp-2.6.5-7.193.i586.rpm and all earlier kernels and it is
present on kernel-smp-2.6.5-7.201.i586.rpm and all later kernels
including the latest kernel (2.6.5-7.244).

Seems like a definite VM bug...  Interestingly on the .244 kernel the
OOM conditions print out a lot of debug information to dmesg about the
memory use in the system and AFAICS none of the memory is exhausted!  So
it seems the system goes OOM without it actually being OOM because it
detects that "free swap == 0" or something along those lines...

Or do we nowadays require swap to be present?

The machine has 6GiB RAM so swap was turned off on it.  (In our
experience if a machine with a lot of concurrent connections starts
swapping the system goes down the drain (it becomes too slow) so swap is
not something we want on servers with 40000+ users...)

If the above is not enough information to find/fix the problem please
let me know what more you would like to know...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

