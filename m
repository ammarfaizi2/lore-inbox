Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284160AbRLFRim>; Thu, 6 Dec 2001 12:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284156AbRLFRii>; Thu, 6 Dec 2001 12:38:38 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:52229 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S284160AbRLFRi3>; Thu, 6 Dec 2001 12:38:29 -0500
Date: Thu, 6 Dec 2001 14:21:39 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.16 for pointers to __devexit functions
In-Reply-To: <11777.1007619756@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.21.0112061421280.21465-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please regenerate this patch against -pre5 and then send me... 

On Thu, 6 Dec 2001, Keith Owens wrote:

> This patch against 2.4.16 defines __devexit_p() for pointers to
> functions defined as __devexit, the wrapper inserts the function name
> or NULL, based on config options.  It allows people to use the new
> binutils on the kernel, there are some real kernel bugs that binutils
> will find once this patch is in.
> 
> I have patched all the obvious references to __devexit functions,
> leaving a few which appear to be real bugs.  I notified the maintainers
> of the buggy code privately.
> 
> 
> Index: 16.1/Documentation/pci.txt
> --- 16.1/Documentation/pci.txt Tue, 06 Nov 2001 12:07:56 +1100 kaos (linux-2.4/a/d/42_pci.txt 1.1.1.2.1.2 644)
> +++ 16.1(w)/Documentation/pci.txt Thu, 06 Dec 2001 16:16:25 +1100 kaos (linux-2.4/a/d/42_pci.txt 1.1.1.2.1.2 644)
> @@ -104,6 +104,10 @@ Tips:
>  	If you are sure the driver is not a hotplug driver then use only 
>  	__init/exit __initdata/exitdata.
>  
> +        Pointers to functions marked as __devexit must be created using
> +        __devexit_p(function_name).  That will generate the function
> +        name or NULL if the __devexit function will be discarded.
> +
>  
>  2. How to find PCI devices manually (the old style)
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Index: 16.1/include/linux/init.h
> --- 16.1/include/linux/init.h Mon, 30 Jul 2001 10:52:30 +1000 kaos (linux-2.4/f/b/11_init.h 1.1.1.1.1.2 644)
> +++ 16.1(w)/include/linux/init.h Thu, 06 Dec 2001 17:11:02 +1100 kaos (linux-2.4/f/b/11_init.h 1.1.1.1.1.2 644)
> @@ -111,7 +111,7 @@ extern struct kernel_param __setup_start
>   */
>  #define module_exit(x)	__exitcall(x);
>  
> -#else
> +#else	/* MODULE */
>  
>  #define __init
>  #define __exit
> @@ -141,7 +141,7 @@ typedef void (*__cleanup_module_func_t)(
>  
>  #define __setup(str,func) /* nothing */
>  
> -#endif
> +#endif	/* !MODULE */
>  
>  #ifdef CONFIG_HOTPLUG
>  #define __devinit
> @@ -153,6 +153,18 @@ typedef void (*__cleanup_module_func_t)(
>  #define __devinitdata __initdata
>  #define __devexit __exit
>  #define __devexitdata __exitdata
> +#endif
> +
> +/* Functions marked as __devexit may be discarded at kernel link time, depending
> +   on config options.  Newer versions of binutils detect references from
> +   retained sections to discarded sections and flag an error.  Pointers to
> +   __devexit functions must use __devexit_p(function_name), the wrapper will
> +   insert either the function_name or NULL, depending on the config options.
> + */
> +#if defined(MODULE) || defined(CONFIG_HOTPLUG)
> +#define __devexit_p(x) x
> +#else
> +#define __devexit_p(x) NULL
>  #endif
>  
>  #endif /* _LINUX_INIT_H */
> Index: 16.1/drivers/media/video/bttv-driver.c
> --- 16.1/drivers/media/video/bttv-driver.c Fri, 19 Oct 2001 12:25:53 +1000 kaos (linux-2.4/t/b/47_bttv-drive 1.3.1.1.1.2.1.1.1.1.1.2 644)
> +++ 16.1(w)/drivers/media/video/bttv-driver.c Thu, 06 Dec 2001 16:30:16 +1100 kaos (linux-2.4/t/b/47_bttv-drive 1.3.1.1.1.2.1.1.1.1.1.2 644)
> @@ -3025,7 +3025,7 @@ static struct pci_driver bttv_pci_driver
>          name:     "bttv",
>          id_table: bttv_pci_tbl,
>          probe:    bttv_probe,
> -        remove:   bttv_remove,
> +        remove:   __devexit_p(bttv_remove),
>  };
>  
>  int bttv_init_module(void)
> Index: 16.1/drivers/ieee1394/ohci1394.c
> --- 16.1/drivers/ieee1394/ohci1394.c Thu, 04 Oct 2001 16:23:36 +1000 kaos (linux-2.4/v/b/2_ohci1394.c 1.1.1.1.1.3.1.3.1.2 644)
> +++ 16.1(w)/drivers/ieee1394/ohci1394.c Thu, 06 Dec 2001 17:12:55 +1100 kaos (linux-2.4/v/b/2_ohci1394.c 1.1.1.1.1.3.1.3.1.2 644)
> @@ -2423,7 +2423,7 @@ static struct pci_driver ohci1394_driver
>  	name:		OHCI1394_DRIVER_NAME,
>  	id_table:	ohci1394_pci_tbl,
>  	probe:		ohci1394_add_one,
> -	remove:		ohci1394_remove_one,
> +	remove:		__devexit_p(ohci1394_remove_one),
>  };
>  
>  static void __exit ohci1394_cleanup (void)
> Index: 16.1/drivers/pcmcia/pci_socket.c
> --- 16.1/drivers/pcmcia/pci_socket.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/v/b/38_pci_socket 1.1.1.3 644)
> +++ 16.1(w)/drivers/pcmcia/pci_socket.c Thu, 06 Dec 2001 16:40:06 +1100 kaos (linux-2.4/v/b/38_pci_socket 1.1.1.3 644)
> @@ -249,7 +249,7 @@ static struct pci_driver pci_cardbus_dri
>  	name:		"cardbus",
>  	id_table:	cardbus_table,
>  	probe:		cardbus_probe,
> -	remove:		cardbus_remove,
> +	remove:		__devexit_p(cardbus_remove),
>  	suspend:	cardbus_suspend,
>  	resume:		cardbus_resume,
>  };
> Index: 16.1/drivers/atm/firestream.c
> --- 16.1/drivers/atm/firestream.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/w/b/32_firestream 1.2.1.5.1.1 644)
> +++ 16.1(w)/drivers/atm/firestream.c Thu, 06 Dec 2001 16:18:40 +1100 kaos (linux-2.4/w/b/32_firestream 1.2.1.5.1.1 644)
> @@ -2102,7 +2102,7 @@ static struct pci_driver firestream_driv
>  	name:           "firestream",
>  	id_table:       firestream_pci_tbl,
>  	probe:          firestream_init_one,
> -	remove:         firestream_remove_one,
> +	remove:         __devexit_p(firestream_remove_one),
>  };
>  
>  static int __init firestream_init_module (void)
> Index: 16.1/drivers/atm/eni.c
> --- 16.1/drivers/atm/eni.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/x/b/10_eni.c 1.1.1.1.1.2.1.1 644)
> +++ 16.1(w)/drivers/atm/eni.c Thu, 06 Dec 2001 16:18:19 +1100 kaos (linux-2.4/x/b/10_eni.c 1.1.1.1.1.2.1.1 644)
> @@ -2310,7 +2310,7 @@ static struct pci_driver eni_driver = {
>  	name:		DEV_LABEL,
>  	id_table:	eni_pci_tbl,
>  	probe:		eni_init_one,
> -	remove:		eni_remove_one,
> +	remove:		__devexit_p(eni_remove_one),
>  };
>  
>  
> Index: 16.1/drivers/usb/usb-uhci.c
> --- 16.1/drivers/usb/usb-uhci.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/z/b/2_usb-uhci.c 1.2.1.1.1.16 644)
> +++ 16.1(w)/drivers/usb/usb-uhci.c Thu, 06 Dec 2001 16:43:12 +1100 kaos (linux-2.4/z/b/2_usb-uhci.c 1.2.1.1.1.16 644)
> @@ -3070,7 +3070,7 @@ static struct pci_driver uhci_pci_driver
>  	id_table:	&uhci_pci_ids [0],
>  
>  	probe:		uhci_pci_probe,
> -	remove:		uhci_pci_remove,
> +	remove:		__devexit_p(uhci_pci_remove),
>  
>  #ifdef	CONFIG_PM
>  	suspend:	uhci_pci_suspend,
> Index: 16.1/drivers/usb/uhci.c
> --- 16.1/drivers/usb/uhci.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/z/b/4_uhci.c 1.1.2.1.2.1.2.3.1.12 644)
> +++ 16.1(w)/drivers/usb/uhci.c Thu, 06 Dec 2001 16:41:09 +1100 kaos (linux-2.4/z/b/4_uhci.c 1.1.2.1.2.1.2.3.1.12 644)
> @@ -2990,7 +2990,7 @@ static struct pci_driver uhci_pci_driver
>  	id_table:	uhci_pci_ids,
>  
>  	probe:		uhci_pci_probe,
> -	remove:		uhci_pci_remove,
> +	remove:		__devexit_p(uhci_pci_remove),
>  
>  #ifdef	CONFIG_PM
>  	suspend:	uhci_pci_suspend,
> Index: 16.1/drivers/usb/usb-ohci.c
> --- 16.1/drivers/usb/usb-ohci.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/z/b/28_usb-ohci.c 1.2.1.2.1.6.1.3.2.3.2.2 644)
> +++ 16.1(w)/drivers/usb/usb-ohci.c Thu, 06 Dec 2001 16:40:58 +1100 kaos (linux-2.4/z/b/28_usb-ohci.c 1.2.1.2.1.6.1.3.2.3.2.2 644)
> @@ -2860,7 +2860,7 @@ static struct pci_driver ohci_pci_driver
>  	id_table:	&ohci_pci_ids [0],
>  
>  	probe:		ohci_pci_probe,
> -	remove:		ohci_pci_remove,
> +	remove:		__devexit_p(ohci_pci_remove),
>  
>  #ifdef	CONFIG_PM
>  	suspend:	ohci_pci_suspend,
> Index: 16.1/drivers/video/tdfxfb.c
> --- 16.1/drivers/video/tdfxfb.c Fri, 16 Nov 2001 14:10:23 +1100 kaos (linux-2.4/C/b/37_tdfxfb.c 1.2.2.1.1.1.1.1.1.5 644)
> +++ 16.1(w)/drivers/video/tdfxfb.c Thu, 06 Dec 2001 16:44:21 +1100 kaos (linux-2.4/C/b/37_tdfxfb.c 1.2.2.1.1.1.1.1.1.5 644)
> @@ -495,7 +495,7 @@ static struct pci_driver tdfxfb_driver =
>  	name:		"tdfxfb",
>  	id_table:	tdfxfb_id_table,
>  	probe:		tdfxfb_probe,
> -	remove:		tdfxfb_remove,
> +	remove:		__devexit_p(tdfxfb_remove),
>  };
>  
>  MODULE_DEVICE_TABLE(pci, tdfxfb_id_table);
> Index: 16.1/drivers/video/riva/fbdev.c
> --- 16.1/drivers/video/riva/fbdev.c Fri, 16 Nov 2001 14:10:23 +1100 kaos (linux-2.4/C/b/45_fbdev.c 1.5.1.4 644)
> +++ 16.1(w)/drivers/video/riva/fbdev.c Thu, 06 Dec 2001 16:43:24 +1100 kaos (linux-2.4/C/b/45_fbdev.c 1.5.1.4 644)
> @@ -2082,7 +2082,7 @@ static struct pci_driver rivafb_driver =
>  	name:		"rivafb",
>  	id_table:	rivafb_pci_tbl,
>  	probe:		rivafb_init_one,
> -	remove:		rivafb_remove_one,
> +	remove:		__devexit_p(rivafb_remove_one),
>  };
>  
>  
> Index: 16.1/drivers/video/cyber2000fb.c
> --- 16.1/drivers/video/cyber2000fb.c Fri, 26 Oct 2001 15:50:03 +1000 kaos (linux-2.4/D/b/3_cyber2000f 1.2.2.2.1.1.1.2.1.2 644)
> +++ 16.1(w)/drivers/video/cyber2000fb.c Thu, 06 Dec 2001 16:43:34 +1100 kaos (linux-2.4/D/b/3_cyber2000f 1.2.2.2.1.1.1.2.1.2 644)
> @@ -1683,7 +1683,7 @@ static struct pci_device_id cyberpro_pci
>  static struct pci_driver cyberpro_driver = {
>  	name:		"CyberPro",
>  	probe:		cyberpro_probe,
> -	remove:		cyberpro_remove,
> +	remove:		__devexit_p(cyberpro_remove),
>  	suspend:	cyberpro_suspend,
>  	resume:		cyberpro_resume,
>  	id_table:	cyberpro_pci_table
> Index: 16.1/drivers/video/imsttfb.c
> --- 16.1/drivers/video/imsttfb.c Fri, 16 Nov 2001 14:10:23 +1100 kaos (linux-2.4/D/b/42_imsttfb.c 1.2.2.1.1.3.1.1.1.3 644)
> +++ 16.1(w)/drivers/video/imsttfb.c Thu, 06 Dec 2001 16:43:51 +1100 kaos (linux-2.4/D/b/42_imsttfb.c 1.2.2.1.1.3.1.1.1.3 644)
> @@ -1643,7 +1643,7 @@ static struct pci_driver imsttfb_pci_dri
>  	name:		"imsttfb",
>  	id_table:	imsttfb_pci_tbl,
>  	probe:		imsttfb_probe,
> -	remove:		imsttfb_remove,
> +	remove:		__devexit_p(imsttfb_remove),
>  };
>  
>  static struct fb_ops imsttfb_ops = {
> Index: 16.1/drivers/sound/ymfpci.c
> --- 16.1/drivers/sound/ymfpci.c Tue, 20 Nov 2001 15:39:10 +1100 kaos (linux-2.4/L/b/45_ymfpci.c 1.4.1.9.1.1.1.2.1.3 644)
> +++ 16.1(w)/drivers/sound/ymfpci.c Thu, 06 Dec 2001 16:40:39 +1100 kaos (linux-2.4/L/b/45_ymfpci.c 1.4.1.9.1.1.1.2.1.3 644)
> @@ -2547,7 +2547,7 @@ static struct pci_driver ymfpci_driver =
>  	name:		"ymfpci",
>  	id_table:	ymf_id_tbl,
>  	probe:		ymf_probe_one,
> -	remove:         ymf_remove_one,
> +	remove:         __devexit_p(ymf_remove_one),
>  	suspend:	ymf_suspend,
>  	resume:		ymf_resume
>  };
> Index: 16.1/drivers/sound/emu10k1/main.c
> --- 16.1/drivers/sound/emu10k1/main.c Wed, 10 Oct 2001 11:34:17 +1000 kaos (linux-2.4/M/b/14_main.c 1.3.1.2.1.4 644)
> +++ 16.1(w)/drivers/sound/emu10k1/main.c Thu, 06 Dec 2001 16:40:17 +1100 kaos (linux-2.4/M/b/14_main.c 1.3.1.2.1.4 644)
> @@ -1127,7 +1127,7 @@ static struct pci_driver emu10k1_pci_dri
>  	name:		"emu10k1",
>  	id_table:	emu10k1_pci_tbl,
>  	probe:		emu10k1_probe,
> -	remove:		emu10k1_remove,
> +	remove:		__devexit_p(emu10k1_remove),
>  };
>  
>  static int __init emu10k1_init_module(void)
> Index: 16.1/drivers/char/joystick/pcigame.c
> --- 16.1/drivers/char/joystick/pcigame.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/Y/b/30_pcigame.c 1.1.1.2 644)
> +++ 16.1(w)/drivers/char/joystick/pcigame.c Thu, 06 Dec 2001 16:20:46 +1100 kaos (linux-2.4/Y/b/30_pcigame.c 1.1.1.2 644)
> @@ -180,7 +180,7 @@ static struct pci_driver pcigame_driver 
>  	name:		"pcigame",
>  	id_table:	pcigame_id_table,
>  	probe:		pcigame_probe,
> -	remove:		pcigame_remove,
> +	remove:		__devexit_p(pcigame_remove),
>  };
>  
>  int __init pcigame_init(void)
> Index: 16.1/drivers/char/serial.c
> --- 16.1/drivers/char/serial.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/b/c/22_serial.c 1.1.3.2.2.3.2.2.1.8.1.1 644)
> +++ 16.1(w)/drivers/char/serial.c Thu, 06 Dec 2001 16:20:59 +1100 kaos (linux-2.4/b/c/22_serial.c 1.1.3.2.2.3.2.2.1.8.1.1 644)
> @@ -4896,7 +4896,7 @@ MODULE_DEVICE_TABLE(pci, serial_pci_tbl)
>  static struct pci_driver serial_pci_driver = {
>         name:           "serial",
>         probe:          serial_init_one,
> -       remove:	       serial_remove_one,
> +       remove:	       __devexit_p(serial_remove_one),
>         id_table:       serial_pci_tbl,
>  };
>  
> Index: 16.1/drivers/block/cciss.c
> --- 16.1/drivers/block/cciss.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/c/c/34_cciss.c 1.4.2.3.1.2.1.9 644)
> +++ 16.1(w)/drivers/block/cciss.c Thu, 06 Dec 2001 16:19:09 +1100 kaos (linux-2.4/c/c/34_cciss.c 1.4.2.3.1.2.1.9 644)
> @@ -2019,7 +2019,7 @@ static void __devexit cciss_remove_one (
>  static struct pci_driver cciss_pci_driver = {
>  	 name:   "cciss",
>  	probe:  cciss_init_one,
> -	remove:  cciss_remove_one,
> +	remove:  __devexit_p(cciss_remove_one),
>  	id_table:  cciss_pci_device_id, /* id_table */
>  };
>  
> Index: 16.1/drivers/net/winbond-840.c
> --- 16.1/drivers/net/winbond-840.c Wed, 10 Oct 2001 11:34:17 +1000 kaos (linux-2.4/c/c/43_winbond-84 1.2.1.4.1.2.1.7 644)
> +++ 16.1(w)/drivers/net/winbond-840.c Thu, 06 Dec 2001 16:38:34 +1100 kaos (linux-2.4/c/c/43_winbond-84 1.2.1.4.1.2.1.7 644)
> @@ -1697,7 +1697,7 @@ static struct pci_driver w840_driver = {
>  	name:		DRV_NAME,
>  	id_table:	w840_pci_tbl,
>  	probe:		w840_probe1,
> -	remove:		w840_remove1,
> +	remove:		__devexit_p(w840_remove1),
>  #ifdef CONFIG_PM
>  	suspend:	w840_suspend,
>  	resume:		w840_resume,
> Index: 16.1/drivers/net/sundance.c
> --- 16.1/drivers/net/sundance.c Tue, 23 Oct 2001 14:35:33 +1000 kaos (linux-2.4/c/c/44_sundance.c 1.2.1.10.1.2 644)
> +++ 16.1(w)/drivers/net/sundance.c Thu, 06 Dec 2001 16:38:48 +1100 kaos (linux-2.4/c/c/44_sundance.c 1.2.1.10.1.2 644)
> @@ -1474,7 +1474,7 @@ static struct pci_driver sundance_driver
>  	name:		DRV_NAME,
>  	id_table:	sundance_pci_tbl,
>  	probe:		sundance_probe1,
> -	remove:		sundance_remove1,
> +	remove:		__devexit_p(sundance_remove1),
>  };
>  
>  static int __init sundance_init(void)
> Index: 16.1/drivers/net/natsemi.c
> --- 16.1/drivers/net/natsemi.c Tue, 20 Nov 2001 15:39:10 +1100 kaos (linux-2.4/c/c/45_natsemi.c 1.3.1.8.1.1.1.6 644)
> +++ 16.1(w)/drivers/net/natsemi.c Thu, 06 Dec 2001 16:37:32 +1100 kaos (linux-2.4/c/c/45_natsemi.c 1.3.1.8.1.1.1.6 644)
> @@ -2518,7 +2518,7 @@ static struct pci_driver natsemi_driver 
>  	name:		DRV_NAME,
>  	id_table:	natsemi_pci_tbl,
>  	probe:		natsemi_probe1,
> -	remove:		natsemi_remove1,
> +	remove:		__devexit_p(natsemi_remove1),
>  #ifdef CONFIG_PM
>  	suspend:	natsemi_suspend,
>  	resume:		natsemi_resume,
> Index: 16.1/drivers/net/pcmcia/xircom_tulip_cb.c
> --- 16.1/drivers/net/pcmcia/xircom_tulip_cb.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/d/c/16_xircom_tul 1.4.1.8 644)
> +++ 16.1(w)/drivers/net/pcmcia/xircom_tulip_cb.c Thu, 06 Dec 2001 16:32:03 +1100 kaos (linux-2.4/d/c/16_xircom_tul 1.4.1.8 644)
> @@ -1748,7 +1748,7 @@ static struct pci_driver xircom_driver =
>  	name:		DRV_NAME,
>  	id_table:	xircom_pci_table,
>  	probe:		xircom_init_one,
> -	remove:		xircom_remove_one,
> +	remove:		__devexit_p(xircom_remove_one),
>  #ifdef CONFIG_PM
>  	suspend:	xircom_suspend,
>  	resume:		xircom_resume
> Index: 16.1/drivers/net/ioc3-eth.c
> --- 16.1/drivers/net/ioc3-eth.c Fri, 19 Oct 2001 12:25:53 +1000 kaos (linux-2.4/d/c/49_ioc3-eth.c 1.1.2.1.1.3.1.2.1.2 644)
> +++ 16.1(w)/drivers/net/ioc3-eth.c Thu, 06 Dec 2001 16:36:43 +1100 kaos (linux-2.4/d/c/49_ioc3-eth.c 1.1.2.1.1.3.1.2.1.2 644)
> @@ -1515,7 +1515,7 @@ static struct pci_driver ioc3_driver = {
>  	name:		"ioc3-eth",
>  	id_table:	ioc3_pci_tbl,
>  	probe:		ioc3_probe,
> -	remove:		ioc3_remove_one,
> +	remove:		__devexit_p(ioc3_remove_one),
>  };
>  
>  static int __init ioc3_init_module(void)
> Index: 16.1/drivers/net/tulip/tulip_core.c
> --- 16.1/drivers/net/tulip/tulip_core.c Tue, 20 Nov 2001 15:39:10 +1100 kaos (linux-2.4/e/c/6_tulip_core 1.1.1.1.1.1.2.3.1.3.1.12 644)
> +++ 16.1(w)/drivers/net/tulip/tulip_core.c Thu, 06 Dec 2001 16:33:01 +1100 kaos (linux-2.4/e/c/6_tulip_core 1.1.1.1.1.1.2.3.1.3.1.12 644)
> @@ -1889,7 +1889,7 @@ static struct pci_driver tulip_driver = 
>  	name:		DRV_NAME,
>  	id_table:	tulip_pci_tbl,
>  	probe:		tulip_init_one,
> -	remove:		tulip_remove_one,
> +	remove:		__devexit_p(tulip_remove_one),
>  #ifdef CONFIG_PM
>  	suspend:	tulip_suspend,
>  	resume:		tulip_resume,
> Index: 16.1/drivers/net/8139too.c
> --- 16.1/drivers/net/8139too.c Tue, 27 Nov 2001 11:15:00 +1100 kaos (linux-2.4/f/c/30_8139too.c 1.2.1.5.1.1.1.5.1.7 644)
> +++ 16.1(w)/drivers/net/8139too.c Thu, 06 Dec 2001 16:34:18 +1100 kaos (linux-2.4/f/c/30_8139too.c 1.2.1.5.1.1.1.5.1.7 644)
> @@ -2493,7 +2493,7 @@ static struct pci_driver rtl8139_pci_dri
>  	name:		DRV_NAME,
>  	id_table:	rtl8139_pci_tbl,
>  	probe:		rtl8139_init_one,
> -	remove:		rtl8139_remove_one,
> +	remove:		__devexit_p(rtl8139_remove_one),
>  #ifdef CONFIG_PM
>  	suspend:	rtl8139_suspend,
>  	resume:		rtl8139_resume,
> Index: 16.1/drivers/net/ne2k-pci.c
> --- 16.1/drivers/net/ne2k-pci.c Tue, 02 Oct 2001 11:04:33 +1000 kaos (linux-2.4/f/c/42_ne2k-pci.c 1.3.1.1.1.1.1.1 644)
> +++ 16.1(w)/drivers/net/ne2k-pci.c Thu, 06 Dec 2001 16:37:42 +1100 kaos (linux-2.4/f/c/42_ne2k-pci.c 1.3.1.1.1.1.1.1 644)
> @@ -642,7 +642,7 @@ static void __devexit ne2k_pci_remove_on
>  static struct pci_driver ne2k_driver = {
>  	name:		DRV_NAME,
>  	probe:		ne2k_pci_init_one,
> -	remove:		ne2k_pci_remove_one,
> +	remove:		__devexit_p(ne2k_pci_remove_one),
>  	id_table:	ne2k_pci_tbl,
>  };
>  
> Index: 16.1/drivers/net/epic100.c
> --- 16.1/drivers/net/epic100.c Tue, 02 Oct 2001 11:04:33 +1000 kaos (linux-2.4/f/c/43_epic100.c 1.2.1.4.1.2.1.2.1.3 644)
> +++ 16.1(w)/drivers/net/epic100.c Thu, 06 Dec 2001 16:36:13 +1100 kaos (linux-2.4/f/c/43_epic100.c 1.2.1.4.1.2.1.2.1.3 644)
> @@ -1507,7 +1507,7 @@ static struct pci_driver epic_driver = {
>  	name:		DRV_NAME,
>  	id_table:	epic_pci_tbl,
>  	probe:		epic_init_one,
> -	remove:		epic_remove_one,
> +	remove:		__devexit_p(epic_remove_one),
>  #ifdef CONFIG_PM
>  	suspend:	epic_suspend,
>  	resume:		epic_resume,
> Index: 16.1/drivers/net/arcnet/com20020-pci.c
> --- 16.1/drivers/net/arcnet/com20020-pci.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/h/c/3_com20020-p 1.2.1.1.1.3 644)
> +++ 16.1(w)/drivers/net/arcnet/com20020-pci.c Thu, 06 Dec 2001 16:30:57 +1100 kaos (linux-2.4/h/c/3_com20020-p 1.2.1.1.1.3 644)
> @@ -160,7 +160,7 @@ static struct pci_driver com20020pci_dri
>  	name:		"com20020",
>  	id_table:	com20020pci_id_table,
>  	probe:		com20020pci_probe,
> -	remove:		com20020pci_remove
> +	remove:		__devexit_p(com20020pci_remove),
>  };
>  
>  static int __init com20020pci_init(void)
> Index: 16.1/drivers/net/sis900.c
> --- 16.1/drivers/net/sis900.c Wed, 10 Oct 2001 11:34:17 +1000 kaos (linux-2.4/h/c/13_sis900.c 1.3.1.11.1.3 644)
> +++ 16.1(w)/drivers/net/sis900.c Thu, 06 Dec 2001 16:38:10 +1100 kaos (linux-2.4/h/c/13_sis900.c 1.3.1.11.1.3 644)
> @@ -2098,7 +2098,7 @@ static struct pci_driver sis900_pci_driv
>  	name:		SIS900_MODULE_NAME,
>  	id_table:	sis900_pci_tbl,
>  	probe:		sis900_probe,
> -	remove:		sis900_remove,
> +	remove:		__devexit_p(sis900_remove),
>  };
>  
>  static int __init sis900_init_module(void)
> Index: 16.1/drivers/net/yellowfin.c
> --- 16.1/drivers/net/yellowfin.c Tue, 23 Oct 2001 14:35:33 +1000 kaos (linux-2.4/h/c/17_yellowfin. 1.1.1.3.1.8.1.1 644)
> +++ 16.1(w)/drivers/net/yellowfin.c Thu, 06 Dec 2001 16:39:33 +1100 kaos (linux-2.4/h/c/17_yellowfin. 1.1.1.3.1.8.1.1 644)
> @@ -1506,7 +1506,7 @@ static struct pci_driver yellowfin_drive
>  	name:		DRV_NAME,
>  	id_table:	yellowfin_pci_tbl,
>  	probe:		yellowfin_init_one,
> -	remove:		yellowfin_remove_one,
> +	remove:		__devexit_p(yellowfin_remove_one),
>  };
>  
>  
> Index: 16.1/drivers/net/via-rhine.c
> --- 16.1/drivers/net/via-rhine.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/h/c/19_via-rhine. 1.1.1.4.1.2.1.3.1.2.1.1.1.1 644)
> +++ 16.1(w)/drivers/net/via-rhine.c Thu, 06 Dec 2001 16:39:20 +1100 kaos (linux-2.4/h/c/19_via-rhine. 1.1.1.4.1.2.1.3.1.2.1.1.1.1 644)
> @@ -1667,7 +1667,7 @@ static struct pci_driver via_rhine_drive
>  	name:		"via-rhine",
>  	id_table:	via_rhine_pci_tbl,
>  	probe:		via_rhine_init_one,
> -	remove:		via_rhine_remove_one,
> +	remove:		__devexit_p(via_rhine_remove_one),
>  };
>  
>  
> Index: 16.1/drivers/net/starfire.c
> --- 16.1/drivers/net/starfire.c Tue, 02 Oct 2001 11:04:33 +1000 kaos (linux-2.4/h/c/22_starfire.c 1.1.1.9.1.3 644)
> +++ 16.1(w)/drivers/net/starfire.c Thu, 06 Dec 2001 16:38:22 +1100 kaos (linux-2.4/h/c/22_starfire.c 1.1.1.9.1.3 644)
> @@ -1963,7 +1963,7 @@ static void __devexit starfire_remove_on
>  static struct pci_driver starfire_driver = {
>  	name:		DRV_NAME,
>  	probe:		starfire_init_one,
> -	remove:		starfire_remove_one,
> +	remove:		__devexit_p(starfire_remove_one),
>  	id_table:	starfire_pci_tbl,
>  };
>  
> Index: 16.1/drivers/net/eepro100.c
> --- 16.1/drivers/net/eepro100.c Tue, 13 Nov 2001 08:45:38 +1100 kaos (linux-2.4/h/c/27_eepro100.c 1.1.1.1.1.2.6.4.2.4 644)
> +++ 16.1(w)/drivers/net/eepro100.c Thu, 06 Dec 2001 16:36:00 +1100 kaos (linux-2.4/h/c/27_eepro100.c 1.1.1.1.1.2.6.4.2.4 644)
> @@ -2281,7 +2281,7 @@ static struct pci_driver eepro100_driver
>  	name:		"eepro100",
>  	id_table:	eepro100_pci_tbl,
>  	probe:		eepro100_init_one,
> -	remove:		eepro100_remove_one,
> +	remove:		__devexit_p(eepro100_remove_one),
>  #ifdef CONFIG_PM
>  	suspend:	eepro100_suspend,
>  	resume:		eepro100_resume,
> Index: 16.1/drivers/net/defxx.c
> --- 16.1/drivers/net/defxx.c Tue, 02 Oct 2001 11:04:33 +1000 kaos (linux-2.4/h/c/40_defxx.c 1.2.1.4.1.3.1.1 644)
> +++ 16.1(w)/drivers/net/defxx.c Thu, 06 Dec 2001 16:35:16 +1100 kaos (linux-2.4/h/c/40_defxx.c 1.2.1.4.1.3.1.1 644)
> @@ -3360,7 +3360,7 @@ MODULE_DEVICE_TABLE(pci, dfx_pci_tbl);
>  static struct pci_driver dfx_driver = {
>  	name:		"defxx",
>  	probe:		dfx_init_one,
> -	remove:		dfx_remove_one,
> +	remove:		__devexit_p(dfx_remove_one),
>  	id_table:	dfx_pci_tbl,
>  };
>  
> Index: 16.1/drivers/net/tokenring/lanstreamer.c
> --- 16.1/drivers/net/tokenring/lanstreamer.c Mon, 12 Nov 2001 11:34:37 +1100 kaos (linux-2.4/i/c/46_lanstreame 1.3.1.1.1.2.1.3 644)
> +++ 16.1(w)/drivers/net/tokenring/lanstreamer.c Thu, 06 Dec 2001 16:32:35 +1100 kaos (linux-2.4/i/c/46_lanstreame 1.3.1.1.1.2.1.3 644)
> @@ -1812,7 +1812,7 @@ static struct pci_driver streamer_pci_dr
>    name:       "lanstreamer",
>    id_table:   streamer_pci_tbl,
>    probe:      streamer_init_one,
> -  remove:     streamer_remove_one,
> +  remove:     __devexit_p(streamer_remove_one),
>  };
>  
>  static int __init streamer_init_module(void) {
> Index: 16.1/drivers/net/tokenring/olympic.c
> --- 16.1/drivers/net/tokenring/olympic.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/j/c/7_olympic.c 1.2.1.2.1.2.1.1.1.1.1.1 644)
> +++ 16.1(w)/drivers/net/tokenring/olympic.c Thu, 06 Dec 2001 16:32:48 +1100 kaos (linux-2.4/j/c/7_olympic.c 1.2.1.2.1.2.1.1.1.1.1.1 644)
> @@ -1705,7 +1705,7 @@ static struct pci_driver olympic_driver 
>  	name:		"olympic",
>  	id_table:	olympic_pci_tbl,
>  	probe:		olympic_probe,
> -	remove:		olympic_remove_one
> +	remove:		__devexit_p(olympic_remove_one),
>  };
>  
>  static int __init olympic_pci_init(void) 
> Index: 16.1/drivers/net/3c59x.c
> --- 16.1/drivers/net/3c59x.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/j/c/16_3c59x.c 1.3.1.8 644)
> +++ 16.1(w)/drivers/net/3c59x.c Thu, 06 Dec 2001 16:34:31 +1100 kaos (linux-2.4/j/c/16_3c59x.c 1.3.1.8 644)
> @@ -2919,7 +2919,7 @@ static void __devexit vortex_remove_one 
>  static struct pci_driver vortex_driver = {
>  	name:		"3c59x",
>  	probe:		vortex_init_one,
> -	remove:		vortex_remove_one,
> +	remove:		__devexit_p(vortex_remove_one),
>  	id_table:	vortex_pci_tbl,
>  #ifdef CONFIG_PM
>  	suspend:	vortex_suspend,
> Index: 16.1/drivers/net/tlan.c
> --- 16.1/drivers/net/tlan.c Tue, 02 Oct 2001 11:04:33 +1000 kaos (linux-2.4/l/c/11_tlan.c 1.1.1.2.1.3.1.1 644)
> +++ 16.1(w)/drivers/net/tlan.c Thu, 06 Dec 2001 16:39:11 +1100 kaos (linux-2.4/l/c/11_tlan.c 1.1.1.2.1.3.1.1 644)
> @@ -430,7 +430,7 @@ static struct pci_driver tlan_driver = {
>  	name:		"tlan",
>  	id_table:	tlan_pci_tbl,
>  	probe:		tlan_init_one,
> -	remove:		tlan_remove_one,	
> +	remove:		__devexit_p(tlan_remove_one),	
>  };
>  
>  static int __init tlan_probe(void)
> Index: 16.1/drivers/net/pci-skeleton.c
> --- 16.1/drivers/net/pci-skeleton.c Fri, 19 Oct 2001 12:25:53 +1000 kaos (linux-2.4/q/d/47_pci-skelet 1.1.1.7.1.4 644)
> +++ 16.1(w)/drivers/net/pci-skeleton.c Thu, 06 Dec 2001 16:37:20 +1100 kaos (linux-2.4/q/d/47_pci-skelet 1.1.1.7.1.4 644)
> @@ -1980,7 +1980,7 @@ static struct pci_driver netdrv_pci_driv
>  	name:		MODNAME,
>  	id_table:	netdrv_pci_tbl,
>  	probe:		netdrv_init_one,
> -	remove:		netdrv_remove_one,
> +	remove:		__devexit_p(netdrv_remove_one),
>  #ifdef CONFIG_PM
>  	suspend:	netdrv_suspend,
>  	resume:		netdrv_resume,
> Index: 16.1/drivers/media/radio/radio-maxiradio.c
> --- 16.1/drivers/media/radio/radio-maxiradio.c Tue, 02 Oct 2001 11:04:33 +1000 kaos (linux-2.4/x/d/25_radio-maxi 1.1.1.1.1.1 644)
> +++ 16.1(w)/drivers/media/radio/radio-maxiradio.c Thu, 06 Dec 2001 16:27:50 +1100 kaos (linux-2.4/x/d/25_radio-maxi 1.1.1.1.1.1 644)
> @@ -376,7 +376,7 @@ static struct pci_driver maxiradio_drive
>  	name:		"radio-maxiradio",
>  	id_table:	maxiradio_pci_tbl,
>  	probe:		maxiradio_init_one,
> -	remove:		maxiradio_remove_one,
> +	remove:		__devexit_p(maxiradio_remove_one),
>  };
>  
>  int __init maxiradio_radio_init(void)
> Index: 16.1/drivers/net/sungem.c
> --- 16.1/drivers/net/sungem.c Tue, 23 Oct 2001 14:35:33 +1000 kaos (linux-2.4/E/d/26_sungem.c 1.6.1.6 644)
> +++ 16.1(w)/drivers/net/sungem.c Thu, 06 Dec 2001 16:38:58 +1100 kaos (linux-2.4/E/d/26_sungem.c 1.6.1.6 644)
> @@ -2140,7 +2140,7 @@ static struct pci_driver gem_driver = {
>  	name:		GEM_MODULE_NAME,
>  	id_table:	gem_pci_tbl,
>  	probe:		gem_init_one,
> -	remove:		gem_remove_one,
> +	remove:		__devexit_p(gem_remove_one),
>  };
>  
>  static int __init gem_init(void)
> Index: 16.1/drivers/char/joystick/cs461x.c
> --- 16.1/drivers/char/joystick/cs461x.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/K/d/4_cs461x.c 1.1.1.2 644)
> +++ 16.1(w)/drivers/char/joystick/cs461x.c Thu, 06 Dec 2001 16:19:42 +1100 kaos (linux-2.4/K/d/4_cs461x.c 1.1.1.2 644)
> @@ -313,7 +313,7 @@ static struct pci_driver cs461x_pci_driv
>          name:           "PCI Gameport",
>          id_table:       cs461x_pci_tbl,
>          probe:          cs461x_pci_probe,
> -        remove:         cs461x_pci_remove,
> +        remove:         __devexit_p(cs461x_pci_remove),
>  };
>  
>  int __init js_cs461x_init(void)
> Index: 16.1/drivers/net/fealnx.c
> --- 16.1/drivers/net/fealnx.c Tue, 20 Nov 2001 15:39:10 +1100 kaos (linux-2.4/i/e/0_fealnx.c 1.2.1.7 644)
> +++ 16.1(w)/drivers/net/fealnx.c Thu, 06 Dec 2001 16:36:32 +1100 kaos (linux-2.4/i/e/0_fealnx.c 1.2.1.7 644)
> @@ -1858,7 +1858,7 @@ static struct pci_driver fealnx_driver =
>  	name:		"fealnx",
>  	id_table:	fealnx_pci_tbl,
>  	probe:		fealnx_init_one,
> -	remove:		fealnx_remove_one,
> +	remove:		__devexit_p(fealnx_remove_one),
>  };
>  
>  static int __init fealnx_init(void)
> Index: 16.1/drivers/net/wireless/airo.c
> --- 16.1/drivers/net/wireless/airo.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/w/e/24_airo.c 1.2.1.8 644)
> +++ 16.1(w)/drivers/net/wireless/airo.c Thu, 06 Dec 2001 16:34:04 +1100 kaos (linux-2.4/w/e/24_airo.c 1.2.1.8 644)
> @@ -64,7 +64,7 @@ static struct pci_driver airo_driver = {
>  	name:     "airo",
>  	id_table: card_ids,
>  	probe:    airo_pci_probe,
> -	remove:   airo_pci_remove,
> +	remove:   __devexit_p(airo_pci_remove),
>  };
>  #endif /* CONFIG_PCI */
>  
> Index: 16.1/drivers/isdn/tpam/tpam_main.c
> --- 16.1/drivers/isdn/tpam/tpam_main.c Tue, 02 Oct 2001 11:04:33 +1000 kaos (linux-2.4/D/e/29_tpam_main. 1.1.1.1.1.1 644)
> +++ 16.1(w)/drivers/isdn/tpam/tpam_main.c Thu, 06 Dec 2001 16:27:11 +1100 kaos (linux-2.4/D/e/29_tpam_main. 1.1.1.1.1.1 644)
> @@ -254,7 +254,7 @@ static struct pci_driver tpam_driver = {
>  	name:		"tpam",
>  	id_table:	tpam_pci_tbl,
>  	probe:		tpam_probe,
> -	remove:		tpam_remove,
> +	remove:		__devexit_p(tpam_remove),
>  };
>  
>  static int __init tpam_init(void) {
> Index: 16.1/drivers/media/video/meye.c
> --- 16.1/drivers/media/video/meye.c Fri, 26 Oct 2001 15:50:03 +1000 kaos (linux-2.4/G/e/0_meye.c 1.2.1.1.1.1 644)
> +++ 16.1(w)/drivers/media/video/meye.c Thu, 06 Dec 2001 16:30:30 +1100 kaos (linux-2.4/G/e/0_meye.c 1.2.1.1.1.1 644)
> @@ -1460,7 +1460,7 @@ static struct pci_driver meye_driver = {
>  	name:		"meye",
>  	id_table:	meye_pci_tbl,
>  	probe:		meye_probe,
> -	remove:		meye_remove,
> +	remove:		__devexit_p(meye_remove),
>  };
>  
>  static int __init meye_init_module(void) {
> Index: 16.1/drivers/net/dl2k.c
> --- 16.1/drivers/net/dl2k.c Tue, 20 Nov 2001 15:39:10 +1100 kaos (linux-2.4/G/e/43_dl2k.c 1.6 644)
> +++ 16.1(w)/drivers/net/dl2k.c Thu, 06 Dec 2001 16:35:35 +1100 kaos (linux-2.4/G/e/43_dl2k.c 1.6 644)
> @@ -1671,7 +1671,7 @@ static struct pci_driver rio_driver = {
>  	name:"dl2k",
>  	id_table:rio_pci_tbl,
>  	probe:rio_probe1,
> -	remove:rio_remove1,
> +	remove:__devexit_p(rio_remove1),
>  };
>  
>  static int __init
> Index: 16.1/drivers/parport/parport_serial.c
> --- 16.1/drivers/parport/parport_serial.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/G/e/47_parport_se 1.5 644)
> +++ 16.1(w)/drivers/parport/parport_serial.c Thu, 06 Dec 2001 16:39:45 +1100 kaos (linux-2.4/G/e/47_parport_se 1.5 644)
> @@ -331,7 +331,7 @@ static struct pci_driver parport_serial_
>  	name:		"parport_serial",
>  	id_table:	parport_serial_pci_tbl,
>  	probe:		parport_serial_pci_probe,
> -	remove:		parport_serial_pci_remove,
> +	remove:		__devexit_p(parport_serial_pci_remove),
>  };
>  
>  
> Index: 16.1/drivers/media/radio/radio-gemtek-pci.c
> --- 16.1/drivers/media/radio/radio-gemtek-pci.c Tue, 02 Oct 2001 11:04:33 +1000 kaos (linux-2.4/L/e/51_radio-gemt 1.1.1.1 644)
> +++ 16.1(w)/drivers/media/radio/radio-gemtek-pci.c Thu, 06 Dec 2001 16:27:38 +1100 kaos (linux-2.4/L/e/51_radio-gemt 1.1.1.1 644)
> @@ -424,7 +424,7 @@ static struct pci_driver gemtek_pci_driv
>      name:	"gemtek_pci",
>  id_table:	gemtek_pci_id,
>     probe:	gemtek_pci_probe,
> -  remove:	gemtek_pci_remove
> +  remove:	__devexit_p(gemtek_pci_remove),
>  };
>  
>  static int __init gemtek_pci_init_module( void )
> Index: 16.1/drivers/sound/btaudio.c
> --- 16.1/drivers/sound/btaudio.c Fri, 19 Oct 2001 12:25:53 +1000 kaos (linux-2.4/Q/e/39_btaudio.c 1.4.1.1 644)
> +++ 16.1(w)/drivers/sound/btaudio.c Thu, 06 Dec 2001 16:40:28 +1100 kaos (linux-2.4/Q/e/39_btaudio.c 1.4.1.1 644)
> @@ -1030,7 +1030,7 @@ static struct pci_driver btaudio_pci_dri
>          name:     "btaudio",
>          id_table: btaudio_pci_tbl,
>          probe:    btaudio_probe,
> -        remove:   btaudio_remove,
> +        remove:   __devexit_p(btaudio_remove),
>  };
>  
>  int btaudio_init_module(void)
> Index: 16.1/drivers/net/wan/farsync.c
> --- 16.1/drivers/net/wan/farsync.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/Q/e/42_farsync.c 1.1.1.2.1.1 644)
> +++ 16.1(w)/drivers/net/wan/farsync.c Thu, 06 Dec 2001 16:33:16 +1100 kaos (linux-2.4/Q/e/42_farsync.c 1.1.1.2.1.1 644)
> @@ -1810,7 +1810,7 @@ static struct pci_driver fst_driver = {
>          name:           FST_NAME,
>          id_table:       fst_pci_dev_id,
>          probe:          fst_add_one,
> -        remove:         fst_remove_one,
> +        remove:         __devexit_p(fst_remove_one),
>          suspend:        NULL,
>          resume:         NULL,
>  };
> Index: 16.1/drivers/net/irda/vlsi_ir.c
> --- 16.1/drivers/net/irda/vlsi_ir.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/Q/e/43_vlsi_ir.c 1.6 644)
> +++ 16.1(w)/drivers/net/irda/vlsi_ir.c Thu, 06 Dec 2001 16:31:41 +1100 kaos (linux-2.4/Q/e/43_vlsi_ir.c 1.6 644)
> @@ -1291,7 +1291,7 @@ static struct pci_driver vlsi_irda_drive
>  	name:           drivername,
>  	id_table:       vlsi_irda_table,
>  	probe:          vlsi_irda_probe,
> -	remove:         vlsi_irda_remove,
> +	remove:         __devexit_p(vlsi_irda_remove),
>  	suspend:        vlsi_irda_suspend,
>  	resume:         vlsi_irda_resume,
>  };
> Index: 16.1/drivers/video/radeonfb.c
> --- 16.1/drivers/video/radeonfb.c Fri, 16 Nov 2001 14:10:23 +1100 kaos (linux-2.4/i/f/9_radeonfb.c 1.6 644)
> +++ 16.1(w)/drivers/video/radeonfb.c Thu, 06 Dec 2001 16:44:08 +1100 kaos (linux-2.4/i/f/9_radeonfb.c 1.6 644)
> @@ -619,7 +619,7 @@ static struct pci_driver radeonfb_driver
>  	name:		"radeonfb",
>  	id_table:	radeonfb_pci_table,
>  	probe:		radeonfb_pci_register,
> -	remove:		radeonfb_pci_unregister,
> +	remove:		__devexit_p(radeonfb_pci_unregister),
>  };
>  
>  
> Index: 16.1/drivers/isdn/hisax/st5481_init.c
> --- 16.1/drivers/isdn/hisax/st5481_init.c Tue, 02 Oct 2001 11:04:33 +1000 kaos (linux-2.4/l/f/11_st5481_ini 1.2 644)
> +++ 16.1(w)/drivers/isdn/hisax/st5481_init.c Thu, 06 Dec 2001 16:25:59 +1100 kaos (linux-2.4/l/f/11_st5481_ini 1.2 644)
> @@ -178,7 +178,7 @@ MODULE_DEVICE_TABLE (usb, st5481_ids);
>  static struct usb_driver st5481_usb_driver = {
>  	name: "st5481_usb",
>  	probe: probe_st5481,
> -	disconnect: disconnect_st5481,
> +	disconnect: __devexit_p(disconnect_st5481),
>  	id_table: st5481_ids,
>  };
>  
> Index: 16.1/drivers/net/ns83820.c
> --- 16.1/drivers/net/ns83820.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/l/f/32_ns83820.c 1.6 644)
> +++ 16.1(w)/drivers/net/ns83820.c Thu, 06 Dec 2001 16:37:57 +1100 kaos (linux-2.4/l/f/32_ns83820.c 1.6 644)
> @@ -1455,7 +1455,7 @@ static struct pci_driver driver = {
>  	name:		"ns83820",
>  	id_table:	ns83820_pci_tbl,
>  	probe:		ns83820_init_one,
> -	remove:		ns83820_remove_one,
> +	remove:		__devexit_p(ns83820_remove_one),
>  #if 0	/* FIXME: implement */
>  	suspend:	,
>  	resume:		,
> Index: 16.1/drivers/char/joystick/emu10k1-gp.c
> --- 16.1/drivers/char/joystick/emu10k1-gp.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/m/f/32_emu10k1-gp 1.2 644)
> +++ 16.1(w)/drivers/char/joystick/emu10k1-gp.c Thu, 06 Dec 2001 16:20:28 +1100 kaos (linux-2.4/m/f/32_emu10k1-gp 1.2 644)
> @@ -108,7 +108,7 @@ static struct pci_driver emu_driver = {
>          name:           "Emu10k1 Gameport",
>          id_table:       emu_tbl,
>          probe:          emu_probe,
> -        remove:         emu_remove,
> +        remove:         __devexit_p(emu_remove),
>  };
>  
>  int __init emu_init(void)
> Index: 16.1/drivers/net/pcmcia/xircom_cb.c
> --- 16.1/drivers/net/pcmcia/xircom_cb.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/o/f/25_xircom_cb. 1.3 644)
> +++ 16.1(w)/drivers/net/pcmcia/xircom_cb.c Thu, 06 Dec 2001 16:32:21 +1100 kaos (linux-2.4/o/f/25_xircom_cb. 1.3 644)
> @@ -170,7 +170,7 @@ static struct pci_driver xircom_ops = {
>  	name:		"xircom_cb", 
>  	id_table:	xircom_pci_table, 
>  	probe:		xircom_probe, 
> -	remove:		xircom_remove, 
> +	remove:		__devexit_p(xircom_remove), 
>  };
>  
>  
> Index: 16.1/drivers/net/wireless/orinoco_plx.c
> --- 16.1/drivers/net/wireless/orinoco_plx.c Wed, 10 Oct 2001 11:34:17 +1000 kaos (linux-2.4/r/f/46_orinoco_pl 1.1 644)
> +++ 16.1(w)/drivers/net/wireless/orinoco_plx.c Thu, 06 Dec 2001 16:33:46 +1100 kaos (linux-2.4/r/f/46_orinoco_pl 1.1 644)
> @@ -279,7 +279,7 @@ static struct pci_driver orinoco_plx_dri
>  	name:"orinoco_plx",
>  	id_table:orinoco_plx_pci_id_table,
>  	probe:orinoco_plx_init_one,
> -	remove:orinoco_plx_remove_one,
> +	remove:__devexit_p(orinoco_plx_remove_one),
>  	suspend:0,
>  	resume:0
>  };
> Index: 16.1/drivers/net/8139cp.c
> --- 16.1/drivers/net/8139cp.c Tue, 20 Nov 2001 15:39:10 +1100 kaos (linux-2.4/D/f/10_8139cp.c 1.3 644)
> +++ 16.1(w)/drivers/net/8139cp.c Thu, 06 Dec 2001 16:34:44 +1100 kaos (linux-2.4/D/f/10_8139cp.c 1.3 644)
> @@ -1313,7 +1313,7 @@ static struct pci_driver cp_driver = {
>  	name:		DRV_NAME,
>  	id_table:	cp_pci_tbl,
>  	probe:		cp_init_one,
> -	remove:		cp_remove_one,
> +	remove:		__devexit_p(cp_remove_one),
>  };
>  
>  static int __init cp_init (void)
> 

