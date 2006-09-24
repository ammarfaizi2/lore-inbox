Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWIXWUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWIXWUy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWIXWUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:20:54 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:40127 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751268AbWIXWUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:20:52 -0400
Message-ID: <451704BB.5070203@t-online.de>
Date: Mon, 25 Sep 2006 00:20:43 +0200
From: Hartmut Hackmann <hartmut.hackmann@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [V4L] Support for SAA7134-based AVerTV Hybrid A16AR
References: <20060923001246.GB11916@pasky.or.cz>
In-Reply-To: <20060923001246.GB11916@pasky.or.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: TntawyZZZePnaiFAsCcO4lXED2WsZ3nrv3xSsFmhBZTlzKUuA7l5Ek
X-TOI-MSGID: 8ef314c0-8238-46db-a382-8cf35e4d33cb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Petr

Petr Baudis wrote:
> This adds support for a hybrid PAL/DVB/FM card. Unfortunately I tested
> only the DVB since I don't have any proper antenna available and I can
> receive even the DVB just barely so; I can hear noise in the FM part
> but I couldn't catch any station, then again I don't have an FM antenna
> either.
> 
> The PAL/FM and IR control data are based on what I harvested on the 'net.
> Perhaps I or someone else will fix them if they turn out to be wrong.
> 
I am in doubt about some parts of your patch. Can you please check?

