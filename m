Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135509AbRD3QlW>; Mon, 30 Apr 2001 12:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135576AbRD3QlC>; Mon, 30 Apr 2001 12:41:02 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:9954 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S135509AbRD3Qkx>;
	Mon, 30 Apr 2001 12:40:53 -0400
Message-ID: <3AED958C.3F9EBE1B@mandrakesoft.com>
Date: Mon, 30 Apr 2001 12:40:44 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Greg Hosler <hosler@lugs.org.sg>, Arjan van de Ven <arjanv@redhat.com>,
        josh <skulcap@mammoth.org>, Capricelli Thomas <orzel@kde.org>,
        linux-via@gtf.org
Subject: PATCH 2.4.4: Via audio fixes
Content-Type: multipart/mixed;
 boundary="------------453F4EF62F361B0E2353FCD8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------453F4EF62F361B0E2353FCD8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The attached patch includes fixes to the Via audio driver for which I'm
interested finding testers.  Testing and a private "it works" (hopefully
:)) or "it doesn't work, <here> is what breaks for me" would be
appreciated.
-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
--------------453F4EF62F361B0E2353FCD8
Content-Type: text/plain; charset=us-ascii;
 name="via.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via.patch"

Index: linux_2_4/drivers/sound/via82cxxx_audio.c
diff -u linux_2_4/drivers/sound/via82cxxx_audio.c:1.1.1.16 linux_2_4/drivers/sound/via82cxxx_audio.c:1.1.1.16.70.3
--- linux_2_4/drivers/sound/via82cxxx_audio.c:1.1.1.16	Sat Mar  3 18:12:35 2001
+++ linux_2_4/drivers/sound/via82cxxx_audio.c	Mon Apr 30 09:35:21 2001
@@ -15,7 +15,7 @@
  */
 
 
-#define VIA_VERSION	"1.1.14b"
+#define VIA_VERSION	"1.1.15"
 
 
 #include <linux/config.h>
@@ -92,6 +92,7 @@
 #endif
 
 /* 82C686 function 5 (audio codec) PCI configuration registers */
+#define VIA_ACLINK_STATUS	0x40
 #define VIA_ACLINK_CTRL		0x41
 #define VIA_FUNC_ENABLE		0x42
 #define VIA_PNP_CONTROL		0x43
@@ -1405,20 +1406,41 @@
 #endif
 
         /*
-         * reset AC97 controller: enable, disable, enable
-         * pause after each command for good luck
+         * Reset AC97 controller: enable, disable, enable,
+         * pausing after each command for good luck.  Only
+	 * do this if the codec is not ready, because it causes
+	 * loud pops and such due to such a hard codec reset.
          */
-        pci_write_config_byte (pdev, VIA_ACLINK_CTRL, VIA_CR41_AC97_ENABLE |
-                               VIA_CR41_AC97_RESET | VIA_CR41_AC97_WAKEUP);
-        udelay (100);
-
-        pci_write_config_byte (pdev, VIA_ACLINK_CTRL, 0);
-        udelay (100);
-
-        pci_write_config_byte (pdev, VIA_ACLINK_CTRL,
-			       VIA_CR41_AC97_ENABLE | VIA_CR41_PCM_ENABLE |
-                               VIA_CR41_VRA | VIA_CR41_AC97_RESET);
-        udelay (100);
+	pci_read_config_byte (pdev, VIA_ACLINK_STATUS, &tmp8);
+	if ((tmp8 & VIA_CR40_AC97_READY) == 0) {
+        	pci_write_config_byte (pdev, VIA_ACLINK_CTRL,
+				       VIA_CR41_AC97_ENABLE |
+                		       VIA_CR41_AC97_RESET |
+				       VIA_CR41_AC97_WAKEUP);
+        	udelay (100);
+
+        	pci_write_config_byte (pdev, VIA_ACLINK_CTRL, 0);
+        	udelay (100);
+
+        	pci_write_config_byte (pdev, VIA_ACLINK_CTRL,
+				       VIA_CR41_AC97_ENABLE |
+				       VIA_CR41_PCM_ENABLE |
+                		       VIA_CR41_VRA | VIA_CR41_AC97_RESET);
+        	udelay (100);
+	}
+
+	/* Make sure VRA is enabled, in case we didn't do a
+	 * complete codec reset, above
+	 */
+	pci_read_config_byte (pdev, VIA_ACLINK_CTRL, &tmp8);
+	if (((tmp8 & VIA_CR41_VRA) == 0) ||
+	    ((tmp8 & VIA_CR41_AC97_ENABLE) == 0) ||
+	    ((tmp8 & VIA_CR41_PCM_ENABLE) == 0) ||
+	    ((tmp8 & VIA_CR41_AC97_RESET) == 0))
+        	pci_write_config_byte (pdev, VIA_ACLINK_CTRL,
+				       VIA_CR41_AC97_ENABLE |
+				       VIA_CR41_PCM_ENABLE |
+                		       VIA_CR41_VRA | VIA_CR41_AC97_RESET);
 
 #if 0 /* this breaks on K7M */
 	/* disable legacy stuff */
@@ -1983,17 +2005,16 @@
 	tmp = atomic_read (&chan->n_frags);
 	assert (tmp >= 0);
 	assert (tmp <= chan->frag_number);
