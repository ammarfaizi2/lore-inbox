Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRAERVj>; Fri, 5 Jan 2001 12:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131639AbRAERVU>; Fri, 5 Jan 2001 12:21:20 -0500
Received: from snowstorm.mail.pipex.net ([158.43.192.97]:57340 "HELO
	snowstorm.mail.pipex.net") by vger.kernel.org with SMTP
	id <S129436AbRAERVP>; Fri, 5 Jan 2001 12:21:15 -0500
From: Chris Rankin <rankinc@zip.com.au>
Message-Id: <200101051717.f05HH0A01471@wittsend.ukgateway.net>
Subject: Re: Looking for maintainer of ENSONIQ SoundScape driver
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 5 Jan 2001 17:17:00 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Reply-To: rankinc@zip.com.au
In-Reply-To: <E14EZiH-0007yy-00@the-village.bc.nu> from "Alan Cox" at Jan 05, 2001 04:27:30 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="%--multipart-mixed-boundary-1.1434.978715020--%"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--%--multipart-mixed-boundary-1.1434.978715020--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> > would like to discuss with its maintainer, please. For instance,
> > although /dev/mixer does not use sscape.o (the mixer driver is in the
> > ad1848.o module), unloading sscape.o while a mixer application is
> 
> That sounds like the mixer calls sscape code and there is a locking error
> somewhere that should have prevented the unload

Well, from what I've seen, the sscape code initialies the mpu401 and
ad1848 devices when it loads, and deallocates all their resources when
it unloads. The mixer doesn't actually call sscape code at all, but
references a mixer_dev[] pointer which sscape trashes when it calls
ad1848_unload().

This seems to be the crux of the problem: sscape is fiddling with
resources that belong to other modules.

However, what you describe is exactly what sscape and mpu401 were
doing with regards to /dev/sequencer2. mpu401 was using a coprocessor
device contained within the sscape module. (Patch enclosed.)

> > sscape.o allocates IO ports is also suspicious, and causes these
> > messages to be logged every time the sound modules are loaded:
> > 
> > Jan 5 14:08:31 wittsend kernel: Trying to free nonexistent resource <00000338-00000339>
> > Jan 5 14:08:31 wittsend kernel: Trying to free nonexistent resource <00000330-00000337>
> > 

> Look for request_resource/free_resource mismatches 

The detect_sscape_pnp() routine seems to expect check_region() to
allocate resources, although if that's true, it's rather cavalier
about releasing them again! Is this what Linux 2.2 used to do?

I have access to this machine for another week and so can try to sort
this out, but as far as this mixer problem goes, I'm not sure what
kind of big-picture to aim for. For example, my modules.conf look like
this:

# Sound support
alias synth0 off
alias sound-slot-0 sscape
alias sound-service-0-1 off
alias sound-service-0-6 off
alias sound-service-0-8 off
options sscape irq=5 dma=1 io=0x338 mpu_io=0x330 mpu_irq=9

(No ISA-PNP for sscape yet.)

Now this "sound-slot-0" approach would seem to imply a module-stack
that looks like this:

soundcore
sound
sscape
mpu401, ad1848

However, the actual module usage pattern looks like this:

Module                  Size  Used by
sscape                 10192   0 (autoclean)
ad1848                 16992   0 (autoclean) [sscape]
mpu401                 18928   0 (autoclean) [sscape]
sound                  56976   0 (autoclean) [sscape ad1848 mpu401]
soundcore               3952   5 (autoclean) [sscape sound]

So although sscape can load mpu401 and ad1848, it mustn't unload them? The mixer code seems to live in sound.o - I don't want to do something stupid in there!

And advice gratefully accepted,
Cheers,
Chris Rankin

--%--multipart-mixed-boundary-1.1434.978715020--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Description: English text
Content-Disposition: attachment; filename="sscape-2.diff"

--- drivers/sound/sscape.c.orig	Sun Nov 12 02:33:14 2000
+++ drivers/sound/sscape.c	Wed Jan  3 12:07:42 2001
@@ -1023,7 +1025,7 @@
 	int sscape_ext_midi		= 0;		
 
 	if ( !sscape_pnp_alloc_dma(devc) ) {
-		printk(KERN_ERR "sscape: faild to allocate dma\n");
+		printk(KERN_ERR "sscape: failed to allocate dma\n");
 		return;
 	}
 
@@ -1063,7 +1065,7 @@
 	}
 
 	if (sscape_pnp_upload_file(devc, "/sndscape/scope.cod") == 0 ) {
-		printk(KERN_ERR "sscape: faild to upload file /sndscape/scope.cod\n");
+		printk(KERN_ERR "sscape: failed to upload file /sndscape/scope.cod\n");
 		sscape_pnp_free_dma(devc);
 		return;
 	}
