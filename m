Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318435AbSH1AZt>; Tue, 27 Aug 2002 20:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318447AbSH1AZt>; Tue, 27 Aug 2002 20:25:49 -0400
Received: from sun0.mpimf-heidelberg.mpg.de ([149.217.50.120]:52412 "EHLO
	sun0.mpimf-heidelberg.mpg.de") by vger.kernel.org with ESMTP
	id <S318435AbSH1AZk>; Tue, 27 Aug 2002 20:25:40 -0400
Subject: Re: Linux-2.4.20-pre4-ac1: i810_audio broken
From: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>
To: Andris Pavenis <pavenis@latnet.lv>
Cc: "linux-kernel@vger" <linux-kernel@vger.kernel.org>
In-Reply-To: <1030494098.9252.74.camel@volans>
References: <200208271253.12192.pavenis@latnet.lv> 
	<20020827144629.E28828@redhat.com>  <1030494098.9252.74.camel@volans>
Content-Type: multipart/mixed; boundary="=-Bsntgi25/u9M4oIbbQZv"
X-Mailer: Ximian Evolution 1.0.8 
Date: 28 Aug 2002 02:30:59 +0200
Message-Id: <1030494659.9253.83.camel@volans>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Bsntgi25/u9M4oIbbQZv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I sent the wrong patch...

On Wed, 2002-08-28 at 02:21, Juergen Sawinski wrote:
> I can't see any reason, why my i845 updates should touch dma stuff... 
> 
> The only changes I could think of causing troubles are 
> 1. dma reset (line 790, 842): no check if dma reset is complete
> 2. dma reset: reset occurs before latent interrupt bits are cleared
> 3. channel support (lines 1951 ff): more bits are cleared then should
>    be? (look for 0xcfffff, shouldn't that read 0xffcfffff; compare
>    lines 2829 and 2487)
> 4. At least on ICH4, OFF_CIV is a read only location, but writes
>    occur quite frequently.
> 
> Don't know if that helps.
> 
> George
> 
> P.S.: The attached patch goes to Alan seperately. Give it a try. (You
> can also remove the comment tags from line 795:
> 	while( inb(card->iobase + PI_CR) & 0x02 ) ;
> and line 849
> 	while( inb(card->iobase + PO_CR) & 0x02 ) ;
> They are  not necessary on my box, but...
> )
> 	
> On Tue, 2002-08-27 at 20:46, Doug Ledford wrote:
> > On Tue, Aug 27, 2002 at 12:53:12PM +0300, Andris Pavenis wrote:
> > > Found that i810_audio has been broken in kernel 2.4.20-pre4-ac1. It was Ok with 
> > > 2.4.20-pre1-ac1 I used before.
> > > 
> > > With 2.4.20-pre4-ac1 I'm only getting garbled sound and kernel messages (see below).
> > > Didn't have time yet to study mire detailed which change breaks driver.
> > 
> > The important part of my change is just two lines.  There is the line that 
> > prints out the message "Defaulting to base 2 channel mode." and the line 
> > after it where we mask off a couple bits in the global control register.  
> > Comment those two lines out and let me know if it makes a difference on 
> > your machine.
> > 
> > > In Alan's changelog I see:
> > > 
> > > 2.4.20-pre2-ac5: Further i810_audio updates for 845 (Juergen Sawinski) 
> > > 2.4.20-pre1-ac3: Tidy up error paths on i810_audio init (Alan) 
> > > 2.4.20-pre1-ac2: First set of i810 audio updates (Doug Ledford) 
> > > 
> > > Andris
> > > 
> > > ------ at startup -----------------
> > > Intel 810 + AC97 Audio, version 0.22, 11:18:00 Aug 26 2002
> > > PCI: Found IRQ 5 for device 00:1f.5
> > > PCI: Sharing IRQ 5 with 00:1f.3
> > > PCI: Setting latency timer of device 00:1f.5 to 64
> > > i810: Intel ICH 82801AA found at IO 0xe100 and 0xe000, MEM 0x0000 and 0x0000, IRQ 5
> > > i810_audio: Audio Controller supports 2 channels.
> > > i810_audio: Defaulting to base 2 channel mode.
> > > i810_audio: resetting hw channel 0
> > > ac97_codec: AC97 Audio codec, id: 0x4144:0x5348 (Analog Devices AD1881A)
> > > i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present), to
> > > ------ error messages  ------------
> > > i810_audio: DMA overrun on write
> > > i810_audio: CIV 0, LVI 27, hwptr 253a, count -13626
> > > i810_audio: DMA overrun on write
> > > i810_audio: CIV 0, LVI 27, hwptr 2662, count -296
> > > i810_audio: DMA overrun on write
> > > i810_audio: CIV 0, LVI 27, hwptr 2662, count -296
> > > i810_audio: DMA overrun on write
> > > i810_audio: CIV 0, LVI 27, hwptr 266a, count -8
> > > i810_audio: DMA overrun on write
> > > i810_audio: CIV 1, LVI 31, hwptr 2924, count -10526
> > > i810_audio: DMA overrun on write
> > > i810_audio: CIV 1, LVI 31, hwptr 2924, count -10526
> > > i810_audio: DMA overrun on write
> > > i810_audio: CIV 0, LVI 3, hwptr 253a, count -5434
> > > i810_audio: DMA overrun on write
> > > i810_audio: CIV 0, LVI 3, hwptr 2562, count -40
> > > ......
> > > 
> > > ---------  error message from artsd (KDE-3.1 beta1) -------
> > > Sound server fatal error:
> > > AudioSubSystem::handleIO: write failed
> > > len = 3228, can_write = 4096, errno = 17 (File exists)
> > > This might be a sound hardware/driver specific problem (see aRts FAQ)
> > > 
> > > -------------------------------------------------------------------- 
> > > Kernel was compiled with gcc-3.1 (like earlier kernels where i810_audio worked
> > > Ok)
> > 
> > -- 
> >   Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
> >          Red Hat, Inc. 
> >          1801 Varsity Dr.
> >          Raleigh, NC 27606
> >   
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -- 
> Juergen "George" Sawinski
> Max-Planck Institute for Medical Research
> Dept. of Biomedical Optics
> Jahnstr. 29
> D-69120 Heidelberg
> Germany
> 
> Phone:  +49-6221-486-308
> Fax:    +49-6221-486-325
> 
> priv.
> Phone:  +49-6221-418 858
> Mobile: +49-171-532 5302
> 
> ----
> 

