Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130895AbRCFDKH>; Mon, 5 Mar 2001 22:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130897AbRCFDJ6>; Mon, 5 Mar 2001 22:09:58 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:21983 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S130895AbRCFDJo>;
	Mon, 5 Mar 2001 22:09:44 -0500
Message-ID: <3AA454F6.712C1814@mandrakesoft.com>
Date: Mon, 05 Mar 2001 22:09:42 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
Cc: glouis@dynamicro.on.ca, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Re: 3c509 2.4.2-ac12 compilation fails
In-Reply-To: <200103060142.f261guu26012@devserv.devel.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------5CD5B45C41EE9665EC9A176E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5CD5B45C41EE9665EC9A176E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> 
> > /me begins to download and merge ac12...
> 
> It built for me too

Found it -- 3c509 bug of a different sort.  You don't notice if
CONFIG_ISAPNP is a module... only if its built into the kernel.  That
code is not conditional on CONFIG_ISAPNP_MODULE, only CONFIG_ISAPNP.

Attached are the compilation fixes -- should apply to 2.4.3-pre2 or
2.4.2-ac12 ok.

The patch does not address the larger issue of CONFIG_ISAPNP versus
CONFIG_ISAPNP_MODULE...  That will have to be visited for several
drivers I think, and its not a 2-second obvious fix like the attached
patch (which needs to be applied anyway).

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
--------------5CD5B45C41EE9665EC9A176E
Content-Type: text/plain; charset=us-ascii;
 name="netfix-2.4.3.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netfix-2.4.3.2.patch"

Index: drivers/net/3c509.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/3c509.c,v
retrieving revision 1.1.1.22.2.1
diff -u -r1.1.1.22.2.1 3c509.c
--- drivers/net/3c509.c	2001/03/05 00:39:14	1.1.1.22.2.1
+++ drivers/net/3c509.c	2001/03/06 03:05:53
@@ -327,7 +327,7 @@
 			irq = idev->irq_resource[0].start;
 			if (el3_debug > 3)
 				printk ("ISAPnP reports %s at i/o 0x%x, irq %d\n",
-					el3_isapnp_adapters[i].name, ioaddr, irq);
+					(char*) el3_isapnp_adapters[i].driver_data, ioaddr, irq);
 			EL3WINDOW(0);
 			for (j = 0; j < 3; j++)
 				el3_isapnp_phys_addr[pnp_cards][j] =
Index: drivers/net/3c515.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/3c515.c,v
retrieving revision 1.1.1.22.2.1
diff -u -r1.1.1.22.2.1 3c515.c
--- drivers/net/3c515.c	2001/03/05 00:39:14	1.1.1.22.2.1
+++ drivers/net/3c515.c	2001/03/06 03:05:54
@@ -474,7 +474,7 @@
 			irq = idev->irq_resource[0].start;
 			if(corkscrew_debug)
 				printk ("ISAPNP reports %s at i/o 0x%x, irq %d\n",
-					corkscrew_isapnp_adapters[i].name,ioaddr, irq);
+					(char*) corkscrew_isapnp_adapters[i].driver_data, ioaddr, irq);
 					
 			if ((inw(ioaddr + 0x2002) & 0x1f0) != (ioaddr & 0x1f0))
 				continue;

--------------5CD5B45C41EE9665EC9A176E--

