Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263273AbTCYT0v>; Tue, 25 Mar 2003 14:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbTCYT0u>; Tue, 25 Mar 2003 14:26:50 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:3761 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263273AbTCYT0o>; Tue, 25 Mar 2003 14:26:44 -0500
Date: Tue, 25 Mar 2003 20:37:17 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia (2/4): remove "init_status" from struct pcmcia_driver
Message-ID: <20030325193717.GB15319@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As we don't have a late_initcall in ds.c any more, we can't easily
distinguish between in-kernel drivers and those built as modules. This
information was used by cardmgr to detect whether "rmmod" makes
sense. As unloading of modules seems to be deprecated behaviour anyway
in 2.5., and the current driver unloading process is IMO broken
anyway, I don't shed any tears on this lost functionality.

 drivers/pcmcia/ds.c |    7 +------
 include/pcmcia/ds.h |    2 +-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff -ruN linux-original/drivers/pcmcia/ds.c linux/drivers/pcmcia/ds.c
--- linux-original/drivers/pcmcia/ds.c	2003-03-25 19:49:54.000000000 +0100
+++ linux/drivers/pcmcia/ds.c	2003-03-25 19:55:59.000000000 +0100
@@ -129,9 +129,6 @@
 
 extern struct proc_dir_entry *proc_pccard;
 
-/* We use this to distinguish in-kernel from modular drivers */
-static int init_status = 1;
-
 /*====================================================================*/
 
 static void cs_error(client_handle_t handle, int func, int ret)
@@ -156,7 +153,6 @@
 		return -EINVAL;
 
  	driver->use_count = 0;
- 	driver->status = init_status;
 	driver->drv.bus = &pcmcia_bus_type;
 
 	return driver_register(&driver->drv);
@@ -251,8 +247,7 @@
 	struct pcmcia_driver *p_dev = container_of(driver, 
 						   struct pcmcia_driver, drv);
 
-	*p += sprintf(*p, "%-24.24s %d %d\n", driver->name, p_dev->status,
-		     p_dev->use_count);
+	*p += sprintf(*p, "%-24.24s 1 %d\n", driver->name, p_dev->use_count);
 	d = (void *) p;
 
 	return 0;
diff -ruN linux-original/include/pcmcia/ds.h linux/include/pcmcia/ds.h
--- linux-original/include/pcmcia/ds.h	2003-03-25 18:26:53.000000000 +0100
+++ linux/include/pcmcia/ds.h	2003-03-25 19:51:04.000000000 +0100
@@ -144,7 +144,7 @@
 extern struct bus_type pcmcia_bus_type;
 
 struct pcmcia_driver {
-	int			use_count, status;
+	int			use_count;
 	dev_link_t		*(*attach)(void);
 	void			(*detach)(dev_link_t *);
 	struct module		*owner;
