Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129685AbQLERrp>; Tue, 5 Dec 2000 12:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129563AbQLERre>; Tue, 5 Dec 2000 12:47:34 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:9993 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S129518AbQLERrO>; Tue, 5 Dec 2000 12:47:14 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Tue, 5 Dec 2000 10:16:37 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E14352z-0004UZ-00@the-village.bc.nu>
In-Reply-To: <E14352z-0004UZ-00@the-village.bc.nu>
Subject: Re: 2.4.0-test12-pre4 + cs46xx + KDE 2.0 = frozen system
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <00120510163700.00846@spc.esa.lanl.gov>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 December 2000 16:29, Alan Cox wrote:
> > > Crystal 4280/461x + AC97 Audio, version 0.14, 13:39:25 Dec  4 2000
> > > cs461x: Card found at 0xf8ffe000 and 0xf8e00000, IRQ 18
> > > cs461x: Unknown card (FFFFFFFF:FFFFFFFF) at 0xf8ffe000/0xf8e00000, IRQ
> > > 18 ac97_codec: AC97 Audio codec, id: 0x4352:0x5914 (Unknown)
> >
> > This is failing to detect the CS46xx. I assume someone has fiddled with
> > the driver. Does it work correctly on your machine in 2.2.18pre24 ?

2.2.18pre24 works just fine, sound and everything, with KDE 2.0.  That's
what I'm running right now.  I had to fool around with the reiserfs-3.5.27
patch for one file, but that was no problem.

>
> A follow on question. This may be 2.4 PCI changes. That would mean you
> might want..
>
> --- drivers/sound/cs46xx.c~	Sat Dec  2 01:44:21 2000
> +++ drivers/sound/cs46xx.c	Mon Dec  4 22:58:58 2000
> @@ -2534,6 +2534,11 @@
>  	struct cs_card *card;
>  	struct cs_card_type *cp = &cards[0];
>
> +	if (pci_enable_device(pci_dev)<0)
> +	{
> +		printk(KERN_ERR "cs461x: unable to enable\n");
> +		return -EIO;
> +	}
>  	if ((card = kmalloc(sizeof(struct cs_card), GFP_KERNEL)) == NULL) {
>  		printk(KERN_ERR "cs461x: out of memory\n");
>  		return -ENOMEM;

OK, I patched in the above for both 2.4.0-test12-pre4 and pre5, but did not 
get any "unable to enable" printk messages appearing in /var/log/messages.

The behavior of course is the same, that is, sound will work under GNOME, but 
starting up KDE 2.0 freezes the machine.   To get modules to work with 
2.4.0-test12-pre5, I had to modify linux/include/linux/module.h, line 348, as 
was the case with test12-pre4. This was the patch that was posted to the list 
by Mohammad A. Haque. (Put parenthesis around the bare some_struct).

Here are some lines from messages for the three bootups which I tried:

>From 2.2.18pre24: (sound works with both KDE 2.0 and GNOME)

Crystal 4280/461x + AC97 Audio, version 0.13, 08:56:46 Dec  5 2000
cs461x: Card found at 0xf8ffe000 and 0xf8e00000, IRQ 18
cs461x: Unknown card (1028:0096) at 0xf8ffe000/0xf8e00000, IRQ 18
ac97_codec: AC97 Audio codec, vendor id1: 0x4352, id2: 0x5914 (Unknown)

>From 2.4.0-test12-pre4 with your above patch: (KDE 2.0 freezes)

Crystal 4280/461x + AC97 Audio, version 0.14, 07:16:56 Dec  5 2000
cs461x: Card found at 0xf8ffe000 and 0xf8e00000, IRQ 18
cs461x: Unknown card (FFFFFFFF:FFFFFFFF) at 0xf8ffe000/0xf8e00000, IRQ 18
ac97_codec: AC97 Audio codec, id: 0x4352:0x5914 (Unknown)

>From 2.4.0-test12-pre5 with your above patch: (KDE 2.0 freezes)

Crystal 4280/461x + AC97 Audio, version 0.14, 09:25:46 Dec  5 2000
cs461x: Card found at 0xf8ffe000 and 0xf8e00000, IRQ 18
cs461x: Unknown card (FFFFFFFF:FFFFFFFF) at 0xf8ffe000/0xf8e00000, IRQ 18
ac97_codec: AC97 Audio codec, id: 0x4352:0x5914 (Unknown)

I guess my next step is to learn how to set up a Serial Console for further 
troubleshooting.  Any further help appreciated.

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