@@ -1071,14 +1073,14 @@
 	i = sscape_read_host_ctrl( devc );
 	
 	if ( (i & 0x0F) >  7 ) {
-		printk(KERN_ERR "sscape: scope.cod faild\n");
+		printk(KERN_ERR "sscape: scope.cod failed\n");
 		sscape_pnp_free_dma(devc);
 		return;
 	}
 	if ( i & 0x10 ) sscape_write( devc, 7, 0x2F);
 	code_file_name[21] = (char) ( i & 0x0F) + 0x30;
 	if (sscape_pnp_upload_file( devc, code_file_name) == 0) {
-		printk(KERN_ERR "sscape: faild to upload file %s\n", code_file_name);
+		printk(KERN_ERR "sscape: failed to upload file %s\n", code_file_name);
 		sscape_pnp_free_dma(devc);
 		return;
 	}
@@ -1379,7 +1381,7 @@
  		printk(KERN_WARNING "soundscape: Warning! The WSS mode can't share IRQ with MIDI\n");
  				
 	hw_config->slots[0] = ad1848_init(
-			sscape_is_pnp ? "SoundScape" : "SoundScape PNP",
+			sscape_is_pnp ? "SoundScape PNP" : "SoundScape",
 			hw_config->io_base,
 			hw_config->irq,
 			hw_config->dma,

--%--multipart-mixed-boundary-1.1434.978715020--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Description: 'diff' output text
Content-Disposition: attachment; filename="sscape-1.diff"

diff -urN -X dontdiff linux-vanilla/drivers/sound/audio.c linux-2.4.0/drivers/sound/audio.c
--- linux-vanilla/drivers/sound/audio.c	Fri Aug 11 16:26:43 2000
+++ linux-2.4.0/drivers/sound/audio.c	Tue Jan  2 15:16:54 2001
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
 
@@ -88,9 +90,12 @@
 	if ((ret = DMAbuf_open(dev, mode)) < 0)
 		return ret;
 
-	if (audio_devs[dev]->coproc) {
-		if ((ret = audio_devs[dev]->coproc->
-			open(audio_devs[dev]->coproc->devc, COPR_PCM)) < 0) {
+	if ( (coprocessor = audio_devs[dev]->coproc) != NULL ) {
+		struct module *coproc_owner = coprocessor->owner;
+		if (coproc_owner)
+			__MOD_INC_USE_COUNT(coproc_owner);
+
+		if ((ret = coprocessor->open(coprocessor->devc, COPR_PCM)) < 0) {
 			audio_release(dev, file);
 			printk(KERN_WARNING "Sound: Can't access coprocessor device\n");
 			return ret;
@@ -156,7 +161,8 @@
 
 void audio_release(int dev, struct file *file)
 {
-	int             mode = translate_mode(file);
+	struct coproc_operations *coprocessor;
+	int mode = translate_mode(file);
 
 	dev = dev >> 4;
 
@@ -176,8 +182,14 @@
 	if (mode & OPEN_WRITE)
 		sync_output(dev);
 
-	if (audio_devs[dev]->coproc)
-		audio_devs[dev]->coproc->close(audio_devs[dev]->coproc->devc, COPR_PCM);
+	if ( (coprocessor = audio_devs[dev]->coproc) != NULL ) {
+		struct module *coproc_owner;
+
+		coprocessor->close(coprocessor->devc, COPR_PCM);
+
+		if ( (coproc_owner = coprocessor->owner) != NULL )
+			__MOD_DEC_USE_COUNT(coproc_owner);
+	}
 	DMAbuf_release(dev, mode);
 
 	if (audio_devs[dev]->d->owner)
diff -urN -X dontdiff linux-vanilla/drivers/sound/dev_table.h linux-2.4.0/drivers/sound/dev_table.h
--- linux-vanilla/drivers/sound/dev_table.h	Fri Aug 11 16:26:43 2000
+++ linux-2.4.0/drivers/sound/dev_table.h	Tue Jan  2 14:24:46 2001
@@ -150,6 +150,7 @@
 typedef struct coproc_operations 
 {
 	char name[64];
+	struct module *owner;
 	int (*open) (void *devc, int sub_device);
 	void (*close) (void *devc, int sub_device);
 	int (*ioctl) (void *devc, unsigned int cmd, caddr_t arg, int local);
diff -urN -X dontdiff linux-vanilla/drivers/sound/mpu401.c linux-2.4.0/drivers/sound/mpu401.c
--- linux-vanilla/drivers/sound/mpu401.c	Sun Nov 12 02:32:01 2000
+++ linux-2.4.0/drivers/sound/mpu401.c	Tue Jan  2 15:25:12 2001
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
@@ -490,12 +495,16 @@
 		reset_mpu401(devc);
 	}
 
-	if (midi_devs[dev]->coproc)
+	if ( (coprocessor = midi_devs[dev]->coproc) != NULL )
 	{
-		if ((err = midi_devs[dev]->coproc->
-		     open(midi_devs[dev]->coproc->devc, COPR_MIDI)) < 0)
+		struct module *coproc_owner = coprocessor->owner;
+		if (coproc_owner)
+			__MOD_INC_USE_COUNT(coproc_owner);
+
+		if ((err = coprocessor->open(coprocessor->devc, COPR_MIDI)) < 0)
 		{
-			printk("MPU-401: Can't access coprocessor device\n");
+			printk(KERN_ERR "MPU-401: Can't access coprocessor device\n");
+			mpu401_close(dev);
 			return err;
 		}
 	}
@@ -515,6 +524,7 @@
 static void mpu401_close(int dev)
 {
 	struct mpu_config *devc;
+	struct coproc_operations *coprocessor;
 
 	devc = &dev_conf[dev];
 	if (devc->uart_mode)
@@ -524,8 +534,14 @@
 	devc->mode = 0;
 	devc->inputintr = NULL;
 
-	if (midi_devs[dev]->coproc)
-		midi_devs[dev]->coproc->close(midi_devs[dev]->coproc->devc, COPR_MIDI);
+	coprocessor = midi_devs[dev]->coproc;
+	if (coprocessor) {
+		struct module *coproc_owner;
+		coprocessor->close(coprocessor->devc, COPR_MIDI);
+
+		if ( (coproc_owner = coprocessor->owner) != NULL )
+			__MOD_DEC_USE_COUNT(coproc_owner);
+	}
 	devc->opened = 0;
 }
 
diff -urN -X dontdiff linux-vanilla/drivers/sound/pss.c linux-2.4.0/drivers/sound/pss.c
--- linux-vanilla/drivers/sound/pss.c	Sun Nov 12 02:33:14 2000
+++ linux-2.4.0/drivers/sound/pss.c	Tue Jan  2 15:21:38 2001
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
diff -urN -X dontdiff linux-vanilla/drivers/sound/sscape.c linux-2.4.0/drivers/sound/sscape.c
--- linux-vanilla/drivers/sound/sscape.c	Sun Nov 12 02:33:14 2000
+++ linux-2.4.0/drivers/sound/sscape.c	Tue Jan  2 15:22:02 2001
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

--%--multipart-mixed-boundary-1.1434.978715020--%--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
