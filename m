Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbTI1Du6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 23:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTI1Du6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 23:50:58 -0400
Received: from [24.76.142.122] ([24.76.142.122]:44294 "HELO
	signalmarketing.com") by vger.kernel.org with SMTP id S262316AbTI1Du4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 23:50:56 -0400
Date: Sat, 27 Sep 2003 22:50:54 -0500 (CDT)
From: Derek Foreman <manmower@signalmarketing.com>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: CDROM_SEND_PACKET oddity
In-Reply-To: <20030927175445.GI15415@suse.de>
Message-ID: <Pine.LNX.4.58.0309272200200.1850@uberdeity.signalmarketing.com>
References: <Pine.LNX.4.58.0309262131110.15317@uberdeity.signalmarketing.com>
 <20030927114712.GJ3416@suse.de> <20030927122703.GK3416@suse.de>
 <20030927175445.GI15415@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Sep 2003, Jens Axboe wrote:

> On Sat, Sep 27 2003, Jens Axboe wrote:
> > On Sat, Sep 27 2003, Jens Axboe wrote:
> > Actually, try this patch against current bk, it kills the
> > CDROM_SEND_PACKET setup and use SG_IO internally instead. Should be much
> > much better than what we have now. It's not tested here at all though,
> > I'd appreciate it if you could give it a go.
> 
> This has a better chance of working. Changes:
> 
> - Don't export sg_io() anyways (leftover)
> - Actually set ->cmdp and ->cmd_len
> 
> still untested.

[...]

> +			memcpy(hdr.cmdp, cgc.cmd, sizeof(cgc.cmd));

This breaks because hdr.cmdp is a pointer, not an array.

I think there has to be a hdr.mx_sb_len = sizeof(struct request_sense) in 
there too?

Also, this changes the semantics of CDROM_SEND_PACKET, currently if 
the command fails, it returns EIO, after the patch it succeeds.

how's this incremental patch?  It seems to work as I expect it to.

--- scsi_ioctl.c.orig	2003-09-27 22:45:40.708105384 -0500
+++ scsi_ioctl.c	2003-09-27 22:46:23.490917249 -0500
@@ -479,10 +479,14 @@
 			hdr.dxferp = cgc.buffer;
 			hdr.sbp = (char *) cgc.sense;
 			hdr.timeout = cgc.timeout;
-			memcpy(hdr.cmdp, cgc.cmd, sizeof(cgc.cmd));
+			hdr.cmdp = (unsigned char *)arg
+			         + offsetof(struct cdrom_generic_command, cmd);
+			hdr.mx_sb_len = sizeof(struct request_sense);
 			hdr.cmd_len = sizeof(cgc.cmd);
 			err = sg_io(q, bdev, &hdr);
 
+			if (hdr.status)
+				err = -EIO;
 			cgc.stat = err;
 			cgc.buflen = hdr.resid;
 			if (copy_to_user((struct cdrom_generic_command *) arg, &cgc, sizeof(cgc)))
