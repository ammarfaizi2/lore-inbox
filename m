Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267837AbUHPSOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267837AbUHPSOf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 14:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267855AbUHPSOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 14:14:34 -0400
Received: from av1-1-sn4.m-sp.skanova.net ([81.228.10.116]:13495 "EHLO
	av1-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S267837AbUHPSOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 14:14:09 -0400
To: "Tony A. Lambley" <tal@vextech.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: growisofs stopped working with 2.6.8
References: <1092674287.3021.19.camel@bony>
	<1092672062.20838.29.camel@localhost.localdomain>
	<1092679156.2393.8.camel@bony>
From: Peter Osterlund <petero2@telia.com>
Date: 16 Aug 2004 20:14:02 +0200
In-Reply-To: <1092679156.2393.8.camel@bony>
Message-ID: <m3ekm7osr9.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Tony A. Lambley" <tal@vextech.net> writes:

> It still fails, but I get a different message with the patch:
> 
> $ growisofs -Z /dev/dvd=file.iso
> Executing 'builtin_dd if=file.iso of=/dev/dvd obs=32k seek=0'
> :-( unable to PREVENT MEDIA REMOVAL: Operation not permitted
> 
> K3B fails with the same message as above.
> 
> As you say, it does indeed burn fine as root.

The patch below is needed for a start, but it's not enough, because
growisofs opens the device in read-only mode, so WRITE_10 fails
anyway.

--- drivers/block/scsi_ioctl.c~cdrw-filter	2004-08-16 17:13:23.000000000 +0200
+++ drivers/block/scsi_ioctl.c	2004-08-16 18:44:15.000000000 +0200
@@ -146,6 +146,13 @@
 		safe_for_read(GPCMD_READ_TOC_PMA_ATIP),
 		safe_for_read(GPCMD_REPORT_KEY),
 		safe_for_read(GPCMD_SCAN),
+		safe_for_read(GPCMD_GET_CONFIGURATION),
+		safe_for_read(GPCMD_READ_FORMAT_CAPACITIES),
+		safe_for_read(GPCMD_GET_EVENT_STATUS_NOTIFICATION),
+		safe_for_read(GPCMD_GET_PERFORMANCE),
+
+		safe_for_write(GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL),
+		safe_for_write(GPCMD_FLUSH_CACHE),
 
 		/* Basic writing commands */
 		safe_for_write(WRITE_6),

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
