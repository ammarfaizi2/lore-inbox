Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTFSXYG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 19:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbTFSXYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 19:24:06 -0400
Received: from static213-229-38-018.adsl.inode.at ([213.229.38.18]:10977 "HELO
	home.winischhofer.net") by vger.kernel.org with SMTP
	id S261872AbTFSXXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 19:23:43 -0400
Message-ID: <3EF248F9.7040402@winischhofer.net>
Date: Fri, 20 Jun 2003 01:36:25 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en, de-at, de-de, sv
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SiS IRQ router 96x detection (2.5.69) ...
References: <Pine.LNX.4.55.0306022338530.3631@bigblue.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.55.0306022338530.3631@bigblue.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since the attached patch does not show up in any of the main line 
kernels yet, may I assume it has been overlooked?

Davide, if that one does not apply cleanly to the current 2.5.72, please 
update the patch and repost it. IRQ routing is actually a quite 
important issue and this should really be fixed. I think you need to 
advertise this patch a little more :)

Please also repost the 2.4 version.

Thomas


Davide Libenzi wrote:
> Thanks to Thomas we now know how to detect the 96x SiS SB. The patch
> against 2.5.69 uses the documentated method to use the correct router
> function and hence make new SiS chipsets to work with the new USB routing
> registers. Tested and working fine on my machine. Also, a new pci= option
> has been added to be able to set a pass thru behavior for IRQ requests.
> 
> 
> 
> 
> - Davide
> 
> 
> 
> 
> --- linux-2.5.69.vanilla/arch/i386/pci/common.c	2003-05-26 13:51:38.000000000 -0700
> +++ linux-2.5.69-custom/arch/i386/pci/common.c	2003-06-02 23:13:37.000000000 -0700
> @@ -205,6 +205,9 @@
>  	else if (!strcmp(str, "rom")) {
>  		pci_probe |= PCI_ASSIGN_ROMS;
>  		return NULL;
> +	} else if (!strcmp(str, "stdroute")) {
> +		pci_probe |= PCI_PASSTHRU_IRQROUTE;
> +		return NULL;
>  	} else if (!strcmp(str, "assign-busses")) {
>  		pci_probe |= PCI_ASSIGN_ALL_BUSSES;
>  		return NULL;
> diff -Nru linux-2.5.69.vanilla/arch/i386/pci/irq.c linux-2.5.69-custom/arch/i386/pci/irq.c
> --- linux-2.5.69.vanilla/arch/i386/pci/irq.c	2003-05-26 13:51:38.000000000 -0700
> +++ linux-2.5.69-custom/arch/i386/pci/irq.c	2003-06-02 23:18:46.000000000 -0700
> @@ -42,6 +42,8 @@
>  	u16 vendor, device;
>  	int (*get)(struct pci_dev *router, struct pci_dev *dev, int pirq);
>  	int (*set)(struct pci_dev *router, struct pci_dev *dev, int pirq, int new);
> +	int (*detect)(struct pci_dev *router, struct irq_router *r,
> +		      struct irq_routing_table *rt);
>  };
> 
>  int (*pcibios_enable_irq)(struct pci_dev *dev) = NULL;
> @@ -258,112 +260,264 @@
>  }
> 
>  /*
> - *	PIRQ routing for SiS 85C503 router used in several SiS chipsets
> - *	According to the SiS 5595 datasheet (preliminary V1.0, 12/24/1997)
> - *	the related registers work as follows:
> - *
> - *	general: one byte per re-routable IRQ,
> + *	PIRQ routing for SiS 85C503 router used in several SiS chipsets.
> + *	We have to deal with the following issues here:
> + *	- vendors have different ideas about the meaning of link values
> + *	- some onboard devices (integrated in the chipset) have special
> + *	  links and are thus routed differently (i.e. not via PCI INTA-INTD)
> + *	- different revision of the router have a different layout for
> + *	  the routing registers, particularly for the onchip devices
> + *
> + *	For all routing registers the common thing is we have one byte
> + *	per routeable link which is defined as:
>   *		 bit 7      IRQ mapping enabled (0) or disabled (1)
> - *		 bits [6:4] reserved
> + *		 bits [6:4] reserved (sometimes used for onchip devices)
>   *		 bits [3:0] IRQ to map to
>   *		     allowed: 3-7, 9-12, 14-15
>   *		     reserved: 0, 1, 2, 8, 13
>   *
> - *	individual registers in device config space:
> + *	The config-space registers located at 0x41/0x42/0x43/0x44 are
> + *	always used to route the normal PCI INT A/B/C/D respectively.
> + *	Apparently there are systems implementing PCI routing table using
> + *	link values 0x01-0x04 and others using 0x41-0x44 for PCI INTA..D.
> + *	We try our best to handle both link mappings.
> + *
> + *	Currently (2003-05-21) it appears most SiS chipsets follow the
> + *	definition of routing registers from the SiS-5595 southbridge.
> + *	According to the SiS 5595 datasheets the revision id's of the
> + *	router (ISA-bridge) should be 0x01 or 0xb0.
>   *
> - *	0x41/0x42/0x43/0x44:	PCI INT A/B/C/D - bits as in general case
> + *	Furthermore we've also seen lspci dumps with revision 0x00 and 0xb1.
> + *	Looks like these are used in a number of SiS 5xx/6xx/7xx chipsets.
> + *	They seem to work with the current routing code. However there is
> + *	some concern because of the two USB-OHCI HCs (original SiS 5595
> + *	had only one). YMMV.
>   *
> - *	0x61:			IDEIRQ: bits as in general case - but:
> - *				bits [6:5] must be written 01
> - *				bit 4 channel-select primary (0), secondary (1)
> + *	Onchip routing for router rev-id 0x01/0xb0 and probably 0x00/0xb1:
>   *
> - *	0x62:			USBIRQ: bits as in general case - but:
> - *				bit 4 OHCI function disabled (0), enabled (1)
> + *	0x61:	IDEIRQ:
> + *		bits [6:5] must be written 01
> + *		bit 4 channel-select primary (0), secondary (1)
> + *
> + *	0x62:	USBIRQ:
> + *		bit 6 OHCI function disabled (0), enabled (1)
>   *
> - *	0x6a:			ACPI/SCI IRQ - bits as in general case
> + *	0x6a:	ACPI/SCI IRQ: bits 4-6 reserved
> + *
> + *	0x7e:	Data Acq. Module IRQ - bits 4-6 reserved
>   *
> - *	0x7e:			Data Acq. Module IRQ - bits as in general case
> + *	We support USBIRQ (in addition to INTA-INTD) and keep the
> + *	IDE, ACPI and DAQ routing untouched as set by the BIOS.
>   *
> - *	Apparently there are systems implementing PCI routing table using both
> - *	link values 0x01-0x04 and 0x41-0x44 for PCI INTA..D, but register offsets
> - *	like 0x62 as link values for USBIRQ e.g. So there is no simple
> - *	"register = offset + pirq" relation.
> - *	Currently we support PCI INTA..D and USBIRQ and try our best to handle
> - *	both link mappings.
> - *	IDE/ACPI/DAQ mapping is currently unsupported (left untouched as set by BIOS).
> + *	Currently the only reported exception is the new SiS 65x chipset
> + *	which includes the SiS 69x southbridge. Here we have the 85C503
> + *	router revision 0x04 and there are changes in the register layout
> + *	mostly related to the different USB HCs with USB 2.0 support.
> + *
> + *	Onchip routing for router rev-id 0x04 (try-and-error observation)
> + *
> + *	0x60/0x61/0x62/0x63:	1xEHCI and 3xOHCI (companion) USB-HCs
> + *				bit 6-4 are probably unused, not like 5595
> + */
> +
> +#define PIRQ_SIS_IRQ_MASK	0x0f
> +#define PIRQ_SIS_IRQ_DISABLE	0x80
> +#define PIRQ_SIS_USB_ENABLE	0x40
> +#define PIRQ_SIS_DETECT_REGISTER 0x40
> +
> +/* return value:
> + * -1 on error
> + * 0 for PCI INTA-INTD
> + * 0 or enable bit mask to check or set for onchip functions
>   */
> +static inline int pirq_sis5595_onchip(int pirq, int *reg)
> +{
> +	int ret = -1;
> 
> -static int pirq_sis_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
> +	*reg = pirq;
> +	switch(pirq) {
> +	case 0x01:
> +	case 0x02:
> +	case 0x03:
> +	case 0x04:
> +		*reg += 0x40;
> +	case 0x41:
> +	case 0x42:
> +	case 0x43:
> +	case 0x44:
> +		ret = 0;
> +		break;
> +
> +	case 0x62:
> +		ret = PIRQ_SIS_USB_ENABLE;	/* documented for 5595 */
> +		break;
> +
> +	case 0x61:
> +	case 0x6a:
> +	case 0x7e:
> +		printk(KERN_INFO "SiS pirq: IDE/ACPI/DAQ mapping not implemented: (%u)\n",
> +		       (unsigned) pirq);
> +		/* fall thru */
> +	default:
> +		printk(KERN_INFO "SiS router unknown request: (%u)\n",
> +		       (unsigned) pirq);
> +		break;
> +	}
> +	if (ret < 0 && (pci_probe & PCI_PASSTHRU_IRQROUTE))
> +		ret = 0;
> +	return ret;
> +}
> +
> +/* return value:
> + * -1 on error
> + * 0 for PCI INTA-INTD
> + * 0 or enable bit mask to check or set for onchip functions
> + */
> +static inline int pirq_sis96x_onchip(int pirq, int *reg)
>  {
> -	u8 x;
> -	int reg = pirq;
> +	int ret = -1;
> 
> +	*reg = pirq;
>  	switch(pirq) {
> -		case 0x01:
> -		case 0x02:
> -		case 0x03:
> -		case 0x04:
> -			reg += 0x40;
> -		case 0x41:
> -		case 0x42:
> -		case 0x43:
> -		case 0x44:
> -		case 0x62:
> -			pci_read_config_byte(router, reg, &x);
> -			if (reg != 0x62)
> -				break;
> -			if (!(x & 0x40))
> -				return 0;
> -			break;
> -		case 0x61:
> -		case 0x6a:
> -		case 0x7e:
> -			printk(KERN_INFO "SiS pirq: advanced IDE/ACPI/DAQ mapping not yet implemented\n");
> -			return 0;
> -		default:
> -			printk(KERN_INFO "SiS router pirq escape (%d)\n", pirq);
> -			return 0;
> -	}
> -	return (x & 0x80) ? 0 : (x & 0x0f);
> +	case 0x01:
> +	case 0x02:
> +	case 0x03:
> +	case 0x04:
> +		*reg += 0x40;
> +	case 0x41:
> +	case 0x42:
> +	case 0x43:
> +	case 0x44:
> +	case 0x60:
> +	case 0x61:
> +	case 0x62:
> +	case 0x63:
> +		ret = 0;
> +		break;
> +
> +	default:
> +		printk(KERN_INFO "SiS router unknown request: (%u)\n",
> +		       (unsigned) pirq);
> +		break;
> +	}
> +	if (ret < 0 && (pci_probe & PCI_PASSTHRU_IRQROUTE))
> +		ret = 0;
> +	return ret;
> +}
> +
> +
> +static int pirq_sis5595_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
> +{
> +	u8 x;
> +	int reg, check;
> +
> +	check = pirq_sis5595_onchip(pirq, &reg);
> +	if (check < 0)
> +		return 0;
> +
> +	pci_read_config_byte(router, reg, &x);
> +	if (check != 0  &&  !(x & check))
> +		return 0;
> +
> +	return (x & PIRQ_SIS_IRQ_DISABLE) ? 0 : (x & PIRQ_SIS_IRQ_MASK);
>  }
> 
> -static int pirq_sis_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
> +static int pirq_sis96x_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
>  {
>  	u8 x;
> -	int reg = pirq;
> +	int reg, check;
> +
> +	check = pirq_sis96x_onchip(pirq, &reg);
> +	if (check < 0)
> +		return 0;
> +
> +	pci_read_config_byte(router, reg, &x);
> +	if (check != 0  &&  !(x & check))
> +		return 0;
> +
> +	return (x & PIRQ_SIS_IRQ_DISABLE) ? 0 : (x & PIRQ_SIS_IRQ_MASK);
> +}
> +
> +static int pirq_sis5595_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
> +{
> +	u8 x;
> +	int reg, set;
> +
> +	set = pirq_sis5595_onchip(pirq, &reg);
> +	if (set < 0)
> +		return 0;
> +
> +	x = (irq & PIRQ_SIS_IRQ_MASK);
> +	if (x == 0)
> +		x = PIRQ_SIS_IRQ_DISABLE;
> +	else
> +		x |= set;
> +
> +	pci_write_config_byte(router, reg, x);
> +
> +	return 1;
> +}
> +
> +static int pirq_sis96x_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
> +{
> +	u8 x;
> +	int reg, set;
> +
> +	set = pirq_sis96x_onchip(pirq, &reg);
> +	if (set < 0)
> +		return 0;
> +
> +	x = (irq & PIRQ_SIS_IRQ_MASK);
> +	if (x == 0)
> +		x = PIRQ_SIS_IRQ_DISABLE;
> +	else
> +		x |= set;
> 
> -	switch(pirq) {
> -		case 0x01:
> -		case 0x02:
> -		case 0x03:
> -		case 0x04:
> -			reg += 0x40;
> -		case 0x41:
> -		case 0x42:
> -		case 0x43:
> -		case 0x44:
> -		case 0x62:
> -			x = (irq&0x0f) ? (irq&0x0f) : 0x80;
> -			if (reg != 0x62)
> -				break;
> -			/* always mark OHCI enabled, as nothing else knows about this */
> -			x |= 0x40;
> -			break;
> -		case 0x61:
> -		case 0x6a:
> -		case 0x7e:
> -			printk(KERN_INFO "advanced SiS pirq mapping not yet implemented\n");
> -			return 0;
> -		default:
> -			printk(KERN_INFO "SiS router pirq escape (%d)\n", pirq);
> -			return 0;
> -	}
>  	pci_write_config_byte(router, reg, x);
> 
>  	return 1;
>  }
> 
>  /*
> + * In case of SiS south bridge, we need to detect the two kind of routing
> + * tables we have seen so far (5595 and 96x). Since the maintain the same
> + * device ID, we need to do poke the PCI configuration space to find the
> + * router type we are dealing with.
> + */
> +static int pirq_detect_sis_router(struct pci_dev *router, struct irq_router *r,
> +				  struct irq_routing_table *rt) {
> +	u8 reg;
> +	u16 devid;
> +
> +	/*
> +	 * Factoid: writing bit6 of register 0x40 of the router config space
> +	 * will make the SB to show up 0x096x inside the device id. Note,
> +	 * we need to restore register 0x40 after the device id poke.
> +	 */
> +	pci_read_config_byte(router, PIRQ_SIS_DETECT_REGISTER, &reg);
> +	pci_write_config_byte(router, PIRQ_SIS_DETECT_REGISTER, reg | (1 << 6));
> +	pci_read_config_word(router, PCI_DEVICE_ID, &devid);
> +	pci_write_config_byte(router, PIRQ_SIS_DETECT_REGISTER, reg);
> +
> +	DBG("PCI: Detecting SiS router at %02x:%02x : DeviceID=0x%x\n",
> +	    rt->rtr_bus, rt->rtr_devfn, (unsigned) devid);
> +
> +	if ((devid & 0xfff0) == 0x0960) {
> +		r->get = pirq_sis96x_get;
> +		r->set = pirq_sis96x_set;
> +		DBG("PCI: Detecting SiS router at %02x:%02x : SiS096x detected\n",
> +		    rt->rtr_bus, rt->rtr_devfn);
> +	} else {
> +		r->get = pirq_sis5595_get;
> +		r->set = pirq_sis5595_set;
> +		DBG("PCI: Detecting SiS router at %02x:%02x : SiS5595 detected\n",
> +		    rt->rtr_bus, rt->rtr_devfn);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
>   * VLSI: nibble offset 0x74 - educated guess due to routing table and
>   *       config space of VLSI 82C534 PCI-bridge/router (1004:0102)
>   *       Tested on HP OmniBook 800 covering PIRQ 1, 2, 4, 8 for onboard
> @@ -461,45 +615,45 @@
>  #endif
> 
>  static struct irq_router pirq_routers[] = {
> -	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371FB_0, pirq_piix_get, pirq_piix_set },
> -	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371SB_0, pirq_piix_get, pirq_piix_set },
> -	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_0, pirq_piix_get, pirq_piix_set },
> -	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371MX,   pirq_piix_get, pirq_piix_set },
> -	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_0, pirq_piix_get, pirq_piix_set },
> -	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0, pirq_piix_get, pirq_piix_set },
> -	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0, pirq_piix_get, pirq_piix_set },
> -	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0, pirq_piix_get, pirq_piix_set },
> -	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10, pirq_piix_get, pirq_piix_set },
> -	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0, pirq_piix_get, pirq_piix_set },
> -	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12, pirq_piix_get, pirq_piix_set },
> -	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0, pirq_piix_get, pirq_piix_set },
> -	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_0, pirq_piix_get, pirq_piix_set },
> -
> -	{ "ALI", PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, pirq_ali_get, pirq_ali_set },
> -
> -	{ "ITE", PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_IT8330G_0, pirq_ite_get, pirq_ite_set },
> -
> -	{ "VIA", PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, pirq_via_get, pirq_via_set },
> -	{ "VIA", PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C596, pirq_via_get, pirq_via_set },
> -	{ "VIA", PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, pirq_via_get, pirq_via_set },
> -
> -	{ "OPTI", PCI_VENDOR_ID_OPTI, PCI_DEVICE_ID_OPTI_82C700, pirq_opti_get, pirq_opti_set },
> -
> -	{ "NatSemi", PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520, pirq_cyrix_get, pirq_cyrix_set },
> -	{ "SIS", PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503, pirq_sis_get, pirq_sis_set },
> -	{ "VLSI 82C534", PCI_VENDOR_ID_VLSI, PCI_DEVICE_ID_VLSI_82C534, pirq_vlsi_get, pirq_vlsi_set },
> +	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371FB_0, pirq_piix_get, pirq_piix_set, NULL },
> +	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371SB_0, pirq_piix_get, pirq_piix_set, NULL },
> +	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_0, pirq_piix_get, pirq_piix_set, NULL },
> +	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371MX,   pirq_piix_get, pirq_piix_set, NULL },
> +	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_0, pirq_piix_get, pirq_piix_set, NULL },
> +	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0, pirq_piix_get, pirq_piix_set, NULL },
> +	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0, pirq_piix_get, pirq_piix_set, NULL },
> +	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0, pirq_piix_get, pirq_piix_set, NULL },
> +	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10, pirq_piix_get, pirq_piix_set, NULL },
> +	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0, pirq_piix_get, pirq_piix_set, NULL },
> +	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12, pirq_piix_get, pirq_piix_set, NULL },
> +	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0, pirq_piix_get, pirq_piix_set, NULL },
> +	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_0, pirq_piix_get, pirq_piix_set, NULL },
> +
> +	{ "ALI", PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, pirq_ali_get, pirq_ali_set, NULL },
> +
> +	{ "ITE", PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_IT8330G_0, pirq_ite_get, pirq_ite_set, NULL },
> +
> +	{ "VIA", PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, pirq_via_get, pirq_via_set, NULL },
> +	{ "VIA", PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C596, pirq_via_get, pirq_via_set, NULL },
> +	{ "VIA", PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, pirq_via_get, pirq_via_set, NULL },
> +
> +	{ "OPTI", PCI_VENDOR_ID_OPTI, PCI_DEVICE_ID_OPTI_82C700, pirq_opti_get, pirq_opti_set, NULL },
> +
> +	{ "NatSemi", PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520, pirq_cyrix_get, pirq_cyrix_set, NULL },
> +	{ "SIS", PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503, NULL, NULL, pirq_detect_sis_router },
> +	{ "VLSI 82C534", PCI_VENDOR_ID_VLSI, PCI_DEVICE_ID_VLSI_82C534, pirq_vlsi_get, pirq_vlsi_set, NULL },
>  	{ "ServerWorks", PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4,
> -	  pirq_serverworks_get, pirq_serverworks_set },
> +	  pirq_serverworks_get, pirq_serverworks_set, NULL },
>  	{ "ServerWorks", PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5,
> -	  pirq_serverworks_get, pirq_serverworks_set },
> +	  pirq_serverworks_get, pirq_serverworks_set, NULL },
>  	{ "AMD756 VIPER", PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_740B,
> -		pirq_amd756_get, pirq_amd756_set },
> +		pirq_amd756_get, pirq_amd756_set, NULL },
>  	{ "AMD766", PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7413,
> -		pirq_amd756_get, pirq_amd756_set },
> +		pirq_amd756_get, pirq_amd756_set, NULL },
>  	{ "AMD768", PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_OPUS_7443,
> -		pirq_amd756_get, pirq_amd756_set },
> +		pirq_amd756_get, pirq_amd756_set, NULL },
> 
> -	{ "default", 0, 0, NULL, NULL }
> +	{ "default", 0, 0, NULL, NULL, NULL }
>  };
> 
>  static struct irq_router *pirq_router;
> @@ -541,6 +695,11 @@
>  			pirq_router = r;
>  		}
>  	}
> +	if (pirq_router->detect && pirq_router->detect(pirq_router_dev, pirq_router, rt) < 0) {
> +		DBG("PCI: Interrupt router detect failed at %02x:%02x\n", rt->rtr_bus, rt->rtr_devfn);
> +		return;
> +	}
> +
>  	printk(KERN_INFO "PCI: Using IRQ router %s [%04x/%04x] at %s\n",
>  		pirq_router->name,
>  		pirq_router_dev->vendor,
> diff -Nru linux-2.5.69.vanilla/arch/i386/pci/pci.h linux-2.5.69-custom/arch/i386/pci/pci.h
> --- linux-2.5.69.vanilla/arch/i386/pci/pci.h	2003-05-26 13:51:38.000000000 -0700
> +++ linux-2.5.69-custom/arch/i386/pci/pci.h	2003-06-02 23:13:27.000000000 -0700
> @@ -23,6 +23,7 @@
>  #define PCI_BIOS_IRQ_SCAN	0x2000
>  #define PCI_ASSIGN_ALL_BUSSES	0x4000
>  #define PCI_NO_ACPI_ROUTING	0x8000
> +#define PCI_PASSTHRU_IRQROUTE	0x10000
> 
>  extern unsigned int pci_probe;
> 


-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          http://www.winischhofer.net/
twini AT xfree86 DOT org

