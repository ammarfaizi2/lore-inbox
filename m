Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317770AbSG0Txr>; Sat, 27 Jul 2002 15:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317752AbSG0Txr>; Sat, 27 Jul 2002 15:53:47 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:27142 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S317770AbSG0Txq>;
	Sat, 27 Jul 2002 15:53:46 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200207271956.g6RJurv08967@oboe.it.uc3m.es>
Subject: [PATCH] turn vesa framebuffer off at boot 2.4.18
To: kraxel@goldbach.in-berlin.de
Date: Sat, 27 Jul 2002 21:56:53 +0200 (MET DST)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I use the same kernel everywhere but when vesa framebuffer is compiled
into the kernel the text mode console on my laptop doesn't show the
bottom few lines of the screen.

So I wanted to turn it off at boot ..  but there didn't seem to be a way
:-(.  Hence I added the boot param

     video=vesa:off

Apologies if it was possible some other way. I believe I've heard
of some distros providing FB and NONFB kernels. I didn't stop to
investigate beyond reading the Documentation/fb/*.txt.

This patch is against the pre-2.4.18 kernel code I had handy.
Sorry if it needs to be more recent. I don't have another 120M
to spare for a newer source just now ...

It works.


--- vesafb.c.orig	Sat Jul 27 21:42:39 2002
+++ vesafb.c	Sat Jul 27 21:10:39 2002
@@ -98,6 +98,7 @@
 
 static int             pmi_setpal = 0;	/* pmi for palette changes ??? */
 static int             ypan       = 0;  /* 0..nothing, 1..ypan, 2..ywrap */
+static int             disable    = 0;  /* added by P. Breuer ptb@it.uc3m.es */
 static unsigned short  *pmi_base  = 0;
 static void            (*pmi_start)(void);
 static void            (*pmi_pal)(void);
@@ -462,6 +463,8 @@
 		
 		if (! strcmp(this_opt, "inverse"))
 			inverse=1;
+		else if (! strcmp(this_opt, "off"))
+			disable=1;
 		else if (! strcmp(this_opt, "redraw"))
 			ypan=0;
 		else if (! strcmp(this_opt, "ypan"))
@@ -504,6 +507,12 @@
 int __init vesafb_init(void)
 {
 	int i,j;
+
+        if (disable) {
+		printk(KERN_INFO
+		       "vesafb: aborted on user req (disable)\n");
+                return -EINVAL;
+        }
 
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_VLFB)
 		return -ENXIO;
