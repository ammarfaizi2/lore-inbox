Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289579AbSAJRr2>; Thu, 10 Jan 2002 12:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289574AbSAJRrI>; Thu, 10 Jan 2002 12:47:08 -0500
Received: from lila.inti.gov.ar ([200.10.161.32]:6604 "EHLO lila.inti.gov.ar")
	by vger.kernel.org with ESMTP id <S289578AbSAJRqL>;
	Thu, 10 Jan 2002 12:46:11 -0500
Message-ID: <3C3DD3DF.9490AB98@inti.gov.ar>
Date: Thu, 10 Jan 2002 14:48:15 -0300
From: salvador <salvador@inti.gov.ar>
Reply-To: salvador@inti.gov.ar
Organization: INTI
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: es-AR, en, es
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFC/A][2] Sound: adding /proc/driver/{vendor}/{dev_pci}/ac97 
 entry for
 	 trident driver
Content-Type: multipart/mixed;
 boundary="------------3D810A77FB3E4A9F4B4D7A29"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3D810A77FB3E4A9F4B4D7A29
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Kernel: 2.4.17
Module: trident.c
Harware tested: ALi 1647/1535D+ (M5451+ALC100P)
Purpose of the patch: Add /proc/driver/{vendor}/{card}/ac97-{number}
Revision of the patch: 2

IMPORTANT: This mail contains some text repeated in the mail about the
patch in es1371.c module. The repetition is because the mail goes to
different maintainers.

This (2nd iteration) patch fixes what Alan pointed out in previous patch:
1) I blindly forgot to remove the proc entries when removing the module.
2) I didn't realize the code already supports 2 codecs and the spec talks
about 4 codecs.

I used /proc/driver/{vendor}/{card}/ac97-{number} and not:
/proc/driver/{vendor}/{card}/ac97/{number} as suggested in ac97_codec module

comments. Why?

1) Other modules uses it for proc entries and /dev entries.
2) The code is simpler, I'm just incrementing an ASCI 0 at the end of the
string. It gives upto 10 nice names and upto 208 different names, looks
enough for the current spec that talks about 4 codecs (which can contain a
total of 4*4*2=32 channels). I can change it if needed.
3) Current implementations (see emu10k1/main.c) creates:
/proc/driver/{vendor}/{card}/ac97 it means ac97 is a file, I use the
suggested format ac97/%d the ac97 will become a directory. I see it
confusing and also complicates user space programs trying to list codecs.

This revision also logs a warning if the proc entries couldn't be created. I

consider it a warning because the sound is fully functional without it. If
any of the entries fails to be created it isn't a problem because the remove

routine will try to remove all the entries.
I also followed Tommy Reynolds suggestion about using vmalloc/vfree for the
temporal
buffer. Note the size of the buffer is unknown because the PCI ID could
change their size.

Q1: The module creates /proc/ALiM5451 (or something similar entry) to setup
some codec options. I don't think that's the right place and could conflict
if someday more than one M5451 "chip" can exist in the same machine. I think

this entry should be moved to something like:
/proc/driver/{vendor}/{card}/options

Q2: Should I wrap all the stuff with the "define label" used to indicate
that proc support was enabled in the kernel? emu10k1 (the module I took as
reference) doesn't do it.

Q3: As this entry gives important information about the codec and the code
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



--------------3D810A77FB3E4A9F4B4D7A29
Content-Type: text/plain; charset=us-ascii;
 name="trident.pat"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="trident.pat"

diff -ru linux-2.4.17.ori/drivers/sound/trident.c linux-2.4.17/drivers/sound/trident.c
--- linux-2.4.17.ori/drivers/sound/trident.c	Tue Nov 13 14:19:41 2001
+++ linux-2.4.17/drivers/sound/trident.c	Wed Jan  9 21:51:10 2002
@@ -36,6 +36,9 @@
  *	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
  *  History
+ *  v0.14.9e
+ *	January 8 2002 Salvador E. Tropea (SET) <salvador@inti.gov.ar>
+ *	added a /proc/driver/{vendor}/{card}/ac97-{number} entry
  *  v0.14.9d
  *  	October 8 2001 Arnaldo Carvalho de Melo <acme@conectiva.com.br>
  *	use set_current_state, properly release resources on failure in
@@ -3822,6 +3825,43 @@
 	return 0;
 }
 
