Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268817AbUJKLe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268817AbUJKLe1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 07:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268812AbUJKLe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 07:34:27 -0400
Received: from linaeum.absolutedigital.net ([63.87.232.45]:18087 "EHLO
	linaeum.absolutedigital.net") by vger.kernel.org with ESMTP
	id S268803AbUJKLeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 07:34:09 -0400
Date: Mon, 11 Oct 2004 07:34:00 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: NetDev Mailing List <netdev@oss.sgi.com>, proski@gnu.org,
       hermes@gibson.dropbear.id.au
Subject: [PATCH] Fix readw/writew warnings in drivers/net/wireless/hermes.h
Message-ID: <Pine.LNX.4.61.0410110702590.7899@linaeum.absolutedigital.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fixes several dozen warnings spit out when compiling the hermes 
wireless driver.

In file included from drivers/net/wireless/orinoco.c:448:
drivers/net/wireless/hermes.h: In function `hermes_present':
drivers/net/wireless/hermes.h:398: warning: passing arg 1 of `readw' makes pointer from integer without a cast
drivers/net/wireless/hermes.h: In function `hermes_set_irqmask':
drivers/net/wireless/hermes.h:404: warning: passing arg 2 of `writew' makes pointer from integer without a cast
...

thanks,

-- Cal


Signed-off-by: Cal Peake <cp@absolutedigital.net>


diff -Nru linux-2.6.9-rc4/drivers/net/wireless/hermes.h linux-2.6.9-rc4-1/drivers/net/wireless/hermes.h
--- linux-2.6.9-rc4/drivers/net/wireless/hermes.h	2004-10-11 02:38:38.000000000 -0400
+++ linux-2.6.9-rc4-1/drivers/net/wireless/hermes.h	2004-10-11 06:56:01.000000000 -0400
@@ -364,12 +364,12 @@
 /* Register access convenience macros */
 #define hermes_read_reg(hw, off) ((hw)->io_space ? \
 	inw((hw)->iobase + ( (off) << (hw)->reg_spacing )) : \
-	readw((hw)->iobase + ( (off) << (hw)->reg_spacing )))
+	readw((void __iomem *)(hw)->iobase + ( (off) << (hw)->reg_spacing )))
 #define hermes_write_reg(hw, off, val) do { \
 	if ((hw)->io_space) \
 		outw_p((val), (hw)->iobase + ((off) << (hw)->reg_spacing)); \
 	else \
-		writew((val), (hw)->iobase + ((off) << (hw)->reg_spacing)); \
+		writew((val), (void __iomem *)(hw)->iobase + ((off) << (hw)->reg_spacing)); \
 	} while (0)
 #define hermes_read_regn(hw, name) hermes_read_reg((hw), HERMES_##name)
 #define hermes_write_regn(hw, name, val) hermes_write_reg((hw), HERMES_##name, (val))
@@ -442,7 +442,7 @@
 		 * gcc is smart enough to fold away the two swaps on
 		 * big-endian platforms. */
 		for (i = 0, p = buf; i < count; i++) {
-			*p++ = cpu_to_le16(readw(hw->iobase + off));
+			*p++ = cpu_to_le16(readw((void __iomem *)hw->iobase + off));
 		}
 	}
 }
@@ -462,7 +462,7 @@
 		 * hope gcc is smart enough to fold away the two swaps
 		 * on big-endian platforms. */
 		for (i = 0, p = buf; i < count; i++) {
-			writew(le16_to_cpu(*p++), hw->iobase + off);
+			writew(le16_to_cpu(*p++), (void __iomem *)hw->iobase + off);
 		}
 	}
 }
@@ -478,7 +478,7 @@
 			outw(0, hw->iobase + off);
 	} else {
 		for (i = 0; i < count; i++)
-			writew(0, hw->iobase + off);
+			writew(0, (void __iomem *)hw->iobase + off);
 	}
 }
 
