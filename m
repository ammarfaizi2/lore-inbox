Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVDNUoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVDNUoG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 16:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVDNUoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 16:44:05 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43964 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261565AbVDNUmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 16:42:23 -0400
Date: Thu, 14 Apr 2005 22:42:07 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jim Carter <jimc@math.ucla.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disc driver is module, software suspend fails
Message-ID: <20050414204207.GG2801@elf.ucw.cz>
References: <Pine.LNX.4.61.0504101612240.10130@xena.cft.ca.us> <20050413100756.GK1361@elf.ucw.cz> <Pine.LNX.4.61.0504141023240.6214@simba.math.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504141023240.6214@simba.math.ucla.edu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > > This patch makes software_resume not a late_initcall but rather an
> > > external subroutine similar to software_suspend, and calls it at the
> > > beginning of mount_root (in init/do_mounts.c), just _after_ the initrd
> > > (if any) and its driver have been seen....
> > 
> > But the patch is very dangerous. Unsuspecting users will see their
> > systems resumed after unsafe initrd is ran. It is okay for you,
> > through..
> > 
> > What you want to do si to audit your initrd, then add echo to
> > /sys/power/resume at the end...
> 
> I think you expressed similar reservations earlier but I'm not sure if I 
> understand what your issue is.  Are you saying (please let me know which if 
> any of these threats are the ones that concern you):
> 
> 1.  If the initrd mounted any filesystem read-write, or any journalled 
> filesystem, and left it mounted, that would be bad.

Yes. (Note that mounting in the first place is the problem. Even if
you umount it, you already did some changes on disk, BAD).

> 2.  If the initrd started an ordinary process (or a kernel thread?) and 
> left it running, that would be bad.  The ata_piix driver really does 
> create a kernel thread, though I believe it exists only during actual data 
> transfer.

Should not be a problem with new refrigerator setup.

> 3.  The initrd is copied into a ramdisc which is then mounted.  It's still 
> mounted when software_resume is called (as the patch is arranged presently, 
> or if the initrd does "echo resume > /sys/power/state"), and jimc isn't too 
> sure where the ramdisc's memory goes at that point.

Should not me a problem.

> I was hoping to have a single point in the boot-up code where 
> software_resume happened, rather than multiple places or, heaven forbid,
> calling it repeatedly at various steps in the boot process.  I think we can 
> justify some effort to avoid the situation where software_resume is called 
> before initrd loading, and it sometimes refuses to load the image, and then 
> is called again by the initrd.  

I don't see why calling it repeatedly would be that bad. In fact, it
is what we are doing just now. You can try to resume as many times as
you wish (by echo resume...), but obviously at most one of those will
succeed.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
