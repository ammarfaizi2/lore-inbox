Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUFNAnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUFNAnV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 20:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUFNAln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 20:41:43 -0400
Received: from holomorphy.com ([207.189.100.168]:31133 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261500AbUFNAkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 20:40:36 -0400
Date: Sun, 13 Jun 2004 17:40:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [7/12] Handle NO_SENSE in sd_rw_intr in sd.c
Message-ID: <20040614004034.GV1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040614003148.GO1444@holomorphy.com> <20040614003331.GP1444@holomorphy.com> <20040614003459.GQ1444@holomorphy.com> <20040614003605.GR1444@holomorphy.com> <20040614003708.GS1444@holomorphy.com> <20040614003835.GT1444@holomorphy.com> <20040614003929.GU1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614003929.GU1444@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 * Handle NO_SENSE in sd_rw_intr in drivers/scsi/sd.c (Alan Stern)
This fixes Debian BTS #232494.
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=232494

	Message-ID: <402C7AEF.6030206@post.cz>
	From: =?windows-1252?Q?Tonda_M=ED=9Aek?= <tonda.misek@post.cz>
	To: submit@bugs.debian.org
	Subject: mount not work for usb-storage with vfat

I have unstable Debian distribution.
The usb-storage device is USB flash disk.

mount -t vfat /dev/sda1 /ahd/

mount: /dev/sda1: can't read superblock
SCSI error: <1 0 0 0> return code 0x8000000
Current sda: sense key No sense
end_request: I/O error, dev sda, sector 32
FAT: unable to read boot sector

Moreover vfat driver not recognize mount option "isocharset=iso8859-2" 
at all.

With kernel 2.4.24 all works without problems

Index: linux-2.5/drivers/scsi/sd.c
===================================================================
--- linux-2.5.orig/drivers/scsi/sd.c	2004-06-13 11:57:24.000000000 -0700
+++ linux-2.5/drivers/scsi/sd.c	2004-06-13 12:08:56.000000000 -0700
@@ -770,6 +770,14 @@
 			 * hard error.
 			 */
 			print_sense("sd", SCpnt);
+			/* FALLS THROUGH */
+
+		case NO_SENSE:
+			/*
+			 * The low-level driver got the sense data but
+			 * everything was all right.  Don't treat this
+			 * as an error.
+			 */
 			SCpnt->result = 0;
 			SCpnt->sense_buffer[0] = 0x0;
 			good_bytes = this_count;
