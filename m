Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUAFSY5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 13:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265069AbUAFSY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 13:24:57 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:22543 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265053AbUAFSYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 13:24:53 -0500
Date: Tue, 6 Jan 2004 18:24:48 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Richard Drummond <lists@rcdrummond.net>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] Add tdfx palette hack to offb driver
In-Reply-To: <200303182344.50481.lists@rcdrummond.net>
Message-ID: <Pine.LNX.4.44.0401061823580.18404-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Attached is a patch (against 2.4.20) which adds a palette hack for Voodoo3/4/5 
> cards to the offb driver. It's tested and working here on a Voodoo3 and a 
> Voodoo4. I'd welcome comments, though. Particularly, I think the probing for 
> a Voodoo card may be a bit shaky. Basically I'm match the OF name with the 
> pattern "3Dfx,Voodoo*". This may cause problems if there are Voodoo1 or 2 
> cards available with OF drivers, and so need tightening up.

I have updated the patch against 2.6.0. Could you test it before I commit 
it to my tree.

--- /usr/src/linus-2.6/drivers/video/offb.c	2004-01-05 14:54:57.000000000 -0800
+++ offb.c	2004-01-06 13:21:32.000000000 -0800
@@ -43,6 +43,7 @@
 	cmap_M3B,		/* ATI Rage Mobility M3 Head B */
 	cmap_radeon,		/* ATI Radeon */
 	cmap_gxt2000,		/* IBM GXT2000 */
+	cmap_3dfx,		/* 3Dfx Voodoo3/4/5 */
 };
 
 struct offb_par {
@@ -149,6 +150,18 @@
 		out_le32((unsigned *) par->cmap_adr + regno,
 			 (red << 16 | green << 8 | blue));
 		break;
+	case cmap_3dfx:
+		/* Wait for 3 slots in the FIFO */
+		while((in_le32((unsigned *) par->cmap_adr) & 0x1F) < 3);
+		/* Is the desktop using the upper 256 entries of 
+		 * the CLUT ? */
+		if ((in_le32((unsigned *) par->cmap_adr + 0x5C) & 1 << 12))
+			regno += 256;
+		/* Stuff the palette index and data */
+		out_le32((unsigned *)(par->cmap_adr + 0x50), regno);
+		out_le32((unsigned *)(par->cmap_adr + 0x54),
+			 (red << 16 | green << 8 | blue));
+		break;	
 	}
 
 	if (regno < 16)
@@ -175,7 +188,7 @@
 static int offb_blank(int blank, struct fb_info *info)
 {
 	struct offb_par *par = (struct offb_par *) info->par;
-	int i, j;
+	int i, j, regno;
 
 	if (!par->cmap_adr)
 		return 0;
@@ -233,6 +246,20 @@
 				out_le32((unsigned *) par->cmap_adr + i,
 					 0);
 				break;
+			case cmap_3dfx:
+				/* Wait for 3 slots in the FIFO */
+				while((in_le32((unsigned *) par->cmap_adr) & 0x1F) < 3);
+				/* Is the desktop using the upper 256 
+				 * entries of the CLUT ? */
+				regno = (in_le32((unsigned *) par->cmap_adr +
+							0x5C) & 1 << 12) ?
+							i+256 : i;
+				/* Stuff the palette index and data */
+				out_le32((unsigned *)(par->cmap_adr + 0x50), 
+							regno);
+				out_le32((unsigned *)(par->cmap_adr + 0x54),
+							0);
+				break;
 			}
 	} else
 		fb_set_cmap(&info->cmap, 1, info);
@@ -466,6 +493,10 @@
 			unsigned long regbase = dp->addrs[0].address;
 			par->cmap_adr = ioremap(regbase + 0x6000, 0x1000);
 			par->cmap_type = cmap_gxt2000;
+		} else if (!strncmp(name, "3Dfx,Voodoo", 11)) {
+			unsigned long regbase = dp->addrs[2].address;
+			par->cmap_adr = ioremap(regbase, 0xff);
+			par->cmap_type = cmap_3dfx;
 		}
 		fix->visual = par->cmap_adr ? FB_VISUAL_PSEUDOCOLOR
 		    : FB_VISUAL_STATIC_PSEUDOCOLOR;

