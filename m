Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315693AbSENMxe>; Tue, 14 May 2002 08:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315695AbSENMxd>; Tue, 14 May 2002 08:53:33 -0400
Received: from kim.it.uu.se ([130.238.12.178]:56960 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S315693AbSENMxa>;
	Tue, 14 May 2002 08:53:30 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15585.2238.316509.620544@kim.it.uu.se>
Date: Tue, 14 May 2002 14:53:18 +0200
To: Keith Owens <kaos@ocs.com.au>
Cc: Wickus Botha <Wickus@na.co.za>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: hd.c not compiling. 
In-Reply-To: <9998.1021369222@ocs3.intra.ocs.com.au>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:
 > On Tue, 14 May 2002 10:24:51 +0200, 
 > Wickus Botha <Wickus@na.co.za> wrote:
 > >I'm busy testing the new development kernel 2.5.15. Each time it gets to
 > >compiling the ide stuff it fails. 
 > >hd.c: In function `hd_out':
 > >hd.c:282: `TIMEOUT_VALUE' undeclared (first use in this function)
 > 
 > That is the only hd only driver.  It has not been updated to follow
 > recent 2.5 changes.  Unless you want the old hd only code, set
 > CONFIG_BLK_DEV_HD_IDE=n and use the newer driver for all IDE disks.

Except of course when the new IDE driver crashes and burns, like it does on
my (infamous?) '93 vintage '486. On that box Andre's IDE driver works great
in 2.2.20+ide and 2.4.19pre, but Martin's mutated IDE driver hangs when init
comes to the point where is remounts file systems read-write.

A cleaner fix for hd.c in 2.5.15 follows below; it's from -dj.

/Mikael

--- linux-2.5.15/drivers/ide/hd.c.~1~	Mon May  6 13:05:04 2002
+++ linux-2.5.15/drivers/ide/hd.c	Fri May 10 01:54:43 2002
@@ -66,6 +66,7 @@
 
 static int revalidate_hddisk(kdev_t, int);
 
+#define TIMEOUT_VALUE	(6*HZ)
 #define	HD_DELAY	0
 
 #define MAX_ERRORS     16	/* Max read/write errors/sector */
@@ -827,7 +828,7 @@
 		printk("hd: unable to get major %d for hard disk\n",MAJOR_NR);
 		return -1;
 	}
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &hd_lock);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_hd_request, &hd_lock);
 	blk_queue_max_sectors(BLK_DEFAULT_QUEUE(MAJOR_NR), 255);
 	add_gendisk(&hd_gendisk);
 	init_timer(&device_timer);
