Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAFAR1>; Fri, 5 Jan 2001 19:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131793AbRAFARR>; Fri, 5 Jan 2001 19:17:17 -0500
Received: from snowstorm.mail.pipex.net ([158.43.192.97]:45556 "HELO
	snowstorm.mail.pipex.net") by vger.kernel.org with SMTP
	id <S131684AbRAFARO>; Fri, 5 Jan 2001 19:17:14 -0500
From: Chris Rankin <rankinc@zip.com.au>
Message-Id: <200101060012.f060CwV05428@wittsend.ukgateway.net>
Subject: Updated patch: module-usage for sound coprocessor device
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Date: Sat, 6 Jan 2001 00:12:58 +0000 (GMT)
Reply-To: rankinc@zip.com.au
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="%--multipart-mixed-boundary-1.5359.978739978--%"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--%--multipart-mixed-boundary-1.5359.978739978--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

I recently posted a patch for the coprocessor device in the 2.4.0 sound drivers. Well, it appears that I missed the synth device in the mpu401.c file and so here is an updated version.

Cheers,
Chris

--%--multipart-mixed-boundary-1.5359.978739978--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Description: 'diff' output text
Content-Disposition: attachment; filename="sscape-1.diff"

diff -urN -X linux-2.4.0/dontdiff linux-vanilla/drivers/sound/audio.c linux-2.4.0/drivers/sound/audio.c
--- linux-vanilla/drivers/sound/audio.c	Fri Aug 11 16:26:43 2000
+++ linux-2.4.0/drivers/sound/audio.c	Fri Jan  5 23:52:49 2001
@@ -21,6 +21,7 @@
  * Daniel Rodriksson: reworked the use of the device specific copy_user
  *                    still generic
  * Horst von Brand:  Add missing #include <linux/string.h>
+ * Chris Rankin    : Update the module-usage counter for the coprocessor
  */
 
 #include <linux/stddef.h>
@@ -71,6 +72,7 @@
 	int bits;
 	int dev_type = dev & 0x0f;
 	int mode = translate_mode(file);
+	struct coproc_operations *coprocessor;
 
 	dev = dev >> 4;
 
@@ -88,9 +90,11 @@
 	if ((ret = DMAbuf_open(dev, mode)) < 0)
 		return ret;
 
-	if (audio_devs[dev]->coproc) {
-		if ((ret = audio_devs[dev]->coproc->
-			open(audio_devs[dev]->coproc->devc, COPR_PCM)) < 0) {
+	if ( (coprocessor = audio_devs[dev]->coproc) != NULL ) {
+		if (coprocessor->owner)
+			__MOD_INC_USE_COUNT(coprocessor->owner);
+
+		if ((ret = coprocessor->open(coprocessor->devc, COPR_PCM)) < 0) {
 			audio_release(dev, file);
 			printk(KERN_WARNING "Sound: Can't access coprocessor device\n");
 			return ret;
@@ -156,7 +160,8 @@
 
 void audio_release(int dev, struct file *file)
 {
-	int             mode = translate_mode(file);
+	struct coproc_operations *coprocessor;
+	int mode = translate_mode(file);
 
 	dev = dev >> 4;
 
@@ -176,8 +181,12 @@
 	if (mode & OPEN_WRITE)
 		sync_output(dev);
 
-	if (audio_devs[dev]->coproc)
-		audio_devs[dev]->coproc->close(audio_devs[dev]->coproc->devc, COPR_PCM);
+	if ( (coprocessor = audio_devs[dev]->coproc) != NULL ) {
+		coprocessor->close(coprocessor->devc, COPR_PCM);
+
+		if (coprocessor->owner)
+			__MOD_DEC_USE_COUNT(coprocessor->owner);
+	}
 	DMAbuf_release(dev, mode);
 
 	if (audio_devs[dev]->d->owner)
diff -urN -X linux-2.4.0/dontdiff linux-vanilla/drivers/sound/dev_table.h linux-2.4.0/drivers/sound/dev_table.h
--- linux-vanilla/drivers/sound/dev_table.h	Fri Aug 11 16:26:43 2000
+++ linux-2.4.0/drivers/sound/dev_table.h	Fri Jan  5 13:46:55 2001
@@ -150,6 +150,7 @@
 typedef struct coproc_operations 
 {
 	char name[64];
+	struct module *owner;
 	int (*open) (void *devc, int sub_device);
 	void (*close) (void *devc, int sub_device);
 	int (*ioctl) (void *devc, unsigned int cmd, caddr_t arg, int local);
diff -urN -X linux-2.4.0/dontdiff linux-vanilla/drivers/sound/mpu401.c linux-2.4.0/drivers/sound/mpu401.c
--- linux-vanilla/drivers/sound/mpu401.c	Fri Jan  5 23:14:08 2001
+++ linux-2.4.0/drivers/sound/mpu401.c	Fri Jan  5 22:45:50 2001
@@ -14,6 +14,7 @@
  * Thomas Sailer	ioctl code reworked (vmalloc/vfree removed)
  * Alan Cox		modularisation, use normal request_irq, use dev_id
  * Bartlomiej Zolnierkiewicz	removed some __init to allow using many drivers
+ * Chris Rankin		Update the module-usage counter for the coprocessor
  */
 
 #include <linux/module.h>
@@ -73,6 +74,9 @@
 #define	COMDPORT(base)   (base+1)
 #define	STATPORT(base)   (base+1)
 
+
+static void mpu401_close(int dev);
+
 static int mpu401_status(struct mpu_config *devc)
 {
 	return inb(STATPORT(devc->base));
@@ -465,6 +469,7 @@
 {
 	int err;
 	struct mpu_config *devc;
+	struct coproc_operations *coprocessor;
 
 	if (dev < 0 || dev >= num_midis || midi_devs[dev] == NULL)
 		return -ENXIO;
@@ -490,12 +495,15 @@
 		reset_mpu401(devc);
 	}
 
-	if (midi_devs[dev]->coproc)
+	if ( (coprocessor = midi_devs[dev]->coproc) != NULL )
 	{
-		if ((err = midi_devs[dev]->coproc->
-		     open(midi_devs[dev]->coproc->devc, COPR_MIDI)) < 0)
+		if (coprocessor->owner)
+			__MOD_INC_USE_COUNT(coprocessor->owner);
+
+		if ((err = coprocessor->open(coprocessor->devc, COPR_MIDI)) < 0)
 		{
-			printk("MPU-401: Can't access coprocessor device\n");
+			printk(KERN_WARNING "MPU-401: Can't access coprocessor device\n");
+			mpu401_close(dev);
 			return err;
 		}
 	}
@@ -515,6 +523,7 @@
 static void mpu401_close(int dev)
 {
 	struct mpu_config *devc;
+	struct coproc_operations *coprocessor;
 
 	devc = &dev_conf[dev];
 	if (devc->uart_mode)
@@ -524,8 +533,13 @@
 	devc->mode = 0;
 	devc->inputintr = NULL;
 
-	if (midi_devs[dev]->coproc)
-		midi_devs[dev]->coproc->close(midi_devs[dev]->coproc->devc, COPR_MIDI);
+	coprocessor = midi_devs[dev]->coproc;
+	if (coprocessor) {
+		coprocessor->close(coprocessor->devc, COPR_MIDI);
+
+		if (coprocessor->owner)
+			__MOD_DEC_USE_COUNT(coprocessor->owner);
+	}
 	devc->opened = 0;
 }
 
@@ -791,6 +805,7 @@
 {
 	int midi_dev, err;
 	struct mpu_config *devc;
+	struct coproc_operations *coprocessor;
 
 	midi_dev = synth_devs[dev]->midi_dev;
 
@@ -822,13 +837,17 @@
 
 	devc->inputintr = NULL;
 
-	if (midi_devs[midi_dev]->coproc)
-		if ((err = midi_devs[midi_dev]->coproc->
-		 open(midi_devs[midi_dev]->coproc->devc, COPR_MIDI)) < 0)
+	coprocessor = midi_devs[midi_dev]->coproc;
+	if (coprocessor) {
+		if (coprocessor->owner)
+			__MOD_INC_USE_COUNT(coprocessor->owner);
+
+		if ((err = coprocessor->open(coprocessor->devc, COPR_MIDI)) < 0)
 		{
 			printk(KERN_WARNING "mpu401: Can't access coprocessor device\n");
 			return err;
 		}
+	}
 	devc->opened = mode;
 	reset_mpu401(devc);
 
@@ -845,6 +864,7 @@
 { 
 	int midi_dev;
 	struct mpu_config *devc;
+	struct coproc_operations *coprocessor;
 
 	midi_dev = synth_devs[dev]->midi_dev;
 
@@ -854,8 +874,13 @@
 
 	devc->inputintr = NULL;
 
-	if (midi_devs[midi_dev]->coproc)
-		midi_devs[midi_dev]->coproc->close(midi_devs[midi_dev]->coproc->devc, COPR_MIDI);
+	coprocessor = midi_devs[midi_dev]->coproc;
+	if (coprocessor) {
+		coprocessor->close(coprocessor->devc, COPR_MIDI);
+
+		if (coprocessor->owner)
+			__MOD_DEC_USE_COUNT(coprocessor->owner);
+	}
 	devc->opened = 0;
 	devc->mode = 0;
 }
diff -urN -X linux-2.4.0/dontdiff linux-vanilla/drivers/sound/pss.c linux-2.4.0/drivers/sound/pss.c
--- linux-vanilla/drivers/sound/pss.c	Sun Nov 12 02:33:14 2000
+++ linux-2.4.0/drivers/sound/pss.c	Fri Jan  5 13:46:55 2001
@@ -52,6 +52,8 @@
  *	    Adapted to module_init/module_exit
  * 11-10-2000: Bartlomiej Zolnierkiewicz <bkz@linux-ide.org>
  *	    Added __init to probe_pss(), attach_pss() and probe_pss_mpu()
+ * 02-Jan-2001: Chris Rankin
+ *          Specify that this module owns the coprocessor
  */
 
 
@@ -979,6 +981,7 @@
 static coproc_operations pss_coproc_operations =
 {
 	"ADSP-2115",
+	THIS_MODULE,
 	pss_coproc_open,
 	pss_coproc_close,
 	pss_coproc_ioctl,
diff -urN -X linux-2.4.0/dontdiff linux-vanilla/drivers/sound/sscape.c linux-2.4.0/drivers/sound/sscape.c
--- linux-vanilla/drivers/sound/sscape.c	Sun Nov 12 02:33:14 2000
+++ linux-2.4.0/drivers/sound/sscape.c	Fri Jan  5 13:53:12 2001
@@ -15,6 +15,7 @@
  * Sergey Smitienko	: ensoniq p'n'p support
  * Christoph Hellwig	: adapted to module_init/module_exit
  * Bartlomiej Zolnierkiewicz : added __init to attach_sscape()
+ * Chris Rankin		: Specify that this module owns the coprocessor
  */
 
 #include <linux/init.h>
@@ -600,6 +601,7 @@
 static coproc_operations sscape_coproc_operations =
 {
 	"SoundScape M68K",
+	THIS_MODULE,
 	sscape_coproc_open,
 	sscape_coproc_close,
 	sscape_coproc_ioctl,

--%--multipart-mixed-boundary-1.5359.978739978--%--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
