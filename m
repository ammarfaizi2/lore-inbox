Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751562AbWBVW2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbWBVW2d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWBVW2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:28:33 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:35019 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751562AbWBVW2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:28:32 -0500
To: linuxer@ever.mine.nu
Cc: linux-kernel@vger.kernel.org
Subject: Re: pktcdvd DVD+RW always writes at max drive speed (not media speed)
References: <200602182023.k1IKNNuI012372@rhodes.mine.nu>
	<m3r760cntz.fsf@telia.com>
	<200602182335.k1INZFoi012487@rhodes.mine.nu>
From: Peter Osterlund <petero2@telia.com>
Date: 22 Feb 2006 23:28:21 +0100
In-Reply-To: <200602182335.k1INZFoi012487@rhodes.mine.nu>
Message-ID: <m3ek1v58qi.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linuxer@ever.mine.nu writes:

> Peter Osterlund <petero2@telia.com> writes:
>   > 
>   > linuxer@ever.mine.nu writes:
>   > 
>   > > In drivers/block/pktcdvd.c it appears that in the case of DVD
>   > > rewriting, pkt_open_write always sets the write speed to pkt_get_max_speed
>   > > (the maximum writing speed reported by the drive). 
>   > > 
>   > > In my case, I have a new drive capable of 8x re-writing. However, all of
>   > > my existing media is rated for only 4x rewrite speed. 
>   > > 
>   > > When attempting to rw mount these disks, pktcdvd reports:
>   > > 
>   > > Feb 18 00:09:52 ever kernel: pktcdvd: write speed 11080kB/s
>   > > Feb 18 00:09:54 ever kernel: pktcdvd: 54 01 00 00 00 00 00 00 00 00 00 00 -
>   > > sense 00.54.9c (No sense)
>   > > Feb 18 00:09:54 ever kernel: pktcdvd: pktcdvd0 Optimum Power Calibration failed
>   > > 
>   > > And then of course a huge heap of I/O errors on the disk. 
>   > 
>   > Have you verified that this is caused by the speed setting, ie does it
>   > work correctly if you hack the driver to write at 4x speed?
> 
> Correct. Adding a hard-coded manual setting of write_speed = 5540 to
> pkt_open_write results in functional operation (at least with 4x rated
> DVD+RW media).

Does this patch work for you?


pktcdvd: Don't try to write faster than the DVD media speed allows.

In theory the drive firmware should limit the speed to the fastest
allowed by the currently loaded media, but it doesn't always work in
practice.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |   34 ++++++++++++++++++++++++++++++++--
 1 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index c1b8eae..94ff3ac 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1780,7 +1780,7 @@ static char us_clv_to_speed[16] = {
 /*
  * reads the maximum media speed from ATIP
  */
-static int pkt_media_speed(struct pktcdvd_device *pd, unsigned *speed)
+static int pkt_cd_media_speed(struct pktcdvd_device *pd, unsigned *speed)
 {
 	struct packet_command cgc;
 	struct request_sense sense;
@@ -1852,6 +1852,33 @@ static int pkt_media_speed(struct pktcdv
 	}
 }
 
+static int pkt_dvd_media_speed(struct pktcdvd_device *pd, unsigned int *speed)
+{
+	struct packet_command cgc;
+	struct request_sense sense;
+	unsigned char buf[64];
+	int size, ret;
+
+	init_cdrom_command(&cgc, buf, sizeof(buf), CGC_DATA_READ);
+	cgc.sense = &sense;
+	cgc.cmd[0] = GPCMD_GET_PERFORMANCE;
+	cgc.cmd[8] = 0;
+	cgc.cmd[9] = 1;			    /* Number of descriptors */
+	cgc.cmd[10] = 0x03;		    /* Write speed */
+	ret = pkt_generic_packet(pd, &cgc);
+	if (ret) {
+		pkt_dump_sense(&cgc);
+		return ret;
+	}
+	size = be32_to_cpu(*(int*)&buf[0]) + 4;
+	if (size < 8 + 16)
+		return -1;
+
+	*speed = be32_to_cpu(*(int*)&buf[8 + 12]);
+	DPRINTK("pktcdvd: Max. media speed: %dkB/s\n",*speed);
+	return 0;
+}
+
 static int pkt_perform_opc(struct pktcdvd_device *pd)
 {
 	struct packet_command cgc;
@@ -1889,14 +1916,17 @@ static int pkt_open_write(struct pktcdvd
 
 	if ((ret = pkt_get_max_speed(pd, &write_speed)))
 		write_speed = 16 * 177;
+	DPRINTK("pktcdvd: Max drive write speed %ukB/s\n", write_speed);
 	switch (pd->mmc3_profile) {
 		case 0x13: /* DVD-RW */
 		case 0x1a: /* DVD+RW */
 		case 0x12: /* DVD-RAM */
+			if (pkt_dvd_media_speed(pd, &media_write_speed) == 0)
+				write_speed = min(write_speed, media_write_speed);
 			DPRINTK("pktcdvd: write speed %ukB/s\n", write_speed);
 			break;
 		default:
-			if ((ret = pkt_media_speed(pd, &media_write_speed)))
+			if ((ret = pkt_cd_media_speed(pd, &media_write_speed)))
 				media_write_speed = 16;
 			write_speed = min(write_speed, media_write_speed * 177);
 			DPRINTK("pktcdvd: write speed %ux\n", write_speed / 176);

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
