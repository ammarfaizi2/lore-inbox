Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267352AbUBSV7Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 16:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267398AbUBSV7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 16:59:24 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:48392 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267352AbUBSV6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 16:58:14 -0500
Date: Thu, 19 Feb 2004 21:58:08 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] pm3fb: remove kernel 2.2 code
In-Reply-To: <20040208010609.GG7388@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0402192157570.26894-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ug. That driver needs to to replaced.


On Sun, 8 Feb 2004, Adrian Bunk wrote:

> The patch below removes kernel 2.2 code from pm3fb.{c,h}.
> 
> It also removes KERNEL_2_4 and KERNEL_2_5 since all places where this 
> was used had a
>   #if (defined KERNEL_2_4) || (defined KERNEL_2_5)
> 
> diffstat output:
>  drivers/video/pm3fb.c |  287 +++++++-----------------------------------
>  include/video/pm3fb.h |   40 -----
>  2 files changed, 54 insertions(+), 273 deletions(-)
> 
> Please apply
> Adrian
> 
> 
> --- linux-2.6.2-mm1/include/video/pm3fb.h.old	2004-02-07 21:50:06.000000000 +0100
> +++ linux-2.6.2-mm1/include/video/pm3fb.h	2004-02-07 22:01:37.000000000 +0100
> @@ -1119,34 +1119,6 @@
>  /* ***** pm3fb useful define and macro ***** */
>  /* ***************************************** */
>  
> -/* kernel -specific definitions */
> -/* what kernel is this ? */
> -#if ((LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)) && (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)))
> -#define KERNEL_2_5
> -#endif
> -
> -#if ((LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)) && (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)))
> -#define KERNEL_2_4
> -#endif
> -
> -#if ((LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)) && (LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0))) 
> -#define KERNEL_2_2
> -/* pci_resource_start, available in 2.2.18 */
> -#include <linux/kcomp.h>
> -#ifdef CONFIG_FB_OF
> -#define SUPPORT_FB_OF
> -#endif
> -#endif
> -
> -#if (!defined(KERNEL_2_2)) && (!defined(KERNEL_2_4)) && (!defined(KERNEL_2_5))
> -#error "Only kernel 2.2.x, kernel 2.4.y and kernel 2.5.z might work"
> -#endif
> -
> -/* not sure if/why it's needed. doesn't work without on my PowerMac... */
> -#ifdef __BIG_ENDIAN
> -#define MUST_BYTESWAP
> -#endif
> -
>  /* permedia3 -specific definitions */
>  #define PM3_SCALE_TO_CLOCK(pr, fe, po) ((2 * PM3_REF_CLOCK * fe) / (pr * (1 << (po))))
>  
> @@ -1203,19 +1175,9 @@
>  /* ******************************************** */
>  /* ***** A bunch of register-access macro ***** */
>  /* ******************************************** */
> -#ifdef KERNEL_2_2
> -#ifdef MUST_BYTESWAP /* we are writing big_endian to big_endian through a little_endian macro */
> -#define PM3_READ_REG(r) __swab32(readl((l_fb_info->vIOBase + r)))
> -#define PM3_WRITE_REG(r, v) writel(__swab32(v), (l_fb_info->vIOBase + r))
> -#else /* MUST_BYTESWAP */
> -#define PM3_WRITE_REG(r, v) writel(v, (l_fb_info->vIOBase + r))
> -#define PM3_READ_REG(r) readl((l_fb_info->vIOBase + r))
> -#endif /* MUST_BYTESWAP */
> -#endif /* KERNEL_2_2 */
> -#if (defined KERNEL_2_4) || (defined KERNEL_2_5) /* native-endian access */
> +
>  #define PM3_WRITE_REG(r, v) fb_writel(v, (l_fb_info->vIOBase + r))
>  #define PM3_READ_REG(r) fb_readl((l_fb_info->vIOBase + r))
> -#endif /* KERNEL_2_4 or KERNEL_2_5 */
>  
>  
>  #define depth2bpp(d) ((d + 7L) & ~7L)
> --- linux-2.6.2-mm1/drivers/video/pm3fb.c.old	2004-02-07 21:53:04.000000000 +0100
> +++ linux-2.6.2-mm1/drivers/video/pm3fb.c	2004-02-07 22:03:22.000000000 +0100
> @@ -137,9 +137,6 @@
>  	unsigned long use_current;
>  	struct pm3fb_par *current_par;
>  	struct pci_dev *dev;    /* PCI device */
> -#ifdef SUPPORT_FB_OF
> -	struct device_node *dn; /* OF node for the PCI device */
> -#endif /* SUPPORT_FB_OF */
>  	unsigned long board_type; /* index in the cardbase */
>  	unsigned char *fb_base;	/* framebuffer memory base */
>  	u32 fb_size;		/* framebuffer memory size */
> @@ -665,20 +662,6 @@
>  
>  
>  /* the struct that hold them together */
> -#ifdef KERNEL_2_2
> -struct fbgen_hwswitch pm3fb_switch = {
> -	pm3fb_detect, pm3fb_encode_fix, pm3fb_decode_var, pm3fb_encode_var,
> -	pm3fb_get_par, pm3fb_set_par, pm3fb_getcolreg, pm3fb_setcolreg,
> -	pm3fb_pan_display, pm3fb_blank, pm3fb_set_disp
> -};
> -
> -static struct fb_ops pm3fb_ops = {
> -	fbgen_get_fix, fbgen_get_var, fbgen_set_var,
> -	fbgen_get_cmap, fbgen_set_cmap, fbgen_pan_display, pm3fb_ioctl,
> -	    NULL, NULL
> -};
> -#endif /* KERNEL_2_2 */
> -#if (defined KERNEL_2_4) || (defined KERNEL_2_5)
>  struct fbgen_hwswitch pm3fb_switch = {
>  	pm3fb_detect, pm3fb_encode_fix, pm3fb_decode_var, pm3fb_encode_var,
>  	pm3fb_get_par, pm3fb_set_par, pm3fb_getcolreg, 
> @@ -697,7 +680,7 @@
>  	.fb_blank =	fbgen_blank,
>  	.fb_ioctl =	pm3fb_ioctl,
>  };
> -#endif /* KERNEL_2_4 or KERNEL_2_5 */
> +
>  #ifdef PM3FB_USE_ACCEL
>  #ifdef FBCON_HAS_CFB32
>  static struct display_switch pm3fb_cfb32 = {
> @@ -1451,26 +1434,11 @@
>  
>  	/* pm3 split up memory, replicates, and do a lot of nasty stuff IMHO ;-) */
>  	for (i = 0; i < 32; i++) {
> -#ifdef KERNEL_2_2
> -#ifdef MUST_BYTESWAP
> -		writel(__swab32(i * 0x00345678),
> -		       (l_fb_info->v_fb + (i * 1048576)));
> -#else
> -		writel(i * 0x00345678, (l_fb_info->v_fb + (i * 1048576)));
> -#endif
> -		mb();
> -#ifdef MUST_BYTESWAP
> -		temp1 = __swab32(readl((l_fb_info->v_fb + (i * 1048576))));
> -#else
> -		temp1 = readl((l_fb_info->v_fb + (i * 1048576)));
> -#endif
> -#endif	/* KERNEL_2_2 */
> -#if (defined KERNEL_2_4) || (defined KERNEL_2_5)
>  		fb_writel(i * 0x00345678,
>  			  (l_fb_info->v_fb + (i * 1048576)));
>  		mb();
>  		temp1 = fb_readl((l_fb_info->v_fb + (i * 1048576)));
> -#endif /* KERNEL_2_4 or KERNEL_2_5 */
> +
>  		/* Let's check for wrapover, write will fail at 16MB boundary */
>  		if (temp1 == (i * 0x00345678))
>  			memsize = i;
> @@ -1489,31 +1457,6 @@
>  		}
>  
>  		for (i = 32; i < 64; i++) {
> -#ifdef KERNEL_2_2
> -#ifdef MUST_BYTESWAP
> -			writel(__swab32(i * 0x00345678),
> -			       (l_fb_info->v_fb + (i * 1048576)));
> -#else
> -			writel(i * 0x00345678,
> -			       (l_fb_info->v_fb + (i * 1048576)));
> -#endif
> -			mb();
> -#ifdef MUST_BYTESWAP
> -			temp1 =
> -			    __swab32(readl
> -				     ((l_fb_info->v_fb + (i * 1048576))));
> -			temp2 =
> -			    __swab32(readl
> -				     ((l_fb_info->v_fb +
> -				       ((i - 32) * 1048576))));
> -#else
> -			temp1 = readl((l_fb_info->v_fb + (i * 1048576)));
> -			temp2 =
> -			    readl((l_fb_info->v_fb +
> -				   ((i - 32) * 1048576)));
> -#endif
> -#endif /* KERNEL_2_2 */
> -#if (defined KERNEL_2_4) || (defined KERNEL_2_5)
>  			fb_writel(i * 0x00345678,
>  				  (l_fb_info->v_fb + (i * 1048576)));
>  			mb();
> @@ -1522,7 +1465,6 @@
>  			temp2 =
>  			    fb_readl((l_fb_info->v_fb +
>  				      ((i - 32) * 1048576)));
> -#endif /* KERNEL_2_4 or KERNEL_2_5 */
>  			if ((temp1 == (i * 0x00345678)) && (temp2 == 0))	/* different value, different RAM... */
>  				memsize = i;
>  			else
> @@ -1565,16 +1507,7 @@
>  
>  	for (i = 0; i < (l_fb_info->fb_size / sizeof(u32)) ; i++) /* clear entire FB memory to black */
>  	{
> -#ifdef KERNEL_2_2
> -#ifdef MUST_BYTESWAP
> -		writel(__swab32(cc), (l_fb_info->v_fb + (i * sizeof(u32))));
> -#else
> -		writel(cc, (l_fb_info->v_fb + (i * sizeof(u32))));
> -#endif
> -#endif
> -#if (defined KERNEL_2_4) || (defined KERNEL_2_5)
>  		fb_writel(cc, (l_fb_info->v_fb + (i * sizeof(u32))));
> -#endif
>  	}
>  }
>  
> @@ -3424,89 +3357,63 @@
>  	for (i = 0; i < PM3_MAX_BOARD; i++) {
>  		l_fb_info = &(fb_info[i]);
>  		if ((l_fb_info->dev) && (!disable[i])) {	/* PCI device was found and not disabled by user */
> -#ifdef SUPPORT_FB_OF
> -			struct device_node *dp =
> -			    find_pci_device_OFnode(l_fb_info->dev->bus->
> -						   number,
> -						   l_fb_info->dev->devfn);
> -
> -			if ((dp) && (!strncmp(dp->name, "formacGA12", 10))) {
> -				/* do nothing, init of board is done in pm3fb_of_init */
> -			} else {
> -#endif
> -				DPRINTK(2,
> -					"found @%lx Vendor %lx Device %lx ; base @ : %lx - %lx - %lx - %lx - %lx - %lx, irq %ld\n",
> -					(unsigned long) l_fb_info->dev,
> -					(unsigned long) l_fb_info->dev->
> -					vendor,
> -					(unsigned long) l_fb_info->dev->
> -					device,
> -					(unsigned long)
> -					pci_resource_start(l_fb_info->dev,
> -							   0),
> -					(unsigned long)
> -					pci_resource_start(l_fb_info->dev,
> -							   1),
> -					(unsigned long)
> -					pci_resource_start(l_fb_info->dev,
> -							   2),
> -					(unsigned long)
> -					pci_resource_start(l_fb_info->dev,
> -							   3),
> -					(unsigned long)
> -					pci_resource_start(l_fb_info->dev,
> -							   4),
> -					(unsigned long)
> -					pci_resource_start(l_fb_info->dev,
> -							   5),
> -					(unsigned long) l_fb_info->dev->
> -					irq);
> -
> -				l_fb_info->pIOBase =
> -				    (unsigned char *)
> -				    pci_resource_start(l_fb_info->dev, 0);
> +			DPRINTK(2,
> +				"found @%lx Vendor %lx Device %lx ; base @ : %lx - %lx - %lx - %lx - %lx - %lx, irq %ld\n",
> +				(unsigned long) l_fb_info->dev,
> +				(unsigned long) l_fb_info->dev->vendor,
> +				(unsigned long) l_fb_info->dev->device,
> +				(unsigned long)
> +				pci_resource_start(l_fb_info->dev, 0),
> +				(unsigned long)
> +				pci_resource_start(l_fb_info->dev, 1),
> +				(unsigned long)
> +				pci_resource_start(l_fb_info->dev, 2),
> +				(unsigned long)
> +				pci_resource_start(l_fb_info->dev, 3),
> +				(unsigned long)
> +				pci_resource_start(l_fb_info->dev, 4),
> +				(unsigned long)
> +				pci_resource_start(l_fb_info->dev, 5),
> +				(unsigned long) l_fb_info->dev->irq);
> +
> +			l_fb_info->pIOBase =
> +			    (unsigned char *)
> +			    pci_resource_start(l_fb_info->dev, 0);
>  #ifdef __BIG_ENDIAN
> -				l_fb_info->pIOBase += PM3_REGS_SIZE;
> +			l_fb_info->pIOBase += PM3_REGS_SIZE;
>  #endif
> -				l_fb_info->vIOBase = (unsigned char *) -1;
> -				l_fb_info->p_fb =
> -				    (unsigned char *)
> -				    pci_resource_start(l_fb_info->dev, 1);
> -				l_fb_info->v_fb = (unsigned char *) -1;
> +			l_fb_info->vIOBase = (unsigned char *) -1;
> +			l_fb_info->p_fb =
> +			    (unsigned char *)
> +			    pci_resource_start(l_fb_info->dev, 1);
> +			l_fb_info->v_fb = (unsigned char *) -1;
>  
> -#if (defined KERNEL_2_4) || (defined KERNEL_2_5) 	/* full resource management, new in linux-2.4.x */
> -				if (!request_mem_region
> -				    ((unsigned long)l_fb_info->p_fb, 64 * 1024 * 1024, /* request full aperture size */
> -				     "pm3fb")) {
> -					printk
> -					    (KERN_ERR "pm3fb: Error: couldn't request framebuffer memory, board #%ld\n",
> -					     l_fb_info->board_num);
> -					continue;
> -				}
>  				if (!request_mem_region
> -				    ((unsigned long)l_fb_info->pIOBase, PM3_REGS_SIZE,
> -				     "pm3fb I/O regs")) {
> -					printk
> -					    (KERN_ERR "pm3fb: Error: couldn't request IObase memory, board #%ld\n",
> -					     l_fb_info->board_num);
> -					continue;
> -				}
> -#endif /* KERNEL_2_4 or KERNEL_2_5 */
> -				if (forcesize[l_fb_info->board_num])
> -					l_fb_info->fb_size = forcesize[l_fb_info->board_num];
> -				
> -				l_fb_info->fb_size =
> -				    pm3fb_size_memory(l_fb_info);
> +			    ((unsigned long)l_fb_info->p_fb, 64 * 1024 * 1024, /* request full aperture size */
> +			     "pm3fb")) {
> +				printk
> +				    (KERN_ERR "pm3fb: Error: couldn't request framebuffer memory, board #%ld\n",
> +				     l_fb_info->board_num);
> +				continue;
> +			}
> +			if (!request_mem_region
> +			    ((unsigned long)l_fb_info->pIOBase, PM3_REGS_SIZE,
> +			     "pm3fb I/O regs")) {
> +				printk
> +				    (KERN_ERR "pm3fb: Error: couldn't request IObase memory, board #%ld\n",
> +				     l_fb_info->board_num);
> +				continue;
> +			}
> +			if (forcesize[l_fb_info->board_num])
> +				l_fb_info->fb_size = forcesize[l_fb_info->board_num];
>  
> +			l_fb_info->fb_size =
> +			    pm3fb_size_memory(l_fb_info);
>  				if (l_fb_info->fb_size) {
> -					(void) pci_enable_device(l_fb_info->dev);
> -					pm3fb_common_init(l_fb_info);
> -				} else
> -					printk(KERN_ERR "pm3fb: memory problem, not enabling board #%ld\n", l_fb_info->board_num);
> -				
> -#ifdef SUPPORT_FB_OF
> -			}
> -#endif /* SUPPORT_FB_OF */
> +				(void) pci_enable_device(l_fb_info->dev);
> +				pm3fb_common_init(l_fb_info);
> +			} else
> +				printk(KERN_ERR "pm3fb: memory problem, not enabling board #%ld\n", l_fb_info->board_num);				
>  		}
>  	}
>  }
> @@ -3590,12 +3497,7 @@
>  /* ***** standard FB API init functions ***** */
>  /* ****************************************** */
>  
> -#if (defined KERNEL_2_4) || (defined KERNEL_2_5)
>  int __init pm3fb_setup(char *options)
> -#endif
> -#ifdef KERNEL_2_2
> -__initfunc(void pm3fb_setup(char *options, int *ints))
> -#endif
>  {
>  	long opsi = strlen(options);
>  
> @@ -3606,17 +3508,10 @@
>  		PM3_OPTIONS_SIZE) ? PM3_OPTIONS_SIZE : (opsi + 1));
>  	g_options[PM3_OPTIONS_SIZE - 1] = 0;
>  
> -#if (defined KERNEL_2_4) || (defined KERNEL_2_5)
>  	return (0);
> -#endif
>  }
>  
> -#if (defined KERNEL_2_4) || (defined KERNEL_2_5)
>  int __init pm3fb_init(void)
> -#endif
> -#ifdef KERNEL_2_2
> -__initfunc(void pm3fb_init(void))
> -#endif
>  {
>  	DTRACE;
>  
> @@ -3629,82 +3524,8 @@
>  	if (!fb_info[0].dev) {	/* not even one board ??? */
>  		DPRINTK(1, "No PCI Permedia3 board detected\n");
>  	}
> -#if (defined KERNEL_2_4) || (defined KERNEL_2_5)
>  	return (0);
> -#endif
> -}
> -
> -#ifdef SUPPORT_FB_OF		/* linux-2.2.x only */
> -__initfunc(void pm3fb_of_init(struct device_node *dp))
> -{
> -	struct pm3fb_info *l_fb_info = NULL;
> -	unsigned long i;
> -	long bn = -1;
> -	struct device_node *dn;
> -
> -	DTRACE;
> -
> -	DPRINTK(2, "OpenFirmware board : %s\n", dp->full_name);
> -
> -	for (i = 0; i < dp->n_addrs; i++) {
> -		DPRINTK(2, "MemRange : 0x%08x - 0x%x\n",
> -			dp->addrs[i].address, dp->addrs[i].size);
> -	}
> -
> -	for (i = 0; i < PM3_MAX_BOARD; i++) {	/* find which PCI board is the OF device */
> -		if (fb_info[i].dev) {
> -			dn = find_pci_device_OFnode(fb_info[i].dev->bus->
> -						    number,
> -						    fb_info[i].dev->devfn);
> -			if (dn == dp) {
> -				if (bn == -1)
> -					bn = i;
> -				else {
> -					DPRINTK(1,
> -						"Error: Multiple PCI device for a single OpenFirmware node\n");
> -				}
> -			}
> -		}
> -	}
> -
> -	if (bn == -1) {
> -		DPRINTK(1, "Warning: non-PCI Permedia3 found\n");
> -		i = 0;
> -		while (fb_info[i].dev && (i < PM3_MAX_BOARD))
> -			i++;
> -		if (i < PM3_MAX_BOARD)
> -			bn = i;
> -		else {
> -			printk
> -			    (KERN_ERR "pm3fb: Error: Couldn't find room for OpenFirmware device");
> -			return;
> -		}
> -	}
> -
> -	l_fb_info = &(fb_info[bn]);
> -
> -	l_fb_info->dn = dp;
> -
> -	l_fb_info->pIOBase = (unsigned char *) dp->addrs[3].address;
> -#ifdef __BIG_ENDIAN
> -	l_fb_info->pIOBase += PM3_REGS_SIZE;
> -#endif
> -	l_fb_info->vIOBase = (unsigned char *) -1;
> -	l_fb_info->p_fb = (unsigned char *) dp->addrs[1].address;
> -	l_fb_info->v_fb = (unsigned char *) -1;
> -
> -	l_fb_info->fb_size = pm3fb_size_memory(l_fb_info);	/* (unsigned long)dp->addrs[1].size; *//* OF is a liar ! it claims 256 Mb */
> -
> -	DPRINTK(2,
> -		"OpenFirmware board (#%ld) : IOBase 0x%08lx, p_fb 0x%08lx, fb_size %d KB\n",
> -		bn, (unsigned long) l_fb_info->pIOBase,
> -		(unsigned long) l_fb_info->p_fb, l_fb_info->fb_size >> 10);
> -
> -	l_fb_info->use_current = 1;	/* will use current mode by default */
> -
> -	pm3fb_common_init(l_fb_info);
>  }
> -#endif /* SUPPORT_FB_OF */
>  
>  /* ************************* */
>  /* **** Module support ***** */
> @@ -3808,14 +3629,12 @@
>  				if (l_fb_info->vIOBase !=
>  				    (unsigned char *) -1) {
>  					pm3fb_unmapIO(l_fb_info);
> -#if (defined KERNEL_2_4) || (defined KERNEL_2_5)
>  					release_mem_region(l_fb_info->p_fb,
>  							   l_fb_info->
>  							   fb_size);
>  					release_mem_region(l_fb_info->
>  							   pIOBase,
>  							   PM3_REGS_SIZE);
> -#endif /* KERNEL_2_4 or KERNEL_2_5 */
>  				}
>  				unregister_framebuffer(&l_fb_info->gen.
>  						       info);
> 

