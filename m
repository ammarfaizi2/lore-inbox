Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbVLDLov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbVLDLov (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 06:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbVLDLov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 06:44:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63878 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932133AbVLDLou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 06:44:50 -0500
Subject: Re: [PATCH 2.6.14.3] bttv-cards: add IO-DATA GV-BCTV2/PCI
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: his@kuro.is.sci.toho-u.ac.jp
Cc: linux-kernel@vger.kernel.org, kraxel@goldbach.in-berlin.de,
       Linux and Kernel Video <video4linux-list@redhat.com>
In-Reply-To: <20051204.111420.74726127.his@kuro.is.sci.toho-u.ac.jp>
References: <20051204.111420.74726127.his@kuro.is.sci.toho-u.ac.jp>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 04 Dec 2005 09:44:40 -0200
Message-Id: <1133696680.1192.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2-1mdk 
Content-Transfer-Encoding: 8bit
X-Spam-Score: 4.6 (++++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (4.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[200.163.6.18 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?200.163.6.18>]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[200.163.6.18 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hisashi,

	First of all, kraxel is not the current maintainer. Please c/c to me
instead. Also, please copy v4l mailing list. You don't need to c/c LKML
for this kind of patch.

Em Dom, 2005-12-04 às 11:14 +0900, ITO N. Hisashi escreveu:
> Add support for IO-DATA GV-BCTV/PCI and IO-DATA GV-BCTV2/PCI.
> 
> Signed-off-by: Hisashi Ito <kuro@neko.ac>
> 
> diff -U 5 -rpN linux-2.6.14.3-vanilla/drivers/media/video/bttv-cards.c linux-2.6.14.3/drivers/media/video/bttv-cards.c
	No. Newer patches should be generated against V4L tree. It is available
at http://linuxtv.org
>  
> +static void
> +gvbctv2pci_write(struct bttv *btv, int data)
> +{
> +	btwrite(0, BT848_GPIO_OUT_EN);
> +	btwrite(data, BT848_GPIO_DATA);
> +	btwrite(0xff00, BT848_GPIO_OUT_EN);
> +	data &= ~0x400;
> +	btwrite(data, BT848_GPIO_DATA);
> +	data |= 0x400;
> +	btwrite(data, BT848_GPIO_DATA);
> +	btwrite(0xff00, BT848_GPIO_DATA);
> +	btwrite(0, BT848_GPIO_OUT_EN);
> +}
> +
> +static int
> +gvbctv2pci_read(struct bttv *btv)
> +{
> +	int data;
> +
> +	btwrite(0, BT848_GPIO_OUT_EN);
> +	btwrite(0x0d00, BT848_GPIO_DATA);
> +	btwrite(0x0f00, BT848_GPIO_OUT_EN);
> +	btwrite(0x0500, BT848_GPIO_DATA);
> +	data = btread(BT848_GPIO_DATA);
> +	btwrite(0x0d00, BT848_GPIO_DATA);
> +	btwrite(0x0f00, BT848_GPIO_DATA);
> +	btwrite(0, BT848_GPIO_OUT_EN);
> +	return data;
> +}
> +
> +static void
> +gvbctv2pci_muxsel(struct bttv *btv, unsigned int input)
> +{
> +	static const int masks[] = {0x1f00, 0x0f00, 0x0f00};
> +	gvbctv2pci_write(btv, masks[input]);
> +}
> +
> +static void
> +gvbctv2pci_init(struct bttv *btv)
> +{
> +	gvbctv2pci_write(btv, 0x4d00); /* mute */
> +}

> +gvbctv2pci_audio(struct bttv *btv, struct video_audio *v, int set)
> +{
> +	if (set) {
> +		int con = 0x0d00;
> +
> +		if (v->mode & VIDEO_SOUND_LANG2) {
> +			con = 0x3d00; /* LANG2 */
> +			if (v->mode & VIDEO_SOUND_LANG1)
> +				con = 0x1d00; /* LANG1+LANG2 */
> +		}
> +		/* Set BCTV2 mute here since we can't do via direct gpio. */
> +		if (v->flags & VIDEO_AUDIO_MUTE)
> +			con = 0x4d00;
> +		gvbctv2pci_write(btv, con);
> +	} else {
> +		switch (gvbctv2pci_read(btv) & 0x7000) {
> +		case 0x3000:
> +			v->mode = VIDEO_SOUND_STEREO;
> +			break;
> +		case 0x4000:
> +			v->mode = VIDEO_SOUND_LANG1|VIDEO_SOUND_LANG2;
> +			break;
> +		case 0x5000:
> +			v->mode = VIDEO_SOUND_LANG2;
> +			break;
> +		case 0x6000:
> +			v->mode = VIDEO_SOUND_LANG1;
> +			break;
> +		case 0x7000:
> +			v->mode = VIDEO_SOUND_MONO;
> +			break;
> +		default:
> +			v->mode = VIDEO_SOUND_MONO | VIDEO_SOUND_STEREO |
> +				  VIDEO_SOUND_LANG1  | VIDEO_SOUND_LANG2;
> +		}
> +	}
> +}
> +
> +static void

	Am I wrong, or do you have a different audio chip? If so, the best
practice is to create a separate file for handling it (like we have for
msp34xx, wm8775 and others). 

> +#define BTTV_GVBCTV2PCI     0x89

	No. Today's last board is 0x8f. This is because you've used 2.6.14 instead of the v4l tree.

Cheers, 
Mauro.

