Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266751AbUBEVcS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266818AbUBEV3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:29:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:4029 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266881AbUBEV3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:29:13 -0500
Date: Thu, 5 Feb 2004 22:29:10 +0100
From: Jens Axboe <axboe@suse.de>
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Message-ID: <20040205212910.GH11683@suse.de>
References: <20040205203336.GE10547@stud.uni-erlangen.de> <20040205205421.GE11683@suse.de> <20040205211633.GH10547@stud.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205211633.GH10547@stud.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05 2004, Thomas Glanzmann wrote:
> > I still think this is to be expected when mucking in undefined teritory.
> > Reload the media, it's not hard... Sure you can get around this with
> > snooping if you really wanted to, but IMO it's wasted effort. Add -eject
> > to cdrecord command line of default config, how you want so solve it is
> > not my problem.
> 
> I don't understand why the Linux kernel doesn't simply invalidates the
> buffers when a CDROM media is unmounted. If this would be case no such
> problems would ever occur.

Actually, that would be an acceptable work around to me. The buffers are
invalidated in the block device page cache on last close, should be easy
enough to kill the driver private TOC cache as well.

===== drivers/ide/ide-cd.c 1.68 vs edited =====
--- 1.68/drivers/ide/ide-cd.c	Wed Feb  4 06:37:42 2004
+++ edited/drivers/ide/ide-cd.c	Thu Feb  5 22:28:50 2004
@@ -2860,6 +2860,10 @@
 static
 void ide_cdrom_release_real (struct cdrom_device_info *cdi)
 {
+	ide_drive_t *drive = cdi->handle;
+
+	if (!cdi->use_count)
+		CDROM_STATE_FLAGS(drive)->toc_valid = 0;
 }
 
 

-- 
Jens Axboe

