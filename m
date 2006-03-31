Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWCaUhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWCaUhR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 15:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWCaUhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 15:37:12 -0500
Received: from isilmar.linta.de ([213.239.214.66]:44247 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932283AbWCaUf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 15:35:59 -0500
Date: Fri, 31 Mar 2006 22:17:44 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-pcmcia@lists.infradead.org
Cc: netdev@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH 18/33] pcmcia: convert remaining users of pcmcia_release_io and _irq
Message-ID: <20060331201744.GG28037@dominikbrodowski.de>
Mail-Followup-To: linux-pcmcia@lists.infradead.org, netdev@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060331195852.GB27888@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331195852.GB27888@dominikbrodowski.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the remaining drivers which use pcmcia_release_io or
pcmcia_release_irq, and remove the EXPORT of these symbols.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

---

 Documentation/pcmcia/driver-changes.txt |    4 ++--
 drivers/isdn/hardware/avm/avm_cs.c      |   10 +++++-----
 drivers/isdn/hisax/avma1_cs.c           |    8 ++++----
 drivers/isdn/hisax/sedlbauer_cs.c       |    8 ++------
 drivers/net/pcmcia/smc91c92_cs.c        |   10 ++++++++--
 drivers/net/wireless/orinoco_cs.c       |    3 +--
 drivers/net/wireless/ray_cs.c           |    8 +-------
 drivers/net/wireless/spectrum_cs.c      |    3 +--
 drivers/pcmcia/pcmcia_resource.c        |    3 ---
 drivers/scsi/pcmcia/nsp_cs.c            |    5 +----
 drivers/scsi/pcmcia/qlogic_stub.c       |    7 +------
 drivers/telephony/ixj_pcmcia.c          |    5 +----
 drivers/usb/host/sl811_cs.c             |   14 ++------------
 include/pcmcia/cs.h                     |    2 --
 sound/pcmcia/pdaudiocf/pdaudiocf.c      |    4 +---
 sound/pcmcia/vx/vxpocket.c              |    5 +----
 16 files changed, 31 insertions(+), 68 deletions(-)

50db3fdbbc98260fb538c1cc3f8cc597ba7bffe7
diff --git a/Documentation/pcmcia/driver-changes.txt b/Documentation/pcmcia/driver-changes.txt
index c89a5e2..4739c5c 100644
--- a/Documentation/pcmcia/driver-changes.txt
+++ b/Documentation/pcmcia/driver-changes.txt
@@ -3,8 +3,8 @@ This file details changes in 2.6 which a
 * New release helper (as of 2.6.17)
    Instead of calling pcmcia_release_{configuration,io,irq,win}, all that's
    necessary now is calling pcmcia_disable_device. As there is no valid
-   reason left to call pcmcia_release_io and pcmcia_release_irq, they will
-   be removed soon.
+   reason left to call pcmcia_release_io and pcmcia_release_irq, the
+   exports for them were removed.
 
 * Unify detach and REMOVAL event code, as well as attach and INSERTION
   code (as of 2.6.16)
diff --git a/drivers/isdn/hardware/avm/avm_cs.c b/drivers/isdn/hardware/avm/avm_cs.c
index f3889bd..5f70661 100644
--- a/drivers/isdn/hardware/avm/avm_cs.c
+++ b/drivers/isdn/hardware/avm/avm_cs.c
@@ -284,25 +284,25 @@ found_port:
 	    cs_error(link->handle, RequestIO, i);
 	    break;
 	}
-	
+
 	/*
 	 * allocate an interrupt line
 	 */
 	i = pcmcia_request_irq(link->handle, &link->irq);
 	if (i != CS_SUCCESS) {
 	    cs_error(link->handle, RequestIRQ, i);
-	    pcmcia_release_io(link->handle, &link->io);
+	    /* undo */
+	    pcmcia_disable_device(link->handle);
 	    break;
 	}
-	
+
 	/*
          * configure the PCMCIA socket
 	  */
 	i = pcmcia_request_configuration(link->handle, &link->conf);
 	if (i != CS_SUCCESS) {
 	    cs_error(link->handle, RequestConfiguration, i);
-	    pcmcia_release_io(link->handle, &link->io);
-	    pcmcia_release_irq(link->handle, &link->irq);
+	    pcmcia_disable_device(link->handle);
 	    break;
 	}
 
