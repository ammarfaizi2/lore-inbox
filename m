Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbUKCJKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbUKCJKy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 04:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbUKCJJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 04:09:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63143 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261499AbUKCJGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 04:06:21 -0500
Date: Wed, 3 Nov 2004 10:05:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: still no cd/dvd burning as user with 2.6.9
Message-ID: <20041103090550.GG10434@suse.de>
References: <41889857.5040506@tequila.co.jp> <20041103084330.GB10434@suse.de> <41889EB5.3060304@tequila.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41889EB5.3060304@tequila.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03 2004, Clemens Schwaighofer wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 11/03/2004 05:43 PM, Jens Axboe wrote:
> 
> > It should work, are the permissions on your device file correct?
> 
> that was the first thing I checked:
> 
> gullevek@pluto:~$ ls -l /dev/scd3
> brw-rw----  1 root cdrom 11, 3 2004-04-30 09:28 /dev/scd3
> 
> then I thought I am not in the right group:
> 
> gullevek@pluto:~$ groups
> users disk cdrom audio operator video staff games
> 
> but I am ...
> 
> I haven't tried to write a CD, but DVD is definilty not possible,
> because the device is _not_ listed in k3b if started as user. The
> internal CD writer is, so probably I can write here, because before,
> this wasn't even listed ...

Try with this debug patch so we can see if it rejects command it should
not.

===== drivers/block/scsi_ioctl.c 1.57 vs edited =====
--- 1.57/drivers/block/scsi_ioctl.c	2004-10-19 08:06:58 +02:00
+++ edited/drivers/block/scsi_ioctl.c	2004-11-03 10:05:20 +01:00
@@ -220,8 +220,10 @@
 		return -EINVAL;
 	if (copy_from_user(cmd, hdr->cmdp, hdr->cmd_len))
 		return -EFAULT;
-	if (verify_command(file, cmd))
+	if (verify_command(file, cmd)) {
+		printk(KERN_ERR "rejected command %x\n", cmd[0]);
 		return -EPERM;
+	}
 
 	/*
 	 * we'll do that later

-- 
Jens Axboe

