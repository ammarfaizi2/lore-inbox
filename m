Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293224AbSCUDiw>; Wed, 20 Mar 2002 22:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293237AbSCUDin>; Wed, 20 Mar 2002 22:38:43 -0500
Received: from adsl-209-233-24-156.dsl.snfc21.pacbell.net ([209.233.24.156]:61192
	"EHLO mail.muru.com") by vger.kernel.org with ESMTP
	id <S293224AbSCUDi0>; Wed, 20 Mar 2002 22:38:26 -0500
Date: Wed, 20 Mar 2002 19:38:24 -0800
To: linux-kernel@vger.kernel.org
Cc: dhinds@zen.stanford.edu, marcelo@conectiva.com.br
Subject: [PATCH] Resend: 2.4 PCMCIA linear flash memory card fix
Message-ID: <20020321033824.GA8852@muru.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-URL: http://www.muru.com/ http://www.atomide.com
X-Accept-Language: fi en
X-Location: USA, California, San Francisco
From: Tony Lindgren <tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Here's a resend of the patch to fix the 2.4 PCMCIA linear flash cards.
Looks like I was using the non-working sourceforge address for David 
Hinds. CC:ing Marcelo Tosatti too.

The patch is against 2.4.17, but works on other recent kernels too. 
(I just tested it against 2.4.19-pre4)

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

Here's a short description of the fix:

Basically there were two problems; The RegisterMTD ioctl was
accidentally dropped at some point, so the flash cards would not
register. Then the reference to the flash card memory window was
incorrect, so the cards were not seen, and the flash drivers would
not unload after use.

Regards,

Tony

--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="linux-2.4.17-pcmcia-mtd.patch"

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

--xesSdrSSBC0PokLI--
