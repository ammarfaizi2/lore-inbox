Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262193AbRENQKj>; Mon, 14 May 2001 12:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262243AbRENQK3>; Mon, 14 May 2001 12:10:29 -0400
Received: from www.topmail.de ([212.255.16.226]:31422 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S262193AbRENQKR>;
	Mon, 14 May 2001 12:10:17 -0400
From: Thorsten Glaser <eccesys@topmail.de>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [RFC, PATCH] khttpd until-now private patch
Message-Id: <20010514160834.3428DA5AB9E@www.topmail.de>
Date: Mon, 14 May 2001 18:08:34 +0200 (MET DST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
this is my first try to submit a patch.

I have looked through khttpd and saw some MIME types but others
haven't been there, especially I saw that one could not serve
plain binary files. So I have added some MIME types... a /proc
interface was nice, though.

Secondly I have allowed myself to update the RFC821 date-time
handling. You do not need to add the day of the week field,
and according to RFC282(1,2) UTC should be served ad +0000
(or -0000 if it is not 100% secure that it really is UTC,
 or if UTC is not local time, however I decided to do +0000).

Feel free to correct me if I am wrong, if not I would like
to see this in the stock kernel.

-mirabilos

Here is the patch:

--- linux-2.4.4-ac9/net/khttpd/main.c   Mon May 14 15:16:14 2001
+++ linux/net/khttpd/main.c     Mon May 14 15:58:04 2001
@@ -50,6 +50,12 @@
  *
  ****************************************************************/

+/** ChangeLog:
+       2001-05-14      Thorsten Glaser <mirabilos@users.sourceforge.net>
+                       Add more MIME types for widely-used
+                        files (mostly binary)
+*/
+

 static int errno;
 #define __KERNEL_SYSCALLS__
@@ -371,7 +377,17 @@
        AddMimeType(".deb","application/x-debian-package");
        AddMimeType("lass","application/x-java");
        AddMimeType(".mp3","audio/mpeg");
+       AddMimeType(".mpg","video/mpeg");
        AddMimeType(".txt","text/plain");
+       AddMimeType(".asc","text/plain; charset=ISO_646.irv:1991");
+       AddMimeType(".bin","application/octet-stream");
+       AddMimeType(".com","application/octet-stream");
+       AddMimeType(".exe","application/octet-stream");
+       AddMimeType(".lzh","application/octet-stream");
+        /* because not officially registered and some browser are buggy */
+       AddMimeType(".bz2","application/x-bzip2");
+       AddMimeType(".tbz","application/x-gtar");
+       AddMimeType(".cbz","application/x-cpio");

        AddDynamicString("..");
        AddDynamicString("cgi-bin");
--- linux-2.4.4-ac9/net/khttpd/rfc_time.c       Fri Feb  9 19:29:44 2001
+++ linux/net/khttpd/rfc_time.c Mon May 14 15:55:27 2001
@@ -25,6 +25,13 @@
  *
  ****************************************************************/

+/** ChangeLog:
+       2001-05-14      Thorsten Glaser <mirabilos@users.sourceforge.net>
+                       According to RFC821 the DayOfTheWeek doesn't need
+                        to be set.
+                       According to RFC2822 UTC should be served as +0000
+*/
+
 #include <linux/time.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -33,9 +40,6 @@

 #include "times.h"
 #include "prototypes.h"
-static char *dayName[7] = {
-       "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
-};

 static char *monthName[12] = {
        "Jan", "Feb", "Mar", "Apr", "May", "Jun",
@@ -94,67 +98,57 @@
        M=I2-1;

        rest=Zulu - TimeDays[Y][M];
-       WD=WeekDays[Y][M];
        D=rest/86400;
        rest=rest%86400;
-       WD+=D;
-       WD=WD%7;
        H=rest/3600;
        rest=rest%3600;
        Min=rest/60;
-       rest=rest%60;
-       S=rest;
+       S=rest%60;

 BuildYear:
        Y+=KHTTPD_YEAROFFSET;


-       /* Format:  Day, 01 Mon 1999 01:01:01 GMT */
+       /* Format:  01 Mon 2001 01:01:01 +0000 */

 /*
        We want to do

-       sprintf( Buffer, "%s, %02i %s %04i %02i:%02i:%02i GMT",
-               dayName[ WD ], D+1, monthName[ M ], Y,
+       sprintf( Buffer, "%02i %s %04i %02i:%02i:%02i +0000",
+               D+1, monthName[ M ], Y,
                H, Min, S
        );

        but this is very expensive. Since the string is fixed length,
        it is filled manually.
 */
-       Buffer[0]=dayName[WD][0];
-       Buffer[1]=dayName[WD][1];
-       Buffer[2]=dayName[WD][2];
-       Buffer[3]=',';
-       Buffer[4]=' ';
-       Buffer[5]=itoa_h[D+1];
-       Buffer[6]=itoa_l[D+1];
-       Buffer[7]=' ';
-       Buffer[8]=monthName[M][0];
-       Buffer[9]=monthName[M][1];
-       Buffer[10]=monthName[M][2];
+       Buffer[0]=itoa_h[D+1];
+       Buffer[1]=itoa_l[D+1];
+       Buffer[2]=' ';
+       Buffer[3]=monthName[M][0];
+       Buffer[4]=monthName[M][1];
+       Buffer[5]=monthName[M][2];
+       Buffer[6]=' ';
+       Buffer[7]=itoa_l[Y/1000];
+       Buffer[8]=itoa_l[(Y/100)%10];
+       Buffer[9]=itoa_l[(Y/10)%10];
+       Buffer[10]=itoa_l[Y%10];
        Buffer[11]=' ';
-       Buffer[12]=itoa_l[Y/1000];
-       Buffer[13]=itoa_l[(Y/100)%10];
-       Buffer[14]=itoa_l[(Y/10)%10];
-       Buffer[15]=itoa_l[Y%10];
-       Buffer[16]=' ';
-       Buffer[17]=itoa_h[H];
-       Buffer[18]=itoa_l[H];
-       Buffer[19]=':';
-       Buffer[20]=itoa_h[Min];
-       Buffer[21]=itoa_l[Min];
-       Buffer[22]=':';
-       Buffer[23]=itoa_h[S];
-       Buffer[24]=itoa_l[S];
-       Buffer[25]=' ';
-       Buffer[26]='G';
-       Buffer[27]='M';
-       Buffer[28]='T';
-       Buffer[29]=0;
-
-
-
+       Buffer[12]=itoa_h[H];
+       Buffer[13]=itoa_l[H];
+       Buffer[14]=':';
+       Buffer[15]=itoa_h[Min];
+       Buffer[16]=itoa_l[Min];
+       Buffer[17]=':';
+       Buffer[18]=itoa_h[S];
+       Buffer[19]=itoa_l[S];
+       Buffer[20]=' ';
+       Buffer[21]='+';
+       Buffer[22]='0';
+       Buffer[23]='0';
+       Buffer[24]='0';
+       Buffer[25]='0';
+       Buffer[26]=0;

 }

@@ -196,7 +190,7 @@
        if (s[3]!=',') return 0;
        if (s[19]!=':') return 0;

-       s+=5; /* Skip day of week */
+       if(s[3]==',') s+=5; /* Skip day of week if given */
        D = skip_atoi(s2);  /*  Day of month */
        s++;
        Hash = (unsigned char)s[0]+(unsigned char)s[2];
@@ -212,9 +206,10 @@
        s++;
        S = skip_atoi(s2); /* Seconds */
        s++;
-       if ((s[0]!='G')||(s[1]!='M')||(s[2]!='T'))
+       if ( ((s[0]!='G')||(s[1]!='M')||(s[2]!='T')) &&
+            (((s[0]!='+')&&(s[0]!='-'))||(s[1]!='0')||(s[2]!='0')||(s[3]!='0')) )
        {
-               return 0; /* No GMT */
+               return 0; /* No UTC */
        }

        if (Y<KHTTPD_YEAROFFSET) Y = KHTTPD_YEAROFFSET;


