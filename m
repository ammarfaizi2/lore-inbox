Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293466AbSBZCCN>; Mon, 25 Feb 2002 21:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293465AbSBZCCL>; Mon, 25 Feb 2002 21:02:11 -0500
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:39042 "EHLO
	ohdarn.net") by vger.kernel.org with ESMTP id <S293464AbSBZCAJ>;
	Mon, 25 Feb 2002 21:00:09 -0500
Date: Mon, 25 Feb 2002 21:00:11 -0500
From: Michael Cohen <me@ohdarn.net>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: Submissions for 2.4.19-pre [RivaFB Blanking Fix (Author Unknown)]
Message-Id: <20020225210011.490d7131.me@ohdarn.net>
Organization: OhDarn.net
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the fourth (there were two seconds with different contents, oops) of several mails containing patches to be included in 2.4.19.  Some are worthy of dicussion prior to inclusion and have been marked as such.  The majority of these patches were found on lkml; the remaining ones have URLs listed.

The origin of this patch is unknown, but it is believed to be from lkml.

------
Michael Cohen
OhDarn.net

--- linux.orig/drivers/video/riva/fbdev.c	Wed Nov 14 14:52:20 2001
+++ linux/drivers/video/riva/fbdev.c	Tue Nov 27 17:37:02 2001
@@ -1703,11 +1703,31 @@
 {
 	unsigned char tmp, vesa;
 	struct rivafb_info *rinfo = (struct rivafb_info *)info;
+	struct fb_cmap cmap;
+	u16 black[16];
 
 	DPRINTK("ENTER\n");
 
 	assert(rinfo != NULL);
 
+	/*
+	 * FIXME: X seems to have some issues with this particular hardware
+	 * method of blanking.. so we use a software fallback for now, pending
+	 * a real fix. (Someone with documentation might want to fix this
+	 * properly).
+	 */
+	if (blank) {
+		memset(black, 0, 16 * sizeof(u16));
+		cmap.red = black;
+		cmap.green = black;
+		cmap.blue = black;
+		cmap.transp = NULL;
+		cmap.start = 0;
+		cmap.len = sizeof(black) / sizeof(u16);
+		fb_set_cmap(&cmap, 1, riva_setcolreg, info);
+	}
+
+#if 0
 	tmp = SEQin(rinfo, 0x01) & ~0x20;	/* screen on/off */
 	vesa = CRTCin(rinfo, 0x1a) & ~0xc0;	/* sync on/off */
 
@@ -1730,6 +1750,7 @@
 
 	SEQout(rinfo, 0x01, tmp);
 	CRTCout(rinfo, 0x1a, vesa);
+#endif
 
 	DPRINTK("EXIT\n");
 }
