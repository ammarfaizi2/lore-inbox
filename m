Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265406AbTFWJPl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 05:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265397AbTFWJPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 05:15:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17674 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265406AbTFWJPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 05:15:39 -0400
Date: Mon, 23 Jun 2003 10:29:41 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Eivind Tagseth <eivindt@multinet.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with PCMCIA Compact Flash adapter in 2.5.72
Message-ID: <20030623102941.D23411@flint.arm.linux.org.uk>
Mail-Followup-To: Eivind Tagseth <eivindt@multinet.no>,
	linux-kernel@vger.kernel.org
References: <20030620081846.GB2451@tagseth-trd.consultit.no> <20030620211640.B913@flint.arm.linux.org.uk> <20030622114642.GB1785@tagseth-trd.consultit.no> <20030622141541.B16537@flint.arm.linux.org.uk> <20030622182838.GA6970@tagseth-trd.consultit.no> <20030622191626.GA1811@tagseth-trd.consultit.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030622191626.GA1811@tagseth-trd.consultit.no>; from eivindt@multinet.no on Sun, Jun 22, 2003 at 09:16:27PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 22, 2003 at 09:16:27PM +0200, Eivind Tagseth wrote:
> However, removing the card causes a kernel panic, and everything completely
> freezes.  This also happened with 2.5.69, so it's not caused by a recent
> change.

ide-cs currently calls ide_unregister from interrupt context, which is
a big nono.  Can you try the following patch please (which is completely
untested)?

--- orig/drivers/ide/legacy/ide-cs.c	Sat Jun 14 22:33:52 2003
+++ linux/drivers/ide/legacy/ide-cs.c	Mon Jun 23 10:27:20 2003
@@ -92,7 +92,7 @@
     int		hd;
 } ide_info_t;
 
-static void ide_release(u_long arg);
+static void ide_release(dev_link_t *link);
 static int ide_event(event_t event, int priority,
 		     event_callback_args_t *args);
 
@@ -126,9 +126,6 @@
     memset(info, 0, sizeof(*info));
     link = &info->link; link->priv = info;
 
-    init_timer(&link->release);
-    link->release.function = &ide_release;
-    link->release.data = (u_long)link;
     link->io.Attributes1 = IO_DATA_PATH_WIDTH_AUTO;
     link->io.Attributes2 = IO_DATA_PATH_WIDTH_8;
     link->io.IOAddrLines = 3;
@@ -187,9 +184,8 @@
     if (*linkp == NULL)
 	return;
 
-    del_timer(&link->release);
     if (link->state & DEV_CONFIG)
-	ide_release((u_long)link);
+	ide_release(link);
     
     if (link->handle) {
 	ret = CardServices(DeregisterClient, link->handle);
@@ -383,7 +379,7 @@
 cs_failed:
     cs_error(link->handle, last_fn, last_ret);
 failed:
-    ide_release((u_long)link);
+    ide_release(link);
     link->state &= ~DEV_CONFIG_PENDING;
 
 } /* ide_config */
@@ -396,9 +392,8 @@
     
 ======================================================================*/
 
-void ide_release(u_long arg)
+void ide_release(dev_link_t *link)
 {
-    dev_link_t *link = (dev_link_t *)arg;
     ide_info_t *info = link->priv;
     
     DEBUG(0, "ide_release(0x%p)\n", link);
@@ -446,7 +441,7 @@
     case CS_EVENT_CARD_REMOVAL:
 	link->state &= ~DEV_PRESENT;
 	if (link->state & DEV_CONFIG)
-	    mod_timer(&link->release, jiffies + HZ/20);
+	    ide_release(link);
 	break;
     case CS_EVENT_CARD_INSERTION:
 	link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