> --- linux-2.4.20-pre4-ac2/drivers/sound/i810_audio.c	Tue Aug 27 21:44:25 2002
> +++ jsaw/drivers/sound/i810_audio.c	Wed Aug 28 01:26:28 2002
> @@ -69,12 +69,12 @@
>   *
>   *  ICH 4 caveats
>   *
> - *      The ICH4 has the feature, that the codec ID may not be congruent 
> - *      with the AC-link channel.
> + *      The ICH4 has the feature, that the codec ID doesn't have to be 
> + *      congruent with the IO connection.
>   * 
> - *      Right now, the codec ID is not the real codec ID but the AC-link
> - *      channel. A ID <-> AC-link mapping has still to be implemented.
> - *      
> + *      Therefore, from driver version 0.23 on, there is a "codec ID" <->
> + *      "IO register base offset" mapping (card->ac97_id_map) field.
> + *   
>   *      Juergen "George" Sawinski (jsaw) 
>   */
>   
> @@ -207,7 +207,7 @@
>  	CAS	 = 	0x34			/* Codec Write Semaphore Register */
>  };
>  
> -ENUM_ENGINE(MC2,4);     /* Mic. 2 */
> +ENUM_ENGINE(MC2,4);     /* Mic In 2 */
>  ENUM_ENGINE(PI2,5);     /* PCM In 2 */
>  ENUM_ENGINE(SP,6);      /* S/PDIF */
>  
> @@ -234,8 +234,7 @@
>  #define INT_GPI		(1<<0)
>  #define INT_MASK (INT_SEC|INT_PRI|INT_MC|INT_PO|INT_PI|INT_MO|INT_NI|INT_GPI)
>  
> -
> -#define DRIVER_VERSION "0.22"
> +#define DRIVER_VERSION "0.23"
>  
>  /* magic numbers to protect our data structures */
>  #define I810_CARD_MAGIC		0x5072696E /* "Prin" */
> @@ -295,7 +294,7 @@
>  	/*@FIXME to be verified*/	{  2, 0x0000 }, /* SI7012 */
>  	/*@FIXME to be verified*/	{  2, 0x0000 }, /* NVIDIA_NFORCE */
>  	/*@FIXME to be verified*/	{  2, 0x0000 }, /* AMD768 */
> -	/*@FIXME to be verified*/	{  2, 0x0000 }, /* AMD8111 */
> +	/*@FIXME to be verified*/	{  3, 0x0001 }, /* AMD8111 */
>  };
>  
>  static struct pci_device_id i810_pci_tbl [] __initdata = {
> @@ -417,6 +416,7 @@
>  	int dev_audio;
>  
>  	/* structures for abstraction of hardware facilities, codecs, banks and channels*/
> +	u16    ac97_id_map[NR_AC97];
>  	struct ac97_codec *ac97_codec[NR_AC97];
>  	struct i810_state *states[NR_HW_CH];
>  	struct i810_channel *channel;	/* 1:1 to states[] but diff. lifetime */
> @@ -449,6 +449,9 @@
>  	int initializing;
>  };
>  
> +/* extract register offset from codec struct */
> +#define IO_REG_OFF(codec) (((struct i810_card *) codec->private_data)->ac97_id_map[codec->id])
> +
>  static struct i810_card *devs = NULL;
>  
>  static int i810_open_mixdev(struct inode *inode, struct file *file);
> @@ -1948,13 +1955,13 @@
>  
>  		switch ( val ) {
>  			case 2: /* 2 channels is always supported */
> -				outl(i_glob_cnt & 0xcfffff,
> +				outl(i_glob_cnt & 0xffcfffff,
>  				     state->card->iobase + GLOB_CNT);
>  				/* Do we need to change mixer settings????  */
>  				break;
>  			case 4: /* Supported on some chipsets, better check first */
>  				if ( state->card->channels >= 4 ) {
> -					outl((i_glob_cnt & 0xcfffff) | 0x100000,
> +					outl((i_glob_cnt & 0xffcfffff) | 0x100000,
>  					      state->card->iobase + GLOB_CNT);
>  					/* Do we need to change mixer settings??? */
>  				} else {
> @@ -1963,7 +1970,7 @@
>  				break;
>  			case 6: /* Supported on some chipsets, better check first */
>  				if ( state->card->channels >= 6 ) {
> -					outl((i_glob_cnt & 0xcfffff) | 0x200000,
> +					outl((i_glob_cnt & 0xffcfffff) | 0x200000,
>  					      state->card->iobase + GLOB_CNT);
>  					/* Do we need to change mixer settings??? */
>  				} else {
> @@ -2553,8 +2560,7 @@
>  {
>  	struct i810_card *card = dev->private_data;
>  	int count = 100;
> -	u16 reg_set = ((u16) reg) & 0x7f;
> -	reg_set |= ((u16) dev->id) << 7;
> +	u16 reg_set = IO_REG_OFF(dev) | (reg&0x7f);
>  	
>  	while(count-- && (readb(card->iobase_mmio + CAS) & 1)) 
>  		udelay(1);
> @@ -2574,7 +2580,7 @@
>  {
>  	struct i810_card *card = dev->private_data;
>  	int count = 100;
> -	u8 reg_set = ((dev->id)?((reg&0x7f)|0x80):(reg&0x7f));
> +	u16 reg_set = IO_REG_OFF(dev) | (reg&0x7f);
>  	
>  	while(count-- && (inb(card->iobase + CAS) & 1)) 
>  		udelay(1);
> @@ -2586,8 +2592,7 @@
>  {
>  	struct i810_card *card = dev->private_data;
>  	int count = 100;
> -	u16 reg_set = ((u16) reg) & 0x7f;
> -	reg_set |= ((u16) dev->id) << 7;
> +	u16 reg_set = IO_REG_OFF(dev) | (reg&0x7f);
>  	
>  	while(count-- && (readb(card->iobase_mmio + CAS) & 1)) 
>  		udelay(1);
> @@ -2603,7 +2608,7 @@
>  {
>  	struct i810_card *card = dev->private_data;
>  	int count = 100;
> -	u8 reg_set = ((dev->id)?((reg&0x7f)|0x80):(reg&0x7f));
> +	u16 reg_set = IO_REG_OFF(dev) | (reg&0x7f);
>  	
>  	while(count-- && (inb(card->iobase + CAS) & 1)) 
>  		udelay(1);
> @@ -2779,7 +2784,7 @@
>  	if ((card->pci_id == PCI_DEVICE_ID_INTEL_ICH4)
>  	    && (card->use_mmio)) {
>  		primary_codec_id = (int) readl(card->iobase_mmio + SDM) & 0x3;
> -		printk(KERN_INFO "i810_audio: primary codec id %d\n",
> +		printk(KERN_INFO "i810_audio: Primary codec has ID %d\n",
>  		       primary_codec_id);
>  	}
>  
> @@ -2803,6 +2808,7 @@
>  	int num_ac97 = 0;
>  	int ac97_id;
>  	int total_channels = 0;
> +	int nr_ac97_max = card_cap[card->pci_id_internal].nr_ac97;
>  	struct ac97_codec *codec;
>  	u16 eid;
>  	u32 reg;
> @@ -2828,13 +2834,15 @@
>  	reg = inl(card->iobase + GLOB_CNT);
>  	outl(reg & 0xffcfffff, card->iobase + GLOB_CNT);
>  		
> -	for (num_ac97 = 0; num_ac97 < card_cap[card->pci_id_internal].nr_ac97; num_ac97++) {
> +	for (num_ac97 = 0; num_ac97 < NR_AC97; num_ac97++) 
>  		card->ac97_codec[num_ac97] = NULL;
> -	}
>  
> -	for (num_ac97 = 0; num_ac97 < card_cap[card->pci_id_internal].nr_ac97; num_ac97++) {
> +	/*@FIXME I don't know, if I'm playing to safe here... (jsaw) */
> +	if ((nr_ac97_max > 2) && !card->use_mmio) nr_ac97_max = 2;
> +
> +	for (num_ac97 = 0; num_ac97 < nr_ac97_max; num_ac97++) {
>  		/* codec reset */
> -		printk(KERN_INFO "i810_audio: resetting hw channel %d\n", num_ac97);
> +		printk(KERN_INFO "i810_audio: Resetting connection %d\n", num_ac97);
>  		if (card->use_mmio) readw(card->ac97base_mmio + 0x80*num_ac97);
>  		else inw(card->ac97base + 0x80*num_ac97);
>  
> @@ -2846,7 +2854,7 @@
>  		if ((card->pci_id == PCI_DEVICE_ID_INTEL_ICH4)
>  		    && (card->use_mmio)) {
>  			ac97_id = (int) readl(card->iobase_mmio + SDM) & 0x3;
> -			printk(KERN_INFO "i810_audio: hw channel %d, codec id %d\n",
> +			printk(KERN_INFO "i810_audio: Connection %d with codec id %d\n",
>  			       num_ac97, ac97_id);
>  		}
>  		else {
> @@ -2869,9 +2877,8 @@
>  		/* initialize some basic codec information, other fields will be filled
>  		   in ac97_probe_codec */
>  		codec->private_data = card;
> -
> -		/*@FIXME this will lead to problems!!! id=2 <-> io offset=0*/
> -		codec->id = num_ac97;
> +		codec->id = ac97_id;
> +		card->ac97_id_map[ac97_id] = num_ac97 * 0x80;
>  
>  		if (card->use_mmio) {	
>  			codec->codec_read = i810_ac97_get_mmio;
> @@ -2883,7 +2890,7 @@
>  		}
>  	
>  		if(!i810_ac97_probe_and_powerup(card,codec)) {
> -			printk(KERN_ERR "i810_audio: timed out waiting for codec %d analog ready.\n", num_ac97);
> +			printk(KERN_ERR "i810_audio: timed out waiting for codec %d analog ready.\n", ac97_id);
>  			kfree(codec);
>  			break;	/* it didn't work */
>  		}
> @@ -2903,7 +2910,7 @@
>  		codec->codec_write(codec, AC97_EXTENDED_MODEM_ID, 0L);
>  		if(codec->codec_read(codec, AC97_EXTENDED_MODEM_ID))
>  		{
> -			printk(KERN_WARNING "i810_audio: codec %d is a softmodem - skipping.\n", num_ac97);
> +			printk(KERN_WARNING "i810_audio: codec %d is a softmodem - skipping.\n", ac97_id);
>  			kfree(codec);
>  			continue;
>  		}
-- 
Juergen "George" Sawinski
Max-Planck Institute for Medical Research
Dept. of Biomedical Optics
Jahnstr. 29
D-69120 Heidelberg
Germany

Phone:  +49-6221-486-308
Fax:    +49-6221-486-325

priv.
Phone:  +49-6221-418 858
Mobile: +49-171-532 5302


--=-Bsntgi25/u9M4oIbbQZv
Content-Disposition: attachment; filename=patch-jsaw
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=patch-jsaw; charset=ISO-8859-1

--- linux-2.4.20-pre4-ac2/drivers/sound/i810_audio.c	Tue Aug 27 21:44:25 20=
02
+++ jsaw/drivers/sound/i810_audio.c	Wed Aug 28 01:26:28 2002
@@ -69,12 +69,12 @@
  *
  *  ICH 4 caveats
  *
- *      The ICH4 has the feature, that the codec ID may not be congruent=20
- *      with the AC-link channel.
+ *      The ICH4 has the feature, that the codec ID doesn't have to be=20
+ *      congruent with the IO connection.
  *=20
- *      Right now, the codec ID is not the real codec ID but the AC-link
- *      channel. A ID <-> AC-link mapping has still to be implemented.
- *     =20
+ *      Therefore, from driver version 0.23 on, there is a "codec ID" <->
+ *      "IO register base offset" mapping (card->ac97_id_map) field.
+ *  =20
  *      Juergen "George" Sawinski (jsaw)=20
  */
 =20
@@ -207,7 +207,7 @@
 	CAS	 =3D 	0x34			/* Codec Write Semaphore Register */
 };
=20
-ENUM_ENGINE(MC2,4);     /* Mic. 2 */
+ENUM_ENGINE(MC2,4);     /* Mic In 2 */
 ENUM_ENGINE(PI2,5);     /* PCM In 2 */
 ENUM_ENGINE(SP,6);      /* S/PDIF */
=20
@@ -234,8 +234,7 @@
 #define INT_GPI		(1<<0)
 #define INT_MASK (INT_SEC|INT_PRI|INT_MC|INT_PO|INT_PI|INT_MO|INT_NI|INT_G=
PI)
=20
-
-#define DRIVER_VERSION "0.22"
+#define DRIVER_VERSION "0.23"
=20
 /* magic numbers to protect our data structures */
 #define I810_CARD_MAGIC		0x5072696E /* "Prin" */
@@ -295,7 +294,7 @@
 	/*@FIXME to be verified*/	{  2, 0x0000 }, /* SI7012 */
 	/*@FIXME to be verified*/	{  2, 0x0000 }, /* NVIDIA_NFORCE */
 	/*@FIXME to be verified*/	{  2, 0x0000 }, /* AMD768 */
-	/*@FIXME to be verified*/	{  2, 0x0000 }, /* AMD8111 */
+	/*@FIXME to be verified*/	{  3, 0x0001 }, /* AMD8111 */
 };
=20
 static struct pci_device_id i810_pci_tbl [] __initdata =3D {
@@ -417,6 +416,7 @@
 	int dev_audio;
=20
 	/* structures for abstraction of hardware facilities, codecs, banks and c=
hannels*/
+	u16    ac97_id_map[NR_AC97];
 	struct ac97_codec *ac97_codec[NR_AC97];
 	struct i810_state *states[NR_HW_CH];
 	struct i810_channel *channel;	/* 1:1 to states[] but diff. lifetime */
@@ -449,6 +449,9 @@
 	int initializing;
 };
=20
+/* extract register offset from codec struct */
+#define IO_REG_OFF(codec) (((struct i810_card *) codec->private_data)->ac9=
7_id_map[codec->id])
+
 static struct i810_card *devs =3D NULL;
=20
 static int i810_open_mixdev(struct inode *inode, struct file *file);
@@ -788,6 +791,8 @@
 	while( inb(card->iobase + PI_CR) !=3D 0 ) ;
 	// reset the dma engine now
 	outb(0x02, card->iobase + PI_CR);
+	// wait for the card to acknowledge reset
+//	while( inb(card->iobase + PI_CR) & 0x02 ) ;
 	// now clear any latent interrupt bits (like the halt bit)
 	if(card->pci_id =3D=3D PCI_DEVICE_ID_SI_7012)
 		outb( inb(card->iobase + PI_PICB), card->iobase + PI_PICB );
@@ -840,6 +845,8 @@
 	while( inb(card->iobase + PO_CR) !=3D 0 ) ;
 	// reset the dma engine now
 	outb(0x02, card->iobase + PO_CR);
+	// wait for the card to acknowledge reset
+//	while( inb(card->iobase + PO_CR) & 0x02 ) ;
 	// now clear any latent interrupt bits (like the halt bit)
 	if(card->pci_id =3D=3D PCI_DEVICE_ID_SI_7012)
 		outb( inb(card->iobase + PO_PICB), card->iobase + PO_PICB );
@@ -1948,13 +1955,13 @@
=20
 		switch ( val ) {
 			case 2: /* 2 channels is always supported */
-				outl(i_glob_cnt & 0xcfffff,
+				outl(i_glob_cnt & 0xffcfffff,
 				     state->card->iobase + GLOB_CNT);
 				/* Do we need to change mixer settings????  */
 				break;
 			case 4: /* Supported on some chipsets, better check first */
 				if ( state->card->channels >=3D 4 ) {
-					outl((i_glob_cnt & 0xcfffff) | 0x100000,
+					outl((i_glob_cnt & 0xffcfffff) | 0x100000,
 					      state->card->iobase + GLOB_CNT);
 					/* Do we need to change mixer settings??? */
 				} else {
@@ -1963,7 +1970,7 @@
 				break;
 			case 6: /* Supported on some chipsets, better check first */
 				if ( state->card->channels >=3D 6 ) {
-					outl((i_glob_cnt & 0xcfffff) | 0x200000,
+					outl((i_glob_cnt & 0xffcfffff) | 0x200000,
 					      state->card->iobase + GLOB_CNT);
 					/* Do we need to change mixer settings??? */
 				} else {
@@ -2553,8 +2560,7 @@
 {
 	struct i810_card *card =3D dev->private_data;
 	int count =3D 100;
-	u16 reg_set =3D ((u16) reg) & 0x7f;
-	reg_set |=3D ((u16) dev->id) << 7;
+	u16 reg_set =3D IO_REG_OFF(dev) | (reg&0x7f);
 =09
 	while(count-- && (readb(card->iobase_mmio + CAS) & 1))=20
 		udelay(1);
@@ -2574,7 +2580,7 @@
 {
 	struct i810_card *card =3D dev->private_data;
 	int count =3D 100;
-	u8 reg_set =3D ((dev->id)?((reg&0x7f)|0x80):(reg&0x7f));
+	u16 reg_set =3D IO_REG_OFF(dev) | (reg&0x7f);
 =09
 	while(count-- && (inb(card->iobase + CAS) & 1))=20
 		udelay(1);
@@ -2586,8 +2592,7 @@
 {
 	struct i810_card *card =3D dev->private_data;
 	int count =3D 100;
-	u16 reg_set =3D ((u16) reg) & 0x7f;
-	reg_set |=3D ((u16) dev->id) << 7;
+	u16 reg_set =3D IO_REG_OFF(dev) | (reg&0x7f);
 =09
 	while(count-- && (readb(card->iobase_mmio + CAS) & 1))=20
 		udelay(1);
@@ -2603,7 +2608,7 @@
 {
 	struct i810_card *card =3D dev->private_data;
 	int count =3D 100;
-	u8 reg_set =3D ((dev->id)?((reg&0x7f)|0x80):(reg&0x7f));
+	u16 reg_set =3D IO_REG_OFF(dev) | (reg&0x7f);
 =09
 	while(count-- && (inb(card->iobase + CAS) & 1))=20
 		udelay(1);
@@ -2779,7 +2784,7 @@
 	if ((card->pci_id =3D=3D PCI_DEVICE_ID_INTEL_ICH4)
 	    && (card->use_mmio)) {
 		primary_codec_id =3D (int) readl(card->iobase_mmio + SDM) & 0x3;
-		printk(KERN_INFO "i810_audio: primary codec id %d\n",
+		printk(KERN_INFO "i810_audio: Primary codec has ID %d\n",
 		       primary_codec_id);
 	}
=20
@@ -2803,6 +2808,7 @@
 	int num_ac97 =3D 0;
 	int ac97_id;
 	int total_channels =3D 0;
+	int nr_ac97_max =3D card_cap[card->pci_id_internal].nr_ac97;
 	struct ac97_codec *codec;
 	u16 eid;
 	u32 reg;
@@ -2828,13 +2834,15 @@
 	reg =3D inl(card->iobase + GLOB_CNT);
 	outl(reg & 0xffcfffff, card->iobase + GLOB_CNT);
 	=09
-	for (num_ac97 =3D 0; num_ac97 < card_cap[card->pci_id_internal].nr_ac97; =
num_ac97++) {
+	for (num_ac97 =3D 0; num_ac97 < NR_AC97; num_ac97++)=20
 		card->ac97_codec[num_ac97] =3D NULL;
-	}
=20
-	for (num_ac97 =3D 0; num_ac97 < card_cap[card->pci_id_internal].nr_ac97; =
num_ac97++) {
+	/*@FIXME I don't know, if I'm playing to safe here... (jsaw) */
+	if ((nr_ac97_max > 2) && !card->use_mmio) nr_ac97_max =3D 2;
+
+	for (num_ac97 =3D 0; num_ac97 < nr_ac97_max; num_ac97++) {
 		/* codec reset */
-		printk(KERN_INFO "i810_audio: resetting hw channel %d\n", num_ac97);
+		printk(KERN_INFO "i810_audio: Resetting connection %d\n", num_ac97);
 		if (card->use_mmio) readw(card->ac97base_mmio + 0x80*num_ac97);
 		else inw(card->ac97base + 0x80*num_ac97);
=20
@@ -2846,7 +2854,7 @@
 		if ((card->pci_id =3D=3D PCI_DEVICE_ID_INTEL_ICH4)
 		    && (card->use_mmio)) {
 			ac97_id =3D (int) readl(card->iobase_mmio + SDM) & 0x3;
-			printk(KERN_INFO "i810_audio: hw channel %d, codec id %d\n",
+			printk(KERN_INFO "i810_audio: Connection %d with codec id %d\n",
 			       num_ac97, ac97_id);
 		}
 		else {
@@ -2869,9 +2877,8 @@
 		/* initialize some basic codec information, other fields will be filled
 		   in ac97_probe_codec */
 		codec->private_data =3D card;
-
-		/*@FIXME this will lead to problems!!! id=3D2 <-> io offset=3D0*/
-		codec->id =3D num_ac97;
+		codec->id =3D ac97_id;
+		card->ac97_id_map[ac97_id] =3D num_ac97 * 0x80;
=20
 		if (card->use_mmio) {=09
 			codec->codec_read =3D i810_ac97_get_mmio;
@@ -2883,7 +2890,7 @@
 		}
 =09
 		if(!i810_ac97_probe_and_powerup(card,codec)) {
-			printk(KERN_ERR "i810_audio: timed out waiting for codec %d analog read=
y.\n", num_ac97);
+			printk(KERN_ERR "i810_audio: timed out waiting for codec %d analog read=
y.\n", ac97_id);
 			kfree(codec);
 			break;	/* it didn't work */
 		}
@@ -2903,7 +2910,7 @@
 		codec->codec_write(codec, AC97_EXTENDED_MODEM_ID, 0L);
 		if(codec->codec_read(codec, AC97_EXTENDED_MODEM_ID))
 		{
-			printk(KERN_WARNING "i810_audio: codec %d is a softmodem - skipping.\n"=
, num_ac97);
+			printk(KERN_WARNING "i810_audio: codec %d is a softmodem - skipping.\n"=
, ac97_id);
 			kfree(codec);
 			continue;
 		}
@@ -3453,6 +3460,7 @@
=20
 /*
 Local Variables:
+compile-command: "gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict=
-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-fram=
e-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686 -DMODULE -nost=
dinc -I /usr/lib/gcc-lib/i486-suse-linux/2.95.3/include -DKBUILD_BASENAME=
=3Di810_audio -c -o i810_audio.o i810_audio.c"
 c-basic-offset: 8
 End:
 */

--=-Bsntgi25/u9M4oIbbQZv--

