Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268144AbUH0V2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268144AbUH0V2P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 17:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268135AbUH0VX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 17:23:57 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:59657 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268050AbUH0VU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 17:20:56 -0400
Message-ID: <9ac707cb04082714203a7fa919@mail.gmail.com>
Date: Fri, 27 Aug 2004 17:20:55 -0400
From: Peter Jones <pmjones@gmail.com>
Reply-To: Peter Jones <pmjones@gmail.com>
To: peter.schaefer@gmx.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] SCSI command filter: Add cdparanoia to the list
In-Reply-To: <412B96EF.3060900@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <412B96EF.3060900@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004 21:28:47 +0200, Peter Schaefer
<peter.schaefer@gmx.de> wrote:
> Hello!
> 
> Following the discus^H^H^H flamewar about cdrecord, scsi command
> filter et al, i just want to add that ripping audio CDs seems
> to be affected by the SCSI filter also. I'm not able to use
> my SCSI CDRW drive for that anymore (except being root) and
> have to resort to my (ATAPI) DVD drive.

Right you are.  The commands cdparanoia uses are:

TEST_UNIT_READY
INQUIRY
MODE_SELECT
MODE_SENSE
READ_10
READ_12
READ_TOC
MODE_SELECT_10
MODE_SENSE_10
GPCMD_READ_CD
GPCMD_READ_CD_MSF
0xD4 (10-byte read on old Sony and NEC drives)
0xD4 (12-byte read on some old drives)
0xD5 (10-byte read on some old drives)
0xD8 (12-byte read on some old drives)
0xE5 (10-byte read on Creative/Acer cdd522,525,620,622)

For 0xD4/0xD5/0xD8, I'm not particularly sure which drives require
them; cdparanoia currently takes a heuristic approach to detecting the
available command set, and the data for what drives they come from
isn't in the code.

MODE_SELECT is used to set the block size for reads, as is MODE_SELECT_10.

For all but the MODE_SELECT ones, there's a patch below, but it's all
for vendor-specific commands.  For the mode selects, we're either
going to need some sort of device class mechanism, or for these to be
modifiable at boot time by userland.  Or, of course, startup/login
scripts can just give your user +w on the device if it knows its a CD
drive.

I'm not a big fan of having the vendor-specific commands here either,
but there's not a better way right now.  I imagine this patch will be
vetoed for security concerns because of them.

===== drivers/block/scsi_ioctl.c 1.55 vs edited =====
--- 1.55/drivers/block/scsi_ioctl.c     2004-08-24 09:10:37 -04:00
+++ edited/drivers/block/scsi_ioctl.c   2004-08-27 17:15:49 -04:00
@@ -130,6 +130,10 @@
                safe_for_read(GPCMD_VERIFY_10),
                safe_for_read(VERIFY_16),
                safe_for_read(READ_BUFFER),
+               safe_for_read(D4_READ_10_12),
+               safe_for_read(D5_READ_10),
+               safe_for_read(D8_READ_12),
+               safe_for_read(CREATIVE_READ_10),
  
                /* Audio CD commands */
                safe_for_read(GPCMD_PLAY_CD),
===== include/scsi/scsi.h 1.23 vs edited =====
--- 1.23/include/scsi/scsi.h    2004-08-14 07:38:42 -04:00
+++ edited/include/scsi/scsi.h  2004-08-27 17:15:51 -04:00
@@ -103,8 +103,12 @@
 #define SEARCH_HIGH_12        0xb0
 #define SEARCH_EQUAL_12       0xb1
 #define SEARCH_LOW_12         0xb2
-#define READ_ELEMENT_STATUS   0xb8
 #define SEND_VOLUME_TAG       0xb6
+#define READ_ELEMENT_STATUS   0xb8
+#define D4_READ_10_12         0xd4
+#define D5_READ_10            0xd5
+#define D8_READ_12            0xd8
+#define CREATIVE_READ_10      0xe5
 #define WRITE_LONG_2          0xea
 #define READ_16               0x88
 #define WRITE_16              0x8a
