Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264709AbRFXVGf>; Sun, 24 Jun 2001 17:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264719AbRFXVGZ>; Sun, 24 Jun 2001 17:06:25 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:18791
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S264709AbRFXVGO>; Sun, 24 Jun 2001 17:06:14 -0400
Date: Sun, 24 Jun 2001 23:06:06 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-computone@lazuli.wittsend.com, linux-kernel@vger.kernel.org
Subject: [PATCH] catch potential null derefs in drivers/char/ip2main.c (245ac16)
Message-ID: <20010624230606.G847@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

(My last mail to dougm@computone.com bounced. Is there another
maintainer for drivers/char/ip2main.c somewhere?)

The patch below tries to avoid dereferencing (potential)
NULL pointers. It was reported by the Stanford team way
back and applies against 245ac16 and 246p6. It could
probably be done nicer but that would take someone that
actually understands this code.

--- linux-245-ac16-clean/drivers/char/ip2main.c	Sat May 19 20:58:17 2001
+++ linux-245-ac16/drivers/char/ip2main.c	Sun Jun 24 22:37:27 2001
@@ -866,36 +866,38 @@
 			}
 
 #ifdef	CONFIG_DEVFS_FS
-			sprintf( name, "ipl%d", i );
-			i2BoardPtrTable[i]->devfs_ipl_handle =
-				devfs_register (devfs_handle, name,
-					DEVFS_FL_DEFAULT,
-					IP2_IPL_MAJOR, 4 * i,
-					S_IRUSR | S_IWUSR | S_IRGRP | S_IFCHR,
-					&ip2_ipl, NULL);
+			if (i2BoardPtrTable[i] && pB) {
+				sprintf( name, "ipl%d", i );
+				i2BoardPtrTable[i]->devfs_ipl_handle =
+					devfs_register (devfs_handle, name,
+							DEVFS_FL_DEFAULT,
+							IP2_IPL_MAJOR, 4 * i,
+							S_IRUSR | S_IWUSR | S_IRGRP | S_IFCHR,
+							&ip2_ipl, NULL);
 
-			sprintf( name, "stat%d", i );
-			i2BoardPtrTable[i]->devfs_stat_handle =
-				devfs_register (devfs_handle, name,
-					DEVFS_FL_DEFAULT,
-					IP2_IPL_MAJOR, 4 * i + 1,
-					S_IRUSR | S_IWUSR | S_IRGRP | S_IFCHR,
-					&ip2_ipl, NULL);
+				sprintf( name, "stat%d", i );
+				i2BoardPtrTable[i]->devfs_stat_handle =
+					devfs_register (devfs_handle, name,
+							DEVFS_FL_DEFAULT,
+							IP2_IPL_MAJOR, 4 * i + 1,
+							S_IRUSR | S_IWUSR | S_IRGRP | S_IFCHR,
+							&ip2_ipl, NULL);
 
-			for ( box = 0; box < ABS_MAX_BOXES; ++box )
-			{
-			    for ( j = 0; j < ABS_BIGGEST_BOX; ++j )
-			    {
-				if ( pB->i2eChannelMap[box] & (1 << j) )
+				for ( box = 0; box < ABS_MAX_BOXES; ++box )
 				{
-				    tty_register_devfs(&ip2_tty_driver,
-					0, j + ABS_BIGGEST_BOX *
-						(box+i*ABS_MAX_BOXES));
-				    tty_register_devfs(&ip2_callout_driver,
-					0, j + ABS_BIGGEST_BOX *
-						(box+i*ABS_MAX_BOXES));
+					for ( j = 0; j < ABS_BIGGEST_BOX; ++j )
+					{
+						if ( pB->i2eChannelMap[box] & (1 << j) )
+						{
+							tty_register_devfs(&ip2_tty_driver,
+									   0, j + ABS_BIGGEST_BOX *
+									   (box+i*ABS_MAX_BOXES));
+							tty_register_devfs(&ip2_callout_driver,
+									   0, j + ABS_BIGGEST_BOX *
+									   (box+i*ABS_MAX_BOXES));
+						}
+					}
 				}
-			    }
 			}
 #endif
 
-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

A chicken and an egg are lying in bed. The chicken is smoking a
cigarette with a satisfied smile on it's face and the egg is frowning
and looking a bit pissed off. The egg mutters, to no-one in particular,
"Well, I guess we answered THAT question..."