diff --git a/drivers/isdn/hisax/avma1_cs.c b/drivers/isdn/hisax/avma1_cs.c
index 729c2de..845fa14 100644
--- a/drivers/isdn/hisax/avma1_cs.c
+++ b/drivers/isdn/hisax/avma1_cs.c
@@ -313,18 +313,18 @@ found_port:
 	i = pcmcia_request_irq(link->handle, &link->irq);
 	if (i != CS_SUCCESS) {
 	    cs_error(link->handle, RequestIRQ, i);
-	    pcmcia_release_io(link->handle, &link->io);
+	    /* undo */
+	    pcmcia_disable_device(link->handle);
 	    break;
 	}
-	
+
 	/*
 	 * configure the PCMCIA socket
 	 */
 	i = pcmcia_request_configuration(link->handle, &link->conf);
 	if (i != CS_SUCCESS) {
 	    cs_error(link->handle, RequestConfiguration, i);
-	    pcmcia_release_io(link->handle, &link->io);
-	    pcmcia_release_irq(link->handle, &link->irq);
+	    pcmcia_disable_device(link->handle);
 	    break;
 	}
 
diff --git a/drivers/isdn/hisax/sedlbauer_cs.c b/drivers/isdn/hisax/sedlbauer_cs.c
index e595391..fd0f127 100644
--- a/drivers/isdn/hisax/sedlbauer_cs.c
+++ b/drivers/isdn/hisax/sedlbauer_cs.c
@@ -374,15 +374,11 @@ static void sedlbauer_config(dev_link_t 
 	}
 	/* If we got this far, we're cool! */
 	break;
-	
+
     next_entry:
-/* new in dummy.cs 2001/01/28 MN 
-        if (link->io.NumPorts1)
-           pcmcia_release_io(link->handle, &link->io);
-*/
 	CS_CHECK(GetNextTuple, pcmcia_get_next_tuple(handle, &tuple));
     }
-    
+
     /*
        Allocate an interrupt line.  Note that this does not assign a
        handler to the interrupt, unless the 'Handler' member of the
diff --git a/drivers/net/pcmcia/smc91c92_cs.c b/drivers/net/pcmcia/smc91c92_cs.c
index 56700b1..03b1d8f 100644
--- a/drivers/net/pcmcia/smc91c92_cs.c
+++ b/drivers/net/pcmcia/smc91c92_cs.c
@@ -49,6 +49,7 @@
 #include <pcmcia/cisreg.h>
 #include <pcmcia/ciscode.h>
 #include <pcmcia/ds.h>
+#include <pcmcia/ss.h>
 
 #include <asm/io.h>
 #include <asm/system.h>
@@ -965,10 +966,15 @@ static int check_sig(dev_link_t *link)
 
     if (width) {
 	printk(KERN_INFO "smc91c92_cs: using 8-bit IO window.\n");
+	/* call pcmcia_release_configuration() in _suspend */
 	smc91c92_suspend(link->handle);
-	pcmcia_release_io(link->handle, &link->io);
+
 	link->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
-	pcmcia_request_io(link->handle, &link->io);
+	link->handle->socket->io[0].res->flags &= ~IO_DATA_PATH_WIDTH;
+	link->handle->socket->io[0].res->flags |= IO_DATA_PATH_WIDTH_8;
+
+	/* call pcmcia_request_configuration() in _resume, it handles the
+	 * flag update */
 	smc91c92_resume(link->handle);
 	return check_sig(link);
     }
diff --git a/drivers/net/wireless/orinoco_cs.c b/drivers/net/wireless/orinoco_cs.c
index 7fdc4ff..0ce4165 100644
--- a/drivers/net/wireless/orinoco_cs.c
+++ b/drivers/net/wireless/orinoco_cs.c
@@ -317,8 +317,7 @@ orinoco_cs_config(dev_link_t *link)
 		break;
 		
 	next_entry:
