Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVF0TAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVF0TAi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVF0TAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:00:38 -0400
Received: from usbb-lacimss1.unisys.com ([192.63.108.51]:61444 "EHLO
	usbb-lacimss1.unisys.com") by vger.kernel.org with ESMTP
	id S261591AbVF0TA3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:00:29 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Boot failure with roof file system under LVM (2.6.12-mm*)
Date: Mon, 27 Jun 2005 14:00:23 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C16@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Boot failure with roof file system under LVM (2.6.12-mm*)
Thread-Index: AcV7SnF506piLeHyTdChPOoQ5ovp1A==
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-lvm@redhat.com>, "E.Gryaznova" <grev@namesys.com>
X-OriginalArrivalTime: 27 Jun 2005 19:00:23.0830 (UTC) FILETIME=[79082360:01C57B4A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I cannot boot -mm kernel on my system since 2.6.12-rc5-mm1. The system
is a partition on ES7000 and has a dual boot for SuSE/RH, which is set
up using two LVM volumes. 

le020-p2:~ # pvs
PV         VG         Fmt  Attr PSize  PFree
/dev/sda2  stash      lvm2 a-   16.50G  3.50G
/dev/sdb2  rhel4stash lvm2 a-   16.50G 16.00M

The other partition on that system set up for dual boot also, but uses 2
disks directly without LVM, and boots just fine.

Last thing I see on the console during failed boot:
...
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal


I put little debug in and it turned out that the boot hangs while
waiting on a buffer in fs/reiserfs/super.c read_bitmaps() routine, on
second iteration of the following loop:

    for (i = 0; i < SB_BMAP_NR(s); i++) {
        wait_on_buffer(SB_AP_BITMAP (s)[i].bh);  <========waiting here
indefinitely
        if (!buffer_uptodate(SB_AP_BITMAP(s)[i].bh)) {
            reiserfs_warning(s,"sh-2029: reiserfs read_bitmaps: "
                         "bitmap block (#%lu) reading failed",
                         SB_AP_BITMAP(s)[i].bh->b_blocknr);
            for (i = 0; i < SB_BMAP_NR(s); i++)
                brelse(SB_AP_BITMAP(s)[i].bh);
            vfree(SB_AP_BITMAP(s));
            SB_AP_BITMAP(s) = NULL;
            return 1;
        }
        load_bitmap_info_data (s, SB_AP_BITMAP (s) + i);
    }

Thanks,
--Natalie 
