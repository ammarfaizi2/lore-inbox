Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWAMPYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWAMPYX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWAMPYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:24:23 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:4995 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964971AbWAMPYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:24:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=PFydtBxBvGA0rcvAslsWKH4L4KhnDlS2M90b8v7vsdAst0kZkombnDbDE1PIegDDYaWW/bbClxo2Sda1mp9xOHTwU3fLzQYef6tS+SVE1O3+b4Gr/n4woX8H55Bm2KZBjtMKhtoYSPlfPSt6ticGpAP/Jy0urFNl77XiYSr3nMU=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] block: fix PIO cache coherency bug
In-Reply-To: 
X-Mailer: git-send-email
Date: Sat, 14 Jan 2006 00:24:16 +0900
Message-Id: <11371658562541-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, bzolnier@gmail.com, rmk@arm.linux.org.uk,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all.

This patchset tries to fix data corruption bug caused by not handling
cache coherency during block PIO.  This patch implements
blk_kmap/unmap helpers which take extra @dir argument and perform
appropriate coherency actions.  These are to block PIO what dma_map/
unmap are to block DMA transfers.

IDE, libata, SCSI, rd and md are converted.  Still left are nbd, loop
and pktcddvd.  If I missed something, please let me know.

Russell, can you please test whether this fixes the bug on arm?  If
this fixes the bug and people agree with the approach, I'll follow up
with patches for yet unconverted drivers and documentation update.

 crypto/internal.h             |    1
 drivers/block/rd.c            |   20 ++++----
 drivers/ide/ide-floppy.c      |    8 +--
 drivers/ide/ide-taskfile.c    |    6 +-
 drivers/md/raid1.c            |   13 +++--
 drivers/md/raid5.c            |    9 ++-
 drivers/md/raid6main.c        |    9 ++-
 drivers/scsi/3w-9xxx.c        |    8 +--
 drivers/scsi/3w-xxxx.c        |    4 -
 drivers/scsi/aacraid/aachba.c |    4 -
 drivers/scsi/gdth.c           |    5 +-
 drivers/scsi/ide-scsi.c       |   14 +++--
 drivers/scsi/ips.c            |   21 +++++---
 drivers/scsi/iscsi_tcp.c      |    4 -
 drivers/scsi/libata-core.c    |   24 ++++++---
 drivers/scsi/libata-scsi.c    |    6 +-
 drivers/scsi/megaraid.c       |    8 ++-
 drivers/scsi/qlogicpti.c      |    5 +-
 drivers/scsi/scsi_debug.c     |   11 ++--
 drivers/scsi/scsi_lib.c       |    5 +-
 fs/bio.c                      |    5 --
 include/linux/bio.h           |   59 ------------------------
 include/linux/blkdev.h        |  101 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/highmem.h       |    2
 24 files changed, 213 insertions(+), 139 deletions(-)

Thanks.

--
tejun

