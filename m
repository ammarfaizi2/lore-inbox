Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287699AbSAIPuG>; Wed, 9 Jan 2002 10:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287697AbSAIPt7>; Wed, 9 Jan 2002 10:49:59 -0500
Received: from [200.10.161.32] ([200.10.161.32]:26800 "EHLO lila.inti.gov.ar")
	by vger.kernel.org with ESMTP id <S287684AbSAIPtv>;
	Wed, 9 Jan 2002 10:49:51 -0500
Message-ID: <3C3C6710.94FFF61A@inti.gov.ar>
Date: Wed, 09 Jan 2002 12:51:44 -0300
From: salvador <salvador@inti.gov.ar>
Reply-To: salvador@inti.gov.ar
Organization: INTI
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: es-AR, en, es
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFCA] Sound: adding /proc/driver/{vendor}/{dev_pci}/ac97 entry 
 for
 	 trident driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel: 2.4.17
Hardware: ALiM5451+ALC100P
Module: sound/trident.c

The following patch adds a proc entry to fetch information about the codec
attached to the audio "accelerator".
Note: Most of the code is already in ac97_codec.c module.

Doubts:
1) This adds something like: /proc/driver/ali5451/00:03.00/ac97 I took the
idea from emu10k1.c module. My doubt is about the `:' it looks wrong in a
file name, specially when that's usually used to separate file names/paths.
Should we pass it by a small routine that converts : into something like _?
2) I used a buffer of fixed length as in other modules, but I don't feel
really good doing it. What solutions are recommended? (if any)


--- linux-2.4.17.ori/drivers/sound/trident.c    Tue Nov 13 14:19:41 2001
+++ linux-2.4.17/drivers/sound/trident.c        Tue Jan  8 21:41:05 2002
@@ -36,6 +36,9 @@
  *     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
  *  History
+ *  v0.14.9e
+ *     January 8 2002 Salvador E. Tropea (SET) <salvador@inti.gov.ar>
+ *     added a /proc/driver/{vendor}/{card}/ac97 entry
  *  v0.14.9d
  *     October 8 2001 Arnaldo Carvalho de Melo <acme@conectiva.com.br>
  *     use set_current_state, properly release resources on failure in
@@ -3829,8 +3832,8 @@
        unsigned long ready_2nd = 0;
        struct ac97_codec *codec;
        int i = 0;
+       char proc_str[80], *name="unknown";

-
        /* initialize controller side of AC link, and find out if secondary
codes
           really exist */
        switch (card->pci_id)
@@ -3853,6 +3856,7 @@
                ready_2nd &= SI_AC97_SECONDARY_READY;
                if (card->revision < ALI_5451_V02)
                        ready_2nd = 0;
+               name = "ali5451";
                break;
        case PCI_DEVICE_ID_SI_7018:
                /* disable AC97 GPIO interrupt */
@@ -3865,16 +3869,19 @@
                udelay(2000);
                ready_2nd = inl(TRID_REG(card, SI_SERIAL_INTF_CTRL));
                ready_2nd &= SI_AC97_SECONDARY_READY;
+               name = "sis7018";
                break;
        case PCI_DEVICE_ID_TRIDENT_4DWAVE_DX:
                /* playback on */
                outl(DX_AC97_PLAYBACK, TRID_REG(card,
DX_ACR2_AC97_COM_STAT));
+               name = "trident4D_DX";
                break;
        case PCI_DEVICE_ID_TRIDENT_4DWAVE_NX:
                /* enable AC97 Output Slot 3,4 (PCM Left/Right Playback) */
                outl(NX_AC97_PCM_OUTPUT, TRID_REG(card,
NX_ACR0_AC97_COM_STAT));
                ready_2nd = inl(TRID_REG(card, NX_ACR0_AC97_COM_STAT));
                ready_2nd &= NX_AC97_SECONDARY_READY;
+               name = "trident4D_NX";
                break;
        case PCI_DEVICE_ID_INTERG_5050:
                /* disable AC97 GPIO interrupt */
@@ -3887,6 +3894,7 @@
                udelay(2000);
                ready_2nd = inl(TRID_REG(card, SI_SERIAL_INTF_CTRL));
                ready_2nd &= SI_AC97_SECONDARY_READY;
+               name = "cyber5050";
                break;
        }

@@ -3919,6 +3927,16 @@
                }

                card->ac97_codec[num_ac97] = codec;
+
+               /* Create a proc entry to inform about the codec facilities
*/
+               sprintf(proc_str, "driver/%s", name);
+               if (proc_mkdir (proc_str, 0)) {
+                       sprintf(proc_str, "driver/%s/%s", name,
card->pci_dev->slot_name);
+                       if (proc_mkdir (proc_str, 0)) {
+                               sprintf(proc_str, "driver/%s/%s/ac97", name,
card->pci_dev->slot_name);
+                               create_proc_read_entry (proc_str, 0, 0,
ac97_read_proc, codec);
+                       }
+               }

                /* if there is no secondary codec at all, don't probe any
more */
                if (!ready_2nd)
<---------End of patch

--
Salvador Eduardo Tropea (SET). (Electronics Engineer)
Visit my home page: http://welcome.to/SetSoft or
http://www.geocities.com/SiliconValley/Vista/6552/
Alternative e-mail: set@computer.org set@ieee.org
Address: Curapaligue 2124, Caseros, 3 de Febrero
Buenos Aires, (1678), ARGENTINA Phone: +(5411) 4759 0013



