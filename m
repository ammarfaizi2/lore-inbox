Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263016AbTCWKrg>; Sun, 23 Mar 2003 05:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263017AbTCWKrg>; Sun, 23 Mar 2003 05:47:36 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:24213 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S263016AbTCWKre>;
	Sun, 23 Mar 2003 05:47:34 -0500
Date: Sun, 23 Mar 2003 11:58:37 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marco Roeland <marco.roeland@xs4all.nl>,
       Duncan Sands <baldrick@wanadoo.fr>
cc: Alan Cox <alan@redhat.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       parisc-linux@parisc-linux.org,
       Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Linux 2.5.65-ac2 (drivers/char/genrtc.c compile failure on i386)
In-Reply-To: <20030322202201.GA32386@localhost>
Message-ID: <Pine.GSO.4.21.0303231155380.9116-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Mar 2003, Marco Roeland wrote:
> On Friday March 21st 2003 at 12:41 Alan Cox wrote:
> > Linux 2.5.65-ac2
> >       ...
> > o	M68K rtc updates				(Geert Uytterhoeven)
> 
> The file drivers/char/genrtc.c was updated, but include/arch-generic/rtc.h
> which is used on i386 wasn't (yet?), leading to compile failures on i386:
> (the missing define is only the first symptom)

Oops, until last Friday I didn't even know genrtc was used on ia32...

Anyway, can you please give this a try? I also updated PPC and PA-RISC, the
other two known users of genrtc I forgot to update.

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

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

