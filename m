Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261299AbSKBROP>; Sat, 2 Nov 2002 12:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbSKBROP>; Sat, 2 Nov 2002 12:14:15 -0500
Received: from pasky.ji.cz ([62.44.12.54]:48878 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S261299AbSKBROO>;
	Sat, 2 Nov 2002 12:14:14 -0500
Date: Sat, 2 Nov 2002 18:23:24 +0100
From: Petr Baudis <pasky@ucw.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, aeb@cwi.nl
Subject: [PATCH] [2.5.45] Extended /proc/partitions
Message-ID: <20021102172324.GB2535@pasky.ji.cz>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	aeb@cwi.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  this patch (against 2.5.45) extends contents of /proc/partitions by starting
offset of each partition. This can be terribly useful if you (or someone who
then passed you the computer for a repair) by some mistake over-dd'd the
partition table on a disk, but the system is still up. I know that you can also
dig this out by some ioctl()s, but this can make life a lot easier for those
who don't know C or can't dig the ioctl codes from the kernel source code.

  Note that it's possibly totally flawed (I don't know anything about this
piece of code), but it looks to work ok.

  Kind regards,

--- linux-2.5.45/drivers/block/genhd.c	Sat Nov  2 17:43:41 2002
+++ linux-2.5.45+pasky/drivers/block/genhd.c	Sat Nov  2 16:26:51 2002
@@ -218,23 +218,24 @@
 	char buf[64];
 
 	if (&sgp->full_list == gendisk_list.next)
-		seq_puts(part, "major minor  #blocks  name\n\n");
+		seq_puts(part, "major minor startblock   #blocks  name\n\n");
 
 	/* Don't show non-partitionable devices or empty devices */
 	if (!get_capacity(sgp) || sgp->minors == 1)
 		return 0;
 
 	/* show the full disk and all non-0 size partitions of it */
-	seq_printf(part, "%4d  %4d %10llu %s\n",
+	seq_printf(part, "%4d  %4d  %10llu %10llu %s\n",
		sgp->major, sgp->first_minor,
-		(unsigned long long)get_capacity(sgp) >> 1,
+		0LL, (unsigned long long) get_capacity(sgp) >> 1,
		disk_name(sgp, 0, buf));
 	for (n = 0; n < sgp->minors - 1; n++) {
 		if (sgp->part[n].nr_sects == 0)
 			continue;
-		seq_printf(part, "%4d  %4d %10llu %s\n",
+		seq_printf(part, "%4d  %4d  %10llu %10llu %s\n",
 			sgp->major, n + 1 + sgp->first_minor,
-			(unsigned long long)sgp->part[n].nr_sects >> 1 ,
+			(unsigned long long) sgp->part[n].start_sect,
+			(unsigned long long) sgp->part[n].nr_sects >> 1,
 			disk_name(sgp, n + 1, buf));
 	}
 
-- 
 
				Petr "Pasky" Baudis
 
* ELinks maintainer                * IPv6 guy (XS26 co-coordinator)
* IRCnet operator                  * FreeCiv AI occassional hacker
.
This host is a black hole at HTTP wavelengths. GETs go in, and nothing
comes out, not even Hawking radiation.
                -- Graaagh the Mighty on rec.games.roguelike.angband
.
Public PGP key && geekcode && homepage: http://pasky.ji.cz/~pasky/
