Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287578AbSAIPnq>; Wed, 9 Jan 2002 10:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287607AbSAIPng>; Wed, 9 Jan 2002 10:43:36 -0500
Received: from [200.10.161.32] ([200.10.161.32]:17072 "EHLO lila.inti.gov.ar")
	by vger.kernel.org with ESMTP id <S287578AbSAIPnU>;
	Wed, 9 Jan 2002 10:43:20 -0500
Message-ID: <3C3C658B.1DDBFA69@inti.gov.ar>
Date: Wed, 09 Jan 2002 12:45:15 -0300
From: salvador <salvador@inti.gov.ar>
Reply-To: salvador@inti.gov.ar
Organization: INTI
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: es-AR, en, es
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Thomas Sailer <t.sailer@alumni.ethz.ch>,
        Linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFCA] Sound: adding /proc/driver/{vendor}/{dev_pci}/ac97 entry 
 for es1371 driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel: 2.4.17
Hardware: CT5880+Sigmatel Codec
Module: sound/es1371.c

The following patch adds a proc entry to fetch information about the codec
attached to the CT5880 (ES137x) chip.
Note: Most of the code is already in ac97_codec.c module.

Doubts:
1) This adds something like: /proc/driver/es1371/00:03.00/ac97 I took the
idea from emu10k1.c module. My doubt is about the `:' it looks wrong in a
file name, specially when that's usually used to separate file names/paths.
Should we pass it by a small routine that converts : into something like _?
2) I used a buffer of fixed length as in other modules, but I don't feel
really good doing it. What solutions are recommended? (if any)


diff -ru linux-2.4.17.ori/drivers/sound/es1371.c
linux-2.4.17/drivers/sound/es1371.c
--- linux-2.4.17.ori/drivers/sound/es1371.c     Sun Sep 30 16:26:08 2001
+++ linux-2.4.17/drivers/sound/es1371.c Tue Jan  8 21:56:01 2002
@@ -110,6 +110,8 @@
  *    31.01.2001   0.30  Register/Unregister gameport
  *                       Fix SETTRIGGER non OSS API conformity
  *    14.07.2001   0.31  Add list of laptops needing amplifier control
+ *    08.01.2002   0.32  Add /proc/driver/es1371/{card}/ac97 entry
+ *                       Salvador E. Tropea <salvador@inti.gov.ar>
  */

 /*****************************************************************************/

@@ -2803,6 +2805,7 @@
        unsigned long tmo;
        signed long tmo2;
        unsigned int cssr;
+       char proc_str[80];

        if ((res=pci_enable_device(pcidev)))
                return res;
@@ -2960,6 +2963,16 @@
        for (i = 0; i < sizeof(initvol)/sizeof(initvol[0]); i++) {
                val = initvol[i].vol;
                mixdev_ioctl(&s->codec, initvol[i].mixch, (unsigned
long)&val);
+       }
+
+       /* create a proc entry to inform about the codec facilities */
+       strcpy(proc_str, "driver/es1371");
+       if (proc_mkdir (proc_str, 0)) {
+               sprintf(proc_str, "driver/es1371/%s", s->dev->slot_name);
+               if (proc_mkdir (proc_str, 0)) {
+                       strcat(proc_str, "/ac97");
+                       create_proc_read_entry(proc_str, 0, 0,
ac97_read_proc, &s->codec);
+               }
        }
        /* mute master and PCM when in S/PDIF mode */
        if (s->spdif_volume != -1) {
<--------End of patch

--
Salvador Eduardo Tropea (SET). (Electronics Engineer)
Visit my home page: http://welcome.to/SetSoft or
http://www.geocities.com/SiliconValley/Vista/6552/
Alternative e-mail: set@computer.org set@ieee.org
Address: Curapaligue 2124, Caseros, 3 de Febrero
Buenos Aires, (1678), ARGENTINA Phone: +(5411) 4759 0013



