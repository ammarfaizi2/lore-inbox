Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129940AbQKNPXq>; Tue, 14 Nov 2000 10:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130477AbQKNPXg>; Tue, 14 Nov 2000 10:23:36 -0500
Received: from dryline-fw.wireless-sys.com ([216.126.67.45]:18288 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S130210AbQKNPXZ>; Tue, 14 Nov 2000 10:23:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14864.40185.823180.424412@somanetworks.com>
Date: Mon, 13 Nov 2000 21:01:29 -0500 (EST)
From: "Georg Nikodym" <georgn@somanetworks.com>
To: linux-kernel@vger.kernel.org, maestro-users@zabbo.net
Subject: patch for maestro 2e
X-Mailer: VM 6.75 under 21.2  (beta35) "Nike" XEmacs Lucid
Reply-To: georgn@somanetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I found that the maestro 2E sound hardware didn't want to make noise
for me under 2.4.  Today I got itchy and scratched.  Here's a patch:

(keller) 1021$ bk diffs -u drivers/sound/maestro.c
===== drivers/sound/maestro.c 1.11 vs edited =====
--- 1.11/drivers/sound/maestro.c	Tue Aug 29 10:09:15 2000
+++ edited/drivers/sound/maestro.c	Mon Nov 13 20:53:01 2000
@@ -3390,6 +3390,19 @@
 	
 	ess = &card->channels[0];
 
+	if (pci_enable_device(pcidev)) {
+		printk (KERN_ERR "maestro: pci_enable_device() failed\n");
+		for (i = 0; i < NR_DSPS; i++) {
+			struct ess_state *s = &card->channels[i];
+			if (s->dev_audio != -1)
+				unregister_sound_dsp(s->dev_audio);
+		}
+		release_region(card->iobase, 256);
+		unregister_reboot_notifier(&maestro_nb);
+		kfree(card);
+		return 0;
+	}
+
 	/*
 	 *	Ok card ready. Begin setup proper
 	 */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
