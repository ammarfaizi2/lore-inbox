Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261298AbSKBRLl>; Sat, 2 Nov 2002 12:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261311AbSKBRLl>; Sat, 2 Nov 2002 12:11:41 -0500
Received: from pasky.ji.cz ([62.44.12.54]:43502 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S261298AbSKBRLg>;
	Sat, 2 Nov 2002 12:11:36 -0500
Date: Sat, 2 Nov 2002 18:20:48 +0100
From: Petr Baudis <pasky@pasky.ji.cz>
To: marcelo@connectiva.com.br
Cc: linux-kernel@vger.kernel.org, aeb@cwi.nl
Subject: [PATCH] [2.4.19] Extended /proc/partitions
Message-ID: <20021102172048.GA2535@pasky.ji.cz>
Mail-Followup-To: marcelo@connectiva.com.br, linux-kernel@vger.kernel.org,
	aeb@cwi.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  this patch (against 2.4.19) extends contents of /proc/partitions by starting
offset of each partition. This can be terribly useful if you (or someone who
then passed you the computer for a repair) by some mistake over-dd'd the
partition table on a disk, but the system is still up. I know that you can also
dig this out by some ioctl()s, but this can make life a lot easier for those
who don't know C or can't dig the ioctl codes from the kernel source code.

  Note that it's possibly totally flawed (I don't know anything about this
piece of code), but it looks to work ok.

  Kind regards,

--- linux-2.4.19/drivers/block/genhd.c	Fri Nov  1 21:28:24 2002
+++ linux-2.4.19+pasky/drivers/block/genhd.c	Fri Nov  1 21:27:41 2002
@@ -163,7 +163,7 @@
 	char buf[64];
 	int len, n;
 
-	len = sprintf(page, "major minor  #blocks  name\n\n");
+	len = sprintf(page, "major minor startblock   #blocks  name\n\n");
 		
 	read_lock(&gendisk_lock);
 	for (gp = gendisk_head; gp; gp = gp->next) {
@@ -173,8 +173,9 @@
 
 			hd = &gp->part[n]; disk_round_stats(hd);
 			len += sprintf(page + len,
-				"%4d  %4d %10d %s\n", gp->major,
-				n, gp->sizes[n], disk_name(gp, n, buf));
+				"%4d  %4d  %10ld %10d %s\n", gp->major,
+				n, hd->start_sect, gp->sizes[n],
+				disk_name(gp, n, buf));
 
 			if (len < offset)
 				offset -= len, len = 0;

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
