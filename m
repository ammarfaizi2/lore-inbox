Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289575AbSAJRpI>; Thu, 10 Jan 2002 12:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289576AbSAJRou>; Thu, 10 Jan 2002 12:44:50 -0500
Received: from lila.inti.gov.ar ([200.10.161.32]:62923 "EHLO lila.inti.gov.ar")
	by vger.kernel.org with ESMTP id <S289574AbSAJRo1>;
	Thu, 10 Jan 2002 12:44:27 -0500
Message-ID: <3C3DD377.335BC421@inti.gov.ar>
Date: Thu, 10 Jan 2002 14:46:31 -0300
From: salvador <salvador@inti.gov.ar>
Reply-To: salvador@inti.gov.ar
Organization: INTI
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: es-AR, en, es
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Sailer <t.sailer@alumni.ethz.ch>
Subject: [PATCH][RFCA][2] Sound: adding 
 /proc/driver/{vendor}/{dev_pci}/ac97-{number} entry for
 	 es1371 driver
Content-Type: multipart/mixed;
 boundary="------------AD19CC995635CBD2FFB68D98"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------AD19CC995635CBD2FFB68D98
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Kernel: 2.4.17
Module: es1371.c
Harware tested: SB 16 PCI (CT5880+STAC9721/3)
Purpose of the patch: Add /proc/driver/es1371/{card}/ac97
Revision of the patch: 2

IMPORTANT: This mail contains some text repeated in the mail about the
patch in trident.c module. The repetition is because the mail goes to
different maintainers.

This (2nd iteration) patch fixes what Alan pointed out in previous patch: I
blindly forgot to remove the proc entries when removing the module.
This revision also logs a warning if the proc entries couldn't be created. I

consider it a warning because the sound is fully functional without it. If
any of the entries fails to be created it isn't a problem because the remove

routine will try to remove all the entries.
I also followed Tommy Reynolds suggestion about using vmalloc/vfree for the
temporal
buffer. Note the size of the buffer is unknown because the PCI ID could
change their size.

Q1: Should I wrap all the stuff with the "define label" used to indicate
that proc support was enabled in the kernel? emu10k1 (the module I took as
reference) doesn't do it.

Q2: As this entry gives important information about the codec and the code
is
in ac97_codec module (it means the overhead imposed to the other modules is
small) I think all the modules using codecs should register it. Now: should
we move the code that creates the entries to ac97_codec to simplify the
other
modules?

SET

--
Salvador Eduardo Tropea (SET). (Electronics Engineer)
Visit my home page: http://welcome.to/SetSoft or
http://www.geocities.com/SiliconValley/Vista/6552/
Alternative e-mail: set@computer.org set@ieee.org
Address: Curapaligue 2124, Caseros, 3 de Febrero
Buenos Aires, (1678), ARGENTINA Phone: +(5411) 4759 0013



--------------AD19CC995635CBD2FFB68D98
Content-Type: text/plain; charset=us-ascii;
 name="es1371.pat"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="es1371.pat"

diff -ru linux-2.4.17.ori/drivers/sound/es1371.c linux-2.4.17/drivers/sound/es1371.c
--- linux-2.4.17.ori/drivers/sound/es1371.c	Sun Sep 30 16:26:08 2001
+++ linux-2.4.17/drivers/sound/es1371.c	Wed Jan  9 20:53:58 2002
@@ -110,6 +110,8 @@
  *    31.01.2001   0.30  Register/Unregister gameport
  *                       Fix SETTRIGGER non OSS API conformity
  *    14.07.2001   0.31  Add list of laptops needing amplifier control
+ *    08.01.2002   0.32  Add /proc/driver/es1371/{card}/ac97 entry
+ *                       Salvador E. Tropea <salvador@inti.gov.ar>
  */
 
 /*****************************************************************************/
@@ -2794,6 +2796,9 @@
 };
 
 
+static char driver_str[] = "driver/es1371";
+static char ac97_str[] = "/ac97";
+
 static int __devinit es1371_probe(struct pci_dev *pcidev, const struct pci_device_id *pciid)
 {
 	struct es1371_state *s;
@@ -2803,6 +2808,8 @@
 	unsigned long tmo;
 	signed long tmo2;
 	unsigned int cssr;
+	char *proc_str;
+	int proc_success = 0;
 
 	if ((res=pci_enable_device(pcidev)))
 		return res;
@@ -2961,6 +2968,22 @@
 		val = initvol[i].vol;
 		mixdev_ioctl(&s->codec, initvol[i].mixch, (unsigned long)&val);
 	}
+
+	/* create a proc entry to inform about the codec facilities */
+	proc_str = (char *)vmalloc(sizeof(driver_str) + sizeof(ac97_str) +
+		strlen(s->dev->slot_name));
+	if (proc_mkdir(driver_str, 0)) {
+		sprintf(proc_str, "%s/%s", driver_str, s->dev->slot_name);
+		if (proc_mkdir(proc_str, 0)) {
+			strcat(proc_str, ac97_str);
+			if (create_proc_read_entry(proc_str, 0, 0, ac97_read_proc, &s->codec))
+				proc_success = 1;
+		}
+	}
+	vfree(proc_str);
+	if (!proc_success)
+		printk(KERN_WARNING PFX "cannot create /proc entry\n");
+
 	/* mute master and PCM when in S/PDIF mode */
 	if (s->spdif_volume != -1) {
 		val = 0x0000;
@@ -3003,6 +3026,7 @@
 static void __devinit es1371_remove(struct pci_dev *dev)
 {
 	struct es1371_state *s = pci_get_drvdata(dev);
+	char *proc_str;
 
 	if (!s)
 		return;
@@ -3011,6 +3035,17 @@
 	if (s->ps)
 		remove_proc_entry("es1371", NULL);
 #endif /* ES1371_DEBUG */
+
+	/* remove the proc entry */
+	proc_str = (char *)vmalloc(sizeof(driver_str) + sizeof(ac97_str) +
+		strlen(s->dev->slot_name));
+	sprintf(proc_str, "%s/%s%s", driver_str, s->dev->slot_name, ac97_str);
+	remove_proc_entry(proc_str, NULL);
+	sprintf(proc_str, "%s/%s", driver_str, s->dev->slot_name);
+	remove_proc_entry(proc_str, NULL);
+	remove_proc_entry(driver_str, NULL);
+	vfree(proc_str);
+
 	outl(0, s->io+ES1371_REG_CONTROL); /* switch everything off */
 	outl(0, s->io+ES1371_REG_SERIAL_CONTROL); /* clear serial interrupts */
 	synchronize_irq();

--------------AD19CC995635CBD2FFB68D98--

