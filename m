Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264629AbUGBO6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbUGBO6n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 10:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264633AbUGBO6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 10:58:43 -0400
Received: from av3-2-sn4.m-sp.skanova.net ([81.228.10.113]:64663 "EHLO
	av3-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S264629AbUGBO6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 10:58:37 -0400
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] DVD+RW support for 2.6.7-bk13
References: <m2hdsr6du0.fsf@telia.com> <20040701161620.GA2939@animx.eu.org>
	<m2u0wr4f0v.fsf@telia.com> <20040701232955.GA3682@animx.eu.org>
From: Peter Osterlund <petero2@telia.com>
Date: 02 Jul 2004 16:58:17 +0200
In-Reply-To: <20040701232955.GA3682@animx.eu.org>
Message-ID: <m21xju4fsm.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner <wakko@animx.eu.org> writes:

> > > Any chance of this working with dvd?r?  (Same question for cd-r on the other
> > > patch).
> > 
> > No, not for now. I think support for non-rewritable media requires
> > changes both in the udf filesystem and in the pktcdvd driver.
> 
> I can understand that.  If I wish to write to dvd±rw, do i need both
> patches?

For DVD+RW, you don't need any additional patches. For DVD-RW, you
need the packet writing patch and the patch below.

You can also use the packet writing patch for DVD+RW to improve
performance in case the drive firmware is not good at handling small
writes. (This seems to be the case with my drive.)


Signed-off-by: Peter Osterlund <petero2@telia.com>

---

 linux-petero/drivers/block/Kconfig   |    3 +-
 linux-petero/drivers/block/pktcdvd.c |   37 ++++++++++++++++++++++++++++++++---
 linux-petero/include/linux/pktcdvd.h |    1 
 3 files changed, 37 insertions(+), 4 deletions(-)

diff -puN drivers/block/Kconfig~dvd-rw-packet drivers/block/Kconfig
--- linux/drivers/block/Kconfig~dvd-rw-packet	2004-07-01 15:10:50.000000000 +0200
+++ linux-petero/drivers/block/Kconfig	2004-07-01 15:10:51.000000000 +0200
@@ -348,7 +348,8 @@ config CDROM_PKTCDVD
 	  compliant ATAPI or SCSI drive, which is just about any newer CD
 	  writer.
 
-	  Currently only writing to CD-RW discs is possible.
+	  Currently only writing to CD-RW, DVD-RW and DVD+RW discs is possible.
+	  DVD-RW disks must be in restricted overwrite mode.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called pktcdvd.
diff -puN drivers/block/pktcdvd.c~dvd-rw-packet drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~dvd-rw-packet	2004-07-01 15:10:50.000000000 +0200
+++ linux-petero/drivers/block/pktcdvd.c	2004-07-02 14:44:14.292566688 +0200
@@ -1410,6 +1410,10 @@ static int pkt_set_write_settings(struct
 	char buffer[128];
 	int ret, size;
 
+	/* doesn't apply to DVD+RW */
+	if (pd->mmc3_profile == 0x1a)
+		return 0;
+
 	memset(buffer, 0, sizeof(buffer));
 	init_cdrom_command(&cgc, buffer, sizeof(*wp), CGC_DATA_READ);
 	cgc.sense = &sense;
@@ -1515,6 +1519,18 @@ static int pkt_good_track(track_informat
  */
 static int pkt_good_disc(struct pktcdvd_device *pd, disc_information *di)
 {
+	switch (pd->mmc3_profile) {
+		case 0x0a: /* CD-RW */
+		case 0xffff: /* MMC3 not supported */
+			break;
+		case 0x1a: /* DVD+RW */
+		case 0x13: /* DVD-RW */
+			return 0;
+		default:
+			printk("pktcdvd: Wrong disc profile (%x)\n", pd->mmc3_profile);
+			return 1;
+	}
+
 	/*
 	 * for disc type 0xff we should probably reserve a new track.
 	 * but i'm not sure, should we leave this to user apps? probably.
@@ -1544,10 +1560,18 @@ static int pkt_good_disc(struct pktcdvd_
 
 static int pkt_probe_settings(struct pktcdvd_device *pd)
 {
+	struct packet_command cgc;
+	unsigned char buf[12];
 	disc_information di;
 	track_information ti;
 	int ret, track;
 
+	init_cdrom_command(&cgc, buf, sizeof(buf), CGC_DATA_READ);
+	cgc.cmd[0] = GPCMD_GET_CONFIGURATION;
+	cgc.cmd[8] = 8;
+	ret = pkt_generic_packet(pd, &cgc);
+	pd->mmc3_profile = ret ? 0xffff : buf[6] << 8 | buf[7];
+
 	memset(&di, 0, sizeof(disc_information));
 	memset(&ti, 0, sizeof(track_information));
 
@@ -1845,9 +1869,16 @@ static int pkt_open_write(struct pktcdvd
 
 	if ((ret = pkt_get_max_speed(pd, &write_speed)))
 		write_speed = 16;
-	if ((ret = pkt_media_speed(pd, &media_write_speed)))
-		media_write_speed = 16;
-	write_speed = min(write_speed, media_write_speed);
+	switch (pd->mmc3_profile) {
+		case 0x13: /* DVD-RW */
+		case 0x1a: /* DVD+RW */
+			break;
+		default:
+			if ((ret = pkt_media_speed(pd, &media_write_speed)))
+				media_write_speed = 16;
+			write_speed = min(write_speed, media_write_speed);
+			break;
+	}
 	read_speed = write_speed;
 
 	if ((ret = pkt_set_speed(pd, write_speed, read_speed))) {
diff -puN include/linux/pktcdvd.h~dvd-rw-packet include/linux/pktcdvd.h
--- linux/include/linux/pktcdvd.h~dvd-rw-packet	2004-07-01 15:10:50.000000000 +0200
+++ linux-petero/include/linux/pktcdvd.h	2004-07-01 15:10:51.000000000 +0200
@@ -243,6 +243,7 @@ struct pktcdvd_device
 	__u8			mode_offset;	/* 0 / 8 */
 	__u8			type;
 	unsigned long		flags;
+	__u16			mmc3_profile;
 	__u32			nwa;		/* next writable address */
 	__u32			lra;		/* last recorded address */
 	struct packet_cdrw	cdrw;
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