> Signed-off-by: Petr Baudis <pasky@ucw.cz>
> ---
> 
>  The patch is against linux-2.6.18.
> 
>  Documentation/video4linux/CARDLIST.saa7134  |    1 +
>  drivers/media/video/saa7134/saa7134-cards.c |   36 +++++++++++++++++++++++++++
>  drivers/media/video/saa7134/saa7134-dvb.c   |    1 +
>  drivers/media/video/saa7134/saa7134-input.c |    1 +
>  drivers/media/video/saa7134/saa7134.h       |    1 +
>  5 files changed, 40 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
> index 9068b66..52ab9a0 100644
> --- a/Documentation/video4linux/CARDLIST.saa7134
> +++ b/Documentation/video4linux/CARDLIST.saa7134
> @@ -94,3 +94,4 @@
>   93 -> Medion 7134 Bridge #2                    [16be:0005]
>   94 -> LifeView FlyDVB-T Hybrid Cardbus         [5168:3306,5168:3502]
>   95 -> LifeView FlyVIDEO3000 (NTSC)             [5169:0138]
> + 96 -> AVerTV Hybrid A16AR                      [1461:2c00]
> diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
> index 927413a..a9a322f 100644
> --- a/drivers/media/video/saa7134/saa7134-cards.c
> +++ b/drivers/media/video/saa7134/saa7134-cards.c
> @@ -2891,6 +2891,35 @@ struct saa7134_board saa7134_boards[] = 
>  			.gpio = 0x8000,
>  		},
>  	},
> +	[SAA7134_BOARD_AVERMEDIA_A16AR] = {
> +		/* Petr Baudis <pasky@ucw.cz> */
> +		.name           = "AVerMedia TV Hybrid A16AR",
> +		.audio_clock    = 0x187de7,
> +		.tuner_type     = TUNER_PHILIPS_TDA8290, /* untested */
> +		.radio_type     = TUNER_TEA5767, /* untested */
> +		.tuner_addr	= ADDR_UNSET,
> +		.radio_addr	= ADDR_UNSET,
> +		.tda9887_conf	= TDA9887_PRESENT,

If there is a TDA8290, there can't be a TDA9887. The tuner is a TD1316?
In this case, TUNER_PHILIPS_TD1316 is right.

> +		.mpeg           = SAA7134_MPEG_DVB,
> +		.inputs         = {{
> +			.name = name_tv,
> +			.vmux = 1,
> +			.amux = TV,
> +			.tv   = 1,
> +		},{
> +			.name = name_comp1,
> +			.vmux = 3,
> +			.amux = LINE2,
> +		},{
> +			.name = name_svideo,
> +			.vmux = 8,
> +			.amux = LINE1,
> +		}},
> +		.radio = {
> +			.name = name_radio,
> +			.amux = LINE1,
> +		},
> +	},
>  };
>  
>  const unsigned int saa7134_bcount = ARRAY_SIZE(saa7134_boards);
> @@ -3446,6 +3475,12 @@ struct pci_device_id saa7134_pci_tbl[] =
>  		.subdevice    = 0x3502,  /* whats the difference to 0x3306 ?*/
>  		.driver_data  = SAA7134_BOARD_FLYDVBT_HYBRID_CARDBUS,
>  	},{
> +		.vendor       = PCI_VENDOR_ID_PHILIPS,
> +		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
> +		.subvendor    = 0x1461,
> +		.subdevice    = 0x2c00,
> +		.driver_data  = SAA7134_BOARD_AVERMEDIA_A16AR,
> +	},{
>  		/* --- boards without eeprom + subsystem ID --- */
>  		.vendor       = PCI_VENDOR_ID_PHILIPS,
>  		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
> @@ -3581,6 +3616,7 @@ int saa7134_board_init1(struct saa7134_d
>  		saa_writeb(SAA7134_GPIO_GPMODE3, 0x08);
>  		saa_writeb(SAA7134_GPIO_GPSTATUS3, 0x00);
>  		break;
> +	case SAA7134_BOARD_AVERMEDIA_A16AR:
>  	case SAA7134_BOARD_AVERMEDIA_CARDBUS:
>  		/* power-up tuner chip */
>  		saa_andorl(SAA7134_GPIO_GPMODE0 >> 2,   0xffffffff, 0xffffffff);

This sets all GPIOs to output mode. Is that necessary?

> diff --git a/drivers/media/video/saa7134/saa7134-dvb.c b/drivers/media/video/saa7134/saa7134-dvb.c
> index 279828b..5339c99 100644
> --- a/drivers/media/video/saa7134/saa7134-dvb.c
> +++ b/drivers/media/video/saa7134/saa7134-dvb.c
> @@ -1020,6 +1020,7 @@ #ifdef HAVE_MT352
>  		break;
>  
>  	case SAA7134_BOARD_AVERMEDIA_777:
> +	case SAA7134_BOARD_AVERMEDIA_A16AR:
>  		printk("%s: avertv 777 dvb setup\n",dev->name);
>  		dev->dvb.frontend = mt352_attach(&avermedia_777,
>  						 &dev->i2c_adap);
> diff --git a/drivers/media/video/saa7134/saa7134-input.c b/drivers/media/video/saa7134/saa7134-input.c
> index 7c59549..1f51c04 100644
> --- a/drivers/media/video/saa7134/saa7134-input.c
> +++ b/drivers/media/video/saa7134/saa7134-input.c
> @@ -185,6 +185,7 @@ int saa7134_input_init1(struct saa7134_d
>  	case SAA7134_BOARD_AVERMEDIA_STUDIO_305:
>  	case SAA7134_BOARD_AVERMEDIA_STUDIO_307:
>  	case SAA7134_BOARD_AVERMEDIA_GO_007_FM:
> +	case SAA7134_BOARD_AVERMEDIA_A16AR:
>  		ir_codes     = ir_codes_avermedia;
>  		mask_keycode = 0x0007C8;
>  		mask_keydown = 0x000010;
> diff --git a/drivers/media/video/saa7134/saa7134.h b/drivers/media/video/saa7134/saa7134.h
> index c04ce61..9564190 100644
> --- a/drivers/media/video/saa7134/saa7134.h
> +++ b/drivers/media/video/saa7134/saa7134.h
> @@ -223,6 +223,7 @@ #define SAA7134_BOARD_AVERMEDIA_A169_B1 
>  #define SAA7134_BOARD_MD7134_BRIDGE_2     93
>  #define SAA7134_BOARD_FLYDVBT_HYBRID_CARDBUS 94
>  #define SAA7134_BOARD_FLYVIDEO3000_NTSC 95
> +#define SAA7134_BOARD_AVERMEDIA_A16AR   96
>  
>  #define SAA7134_MAXBOARDS 8
>  #define SAA7134_INPUT_MAX 8
> 
> 
Best regards
    Hartmut
