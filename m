Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbUB2Clj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 21:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbUB2Clj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 21:41:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33711 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261973AbUB2Clh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 21:41:37 -0500
Message-ID: <40415152.8040205@pobox.com>
Date: Sat, 28 Feb 2004 21:41:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Jens Axboe <axboe@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Worrisome IDE PIO transfers...
References: <4041232C.7030305@pobox.com> <200402290121.30498.bzolnier@elka.pw.edu.pl> <20040229015041.GQ3883@waste.org>
In-Reply-To: <20040229015041.GQ3883@waste.org>
Content-Type: multipart/mixed;
 boundary="------------000808010306040804000800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000808010306040804000800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Matt Mackall wrote:
> On Sun, Feb 29, 2004 at 01:21:30AM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
>>I like Alan's idea to use loopback instead of "bswap".
> 
> 
> Or, more likely, device mapper.


Somehow I doubt anybody cares enough to write a whole driver just for 
this unlikely case.

For now let's at least record the knowledge...  (patch attached)

	Jeff



--------------000808010306040804000800
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/ide/ide-taskfile.c 1.28 vs edited =====
--- 1.28/drivers/ide/ide-taskfile.c	Thu Feb 26 12:11:20 2004
+++ edited/drivers/ide/ide-taskfile.c	Sat Feb 28 21:18:27 2004
@@ -29,6 +29,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/compiler.h>
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
@@ -81,7 +82,12 @@
 
 void taskfile_output_data (ide_drive_t *drive, void *buffer, u32 wcount)
 {
-	if (drive->bswap) {
+	if (unlikely(drive->bswap)) {
+		/* FIXME: Besides the inefficiency each sector
+		 * twice, this can lead to data corruption on
+		 * SMP.  Fortunately drives that need this swapping
+		 * are quite uncommon.
+		 */
 		ata_bswap_data(buffer, wcount);
 		HWIF(drive)->ata_output_data(drive, buffer, wcount);
 		ata_bswap_data(buffer, wcount);

--------------000808010306040804000800--