-	while (tmp == 0) {
+	if (tmp == 0) {
+	    	int ret;
 		if (nonblock || !chan->is_active)
 			return -EAGAIN;
 
 		DPRINTK ("Sleeping on block %d\n", n);
-		interruptible_sleep_on (&chan->wait);
-
-		if (signal_pending (current))
-			return -ERESTARTSYS;
-
-		tmp = atomic_read (&chan->n_frags);
+		ret = wait_event_interruptible(chan->wait,
+				(tmp = atomic_read(&chan->n_frags)));
+		if (ret < 0)
+			return ret;
 	}
 
 	/* Now that we have a buffer we can read from, send
@@ -2130,17 +2151,16 @@
 	tmp = atomic_read (&chan->n_frags);
 	assert (tmp >= 0);
 	assert (tmp <= chan->frag_number);
-	while (tmp == 0) {
+	if (tmp == 0) {
+	    	int ret;
 		if (nonblock || !chan->is_enabled)
 			return -EAGAIN;
 
 		DPRINTK ("Sleeping on page %d, tmp==%d, ir==%d\n", n, tmp, chan->is_record);
-		interruptible_sleep_on (&chan->wait);
-
-		if (signal_pending (current))
-			return -ERESTARTSYS;
-
-		tmp = atomic_read (&chan->n_frags);
+		ret = wait_event_interruptible(chan->wait,
+				(tmp = atomic_read(&chan->n_frags)));
+		if (ret < 0)
+		    	return ret;
 	}
 
 	/* Now that we have at least one fragment we can write to, fill the buffer
@@ -2324,7 +2344,8 @@
 
 	via_chan_maybe_start (chan);
 
-	while (atomic_read (&chan->n_frags) < chan->frag_number) {
+	if (atomic_read (&chan->n_frags) < chan->frag_number) {
+	    	int ret;
 		if (nonblock) {
 			DPRINTK ("EXIT, returning -EAGAIN\n");
 			return -EAGAIN;
@@ -2357,11 +2378,11 @@
 #endif
 
 		DPRINTK ("sleeping, nbufs=%d\n", atomic_read (&chan->n_frags));
-		interruptible_sleep_on (&chan->wait);
-
-		if (signal_pending (current)) {
+		ret = wait_event_interruptible(chan->wait,
+			(atomic_read (&chan->n_frags) >= chan->frag_number));
+		if (ret < 0) {
 			DPRINTK ("EXIT, returning -ERESTARTSYS\n");
-			return -ERESTARTSYS;
+			return ret;
 		}
 	}
 
@@ -3012,7 +3033,6 @@
 {
 	int rc;
 	struct via_info *card;
-	u8 tmp;
 	static int printed_version = 0;
 
 	DPRINTK ("ENTER\n");
@@ -3020,24 +3040,19 @@
 	if (printed_version++ == 0)
 		printk (KERN_INFO "Via 686a audio driver " VIA_VERSION "\n");
 
-	if (!request_region (pci_resource_start (pdev, 0),
-	    		     pci_resource_len (pdev, 0),
-			     VIA_MODULE_NAME)) {
-		printk (KERN_ERR PFX "unable to obtain I/O resources, aborting\n");
-		rc = -EBUSY;
+	rc = pci_enable_device (pdev);
+	if (rc)
 		goto err_out;
-	}
 
-	if (pci_enable_device (pdev)) {
-		rc = -EIO;
-		goto err_out_none;
-	}
+	rc = pci_request_regions (pdev, "via82cxxx_audio");
+	if (rc)
+		goto err_out;
 
 	card = kmalloc (sizeof (*card), GFP_KERNEL);
 	if (!card) {
 		printk (KERN_ERR PFX "out of memory, aborting\n");
 		rc = -ENOMEM;
-		goto err_out_none;
+		goto err_out_res;
 	}
 
 	pci_set_drvdata (pdev, card);
@@ -3108,19 +3123,6 @@
 		goto err_out_have_proc;
 	}
 
-	pci_read_config_byte (pdev, 0x3C, &tmp);
-	if ((tmp & 0x0F) != pdev->irq) {
-		printk (KERN_WARNING PFX "IRQ fixup, 0x3C==0x%02X\n", tmp);
-		udelay (15);
-		tmp &= 0xF0;
-		tmp |= pdev->irq;
-		pci_write_config_byte (pdev, 0x3C, tmp);
-		DPRINTK ("new 0x3c==0x%02x\n", tmp);
-	} else {
-		DPRINTK ("IRQ reg 0x3c==0x%02x, irq==%d\n",
-			tmp, tmp & 0x0F);
-	}
-
 	printk (KERN_INFO PFX "board #%d at 0x%04lX, IRQ %d\n",
 		card->card_num + 1, card->baseaddr, pdev->irq);
 
@@ -3142,8 +3144,8 @@
 #endif
 	kfree (card);
 
-err_out_none:
-	release_region (pci_resource_start (pdev, 0), pci_resource_len (pdev, 0));
+err_out_res:
+	pci_release_regions (pdev);
 err_out:
 	pci_set_drvdata (pdev, NULL);
 	DPRINTK ("EXIT - returning %d\n", rc);
@@ -3166,7 +3168,7 @@
 	via_dsp_cleanup (card);
 	via_ac97_cleanup (card);
 
-	release_region (pci_resource_start (pdev, 0), pci_resource_len (pdev, 0));
+	pci_release_regions (pdev);
 
 #ifndef VIA_NDEBUG
 	memset (card, 0xAB, sizeof (*card)); /* poison memory */

--------------453F4EF62F361B0E2353FCD8--

