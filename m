Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288344AbSA0SgI>; Sun, 27 Jan 2002 13:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288354AbSA0Sf6>; Sun, 27 Jan 2002 13:35:58 -0500
Received: from adsl-209-233-24-156.dsl.snfc21.pacbell.net ([209.233.24.156]:56072
	"EHLO nw.muru.com") by vger.kernel.org with ESMTP
	id <S288344AbSA0Sfy>; Sun, 27 Jan 2002 13:35:54 -0500
Date: Sun, 27 Jan 2002 10:35:52 -0800
To: linux-kernel@vger.kernel.org
Cc: dhinds@pcmcia.sourceforge.org
Subject: [PATCH] Linux kernel PCMCIA linear flash memory card fix
Message-ID: <20020127183552.GA8429@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-URL: http://www.muru.com/ http://www.atomide.com
X-Accept-Language: fi en
X-Location: USA, California, San Francisco
From: Tony Lindgren <tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's a little patch to fix the 2.4.17 PCMCIA to make linear flash
cards work. The patch should work with all the recent kernels.

Linear flash card are rarely used, but are needed to boot some embedded
systems, like the AMD ELAN. They are also used in some Cisco routers.

Just FYI, here's some Linux related projects where linear flash cards 
may be used:

Wireless access points running Linux:
http://opensource.instant802.com/

Alios boot loader for AMD ELAN:
http://www.telos.de/linux/alios/default_e.htm

Read Cisco flash cards from Linux: 
ftp://ftp.bbc.co.uk/pub/ciscoflash/

I'm CC'ing dhinds, as I guess he's taking care of the PCMCIA in 
the kernel?

Here's a short description of the fix:

Basically there were two problems; The RegisterMTD ioctl was
accidentally dropped at some point, so the flash cards would not
register. Then the reference to the flash card memory window was   
incorrect, so the cards were not seen, and the flash drivers would 
not unload after use.

Cheers,

Tony


diff -urN -X ./dontdiff linux-2.4.17-vanilla/drivers/pcmcia/bulkmem.c linux-2.4.17-tony/drivers/pcmcia/bulkmem.c
--- linux-2.4.17-vanilla/drivers/pcmcia/bulkmem.c	Sun Aug 12 17:37:53 2001
+++ linux-2.4.17-tony/drivers/pcmcia/bulkmem.c	Sat Jan 26 21:41:49 2002
@@ -300,7 +300,7 @@
     {
 	window_handle_t w;
         int ret = pcmcia_request_window(a1, a2, &w);
-        (window_handle_t *)a1 = w;
+        *(window_handle_t *)a1 = w;
 	return  ret;
     }
         break;
diff -urN -X ./dontdiff linux-2.4.17-vanilla/drivers/pcmcia/cs.c linux-2.4.17-tony/drivers/pcmcia/cs.c
--- linux-2.4.17-vanilla/drivers/pcmcia/cs.c	Fri Dec 21 09:41:55 2001
+++ linux-2.4.17-tony/drivers/pcmcia/cs.c	Sat Jan 26 21:41:15 2002
@@ -2283,9 +2283,8 @@
         *(eraseq_handle_t *)a1 = w;
 	return  ret;
     }
-        break;
-/*	return pcmcia_register_erase_queue(a1, a2); break; */
-
+	break;
+    case RegisterMTD:
 	return pcmcia_register_mtd(a1, a2); break;
     case ReleaseConfiguration:
 	return pcmcia_release_configuration(a1); break;
