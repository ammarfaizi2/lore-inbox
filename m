Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262876AbSKMUyA>; Wed, 13 Nov 2002 15:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbSKMUyA>; Wed, 13 Nov 2002 15:54:00 -0500
Received: from ns.splentec.com ([209.47.35.194]:4877 "EHLO pepsi.splentec.com")
	by vger.kernel.org with ESMTP id <S262876AbSKMUx4>;
	Wed, 13 Nov 2002 15:53:56 -0500
Message-ID: <3DD2BD7C.ABCA9350@splentec.com>
Date: Wed, 13 Nov 2002 16:00:44 -0500
From: Luben Tuikov <luben@splentec.com>
Organization: Splentec Ltd.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 3w-xxxx: additional ata->sense codes, avoid driver lockup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few of our IDE hds were generating those errors.

The first one locks up the 3w-xxxx driver (into an inf. loop)
when the error register = 0x11; this also resulted sometimes
in kernel lockup, also when doing raidstop...

The second one (0x51 move) is for completely broken
sectors/medium -- this makes SCSI core figure this one out
quickly and do the appropriate action, rather than retry
the command several times + timeout, of course without
success.

For the status byte, we're more generous (actually only interested
in the error bit); if found, good, else the effect is the same.

-- 
Luben

--- linux-2.5.47/drivers/scsi/3w-xxxx.h Sun Nov 10 22:28:06 2002
+++ linux/drivers/scsi/3w-xxxx.h        Wed Nov 13 15:07:28 2002
@@ -108,7 +108,9 @@
   {0x01, 0x03, 0x13, 0x00}, // Address mark not found       Address mark not found for data field
   {0x04, 0x0b, 0x00, 0x00}, // Aborted command              Aborted command
   {0x10, 0x0b, 0x14, 0x00}, // ID not found                 Recorded entity not found
+  {0x11, 0x0b, 0x12, 0x00}, // Address Mark Not Found       Address Mark Not Found For ID Field
   {0x40, 0x03, 0x11, 0x00}, // Uncorrectable ECC error      Unrecovered read error
+  {0x51, 0x03, 0x31, 0x00}, // Uncorrectable Data Error     Medium Format Corrupted  
   {0x61, 0x04, 0x00, 0x00}, // Device fault                 Hardware error
   {0x84, 0x0b, 0x47, 0x00}, // Data CRC error               SCSI parity error
   {0xd0, 0x0b, 0x00, 0x00}, // Device busy                  Aborted command
@@ -118,7 +120,6 @@
                             // 3ware Error                  SCSI Error
   {0x09, 0x0b, 0x00, 0x00}, // Unrecovered disk error       Aborted command
   {0x37, 0x0b, 0x04, 0x00}, // Unit offline                 Logical unit not ready
-  {0x51, 0x0b, 0x00, 0x00}  // Unspecified                  Aborted command
 };
 
 /* Control register bit definitions */
--- linux-2.5.47/drivers/scsi/3w-xxxx.c Sun Nov 10 22:28:30 2002
+++ linux/drivers/scsi/3w-xxxx.c        Wed Nov 13 15:07:28 2002
@@ -716,7 +716,7 @@
 
        /* Attempt to return intelligent sense information */
        if (fill_sense) {
-               if ((command->status == 0xc7) || (command->status == 0xcb)) {
+               if (command->status & 0xC1) {
                        for (i=0;i<(sizeof(tw_sense_table)/sizeof(tw_sense_table[0]));i++) {
                                if (command->flags == tw_sense_table[i][0]) {