+static char driver_str[] = "driver/";
+static char ac97_str[] = "/ac97-0";
+
+static const char *pci_id2name(u16 pci_id)
+{
+	const char *ret = "unknown";
+	
+	switch (pci_id)
+	{
+	case PCI_DEVICE_ID_ALI_5451:
+		ret = "ali5451";
+		break;
+	case PCI_DEVICE_ID_SI_7018:
+		ret = "sis7018";
+		break;
+	case PCI_DEVICE_ID_TRIDENT_4DWAVE_DX:
+		ret = "trident4D_DX";
+		break;
+	case PCI_DEVICE_ID_TRIDENT_4DWAVE_NX:
+		ret = "trident4D_NX";
+		break;
+	case PCI_DEVICE_ID_INTERG_5050:
+		ret = "cyber5050";
+		break;
+	}
+	
+	return ret;
+}
+
+static void remove_proc_dirs(struct trident_card *card, const char *name, char *proc_str)
+{
+	sprintf(proc_str, "%s%s/%s", driver_str, name, card->pci_dev->slot_name);
+	remove_proc_entry(proc_str, NULL);
+	sprintf(proc_str, "%s%s", driver_str, name);
+	remove_proc_entry(proc_str, NULL);
+}
+
 /* AC97 codec initialisation. */
 static int __init trident_ac97_init(struct trident_card *card)
 {
@@ -3829,8 +3869,11 @@
 	unsigned long ready_2nd = 0;
 	struct ac97_codec *codec;
 	int i = 0;
+	char *proc_str;
+	const char *name;
+	int size_buf;
+	int proc_success = 0;
 	
-
 	/* initialize controller side of AC link, and find out if secondary codes
 	   really exist */
 	switch (card->pci_id)
@@ -3890,9 +3933,25 @@
 		break;
 	}
 
+	/* Create a proc directory to inform about the codec facilities */
+	name = pci_id2name(card->pci_id);
+	size_buf = sizeof(driver_str) + sizeof(ac97_str) + strlen(name) +
+		strlen(card->pci_dev->slot_name); /* Note: sizeof gives 1 extra for EOS and / */
+	proc_str = (char *)vmalloc(size_buf);
+	sprintf(proc_str, "%s%s", driver_str, name);
+	if (proc_mkdir(proc_str, 0)) {
+		sprintf(proc_str, "%s%s/%s", driver_str, name, card->pci_dev->slot_name);
+		if (proc_mkdir(proc_str, 0))
+			proc_success = 1;
+	}
+	strcat(proc_str, ac97_str);
+	size_buf = strlen(proc_str) - 1;
+
 	for (num_ac97 = 0; num_ac97 < NR_AC97; num_ac97++) {
-		if ((codec = kmalloc(sizeof(struct ac97_codec), GFP_KERNEL)) == NULL)
+		if ((codec = kmalloc(sizeof(struct ac97_codec), GFP_KERNEL)) == NULL) {
+			remove_proc_dirs(card, name, proc_str);
 			return -ENOMEM;
+		}
 		memset(codec, 0, sizeof(struct ac97_codec));
 
 		/* initialize some basic codec information, other fields will be filled
@@ -3920,11 +3979,22 @@
 
 		card->ac97_codec[num_ac97] = codec;
 
+		/* Create a proc entry to inform about the codec facilities */
+		if (proc_success) {
+			if (!create_proc_read_entry(proc_str, 0, 0, ac97_read_proc, codec))
+				proc_success = 0;
+			proc_str[size_buf]++; /* after 10 codecs looks ugly, but works */
+		}
+
 		/* if there is no secondary codec at all, don't probe any more */
 		if (!ready_2nd)
 			break;
 	}
 
+	vfree(proc_str);
+	if (!proc_success)
+		printk(KERN_WARNING "trident: cannot create /proc entry\n");
+
 	if (card->pci_id == PCI_DEVICE_ID_ALI_5451) {
 		for (num_ac97 = 0; num_ac97 < NR_AC97; num_ac97++) {
 			if (card->ac97_codec[num_ac97] == NULL)
@@ -4145,6 +4215,9 @@
 {
 	int i;
 	struct trident_card *card = pci_get_drvdata(pci_dev);
+	int size_buf;
+	char *proc_str;
+	const char *name;
 
 	/*
  	 *	Kill running timers before unload. We can't have them
@@ -4170,12 +4243,27 @@
 	free_irq(card->irq, card);
 	release_region(card->iobase, 256);
 
+	name = pci_id2name(card->pci_id);
+	size_buf = sizeof(driver_str) + sizeof(ac97_str) + strlen(name) +
+		strlen(card->pci_dev->slot_name); /* Note: sizeof gives 1 extra for EOS */
+	proc_str = (char *)vmalloc(size_buf);
+	sprintf(proc_str, "%s%s/%s%s", driver_str, name, card->pci_dev->slot_name,
+		ac97_str);
+	size_buf = strlen(proc_str) - 1;
+
 	/* unregister audio devices */
-	for (i = 0; i < NR_AC97; i++)
+	for (i = 0; i < NR_AC97; i++) {
 		if (card->ac97_codec[i] != NULL) {
 			unregister_sound_mixer(card->ac97_codec[i]->dev_mixer);
 			kfree (card->ac97_codec[i]);
 		}
+		remove_proc_entry(proc_str, NULL);
+		proc_str[size_buf]++;
+	}
+
+	remove_proc_dirs(card, name, proc_str);
+	vfree(proc_str);
+
 	unregister_sound_dsp(card->dev_audio);
 
 	kfree(card);
--------------3D810A77FB3E4A9F4B4D7A29--

