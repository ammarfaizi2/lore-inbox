Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264262AbTCXQO5>; Mon, 24 Mar 2003 11:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264265AbTCXQO5>; Mon, 24 Mar 2003 11:14:57 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:32235 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264262AbTCXQOy>; Mon, 24 Mar 2003 11:14:54 -0500
Date: Mon, 24 Mar 2003 17:25:19 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pcmcia_bus_type changes cause oops...
Message-ID: <20030324162519.GB2194@brodo.de>
References: <20030324153659.GA32044@hottah.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030324153659.GA32044@hottah.alcove-fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stelian,

Thanks for your bug report. Let me analyze it a bit:

> ds: no socket drivers loaded!

ds.o is loaded for the first time, but fails as the yenta-socket driver was 
not loaded before

> pcnet_cs: Unknown symbol pcmcia_unregister_driver
> pcnet_cs: Unknown symbol pcmcia_register_driver

This is strange. There is an EXPORT_SYMBOL(pcmcia_register_driver) ...
maybe gets away after a "make clean"... not worriesome, though; as the
loading continues.

> kobject pcmcia: registering. parent: <NULL>, set: bus
ds.o is loaded for the second time; and pcmcia_bus_type is to be added
again. Due to a bug in ds.c it didn't get unregistered in the failed loading
of ds.o - the attached patch should fix it. Could you please try it?

It is strange, though, that you nonetheless managed to get it to work with
"inadvertedly modified" timings...

Thanks,

	Dominik

--- linux/drivers/pcmcia/ds.c.original	2003-03-24 17:23:29.000000000 +0100
+++ linux/drivers/pcmcia/ds.c	2003-03-24 17:14:10.000000000 +0100
@@ -920,16 +920,16 @@
     pcmcia_get_card_services_info(&serv);
     if (serv.Revision != CS_RELEASE_CODE) {
 	printk(KERN_NOTICE "ds: Card Services release does not match!\n");
-	return -1;
+	goto error;
     }
     if (serv.Count == 0) {
 	printk(KERN_NOTICE "ds: no socket drivers loaded!\n");
-	return -1;
+	goto error;
     }
     
     sockets = serv.Count;
     socket_table = kmalloc(sockets*sizeof(socket_info_t), GFP_KERNEL);
-    if (!socket_table) return -1;
+    if (!socket_table) goto error;
     for (i = 0, s = socket_table; i < sockets; i++, s++) {
 	s->state = 0;
 	s->user = NULL;
@@ -984,6 +984,9 @@
     init_status = 0;
 #endif
     return 0;
+ error:
+    bus_unregister(&pcmcia_bus_type);
+    return 1;
 }
 
 
