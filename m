Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289181AbSAGNLW>; Mon, 7 Jan 2002 08:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289186AbSAGNLC>; Mon, 7 Jan 2002 08:11:02 -0500
Received: from gherkin.frus.com ([192.158.254.49]:56448 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S289184AbSAGNK6>;
	Mon, 7 Jan 2002 08:10:58 -0500
Message-Id: <m16NZYG-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: [PATCH] 2.5.2pre9: emu10k1, intermezzo, lvm
To: linux-kernel@vger.kernel.org
Date: Mon, 7 Jan 2002 07:10:56 -0600 (CST)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=ELM716568930-2023-0_
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ELM716568930-2023-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII

As far as the intermezzo patch, please refer to the set previously
posted by Adam Richter: untested, but compiles.

For the lvm driver, there's still one reference to lvm_get_blksize()
that should probably be changed to block_size(): untested, but compiles.

The emu10k1 driver needs a few kdev_t fixups: tested.

The two attached patches for emu10k1 and lvm are against 2.5.2pre9.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------

--ELM716568930-2023-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: attachment; filename=patch02_emu10k1

--- linux/drivers/sound/emu10k1/audio.c.orig	Thu Oct 11 06:51:46 2001
+++ linux/drivers/sound/emu10k1/audio.c	Sat Jan  5 17:55:56 2002
@@ -1098,7 +1098,7 @@
 
 static int emu10k1_audio_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int my_minor = minor(inode->i_rdev);
 	struct emu10k1_card *card = NULL;
 	struct list_head *entry;
 	struct emu10k1_wavedevice *wave_dev;
@@ -1110,7 +1110,7 @@
 	list_for_each(entry, &emu10k1_devs) {
 		card = list_entry(entry, struct emu10k1_card, list);
 
-		if (!((card->audio_dev ^ minor) & ~0xf) || !((card->audio_dev1 ^ minor) & ~0xf))
+		if (!((card->audio_dev ^ my_minor) & ~0xf) || !((card->audio_dev1 ^ my_minor) & ~0xf))
 			goto match;
 	}
 
@@ -1206,7 +1206,7 @@
 		woinst->buffer.fragment_size = 0;
 		woinst->buffer.ossfragshift = 0;
 		woinst->buffer.numfrags = 0;
-		woinst->device = (card->audio_dev1 == minor);
+		woinst->device = (card->audio_dev1 == my_minor);
 		woinst->timer.state = TIMER_STATE_UNINSTALLED;
 		woinst->num_voices = 1;
 		for (i = 0; i < WAVEOUT_MAXVOICES; i++) {
--- linux/drivers/sound/emu10k1/midi.c.orig	Thu Oct 11 06:51:46 2001
+++ linux/drivers/sound/emu10k1/midi.c	Sat Jan  5 17:59:03 2002
@@ -87,7 +87,7 @@
 
 static int emu10k1_midi_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int my_minor = minor(inode->i_rdev);
 	struct emu10k1_card *card = NULL;
 	struct emu10k1_mididevice *midi_dev;
 	struct list_head *entry;
@@ -98,7 +98,7 @@
 	list_for_each(entry, &emu10k1_devs) {
 		card = list_entry(entry, struct emu10k1_card, list);
 
-		if (card->midi_dev == minor)
+		if (card->midi_dev == my_minor)
 			goto match;
 	}
 
--- linux/drivers/sound/emu10k1/mixer.c.orig	Thu Oct 11 06:51:46 2001
+++ linux/drivers/sound/emu10k1/mixer.c	Sun Jan  6 01:33:02 2002
@@ -640,7 +640,7 @@
 
 static int emu10k1_mixer_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int my_minor = minor(inode->i_rdev);
 	struct emu10k1_card *card = NULL;
 	struct list_head *entry;
 
@@ -649,7 +649,7 @@
 	list_for_each(entry, &emu10k1_devs) {
 		card = list_entry(entry, struct emu10k1_card, list);
 
-		if (card->ac97.dev_mixer == minor)
+		if (card->ac97.dev_mixer == my_minor)
 			goto match;
 	}
 

--ELM716568930-2023-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: attachment; filename=patch02_lvm

--- linux/drivers/md/lvm.c.orig	Sat Jan  5 07:01:57 2002
+++ linux/drivers/md/lvm.c	Sat Jan  5 07:07:35 2002
@@ -1044,7 +1044,7 @@
 
 	memset(&bio,0,sizeof(bio));
 	bio.bi_dev = inode->i_rdev;
-	bio.bi_size = lvm_get_blksize(bio.bi_dev); /* NEEDED by bio_sectors */
+	bio.bi_size = block_size(bio.bi_dev); /* NEEDED by bio_sectors */
  	bio.bi_sector = block * bio_sectors(&bio);
 	bio.bi_rw = READ;
 	if ((err=lvm_map(&bio)) < 0)  {

--ELM716568930-2023-0_--
