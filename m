Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130202AbQLSPlV>; Tue, 19 Dec 2000 10:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130304AbQLSPlL>; Tue, 19 Dec 2000 10:41:11 -0500
Received: from univ.uniyar.ac.ru ([193.233.51.120]:1444 "EHLO
	univ.uniyar.ac.ru") by vger.kernel.org with ESMTP
	id <S130202AbQLSPk7>; Tue, 19 Dec 2000 10:40:59 -0500
Date: Tue, 19 Dec 2000 18:09:57 +0300 (MSK)
From: "Igor Yu. Zhbanov" <bsg@uniyar.ac.ru>
To: Alan.Cox@linux.org
cc: linux-kernel@vger.kernel.org, urban@svenskatest.se,
        chaffee@cs.berkeley.edu
Subject: [PATCH] Bug in date converting functions DOS<=>UNIX in FAT and SMBFS drivers
Message-ID: <Pine.GSO.3.96.SK.1001219180019.894A-100000@univ.uniyar.ac.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Few weeks ago I have sent the following letter:

> Hello!
>
> I have found a bug in drivers of file systems which use a DOS-like format
> of date (16 bit: years since 1980 - 7 bits, month - 4 bits, day - 5 bits).
>
> There are two problems:
> 1) It is unable to convert UNIX-like dates before 1980 to DOS-like date format.
> 2) VFAT for example have three kinds of dates: creation date, modification date
>    and access date. Sometimes one of these dates is set to zero (which indicates
>    that this date is not set). Zero is not a valid date (e.g. months are
>    numbered from one, not from zero) and can't be properly converted to
>    UNIX-like format of date (it was converted to date before 1980).
>
> I have found FAT, NCPFS and SMBFS drivers subject to this problems. Patch for
> fixing these bugs attached.
>
> Also I have a question about VFAT file system. VFAT have not access time fields
> in directory entries but it has access date fields. Currently information about
> the time of last access is not supported for VFAT file system in LINUX. Is this
> correct? Maybe access time should be truncated to days.
>
> Thank you.
>
> P.S. Since I'm not currently subscribed to Linux Kernel Mailing List please CC:
> all replies to bsg@uniyar.ac.ru if any.
>

As I see now in 2.2.19pre2 NCPFS is fixed but VFAT and SMBFS doesn't. (This
happened because the maintainer of NCPFS resent my patch to Alan Cox but only the
part of patch related to NCPFS). So I resent you patch for VFAT and SMBFS.

diff -ur linux-2.2.17/fs/fat/misc.c linux/fs/fat/misc.c
--- linux-2.2.17/fs/fat/misc.c	Thu May  4 04:16:46 2000
+++ linux/fs/fat/misc.c	Wed Nov 22 14:05:08 2000
@@ -2,6 +2,8 @@
  *  linux/fs/fat/misc.c
  *
  *  Written 1992,1993 by Werner Almesberger
+ *  22/11/2000 - Fixed fat_date_unix2dos for dates earlier than 01/01/1980
+ *		 and date_dos2unix for date==0 by Igor Zhbanov(bsg@uniyar.ac.ru)
  */
 
 #include <linux/fs.h>
@@ -288,7 +290,9 @@
 {
 	int month,year,secs;
 
-	month = ((date >> 5) & 15)-1;
+	/* first subtract and mask after that... Otherwise, if
+	   date == 0, bad things happen */
+	month = ((date >> 5) - 1) & 15;
 	year = date >> 9;
 	secs = (time & 31)*2+60*((time >> 5) & 63)+(time >> 11)*3600+86400*
 	    ((date & 31)-1+day_n[month]+(year/4)+year*365-((year & 3) == 0 &&
@@ -310,6 +314,8 @@
 	unix_date -= sys_tz.tz_minuteswest*60;
 	if (sys_tz.tz_dsttime) unix_date += 3600;
 
+	if (unix_date < 315532800)
+		unix_date = 315532800; /* Jan 1 GMT 00:00:00 1980. But what about another time zone? */
 	*time = (unix_date % 60)/2+(((unix_date/60) % 60) << 5)+
 	    (((unix_date/3600) % 24) << 11);
 	day = unix_date/86400-3652;
diff -ur linux-2.2.17/fs/smbfs/ChangeLog linux/fs/smbfs/ChangeLog
--- linux-2.2.17/fs/smbfs/ChangeLog	Mon Sep  4 21:39:27 2000
+++ linux/fs/smbfs/ChangeLog	Wed Nov 22 14:10:40 2000
@@ -1,5 +1,10 @@
 ChangeLog for smbfs.
 
+2000-11-22 Igor Zhbanov <bsg@uniyar.ac.ru>
+
+	* proc.c: fixed date_unix2dos for dates earlier than 01/01/1980
+	  and date_dos2unix for date==0
+
 2000-07-20 Urban Widmark <urban@svenskatest.se>
 
 	* proc.c: fix 2 places where bad server responses could cause an Oops.
diff -ur linux-2.2.17/fs/smbfs/proc.c linux/fs/smbfs/proc.c
--- linux-2.2.17/fs/smbfs/proc.c	Mon Sep  4 21:39:27 2000
+++ linux/fs/smbfs/proc.c	Wed Nov 22 14:13:32 2000
@@ -169,7 +169,9 @@
 	int month, year;
 	time_t secs;
 
-	month = ((date >> 5) & 15) - 1;
+	/* first subtract and mask after that... Otherwise, if
+	   date == 0, bad things happen */
+	month = ((date >> 5) - 1) & 15;
 	year = date >> 9;
 	secs = (time & 31) * 2 + 60 * ((time >> 5) & 63) + (time >> 11) * 3600 + 86400 *
 	    ((date & 31) - 1 + day_n[month] + (year / 4) + year * 365 - ((year & 3) == 0 &&
@@ -188,6 +190,8 @@
 	int day, year, nl_day, month;
 
 	unix_date = utc2local(server, unix_date);
+	if (unix_date < 315532800)
+		unix_date = 315532800; /* Jan 1 GMT 00:00:00 1980. But what about another time zone? */
 	*time = (unix_date % 60) / 2 +
 		(((unix_date / 60) % 60) << 5) +
 		(((unix_date / 3600) % 24) << 11);


That's all.
Thank you.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
