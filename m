Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268168AbTBOA1Q>; Fri, 14 Feb 2003 19:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268237AbTBOA1Q>; Fri, 14 Feb 2003 19:27:16 -0500
Received: from air-2.osdl.org ([65.172.181.6]:29312 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S268168AbTBOA1O>;
	Fri, 14 Feb 2003 19:27:14 -0500
Date: Fri, 14 Feb 2003 16:37:00 -0800
From: Bob Miller <rem@osdl.org>
To: Lars Magne Ingebrigtsen <larsi@gnus.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.60 5/9] Update the Archimedes parallel port driver for new module API.
Message-ID: <20030215003700.GA13456@doc.pdx.osdl.net>
References: <20030214235325.GH13336@doc.pdx.osdl.net> <m3el6agzw0.fsf@quimbies.gnus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3el6agzw0.fsf@quimbies.gnus.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2003 at 01:18:23AM +0100, Lars Magne Ingebrigtsen wrote:
> Bob Miller <rem@osdl.org> writes:
> 
> > --- a/drivers/parport/parport_arc.c	Fri Feb 14 09:50:44 2003
> 
> [...]
> 
> > +	char *fake_name = "parport probe");
> 
> Surely that can't be correct?  (The parenthesis at the end there, I
> mean...)
> 
Sigh...  Corrected diff below...

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17


diff -Nru a/drivers/parport/parport_arc.c b/drivers/parport/parport_arc.c
--- a/drivers/parport/parport_arc.c	Fri Feb 14 09:50:44 2003
+++ b/drivers/parport/parport_arc.c	Fri Feb 14 09:50:44 2003
@@ -65,18 +65,14 @@
 	return data_copy;
 }
 
-static void arc_inc_use_count(void)
+static int arc_inc_use_count(void)
 {
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
+	return try_module_get(THIS_MODULE);
 }
 
 static void arc_dec_use_count(void)
 {
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
+	module_put(THIS_MODULE);
 }
 
 static struct parport_operations parport_arc_ops = 
@@ -123,18 +119,24 @@
 {
 	/* Archimedes hardware provides only one port, at a fixed address */
 	struct parport *p;
+	struct resource res;
+	char *fake_name = "parport probe";
 
-	if (check_region(PORT_BASE, 1))
+	res = request_region(PORT_BASE, 1, fake_name);
+	if (res == NULL)
 		return 0;
 
 	p = parport_register_port (PORT_BASE, IRQ_PRINTERACK,
 				   PARPORT_DMA_NONE, &parport_arc_ops);
 
-	if (!p)
+	if (!p) {
+		release_region(PORT_BASE, 1);
 		return 0;
+	}
 
 	p->modes = PARPORT_MODE_ARCSPP;
 	p->size = 1;
+	rename_region(res, p->name);
 
 	printk(KERN_INFO "%s: Archimedes on-board port, using irq %d\n",
 	       p->irq);

