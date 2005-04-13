Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVDMKIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVDMKIV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 06:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVDMKIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 06:08:21 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41692 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261284AbVDMKIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 06:08:15 -0400
Date: Wed, 13 Apr 2005 12:07:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jim Carter <jimc@math.ucla.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disc driver is module, software suspend fails
Message-ID: <20050413100756.GK1361@elf.ucw.cz>
References: <Pine.LNX.4.61.0504101612240.10130@xena.cft.ca.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504101612240.10130@xena.cft.ca.us>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Ne 10-04-05 16:14:52, Jim Carter wrote:
> On Wed, 30 Mar 2005, Pavel Machek wrote: 
> > You do not want to mount journaling filesystems; they tend to write to
> > disks even during read-only mounts... But doing it from initrd should
> > be okay. ext2 and init=/bin/bash should do the trick, too.
> 
> I did give it a try -- successfully.  
> 
> For reference I recite the original issue: the driver for my primary
> disc is in the initrd, not hardwired.  (It's ata_piix and friends, but
> the same issue happens if you boot from RAID or other weird devices.  As
> modern systems tend to have a SATA disc, more and more people are
> complaining on the web that software suspend has stopped working after
> they upgraded their machines.)  software_suspend would suspend all the
> way, then immediately wake up having accomplished nothing (but broken
> nothing either).  In kernel 2.6.12-rc1 but not 2.6.8 it complains "can't
> find swap device".  If this safety check is unwisely overriden so a
> suspend image is written, and you then resume (providing the device by
> number), it fails to read the image using the driver which it hasn't
> loaded yet.

Yep.

> This patch makes software_resume not a late_initcall but rather an
> external subroutine similar to software_suspend, and calls it at the
> beginning of mount_root (in init/do_mounts.c), just _after_ the initrd
> (if any) and its driver have been seen.  This buried placement is needed
> because there are several flow paths that call mount_root, and otherwise
> each path would need to be monkeyed with.

But the patch is very dangerous. Unsuspecting users will see their
systems resumed after unsafe initrd is ran. It is okay for you,
through..

What you want to do si to audit your initrd, then add echo to
/sys/power/resume at the end...

> So, what do you think?  Can we bring the benefit of software suspend to
> systems with SATA or RAID boot discs?

Yes, but not this way. -rc2 already contains
/sys/power/resume... (Better documentation would be needed, through).
									Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
