Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268400AbUHQUAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268400AbUHQUAH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 16:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268397AbUHQUAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 16:00:07 -0400
Received: from av3-2-sn1.fre.skanova.net ([81.228.11.110]:51861 "EHLO
	av3-2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S268396AbUHQT7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 15:59:49 -0400
To: Frediano Ziglio <freddyz77@tin.it>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Packet writing problems
References: <1092669361.4254.24.camel@freddy> <m3acwuq5nc.fsf@telia.com>
	<m3657iq4rk.fsf@telia.com> <1092686149.4338.1.camel@freddy>
From: Peter Osterlund <petero2@telia.com>
Date: 17 Aug 2004 21:59:47 +0200
In-Reply-To: <1092686149.4338.1.camel@freddy>
Message-ID: <m37jrxk024.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frediano Ziglio <freddyz77@tin.it> writes:

> Il lun, 2004-08-16 alle 21:09, Peter Osterlund ha scritto:
> ...
> > 
> > The second problem is in the dvdrw-support patch in the -mm kernel.
> > (This patch is also included in the patch you are using.)
> > 
> > The problem is that some drives fail the "GET CONFIGURATION" command
> > when asked to only return 8 bytes. This happens for example on my
> > drive, which is identified as:
> > 
> >         hdc: HL-DT-ST DVD+RW GCA-4040N, ATAPI CD/DVD-ROM drive
> > 
> > Since the cdrom_mmc3_profile() function already allocates 32 bytes for
> > the reply buffer, this patch is enough to make the command succeed on
> > my drive.
> > 
> 
> I'm forgetting... 
> 
> mounting devices it reports that disk was CD-RW and speed was 15
> (DVD-RW) and 31 (DVD+RW).

That shouldn't cause any real problems, but since it's quite
confusing, here is a patch to fix it.  With this change, both DVD+RW
and DVD-RW media is correctly identified in the kernel log, and DVD
speeds are printed in kB/s.

---

 linux-petero/drivers/block/pktcdvd.c |   34 ++++++++++++++++++++--------------
 linux-petero/include/linux/pktcdvd.h |    4 ++--
 2 files changed, 22 insertions(+), 16 deletions(-)

diff -puN drivers/block/pktcdvd.c~packet-dvd-printk-fix drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~packet-dvd-printk-fix	2004-08-16 23:51:52.000000000 +0200
+++ linux-petero/drivers/block/pktcdvd.c	2004-08-17 00:33:47.000000000 +0200
@@ -483,11 +483,6 @@ static int pkt_set_speed(struct pktcdvd_
 	struct request_sense sense;
 	int ret;
 
-	write_speed = write_speed * 177; /* should be 176.4, but CD-RWs rounds down */
-	write_speed = min_t(unsigned, write_speed, MAX_SPEED);
-	read_speed = read_speed * 177;
-	read_speed = min_t(unsigned, read_speed, MAX_SPEED);
-
 	init_cdrom_command(&cgc, NULL, 0, CGC_DATA_NONE);
 	cgc.sense = &sense;
 	cgc.cmd[0] = GPCMD_SET_SPEED;
@@ -602,8 +597,8 @@ static void pkt_iosched_process_queue(st
 			pd->iosched.successive_reads = 0;
 		if (pd->iosched.successive_reads >= HI_SPEED_SWITCH) {
 			if (pd->read_speed == pd->write_speed) {
-				pd->read_speed = 0xff;
-				pkt_set_speed(pd, pd->write_speed, MAX_SPEED);
+				pd->read_speed = MAX_SPEED;
+				pkt_set_speed(pd, pd->write_speed, pd->read_speed);
 			}
 		} else {
 			if (pd->read_speed != pd->write_speed) {
@@ -1632,7 +1627,17 @@ static int pkt_probe_settings(struct pkt
 	if (pkt_good_disc(pd, &di))
 		return -ENXIO;
 
-	printk("pktcdvd: inserted media is CD-R%s\n", di.erasable ? "W" : "");
+	switch (pd->mmc3_profile) {
+		case 0x1a: /* DVD+RW */
+			printk("pktcdvd: inserted media is DVD+RW\n");
+			break;
+		case 0x13: /* DVD-RW */
+			printk("pktcdvd: inserted media is DVD-RW\n");
+			break;
+		default:
+			printk("pktcdvd: inserted media is CD-R%s\n", di.erasable ? "W" : "");
+			break;
+	}
 	pd->type = di.erasable ? PACKET_CDRW : PACKET_CDR;
 
 	track = 1; /* (di.last_track_msb << 8) | di.last_track_lsb; */
@@ -1785,7 +1790,7 @@ static int pkt_get_max_speed(struct pktc
 			offset = 34;
 	}
 
-	*write_speed = ((cap_buf[offset] << 8) | cap_buf[offset + 1]) / 0xb0;
+	*write_speed = (cap_buf[offset] << 8) | cap_buf[offset + 1];
 	return 0;
 }
 
@@ -1917,15 +1922,17 @@ static int pkt_open_write(struct pktcdvd
 	pkt_write_caching(pd, USE_WCACHING);
 
 	if ((ret = pkt_get_max_speed(pd, &write_speed)))
-		write_speed = 16;
+		write_speed = 16 * 177;
 	switch (pd->mmc3_profile) {
 		case 0x13: /* DVD-RW */
 		case 0x1a: /* DVD+RW */
+			DPRINTK("pktcdvd: write speed %ukB/s\n", write_speed);
 			break;
 		default:
 			if ((ret = pkt_media_speed(pd, &media_write_speed)))
 				media_write_speed = 16;
-			write_speed = min(write_speed, media_write_speed);
+			write_speed = min(write_speed, media_write_speed * 177);
+			DPRINTK("pktcdvd: write speed %ux\n", write_speed / 176);
 			break;
 	}
 	read_speed = write_speed;
@@ -1934,7 +1941,6 @@ static int pkt_open_write(struct pktcdvd
 		DPRINTK("pktcdvd: %s couldn't set write speed\n", pd->name);
 		return -EIO;
 	}
-	DPRINTK("pktcdvd: write speed %u\n", write_speed);
 	pd->write_speed = write_speed;
 	pd->read_speed = read_speed;
 
@@ -2310,8 +2316,8 @@ static int pkt_seq_show(struct seq_file 
 	seq_printf(m, "\nMisc:\n");
 	seq_printf(m, "\treference count:\t%d\n", pd->refcnt);
 	seq_printf(m, "\tflags:\t\t\t0x%lx\n", pd->flags);
-	seq_printf(m, "\tread speed:\t\t%ukB/s\n", pd->read_speed * 150);
-	seq_printf(m, "\twrite speed:\t\t%ukB/s\n", pd->write_speed * 150);
+	seq_printf(m, "\tread speed:\t\t%ukB/s\n", pd->read_speed);
+	seq_printf(m, "\twrite speed:\t\t%ukB/s\n", pd->write_speed);
 	seq_printf(m, "\tstart offset:\t\t%lu\n", pd->offset);
 	seq_printf(m, "\tmode page offset:\t%u\n", pd->mode_offset);
 
diff -puN include/linux/pktcdvd.h~packet-dvd-printk-fix include/linux/pktcdvd.h
--- linux/include/linux/pktcdvd.h~packet-dvd-printk-fix	2004-08-17 00:34:42.000000000 +0200
+++ linux-petero/include/linux/pktcdvd.h	2004-08-17 00:35:09.000000000 +0200
@@ -239,8 +239,8 @@ struct pktcdvd_device
 	struct packet_settings	settings;
 	struct packet_stats	stats;
 	int			refcnt;		/* Open count */
-	__u8			write_speed;	/* current write speed */
-	__u8			read_speed;	/* current read speed */
+	int			write_speed;	/* current write speed, kB/s */
+	int			read_speed;	/* current read speed, kB/s */
 	unsigned long		offset;		/* start offset */
 	__u8			mode_offset;	/* 0 / 8 */
 	__u8			type;
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
