Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261482AbTCYITE>; Tue, 25 Mar 2003 03:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261634AbTCYITE>; Tue, 25 Mar 2003 03:19:04 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:20610 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261482AbTCYITC>; Tue, 25 Mar 2003 03:19:02 -0500
Date: Tue, 25 Mar 2003 09:29:02 +0100
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.66
Message-ID: <20030325082902.GA5328@localhost>
References: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com> <20030325001414.GX18830@iucha.net> <200303250905.53881@bilbo.math.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200303250905.53881@bilbo.math.uni-mannheim.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25th March 2003 at 09:05 uur Rolf Eike Beer wrote:

> It was broken somewhere between -bk1 and -bk4.

Geert Uytterhoeven posted this patch for it, two days ago, it is already
present in 2.5.65-ac4.

--- linux-2.5.x/include/asm-generic/rtc.h.orig	Mon Feb 10 21:59:25 2003
+++ linux-2.5.x/include/asm-generic/rtc.h	Sun Mar 23 11:47:24 2003
@@ -22,9 +22,8 @@
 #define RTC_AIE 0x20		/* alarm interrupt enable */
 #define RTC_UIE 0x10		/* update-finished interrupt enable */
 
-extern void gen_rtc_interrupt(unsigned long);
-
 /* some dummy definitions */
+#define RTC_BATT_BAD 0x100	/* battery bad */
 #define RTC_SQWE 0x08		/* enable square-wave output */
 #define RTC_DM_BINARY 0x04	/* all time/date values are BCD if clear */
 #define RTC_24H 0x02		/* 24 hour mode - else hours bit 7 means pm */
@@ -43,7 +42,7 @@
 	return uip;
 }
 
-static inline void get_rtc_time(struct rtc_time *time)
+static inline unsigned int get_rtc_time(struct rtc_time *time)
 {
 	unsigned long uip_watchdog = jiffies;
 	unsigned char ctrl;
@@ -108,6 +107,8 @@
 		time->tm_year += 100;
 
 	time->tm_mon--;
+
+	return RTC_24H;
 }
 
 /* Set the current date and time in the real time clock. */
--- linux-2.5.x/include/asm-parisc/rtc.h.orig	Wed Aug 28 08:33:46 2002
+++ linux-2.5.x/include/asm-parisc/rtc.h	Sun Mar 23 11:52:15 2003
@@ -24,7 +24,7 @@
 #define RTC_AIE 0x20		/* alarm interrupt enable */
 #define RTC_UIE 0x10		/* update-finished interrupt enable */
 
-extern void gen_rtc_interrupt(unsigned long);
+#define RTC_BATT_BAD 0x100	/* battery bad */
 
 /* some dummy definitions */
 #define RTC_SQWE 0x08		/* enable square-wave output */
@@ -44,14 +44,14 @@
 	{ 0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366 }
 };
 
-static int get_rtc_time(struct rtc_time *wtime)
+static inline unsigned int get_rtc_time(struct rtc_time *wtime)
 {
 	struct pdc_tod tod_data;
 	long int days, rem, y;
 	const unsigned short int *ip;
 
 	if(pdc_tod_read(&tod_data) < 0)
-		return -1;
+		return RTC_24H | RTC_BATT_BAD;
 
 	
 	// most of the remainder of this function is:
@@ -93,7 +93,7 @@
 	wtime->tm_mon = y;
 	wtime->tm_mday = days + 1;
 	
-	return 0;
+	return RTC_24H;
 }
 
 static int set_rtc_time(struct rtc_time *wtime)
--- linux-2.5.x/include/asm-ppc/rtc.h.orig	Tue Feb 18 10:08:44 2003
+++ linux-2.5.x/include/asm-ppc/rtc.h	Sun Mar 23 11:47:31 2003
@@ -35,15 +35,14 @@
 #define RTC_AIE 0x20		/* alarm interrupt enable */
 #define RTC_UIE 0x10		/* update-finished interrupt enable */
 
-extern void gen_rtc_interrupt(unsigned long);
-
 /* some dummy definitions */
+#define RTC_BATT_BAD 0x100	/* battery bad */
 #define RTC_SQWE 0x08		/* enable square-wave output */
 #define RTC_DM_BINARY 0x04	/* all time/date values are BCD if clear */
 #define RTC_24H 0x02		/* 24 hour mode - else hours bit 7 means pm */
 #define RTC_DST_EN 0x01	        /* auto switch DST - works f. USA only */
 
-static inline void get_rtc_time(struct rtc_time *time)
+static inline unsigned int get_rtc_time(struct rtc_time *time)
 {
 	if (ppc_md.get_rtc_time) {
 		unsigned long nowtime;
@@ -55,6 +54,7 @@
 		time->tm_year -= 1900;
 		time->tm_mon -= 1; /* Make sure userland has a 0-based month */
 	}
+	return RTC_24H;
 }
 
 /* Set the current date and time in the real time clock. */

