Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288808AbSAELuY>; Sat, 5 Jan 2002 06:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288795AbSAELuT>; Sat, 5 Jan 2002 06:50:19 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:55783 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S288798AbSAELt7>; Sat, 5 Jan 2002 06:49:59 -0500
Date: Sat, 5 Jan 2002 03:49:57 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Patch: linux-2.5.2-pre8/drivers/sound compilation fixes: MINOR-->minor
Message-ID: <20020105034957.A24102@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Doing a global replace of "MINOR(" with "minor(" in all
.c files in linux/drivers/sound allows all of the sound drivers
to compile (at least as modules on x86).  This reflect the
changes in kdev_t introduced in linux-2.5.2-pre6.  You can do this
by applying the following patch *or* by the following shell command
(which is how I did it in the first place):

for file in $(find linux/drivers/sound -name '*.c' | xargs egrep -l 'MINOR\(' ) ; do
ed $file << DONE ; done
%s/MINOR(/minor(/g
DONE

	One note about this: this resulted in some drivers that
made the following rather obscure looking declarations:

	{
		int minor = minor(dev);
		...
	}

	Apparently, the variable being declared is not in the scope
of its initialization value.  So, the code works, but it's not as
clear as could be.  I could rename the effected variables if need
be, although I that is something that individual device driver
maintainers could deal with at "leisure" just as well.

	I have not tested these changes.  I only know that they
make the sound drivers compile.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sound.diffs"

diff -u -r linux-2.5.2-pre8/drivers/sound/btaudio.c linux/drivers/sound/btaudio.c
--- linux-2.5.2-pre8/drivers/sound/btaudio.c	Wed Oct 17 14:19:20 2001
+++ linux/drivers/sound/btaudio.c	Sat Jan  5 03:29:11 2002
@@ -300,7 +300,7 @@
 
 static int btaudio_mixer_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct btaudio *bta;
 
 	for (bta = btaudios; bta != NULL; bta = bta->next)
@@ -459,7 +459,7 @@
 
 static int btaudio_dsp_open_digital(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct btaudio *bta;
 
 	for (bta = btaudios; bta != NULL; bta = bta->next)
@@ -475,7 +475,7 @@
 
 static int btaudio_dsp_open_analog(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct btaudio *bta;
 
 	for (bta = btaudios; bta != NULL; bta = bta->next)
diff -u -r linux-2.5.2-pre8/drivers/sound/cmpci.c linux/drivers/sound/cmpci.c
--- linux-2.5.2-pre8/drivers/sound/cmpci.c	Sun Nov 25 10:17:47 2001
+++ linux/drivers/sound/cmpci.c	Sat Jan  5 03:29:11 2002
@@ -1440,7 +1440,7 @@
 
 static int cm_open_mixdev(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct cm_state *s = devs;
 
 	while (s && s->dev_mixer != minor)
@@ -2190,7 +2190,7 @@
 
 static int cm_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct cm_state *s = devs;
 	unsigned char fmtm = ~0, fmts = 0;
 
@@ -2445,7 +2445,7 @@
 
 static int cm_midi_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct cm_state *s = devs;
 	unsigned long flags;
 
@@ -2662,7 +2662,7 @@
 
 static int cm_dmfm_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct cm_state *s = devs;
 
 	while (s && s->dev_dmfm != minor)
diff -u -r linux-2.5.2-pre8/drivers/sound/dmasound/dmasound_core.c linux/drivers/sound/dmasound/dmasound_core.c
--- linux-2.5.2-pre8/drivers/sound/dmasound/dmasound_core.c	Thu Oct 25 13:53:52 2001
+++ linux/drivers/sound/dmasound/dmasound_core.c	Sat Jan  5 03:29:11 2002
@@ -845,11 +845,11 @@
 
 	if (dmasound.mach.sq_open)
 	    dmasound.mach.sq_open();
-	dmasound.minDev = MINOR(inode->i_rdev) & 0x0f;
+	dmasound.minDev = minor(inode->i_rdev) & 0x0f;
 	dmasound.soft = dmasound.dsp;
 	dmasound.hard = dmasound.dsp;
 	sound_init();
-	if ((MINOR(inode->i_rdev) & 0x0f) == SND_DEV_AUDIO) {
+	if ((minor(inode->i_rdev) & 0x0f) == SND_DEV_AUDIO) {
 		sound_set_speed(8000);
 		sound_set_stereo(0);
 		sound_set_format(AFMT_MU_LAW);
Only in linux/drivers/sound/emu10k1: CVS
diff -u -r linux-2.5.2-pre8/drivers/sound/emu10k1/audio.c linux/drivers/sound/emu10k1/audio.c
--- linux-2.5.2-pre8/drivers/sound/emu10k1/audio.c	Tue Oct  9 10:53:17 2001
+++ linux/drivers/sound/emu10k1/audio.c	Sat Jan  5 03:29:11 2002
@@ -1098,7 +1098,7 @@
 
 static int emu10k1_audio_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct emu10k1_card *card = NULL;
 	struct list_head *entry;
 	struct emu10k1_wavedevice *wave_dev;
diff -u -r linux-2.5.2-pre8/drivers/sound/emu10k1/midi.c linux/drivers/sound/emu10k1/midi.c
--- linux-2.5.2-pre8/drivers/sound/emu10k1/midi.c	Tue Oct  9 10:53:18 2001
+++ linux/drivers/sound/emu10k1/midi.c	Sat Jan  5 03:29:11 2002
@@ -87,7 +87,7 @@
 
 static int emu10k1_midi_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct emu10k1_card *card = NULL;
 	struct emu10k1_mididevice *midi_dev;
 	struct list_head *entry;
diff -u -r linux-2.5.2-pre8/drivers/sound/emu10k1/mixer.c linux/drivers/sound/emu10k1/mixer.c
--- linux-2.5.2-pre8/drivers/sound/emu10k1/mixer.c	Tue Oct  9 10:53:18 2001
+++ linux/drivers/sound/emu10k1/mixer.c	Sat Jan  5 03:29:11 2002
@@ -640,7 +640,7 @@
 
 static int emu10k1_mixer_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct emu10k1_card *card = NULL;
 	struct list_head *entry;
 
diff -u -r linux-2.5.2-pre8/drivers/sound/gus_midi.c linux/drivers/sound/gus_midi.c
--- linux-2.5.2-pre8/drivers/sound/gus_midi.c	Tue Mar  6 19:28:32 2001
+++ linux/drivers/sound/gus_midi.c	Sat Jan  5 03:29:11 2002
@@ -21,6 +21,8 @@
 #include "gus.h"
 #include "gus_hw.h"
 
+#include <linux/init.h>
+
 static int      midi_busy = 0, input_opened = 0;
 static int      my_dev;
 static int      output_used = 0;
diff -u -r linux-2.5.2-pre8/drivers/sound/ite8172.c linux/drivers/sound/ite8172.c
--- linux-2.5.2-pre8/drivers/sound/ite8172.c	Thu Oct 25 13:53:52 2001
+++ linux/drivers/sound/ite8172.c	Sat Jan  5 03:29:11 2002
@@ -832,7 +832,7 @@
 
 static int it8172_open_mixdev(struct inode *inode, struct file *file)
 {
-    int minor = MINOR(inode->i_rdev);
+    int minor = minor(inode->i_rdev);
     struct list_head *list;
     struct it8172_state *s;
 
@@ -1543,7 +1543,7 @@
 
 static int it8172_open(struct inode *inode, struct file *file)
 {
-    int minor = MINOR(inode->i_rdev);
+    int minor = minor(inode->i_rdev);
     DECLARE_WAITQUEUE(wait, current);
     unsigned long flags;
     struct list_head *list;
Only in linux/drivers/sound/: lowlevel
diff -u -r linux-2.5.2-pre8/drivers/sound/msnd_pinnacle.c linux/drivers/sound/msnd_pinnacle.c
--- linux-2.5.2-pre8/drivers/sound/msnd_pinnacle.c	Sun Sep 30 12:26:08 2001
+++ linux/drivers/sound/msnd_pinnacle.c	Sat Jan  5 03:29:11 2002
@@ -639,9 +639,9 @@
 	return -EINVAL;
 }
 
 static int dev_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 
 	if (cmd == OSS_GETVERSION) {
 		int sound_version = SOUND_VERSION;
@@ -751,9 +751,9 @@
 	set_default_rec_audio_parameters();
 }
 
 static int dev_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	int err = 0;
 
 	if (minor == dev.dsp_minor) {
@@ -786,9 +786,9 @@
 	return err;
 }
 
 static int dev_release(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	int err = 0;
 
 	lock_kernel();
@@ -976,18 +976,18 @@
 	return len - count;
 }
 
 static ssize_t dev_read(struct file *file, char *buf, size_t count, loff_t *off)
 {
-	int minor = MINOR(file->f_dentry->d_inode->i_rdev);
+	int minor = minor(file->f_dentry->d_inode->i_rdev);
 	if (minor == dev.dsp_minor)
 		return dsp_read(buf, count);
 	else
 		return -EINVAL;
 }
 
 static ssize_t dev_write(struct file *file, const char *buf, size_t count, loff_t *off)
 {
-	int minor = MINOR(file->f_dentry->d_inode->i_rdev);
+	int minor = minor(file->f_dentry->d_inode->i_rdev);
 	if (minor == dev.dsp_minor)
 		return dsp_write(buf, count);
 	else
diff -u -r linux-2.5.2-pre8/drivers/sound/nec_vrc5477.c linux/drivers/sound/nec_vrc5477.c
--- linux-2.5.2-pre8/drivers/sound/nec_vrc5477.c	Thu Oct 25 13:53:52 2001
+++ linux/drivers/sound/nec_vrc5477.c	Sat Jan  5 03:29:11 2002
@@ -813,7 +813,7 @@
 
 static int vrc5477_ac97_open_mixdev(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct list_head *list;
 	struct vrc5477_ac97_state *s;
 
@@ -1529,7 +1529,7 @@
 
 static int vrc5477_ac97_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long flags;
 	struct list_head *list;
--- linux-2.5.2-pre8/drivers/sound/rme96xx.c	Thu Oct 25 13:53:52 2001
+++ linux/drivers/sound/rme96xx.c	Sat Jan  5 03:29:11 2002
@@ -1162,7 +1162,7 @@
 
 static int rme96xx_open(struct inode *in, struct file *f)
 {
-	int minor = MINOR(in->i_rdev);
+	int minor = minor(in->i_rdev);
 	struct list_head *list;
 	int devnum = ((minor-3)/16) % devices; /* default = 0 */
 	rme96xx_info *s;
@@ -1490,7 +1490,7 @@
 
 static int rme96xx_mixer_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct list_head *list;
 	rme96xx_info *s;
 
diff -u -r linux-2.5.2-pre8/drivers/sound/sonicvibes.c linux/drivers/sound/sonicvibes.c
--- linux-2.5.2-pre8/drivers/sound/sonicvibes.c	Sun Sep 30 12:26:08 2001
+++ linux/drivers/sound/sonicvibes.c	Sat Jan  5 03:29:11 2002
@@ -1235,7 +1235,7 @@
 
 static int sv_open_mixdev(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct list_head *list;
 	struct sv_state *s;
 
@@ -1893,7 +1893,7 @@
 
 static int sv_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned char fmtm = ~0, fmts = 0;
 	struct list_head *list;
@@ -2142,7 +2142,7 @@
 
 static int sv_midi_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long flags;
 	struct list_head *list;
@@ -2364,7 +2364,7 @@
 
 static int sv_dmfm_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	DECLARE_WAITQUEUE(wait, current);
 	struct list_head *list;
 	struct sv_state *s;
diff -u -r linux-2.5.2-pre8/drivers/sound/trident.c linux/drivers/sound/trident.c
--- linux-2.5.2-pre8/drivers/sound/trident.c	Tue Nov 13 09:19:41 2001
+++ linux/drivers/sound/trident.c	Sat Jan  5 03:29:11 2002
@@ -2555,7 +2555,7 @@
 static int trident_open(struct inode *inode, struct file *file)
 {
 	int i = 0;
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct trident_card *card = devs;
 	struct trident_state *state = NULL;
 	struct dmabuf *dmabuf = NULL;
@@ -3750,7 +3750,7 @@
 static int trident_open_mixdev(struct inode *inode, struct file *file)
 {
 	int i = 0;
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct trident_card *card = devs;
 
 	for (card = devs; card != NULL; card = card->next)
diff -u -r linux-2.5.2-pre8/drivers/sound/via82cxxx_audio.c linux/drivers/sound/via82cxxx_audio.c
--- linux-2.5.2-pre8/drivers/sound/via82cxxx_audio.c	Mon Dec 10 10:39:20 2001
+++ linux/drivers/sound/via82cxxx_audio.c	Sat Jan  5 03:29:11 2002
@@ -1358,7 +1358,7 @@
 
 static int via_mixer_open (struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct via_info *card;
 	struct pci_dev *pdev;
 	struct pci_driver *drvr;
@@ -2974,7 +2974,7 @@
 
 static int via_dsp_open (struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct via_info *card;
 	struct pci_dev *pdev;
 	struct via_channel *chan;
diff -u -r linux-2.5.2-pre8/drivers/sound/vwsnd.c linux/drivers/sound/vwsnd.c
--- linux-2.5.2-pre8/drivers/sound/vwsnd.c	Fri Nov  9 14:07:41 2001
+++ linux/drivers/sound/vwsnd.c	Sat Jan  5 03:29:11 2002
@@ -2907,7 +2907,7 @@
 static int vwsnd_audio_open(struct inode *inode, struct file *file)
 {
 	vwsnd_dev_t *devc;
-	dev_t minor = MINOR(inode->i_rdev);
+	dev_t minor = minor(inode->i_rdev);
 	int sw_samplefmt;
 
 	DBGE("(inode=0x%p, file=0x%p)\n", inode, file);
@@ -3054,7 +3054,7 @@
 
 	INC_USE_COUNT;
 	for (devc = vwsnd_dev_list; devc; devc = devc->next_dev)
-		if (devc->mixer_minor == MINOR(inode->i_rdev))
+		if (devc->mixer_minor == minor(inode->i_rdev))
 			break;
 
 	if (devc == NULL) {

--bg08WKrSYDhXBjb5--