-		if (link->io.NumPorts1)
-			pcmcia_release_io(link->handle, &link->io);
+		pcmcia_disable_device(handle);
 		last_ret = pcmcia_get_next_tuple(handle, &tuple);
 		if (last_ret  == CS_NO_MORE_ITEMS) {
 			printk(KERN_ERR PFX "GetNextTuple(): No matching "
diff --git a/drivers/net/wireless/ray_cs.c b/drivers/net/wireless/ray_cs.c
index 7880d8c..fc81ac6 100644
--- a/drivers/net/wireless/ray_cs.c
+++ b/drivers/net/wireless/ray_cs.c
@@ -849,22 +849,16 @@ static void ray_release(dev_link_t *link
     DEBUG(1, "ray_release(0x%p)\n", link);
 
     del_timer(&local->timer);
-    link->state &= ~DEV_CONFIG;
 
     iounmap(local->sram);
     iounmap(local->rmem);
     iounmap(local->amem);
     /* Do bother checking to see if these succeed or not */
-    i = pcmcia_release_window(link->win);
-    if ( i != CS_SUCCESS ) DEBUG(0,"ReleaseWindow(link->win) ret = %x\n",i);
     i = pcmcia_release_window(local->amem_handle);
     if ( i != CS_SUCCESS ) DEBUG(0,"ReleaseWindow(local->amem) ret = %x\n",i);
     i = pcmcia_release_window(local->rmem_handle);
     if ( i != CS_SUCCESS ) DEBUG(0,"ReleaseWindow(local->rmem) ret = %x\n",i);
-    i = pcmcia_release_configuration(link->handle);
-    if ( i != CS_SUCCESS ) DEBUG(0,"ReleaseConfiguration ret = %x\n",i);
-    i = pcmcia_release_irq(link->handle, &link->irq);
-    if ( i != CS_SUCCESS ) DEBUG(0,"ReleaseIRQ ret = %x\n",i);
+    pcmcia_disable_device(link->handle);
 
     DEBUG(2,"ray_release ending\n");
 }
diff --git a/drivers/net/wireless/spectrum_cs.c b/drivers/net/wireless/spectrum_cs.c
index 78320c1..b7ed99f 100644
--- a/drivers/net/wireless/spectrum_cs.c
+++ b/drivers/net/wireless/spectrum_cs.c
@@ -790,8 +790,7 @@ spectrum_cs_config(dev_link_t *link)
 		break;
 		
 	next_entry:
-		if (link->io.NumPorts1)
-			pcmcia_release_io(link->handle, &link->io);
+		pcmcia_disable_device(handle);
 		last_ret = pcmcia_get_next_tuple(handle, &tuple);
 		if (last_ret  == CS_NO_MORE_ITEMS) {
 			printk(KERN_ERR PFX "GetNextTuple(): No matching "
diff --git a/drivers/pcmcia/pcmcia_resource.c b/drivers/pcmcia/pcmcia_resource.c
index 555c869..f4dcea6 100644
--- a/drivers/pcmcia/pcmcia_resource.c
+++ b/drivers/pcmcia/pcmcia_resource.c
@@ -514,7 +514,6 @@ int pcmcia_release_io(struct pcmcia_devi
 
 	return CS_SUCCESS;
 } /* pcmcia_release_io */
-EXPORT_SYMBOL(pcmcia_release_io);
 
 
 int pcmcia_release_irq(struct pcmcia_device *p_dev, irq_req_t *req)
@@ -547,7 +546,6 @@ int pcmcia_release_irq(struct pcmcia_dev
 
 	return CS_SUCCESS;
 } /* pcmcia_release_irq */
-EXPORT_SYMBOL(pcmcia_release_irq);
 
 
 int pcmcia_release_window(window_handle_t win)
@@ -937,6 +935,5 @@ void pcmcia_disable_device(struct pcmcia
 		pcmcia_release_window(p_dev->instance->win);
 
 	p_dev->instance->dev = NULL;
-	p_dev->instance->state &= ~DEV_CONFIG;
 }
 EXPORT_SYMBOL(pcmcia_disable_device);
diff --git a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
index dd383c5..d469e0d 100644
--- a/drivers/scsi/pcmcia/nsp_cs.c
+++ b/drivers/scsi/pcmcia/nsp_cs.c
@@ -1802,10 +1802,7 @@ static void nsp_cs_config(dev_link_t *li
 
 	next_entry:
 		nsp_dbg(NSP_DEBUG_INIT, "next");
-
-		if (link->io.NumPorts1) {
-			pcmcia_release_io(link->handle, &link->io);
-		}
+		pcmcia_disable_device(handle);
 		CS_CHECK(GetNextTuple, pcmcia_get_next_tuple(handle, &tuple));
 	}
 
diff --git a/drivers/scsi/pcmcia/qlogic_stub.c b/drivers/scsi/pcmcia/qlogic_stub.c
index 70269fc..1e27059 100644
--- a/drivers/scsi/pcmcia/qlogic_stub.c
+++ b/drivers/scsi/pcmcia/qlogic_stub.c
@@ -288,12 +288,7 @@ out:
 
 cs_failed:
 	cs_error(link->handle, last_fn, last_ret);
-	link->dev = NULL;
-
-	pcmcia_release_configuration(link->handle);
-	pcmcia_release_io(link->handle, &link->io);
-	pcmcia_release_irq(link->handle, &link->irq);
-	link->state &= ~DEV_CONFIG;
+	pcmcia_disable_device(link->handle);
 	return;
 
 }				/* qlogic_config */
diff --git a/drivers/telephony/ixj_pcmcia.c b/drivers/telephony/ixj_pcmcia.c
index d3a7b0c..fe3cde0 100644
--- a/drivers/telephony/ixj_pcmcia.c
+++ b/drivers/telephony/ixj_pcmcia.c
@@ -229,10 +229,7 @@ static void ixj_cs_release(dev_link_t *l
 	ixj_info_t *info = link->priv;
 	DEBUG(0, "ixj_cs_release(0x%p)\n", link);
 	info->ndev = 0;
-	link->dev = NULL;
-	pcmcia_release_configuration(link->handle);
-	pcmcia_release_io(link->handle, &link->io);
-	link->state &= ~DEV_CONFIG;
+	pcmcia_disable_device(link->handle);
 }
 
 static int ixj_suspend(struct pcmcia_device *dev)
diff --git a/drivers/usb/host/sl811_cs.c b/drivers/usb/host/sl811_cs.c
index 134d200..ee81167 100644
--- a/drivers/usb/host/sl811_cs.c
+++ b/drivers/usb/host/sl811_cs.c
@@ -154,19 +154,10 @@ static void sl811_cs_detach(struct pcmci
 
 static void sl811_cs_release(dev_link_t * link)
 {
-
 	DBG(0, "sl811_cs_release(0x%p)\n", link);
 
-	/* Unlink the device chain */
-	link->dev = NULL;
-
+	pcmcia_disable_device(link->handle);
 	platform_device_unregister(&platform_dev);
-	pcmcia_release_configuration(link->handle);
-	if (link->io.NumPorts1)
-		pcmcia_release_io(link->handle, &link->io);
-	if (link->irq.AssignedIRQ)
-		pcmcia_release_irq(link->handle, &link->irq);
-	link->state &= ~DEV_CONFIG;
 }
 
 static void sl811_cs_config(dev_link_t *link)
@@ -260,8 +251,7 @@ static void sl811_cs_config(dev_link_t *
 		break;
 
 next_entry:
-		if (link->io.NumPorts1)
-			pcmcia_release_io(link->handle, &link->io);
+		pcmcia_disable_device(handle);
 		last_ret = pcmcia_get_next_tuple(handle, &tuple);
 	}
 
diff --git a/include/pcmcia/cs.h b/include/pcmcia/cs.h
index a5d8df2..7b91520 100644
--- a/include/pcmcia/cs.h
+++ b/include/pcmcia/cs.h
@@ -379,8 +379,6 @@ int pcmcia_get_mem_page(window_handle_t 
 int pcmcia_map_mem_page(window_handle_t win, memreq_t *req);
 int pcmcia_modify_configuration(struct pcmcia_device *p_dev, modconf_t *mod);
 int pcmcia_release_configuration(struct pcmcia_device *p_dev);
-int pcmcia_release_io(struct pcmcia_device *p_dev, io_req_t *req);
-int pcmcia_release_irq(struct pcmcia_device *p_dev, irq_req_t *req);
 int pcmcia_release_window(window_handle_t win);
 int pcmcia_request_configuration(struct pcmcia_device *p_dev, config_req_t *req);
 int pcmcia_request_io(struct pcmcia_device *p_dev, io_req_t *req);
diff --git a/sound/pcmcia/pdaudiocf/pdaudiocf.c b/sound/pcmcia/pdaudiocf/pdaudiocf.c
index a2d3eb4..80c5355 100644
--- a/sound/pcmcia/pdaudiocf/pdaudiocf.c
+++ b/sound/pcmcia/pdaudiocf/pdaudiocf.c
@@ -273,9 +273,7 @@ static void pdacf_config(dev_link_t *lin
 cs_failed:
 	cs_error(link->handle, last_fn, last_ret);
 failed:
-	pcmcia_release_configuration(link->handle);
-	pcmcia_release_io(link->handle, &link->io);
-	pcmcia_release_irq(link->handle, &link->irq);
+	pcmcia_disable_device(link->handle);
 }
 
 #ifdef CONFIG_PM
diff --git a/sound/pcmcia/vx/vxpocket.c b/sound/pcmcia/vx/vxpocket.c
index 9278874..8093e50 100644
--- a/sound/pcmcia/vx/vxpocket.c
+++ b/sound/pcmcia/vx/vxpocket.c
@@ -272,10 +272,7 @@ static void vxpocket_config(dev_link_t *
 cs_failed:
 	cs_error(link->handle, last_fn, last_ret);
 failed:
-	pcmcia_release_configuration(link->handle);
-	pcmcia_release_io(link->handle, &link->io);
-	pcmcia_release_irq(link->handle, &link->irq);
-	link->state &= ~DEV_CONFIG;
+	pcmcia_disable_device(link->handle);
 	kfree(parse);
 }
 
-- 
1.2.4

