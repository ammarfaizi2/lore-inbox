Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292877AbSBVOh4>; Fri, 22 Feb 2002 09:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292882AbSBVOhr>; Fri, 22 Feb 2002 09:37:47 -0500
Received: from astechnix.cluj.astral.ro ([194.105.28.94]:63764 "HELO
	astechnix.cluj.astral.ro") by vger.kernel.org with SMTP
	id <S292877AbSBVOhk>; Fri, 22 Feb 2002 09:37:40 -0500
Date: Fri, 22 Feb 2002 16:44:26 +0200 (EET)
From: Jani Monoses <jani@astechnix.cluj.astral.ro>
X-X-Sender: <jani@cow>
To: <linux-kernel@vger.kernel.org>
cc: Marcelo Tosati <marcelo@conectiva.com.br>
Subject: [PATCH] -rc4 : tridentfb compilation fix 
In-Reply-To: <Pine.LNX.4.10.10202010744240.29069-100000@www.transvirtual.com>
Message-ID: <Pine.LNX.4.33L2.0202221639010.20879-100000@cow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo

this replaces floating point with fixed point in tridentfb so it compiles
and also contains the strtok -> strsep change made by the janitors.
Please apply..

I only discovered a couple of hours ago while trying rc3 that tridentfb
didn't compile - I didn't know about the FPU issue when submitting.

Thanks
Jani.



--- linux/tridentfb.c	Fri Feb 22 13:50:10 2002
+++ linux/drivers/video/tridentfb.c	Fri Feb 22 16:28:30 2002
@@ -35,7 +35,7 @@

 #include "tridentfb.h"

-#define VERSION		"0.6.8"
+#define VERSION		"0.6.9"

 struct tridentfb_par {
 	struct fb_var_screeninfo var;
@@ -520,9 +520,8 @@
 	write3X4(CRTHiOrd, (read3X4(CRTHiOrd) & 0xF8) | (base & 0xE0000) >> 17);
 }

-
-#error "Floating point maths. This needs fixing before the driver is safe"
-#define calc_freq(n,m,k) ((NTSC * (n+8))/((m+2)*(1<<k)))
+/* Use 20.12 fixed-point for NTSC value and frequency calculation */
+#define calc_freq(n,m,k)  ( (unsigned long)0xE517 * (n+8) / (m+2)*(1<<k) )

 /* Set dotclock frequency */
 static void set_vclk(int freq)
@@ -1260,8 +1259,8 @@
 	char * opt;
 	if (!options || !*options)
 		return 0;
-	for(opt = strtok(options,",");opt;opt = strtok(NULL,",")){
-		if (!opt) continue;
+	while((opt = strsep(&options,",")) != NULL ) {
+		if (!*opt) continue;
 		if (!strncmp(opt,"noaccel",7))
 			noaccel = 1;
 		else if (!strncmp(opt,"accel",5))

