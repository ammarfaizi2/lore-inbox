Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTLJUql (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 15:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263942AbTLJUql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 15:46:41 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:63206 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263930AbTLJUqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 15:46:38 -0500
Date: Wed, 10 Dec 2003 21:46:28 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, ralf@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.24-pre1: ask for CONFIG_INDYDOG only on mips
Message-ID: <20031210204628.GA9103@fs.tum.de>
References: <Pine.LNX.4.44.0312101417080.1546-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0312101417080.1546-100000@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 02:23:14PM -0200, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.23 to v2.4.24-pre1
> ============================================
>...
> Ralf Bächle:
>...
>   o MIPS char driver update
>...

This change contains the following bogus change for
drivers/char/Config.in:

...
@@ -237,9 +251,6 @@
    tristate '  Eurotech CPU-1220/1410 Watchdog Timer' CONFIG_EUROTECH_WDT
    tristate '  IB700 SBC Watchdog Timer' CONFIG_IB700_WDT
    tristate '  ICP ELectronics Wafer 5823 Watchdog' CONFIG_WAFER_WDT
-   if [ "$CONFIG_SGI_IP22" = "y" ]; then
-      dep_tristate '  Indy/I2 Hardware Watchdog' CONFIG_INDYDOG $CONFIG_SGI_IP22
-   fi
    tristate '  Intel i810 TCO timer / Watchdog' CONFIG_I810_TCO
    tristate '  Mixcom Watchdog' CONFIG_MIXCOMWD
    tristate '  SBC-60XX Watchdog Timer' CONFIG_60XX_WDT
@@ -256,6 +267,7 @@
       fi
    fi
    tristate '  ZF MachZ Watchdog' CONFIG_MACHZ_WDT
+   dep_tristate '  Indy/I2 Hardware Watchdog' CONFIG_INDYDOG $CONFIG_SGI_IP22
    dep_tristate '  AMD 766/768 TCO Timer/Watchdog' CONFIG_AMD7XX_TCO $CONFIG_EXPERIMENTAL
 fi
 endmenu
...


A dependency on a possibly undefined variable doesn't work with the 2.4 
config system, and "make oldconfig" asks me on i386 for CONFIG_INDYDOG.

The following patch fixes it:


--- linux-2.4.24-pre1-full/drivers/char/Config.in.old	2003-12-10 18:48:40.000000000 +0100
+++ linux-2.4.24-pre1-full/drivers/char/Config.in	2003-12-10 18:51:15.000000000 +0100
@@ -267,7 +267,9 @@
       fi
    fi
    tristate '  ZF MachZ Watchdog' CONFIG_MACHZ_WDT
-   dep_tristate '  Indy/I2 Hardware Watchdog' CONFIG_INDYDOG $CONFIG_SGI_IP22
+   if [ "$CONFIG_SGI_IP22" = "y" ]; then
+      dep_tristate '  Indy/I2 Hardware Watchdog' CONFIG_INDYDOG $CONFIG_SGI_IP22
+   fi
    dep_tristate '  AMD 766/768 TCO Timer/Watchdog' CONFIG_AMD7XX_TCO $CONFIG_EXPERIMENTAL
 fi
 endmenu



cu
Adrian

BTW: Why does this mips patch remove the i386 Mwave support option
     from drivers/char/Config.in ?

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

