Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129213AbQKTQdL>; Mon, 20 Nov 2000 11:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129199AbQKTQdC>; Mon, 20 Nov 2000 11:33:02 -0500
Received: from dryline-fw.wireless-sys.com ([216.126.67.45]:22582 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S129213AbQKTQcu>; Mon, 20 Nov 2000 11:32:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14873.19299.234207.512068@somanetworks.com>
Date: Mon, 20 Nov 2000 11:03:47 -0500 (EST)
From: "Georg Nikodym" <georgn@somanetworks.com>
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org, Zach Brown <zab@zabbo.net>
Subject: [PATCH] maestro 2E not enabled
X-Mailer: VM 6.75 under 21.2  (beta37) "Pan" XEmacs Lucid
Reply-To: georgn@somanetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Second try (probably since I didn't correctly follow all the rules
before, thanks for the timely discussion).

The Maestro 2E on my laptop, which worked on 2.2 kernels, stopped
working on 2.4.0.  Where stopped working means no sound and "pauses"
when interacting with the driver.

The symptom was hundreds of:

	maestro: APU register select failed.

messages (there were other messages, but they were difficult to find
in all the noise) when the driver was loaded and a few hundred more if
anybody attempted to talk to the device.

maestro.c had not changed significantly since 2.2 (certainly not
anywhere close to the code emitting these messages).

lspci showed that the device was "[disabled]".  Quick comparison
against other drivers showed that maestro.c was missing a call to
pci_enable_device().

Attached (well, inlined, really) is a patch that adds that call plus
some teardown logic in the event of failure.

By way of full disclosure, I have previously sent out this patch to
lkml and the maestro-users list.  Zach has added it to what sounds
like a huge list but not explicitly blessed it (which is
understandable since I didn't really provide any of the above
information in said posting).

Thanks.

===== maestro.c 1.12 vs 1.13 =====
--- 1.12/drivers/sound/maestro.c	Sat Nov 11 13:33:13 2000
+++ 1.13/drivers/sound/maestro.c	Mon Nov 20 10:19:38 2000
@@ -3392,6 +3392,19 @@
 	
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
