Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVDNRyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVDNRyJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 13:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVDNRyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 13:54:09 -0400
Received: from simba.math.ucla.edu ([128.97.4.125]:13441 "EHLO
	simba.math.ucla.edu") by vger.kernel.org with ESMTP id S261574AbVDNRyD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 13:54:03 -0400
Date: Thu, 14 Apr 2005 10:53:59 -0700 (PDT)
From: Jim Carter <jimc@math.ucla.edu>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disc driver is module, software suspend fails
In-Reply-To: <20050413100756.GK1361@elf.ucw.cz>
Message-ID: <Pine.LNX.4.61.0504141023240.6214@simba.math.ucla.edu>
References: <Pine.LNX.4.61.0504101612240.10130@xena.cft.ca.us>
 <20050413100756.GK1361@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2005, Pavel Machek wrote:

> > This patch makes software_resume not a late_initcall but rather an
> > external subroutine similar to software_suspend, and calls it at the
> > beginning of mount_root (in init/do_mounts.c), just _after_ the initrd
> > (if any) and its driver have been seen....
> 
> But the patch is very dangerous. Unsuspecting users will see their
> systems resumed after unsafe initrd is ran. It is okay for you,
> through..
> 
> What you want to do si to audit your initrd, then add echo to
> /sys/power/resume at the end...

I think you expressed similar reservations earlier but I'm not sure if I 
understand what your issue is.  Are you saying (please let me know which if 
any of these threats are the ones that concern you):

1.  If the initrd mounted any filesystem read-write, or any journalled 
filesystem, and left it mounted, that would be bad.

2.  If the initrd started an ordinary process (or a kernel thread?) and 
left it running, that would be bad.  The ata_piix driver really does 
create a kernel thread, though I believe it exists only during actual data 
transfer.

3.  The initrd is copied into a ramdisc which is then mounted.  It's still 
mounted when software_resume is called (as the patch is arranged presently, 
or if the initrd does "echo resume > /sys/power/state"), and jimc isn't too 
sure where the ramdisc's memory goes at that point.


I was hoping to have a single point in the boot-up code where 
software_resume happened, rather than multiple places or, heaven forbid,
calling it repeatedly at various steps in the boot process.  I think we can 
justify some effort to avoid the situation where software_resume is called 
before initrd loading, and it sometimes refuses to load the image, and then 
is called again by the initrd.  

Suppose software_resume (after the initrd) does an audit, and refuses to 
load the image if there's a problem?  Or even better, if all it needs is to 
unmount filesystems, it should just do that and load the image.  Is this 
the right way to proceed?

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
