Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279307AbRJWHc1>; Tue, 23 Oct 2001 03:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279308AbRJWHcS>; Tue, 23 Oct 2001 03:32:18 -0400
Received: from fe090.worldonline.dk ([212.54.64.152]:52748 "HELO
	fe090.worldonline.dk") by vger.kernel.org with SMTP
	id <S279307AbRJWHcG>; Tue, 23 Oct 2001 03:32:06 -0400
Date: Tue, 23 Oct 2001 09:32:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Ken Ashcraft <kash@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [CHECKER] Probable Security Errors in 2.4.12-ac3
Message-ID: <20011023093230.I638@suse.de>
In-Reply-To: <Pine.GSO.4.33.0110202220470.963-100000@saga5.Stanford.EDU>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0110202220470.963-100000@saga5.Stanford.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 20 2001, Ken Ashcraft wrote:
> ---------------------------------------------------------
> [BUG] needs upper bound
> /home/kash/linux/2.4.12/drivers/cdrom/cdrom.c:2019:mmc_ioctl: ERROR:RANGE:2012:2019: [LOOP] Looping on user length "nr" set by 'copy_from_user':2018 [linkages -> 2018:nr=nframes -> 2012:ra:start] [distance=26]
> 			lba = ra.addr.lba;
> 		else
> 			return -EINVAL;
> 
> 		/* FIXME: we need upper bound checking, too!! */
> Start --->
> 		if (lba < 0 || ra.nframes <= 0)
> 			return -EINVAL;
> 
> 		/*
> 		 * start with will ra.nframes size, back down if alloc fails
> 		 */
> 		nr = ra.nframes;
> Error --->
> 		do {
> 			cgc.buffer = kmalloc(CD_FRAMESIZE_RAW * nr, GFP_KERNEL);
> 			if (cgc.buffer)
> 				break;

Here's a fix for that. Linus, please apply.

-- 
Jens Axboe


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=cd-cdda-1

--- drivers/cdrom/cdrom.c~	Tue Oct 23 09:28:35 2001
+++ drivers/cdrom/cdrom.c	Tue Oct 23 09:29:23 2001
@@ -2009,7 +2009,7 @@
 			return -EINVAL;
 
 		/* FIXME: we need upper bound checking, too!! */
-		if (lba < 0 || ra.nframes <= 0)
+		if (lba < 0 || ra.nframes <= 0 || ra.nframes > 64)
 			return -EINVAL;
 
 		/*

--J2SCkAp4GZ/dPZZf--
