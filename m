Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262178AbTDAH7z>; Tue, 1 Apr 2003 02:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262180AbTDAH7z>; Tue, 1 Apr 2003 02:59:55 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:41939 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id <S262178AbTDAH7x>; Tue, 1 Apr 2003 02:59:53 -0500
Date: Tue, 1 Apr 2003 18:10:45 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Message-ID: <20030401081045.GD1394@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I believe the patch below will apply to both the above (I know it does
to 2.5.66 and 2.4.20-pre2 mm/shmem.c does not look any different so it
should be fine. :)

Anyways, what this patch does is allow you to specify the max amount of
memory tmpfs can use as a percentage of available real ram. This (in my
eyes) is useful so that you do not have to remember to change the
setting if you want something other then 50% and some of your ram does
(and you can't replacew it immediately).

Usage of this option is as follows:

tmpfs      /dev/shm tmpfs  rw,size=63%,noauto            0 0

This is taken from my working system and sets the tmpfs size to 63% of
my real RAM (256MB). The end result is:

Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/shm/tmp            160868      6776    154092   5% /tmp

I've also tested remounting to silly values (and sane ones) and it all
works fine with no oopses or freezes and the correct values appearing
in df.

All up I feel safer using this then a hard value.

Please apply. :)

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to
kill my dad."
        - George W. Bush Jr, Leader of the United States Regime
          September 26, 2002 (from a political fundraiser in Houston, Texas)

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="add-perc-tmpfs-size-2.5.66.patch"

--- linux/mm/shmem.c.old	Sun Mar 30 00:51:39 2003
+++ linux/mm/shmem.c	Sun Mar 30 03:23:47 2003
@@ -1630,6 +1630,12 @@
 		if (!strcmp(this_char,"size")) {
 			unsigned long long size;
 			size = memparse(value,&rest);
+			if (*rest == '%') {
+				struct sysinfo si;
+				si_meminfo(&si);
+				size = (si.totalram << PAGE_CACHE_SHIFT) / 100 * size;
+				rest++;
+			}
 			if (*rest)
 				goto bad_val;
 			*blocks = size >> PAGE_CACHE_SHIFT;

--0OAP2g/MAC+5xKAE--
