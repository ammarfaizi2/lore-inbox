Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSFXIzG>; Mon, 24 Jun 2002 04:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293680AbSFXIzF>; Mon, 24 Jun 2002 04:55:05 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:63441 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S293203AbSFXIzD>; Mon, 24 Jun 2002 04:55:03 -0400
Date: Mon, 24 Jun 2002 10:54:57 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Martin Dalecki <dalecki@evision-ventures.com>, Jens Axboe <axboe@suse.de>
Subject: Re: hda: error: DMA in progress..
Message-ID: <20020624085457.GD16752@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Jens Axboe <axboe@suse.de>
References: <20020621092459.GD27090@suse.de> <3D12FA4D.6060500@evision-ventures.com> <20020621101202.GF27090@suse.de> <3D130095.6050207@evision-ventures.com> <20020621103553.GI27090@suse.de> <3D13098E.2020100@evision-ventures.com> <E17LPqm-0006S3-00@come.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17LPqm-0006S3-00@come.alcove-fr>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2002 at 04:57:24PM +0200, Stelian Pop wrote:

> Martin, I have the same problem on my Sony Vaio C1VE, 
> Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01), HITACHI_DK23AA-12 disk.
> 
> It doesn't even boot, the "DMA in progress error..." appears just
> after having mounted the root partition. 2.5.23 worked on this laptop.

Ok, after poking around the "waiting_for_dma" changes, I found that
the attached patch is solving all my problems, my laptop works again.

BIG FAT WARNING: I have a very limited knowledge in the ide driver
internals, the attached patch could destroy all your data!

Please advice.

Stelian.

===== include/linux/ide.h 1.90 vs edited =====
--- 1.90/include/linux/ide.h	Thu Jun 20 13:35:15 2002
+++ edited/include/linux/ide.h	Mon Jun 24 10:17:00 2002
@@ -766,10 +766,12 @@
  */
 static inline ide_startstop_t udma_init(struct ata_device *drive, struct request *rq)
 {
-	int ret = drive->channel->udma_init(drive, rq);
-	if (ret == ide_started)
-		set_bit(IDE_DMA, drive->channel->active);
-
+	int ret;
+	
+	set_bit(IDE_DMA, drive->channel->active);
+	ret = drive->channel->udma_init(drive, rq);
+	if (ret != ide_started)
+		clear_bit(IDE_DMA, drive->channel->active);
 	return ret;
 }
 
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
