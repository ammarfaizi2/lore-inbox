Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280563AbRKKUmu>; Sun, 11 Nov 2001 15:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281055AbRKKUml>; Sun, 11 Nov 2001 15:42:41 -0500
Received: from d-dialin-1179.addcom.de ([62.96.163.227]:33006 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S280764AbRKKUmV>; Sun, 11 Nov 2001 15:42:21 -0500
Date: Sun, 11 Nov 2001 21:42:27 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>, Pete Zaitcev <zaitcev@redhat.com>
Subject: [PATCH] save sound mixer state over suspend
Message-ID: <Pine.LNX.4.33.0111112107530.1518-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The appended patch introduces two new functions to the ac97_codec 
handling: ac97_save_state() and ac97_restore_state().
These functions save/restore the mixer state over suspend. (So after 
resume the volume is the same it was before)

As an example, I changed the ymfpci driver to use the new functionality -
works fine here.

--Kai

diff -ur linux-2.4.15-pre2/drivers/sound/ac97_codec.c linux-2.4.15-pre2.x/drivers/sound/ac97_codec.c
--- linux-2.4.15-pre2/drivers/sound/ac97_codec.c	Sat Nov 10 19:08:12 2001
+++ linux-2.4.15-pre2.x/drivers/sound/ac97_codec.c	Sun Nov 11 20:39:15 2001
@@ -1019,4 +1019,31 @@
 }
 
 EXPORT_SYMBOL(ac97_set_adc_rate);
+
+int ac97_save_state(struct ac97_codec *codec)
+{
+	return 0;	
+}
+
+EXPORT_SYMBOL(ac97_save_state);
+
+int ac97_restore_state(struct ac97_codec *codec)
+{
+	int i;
+	unsigned int left, right, val;
+
+	for (i = 0; i < SOUND_MIXER_NRDEVICES; i++) {
+		if (!supported_mixer(codec, i)) 
+			continue;
+
+		val = codec->mixer_state[i];
+		right = val >> 8;
+		left = val  & 0xff;
+		codec->write_mixer(codec, i, left, right);
+	}
+	return 0;
+}
+
+EXPORT_SYMBOL(ac97_restore_state);
+
 MODULE_LICENSE("GPL");
diff -ur linux-2.4.15-pre2/drivers/sound/ymfpci.c linux-2.4.15-pre2.x/drivers/sound/ymfpci.c
--- linux-2.4.15-pre2/drivers/sound/ymfpci.c	Wed Oct 24 22:51:49 2001
+++ linux-2.4.15-pre2.x/drivers/sound/ymfpci.c	Sun Nov 11 20:40:46 2001
@@ -1824,7 +1824,7 @@
 	}
 
 	unit = NULL;	/* gcc warns */
-	for (list = ymf_devs.next; list != &ymf_devs; list = list->next) {
+	list_for_each(list, &ymf_devs) {
 		unit = list_entry(list, ymfpci_t, ymf_devs);
 		if (((unit->dev_audio ^ minor) & ~0x0F) == 0)
 			break;
@@ -1935,7 +1935,7 @@
 	struct list_head *list;
 	ymfpci_t *unit;
 
-	for (list = ymf_devs.next; list != &ymf_devs; list = list->next) {
+	list_for_each(list, &ymf_devs) {
 		unit = list_entry(list, ymfpci_t, ymf_devs);
 		for (i = 0; i < NR_AC97; i++) {
 			if (unit->ac97_codec[i] != NULL &&
@@ -1990,16 +1990,25 @@
 
 static int ymf_suspend(struct pci_dev *pcidev, u32 unused)
 {
+	int i;
 	struct ymf_unit *unit = pci_get_drvdata(pcidev);
 	unsigned long flags;
 	struct ymf_dmabuf *dmabuf;
 	struct list_head *p;
 	struct ymf_state *state;
+	struct ac97_codec *codec;
 
 	spin_lock_irqsave(&unit->reg_lock, flags);
 
 	unit->suspended = 1;
 
+	for (i = 0; i < NR_AC97; i++) {
+		codec = unit->ac97_codec[i];
+		if (!codec)
+			continue;
+		ac97_save_state(codec);
+	}
+
 	list_for_each(p, &unit->states) {
 		state = list_entry(p, struct ymf_state, chain);
 
@@ -2024,13 +2033,22 @@
 
 static int ymf_resume(struct pci_dev *pcidev)
 {
+	int i;
 	struct ymf_unit *unit = pci_get_drvdata(pcidev);
 	unsigned long flags;
 	struct list_head *p;
 	struct ymf_state *state;
+	struct ac97_codec *codec;
 
 	ymfpci_aclink_reset(unit->pci);
 	ymfpci_codec_ready(unit, 0, 1);		/* prints diag if not ready. */
+
+	for (i = 0; i < NR_AC97; i++) {
+		codec = unit->ac97_codec[i];
+		if (!codec)
+			continue;
+		ac97_restore_state(codec);
+	}
 
 #ifdef CONFIG_SOUND_YMFPCI_LEGACY
 	/* XXX At this time the legacy registers are probably deprogrammed. */
diff -ur linux-2.4.15-pre2/include/linux/ac97_codec.h linux-2.4.15-pre2.x/include/linux/ac97_codec.h
--- linux-2.4.15-pre2/include/linux/ac97_codec.h	Sun Nov 11 13:12:47 2001
+++ linux-2.4.15-pre2.x/include/linux/ac97_codec.h	Sun Nov 11 20:40:29 2001
@@ -239,6 +239,7 @@
 extern int ac97_probe_codec(struct ac97_codec *);
 extern unsigned int ac97_set_adc_rate(struct ac97_codec *codec, unsigned int rate);
 extern unsigned int ac97_set_dac_rate(struct ac97_codec *codec, unsigned int rate);
-
+extern int ac97_save_state(struct ac97_codec *codec);
+extern int ac97_restore_state(struct ac97_codec *codec);
 
 #endif /* _AC97_CODEC_H_ */




