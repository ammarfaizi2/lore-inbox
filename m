Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267773AbTAMD1s>; Sun, 12 Jan 2003 22:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267775AbTAMD1s>; Sun, 12 Jan 2003 22:27:48 -0500
Received: from dp.samba.org ([66.70.73.150]:18882 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267773AbTAMD1k>;
	Sun, 12 Jan 2003 22:27:40 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15906.13194.169834.758112@argo.ozlabs.ibm.com>
Date: Mon, 13 Jan 2003 14:33:30 +1100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
In-Reply-To: <1042312710.2952.6.camel@irongate.swansea.linux.org.uk>
References: <20030110165441$1a8a@gated-at.bofh.it>
	<20030110165505$38d9@gated-at.bofh.it>
	<m3iswv27o3.fsf@averell.firstfloor.org>
	<1042295999.2517.10.camel@irongate.swansea.linux.org.uk>
	<20030111140602.GA20221@averell>
	<1042299059.2517.29.camel@irongate.swansea.linux.org.uk>
	<20030111152529.GA20512@averell>
	<1042312710.2952.6.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:

> The pcmcia stuff crashes erratically with the old IDE the bugs have not
> changed but the problem now shows up far more often. With a 2Gb type II
> PCMCIA IDE disk I get a crash about 1 in 3 ejects now.

I'm using the patch below, which makes sure that ide_release (in
ide-cs.c) runs in process context not interrupt context.  The specific
problem I saw was that ide_unregister calls various devfs routines
that don't like being called in interrupt context, but there may well
be other thing ide_unregister does that aren't safe in interrupt
context.

I am also hitting another problem on my powerbook that I would like
your advice on.  The thing is that my powerbook (a 500MHz G4 titanium
powerbook) has 3 IDE interfaces, but only the first two have anything
attached.  The pmac IDE driver goes through and initializes all three,
including setting hwif->selectproc for each one.  Then, when I plug in
a CF card in the pcmcia/cardbus slot, ide_register_hw goes and looks
for a free ide_hwifs[] entry.  Slot 2 appears to be available because
there are no devices attached, and so it uses that.  In the process of
setting up ide_hwifs[2], it sets hwif->io_ports but it doesn't reset
selectproc (or hwif->OUTB etc., AFAICS).  The result is that it calls
the pmac IDE selectproc, which crashes (since we munged hwif->io_ports
without telling it).

I have "fixed" the problem for now by adding a call to
init_hwif_data(index) in ide_register_hw just before the first
memcpy.  I'd be interested to know what the right fix is. :)

Regards,
Paul.

diff -urN linux-2.4/drivers/ide/legacy/ide-cs.c pmac/drivers/ide/legacy/ide-cs.c
--- linux-2.4/drivers/ide/legacy/ide-cs.c	2002-12-19 11:50:35.000000000 +1100
+++ pmac/drivers/ide/legacy/ide-cs.c	2003-01-13 14:02:31.000000000 +1100
@@ -92,10 +92,11 @@
     int		ndev;
     dev_node_t	node;
     int		hd;
+    struct tq_struct rel_task;
 } ide_info_t;
 
 static void ide_config(dev_link_t *link);
-static void ide_release(u_long arg);
+static void ide_release(void *arg);
 static int ide_event(event_t event, int priority,
 		     event_callback_args_t *args);
 
@@ -136,9 +137,8 @@
     if (!info) return NULL;
     memset(info, 0, sizeof(*info));
     link = &info->link; link->priv = info;
+    INIT_TQUEUE(&info->rel_task, ide_release, link);
 
-    link->release.function = &ide_release;
-    link->release.data = (u_long)link;
     link->io.Attributes1 = IO_DATA_PATH_WIDTH_AUTO;
     link->io.Attributes2 = IO_DATA_PATH_WIDTH_8;
     link->io.IOAddrLines = 3;
@@ -187,6 +187,7 @@
 static void ide_detach(dev_link_t *link)
 {
     dev_link_t **linkp;
+    ide_info_t *info = link->priv;
     int ret;
 
     DEBUG(0, "ide_detach(0x%p)\n", link);
@@ -197,9 +198,10 @@
     if (*linkp == NULL)
 	return;
 
-    del_timer(&link->release);
-    if (link->state & DEV_CONFIG)
-	ide_release((u_long)link);
+    if (link->state & DEV_CONFIG) {
+	schedule_task(&info->rel_task);
+	flush_scheduled_tasks();
+    }
     
     if (link->handle) {
 	ret = CardServices(DeregisterClient, link->handle);
@@ -209,7 +211,7 @@
     
     /* Unlink, free device structure */
     *linkp = link->next;
-    kfree(link->priv);
+    kfree(info);
     
 } /* ide_detach */
 
@@ -381,7 +383,7 @@
 cs_failed:
     cs_error(link->handle, last_fn, last_ret);
 failed:
-    ide_release((u_long)link);
+    ide_release(link);
 
 } /* ide_config */
 
@@ -393,12 +395,15 @@
     
 ======================================================================*/
 
-void ide_release(u_long arg)
+static void ide_release(void *arg)
 {
-    dev_link_t *link = (dev_link_t *)arg;
+    dev_link_t *link = arg;
     ide_info_t *info = link->priv;
     
-    DEBUG(0, "ide_release(0x%p)\n", link);
+    if (!(link->state & DEV_CONFIG))
+	return;
+
+    DEBUG(0, "ide_do_release(0x%p)\n", link);
 
     if (info->ndev) {
         /* FIXME: if this fails we need to queue the cleanup somehow
@@ -435,6 +440,7 @@
 	      event_callback_args_t *args)
 {
     dev_link_t *link = args->client_data;
+    ide_info_t *info = link->priv;
 
     DEBUG(1, "ide_event(0x%06x)\n", event);
     
@@ -442,7 +448,7 @@
     case CS_EVENT_CARD_REMOVAL:
 	link->state &= ~DEV_PRESENT;
 	if (link->state & DEV_CONFIG)
-	    mod_timer(&link->release, jiffies + HZ/20);
+	    schedule_task(&info->rel_task);
 	break;
     case CS_EVENT_CARD_INSERTION:
 	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
