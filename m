Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129730AbQKVSif>; Wed, 22 Nov 2000 13:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129787AbQKVSiZ>; Wed, 22 Nov 2000 13:38:25 -0500
Received: from c000-h011.c000.muc.cp.net ([209.228.29.35]:23269 "HELO
        c000.muc.cp.net") by vger.kernel.org with SMTP id <S129730AbQKVSiN>;
        Wed, 22 Nov 2000 13:38:13 -0500
X-Sent: 22 Nov 2000 18:04:50 GMT
From: Martin Heiﬂ <mheiss99@uni.de>
To: linux-kernel@vger.kernel.org
Subject: [patch] minor problems when autodetecting an ESS1868 soundcard
Date: Wed, 22 Nov 2000 19:03:22 +0100
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="--=_aj2o1tg95ittjpl6qeds9t5m2r0o70jq59.MFSBCHJLHS"
Message-Id: <20001122183820Z129730-8304+94@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----=_aj2o1tg95ittjpl6qeds9t5m2r0o70jq59.MFSBCHJLHS
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,
i have found a minor 'problem' in the 2.4.0-testX kernels, that occurs
when an ESS1868 soundcard is ISAPnP autodetected. (i.e. when the "sb"
driver is compiled directly into the kernel)

The "source" of the problem is in /drivers/sound/sb_card.c line. 399:

in the sb_isapnp_list[] are two "ESS 1868" entries (same Card identifers
but different logical devices. The Kernel detects both cards but can
only initialize one because only for one the logical device id matches
with the card. It gives an error message for the other one.
Apart from that, EVERYTHING is working correctly. The problem is only
that you get a error for a card that you dont have :-)

The easyest thing would be to remove one of the ESS1868 definitions but
i don't consider that as an option.

Here is my Patch suggestion. I have merged the sb_isapnp_init() into the
sb_init() function to prevent the error from being printed. I don't know
if this "merge"  is "allowed" but at least it now works correctly for
me.

CU
  Martin
Here is my patch:
------------

----=_aj2o1tg95ittjpl6qeds9t5m2r0o70jq59.MFSBCHJLHS
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Content-Description: Patch for ESS1868 autodetection
Content-Disposition: inline

--- /drivers/sound/sb_card.c	Wed Nov 22 16:07:07 2000
+++ sb_card.c	Wed Nov 22 16:11:30 2000
@@ -50,6 +50,10 @@
  *
  * 21-09-2000 Got rid of attach_sbmpu
  * 	Arnaldo Carvalho de Melo <acme@conectiva.com.br>
+ * 	
+ * 22-11-2000 Fixed bug that a ESS1868 was detected two times
+ * 	merged sb_isapnp_init into sb_init to make this possible
+ * 	Martin Heiﬂ <m.heiss@uni.de>
  */
 
 #include <linux/config.h>
@@ -498,10 +502,12 @@
 static struct pci_dev *sb_init(struct pci_bus *bus, struct address_info *hw_config, struct address_info *mpu_config, int slot, int card)
 {
 
+	char *busname = bus->name[0] ? bus->name : sb_isapnp_list[slot].name;
 	/* Configure Audio device */
 	if((sb_dev[card] = isapnp_find_dev(bus, sb_isapnp_list[slot].audio_vendor, sb_isapnp_list[slot].audio_function, NULL)))
 	{
 		int ret;
+		printk(KERN_INFO "sb: %s detected\n", busname); 
 		ret = sb_dev[card]->prepare(sb_dev[card]);
 		/* If device is active, assume configured with /proc/isapnp
 		 * and use anyway. Some other way to check this? */
@@ -521,8 +527,12 @@
 				hw_config->dma2 = sb_dev[card]->dma_resource[sb_isapnp_list[slot].dma2].start;
 			else
 				hw_config->dma2 = -1;
+			printk(KERN_NOTICE "sb: ISAPnP reports '%s' at i/o %#x, irq %d, dma %d, %d\n", busname, hw_config->io_base, hw_config->irq, hw_config->dma, hw_config->dma2);
 		} else
+		{
+			printk(KERN_INFO "sb: Failed to initialize %s\n", busname);
 			return(NULL);
+		}
 	} else
 		return(NULL);
 
@@ -587,29 +597,6 @@
 	return(sb_dev[card]);
 }
 
-static int __init sb_isapnp_init(struct address_info *hw_config, struct address_info *mpu_config, struct pci_bus *bus, int slot, int card)
-{
-	char *busname = bus->name[0] ? bus->name : sb_isapnp_list[slot].name;
-
-	printk(KERN_INFO "sb: %s detected\n", busname); 
-
-	/* Initialize this baby. */
-
-	if(sb_init(bus, hw_config, mpu_config, slot, card)) {
-		/* We got it. */
-		
-		printk(KERN_NOTICE "sb: ISAPnP reports '%s' at i/o %#x, irq %d, dma %d, %d\n",
-		       busname,
-		       hw_config->io_base, hw_config->irq, hw_config->dma,
-		       hw_config->dma2);
-		return 1;
-	}
-	else
-		printk(KERN_INFO "sb: Failed to initialize %s\n", busname);
-
-	return 0;
-}
-
 static int __init sb_isapnp_probe(struct address_info *hw_config, struct address_info *mpu_config, int card)
 {
 	static int first = 1;
@@ -636,7 +623,7 @@
 				sb_isapnp_list[i].card_device,
 				bus))) {
 	
-			if(sb_isapnp_init(hw_config, mpu_config, bus, i, card)) {
+			if(sb_init(bus, hw_config, mpu_config, i, card)) {
 				isapnpjump = i; /* start next search from here */
 				return 0;
 			}

----=_aj2o1tg95ittjpl6qeds9t5m2r0o70jq59.MFSBCHJLHS--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
