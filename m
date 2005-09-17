Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbVIQSgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbVIQSgx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 14:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbVIQSgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 14:36:53 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:20445 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1750850AbVIQSgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 14:36:52 -0400
Message-ID: <432C5F93.80506@linuxtv.org>
Date: Sat, 17 Sep 2005 22:25:23 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: free free irq and Oops on cat /proc/interrupts (2)
References: <432C344D.1030604@linuxtv.org> <20050917215646.78a05044.vsu@altlinux.ru>
In-Reply-To: <20050917215646.78a05044.vsu@altlinux.ru>
Content-Type: multipart/mixed;
 boundary="------------070503070502060108070501"
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070503070502060108070501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sergey Vlasov wrote:

>On Sat, 17 Sep 2005 19:20:45 +0400 Manu Abraham wrote:
>
>  
>
>>Can somebody give me a pointer as to what i am possibly doing wrong.
>>
>>The module loads fine..
>>The module unloads fine.. But i get a "free free IRQ" on free_irq()..
>>    
>>
>
>You are not calling pci_enable_device() in your probe handler.  You
>  
>

In fact i was calling, pci_enable_device() in my previous post.
http://marc.theaimsgroup.com/?l=linux-kernel&m=112680448728918&w=2

After which i was trying to find out why the same is happening.
So the same thing is anyway happening with or without pci_enable_device()

>MUST call this function, check for success, and only after that you
>can use pdev->irq (recent kernels perform interrupt routing only after
>the device is enabled, so the value of pdev->irq before the call to
>pci_enable_device() may not be valid).
>  
>
I thought i will try again, attached is the modified version.
The problem remains as it is ..

Attached is the dmesg with pci_enable_device() included.


Thanks,
Manu


--------------070503070502060108070501
Content-Type: text/plain;
 name="mantis_pci.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mantis_pci.c"

#include <asm/io.h>
#include <asm/pgtable.h>
#include <asm/page.h>
#include <linux/kmod.h>
#include <linux/vmalloc.h>
#include <linux/init.h>
#include <linux/device.h>
#include "mantis_common.h"
#include "mantis_dma.h"
#include "mantis_i2c.h"
#include "mantis_eeprom.h"

#include <asm/irq.h>
#include <linux/signal.h>
#include <linux/sched.h>
#include <linux/interrupt.h>

unsigned int verbose = 1;
module_param(verbose, int, 0644);
MODULE_PARM_DESC(verbose, "verbose startup messages, default is 1 (yes)");

#define PCI_VENDOR_ID_MANTIS			0x1822
#define PCI_DEVICE_ID_MANTIS_R11		0x4e35
#define DRIVER_NAME				"mantis"

static struct pci_device_id mantis_pci_table[] = {
	{ PCI_DEVICE(PCI_VENDOR_ID_MANTIS, PCI_DEVICE_ID_MANTIS_R11) },
	{ 0 },
};

MODULE_DEVICE_TABLE(pci, mantis_pci_table);

static irqreturn_t mantis_pci_irq(int irq, void *dev_id, struct pt_regs *regs)
{
	struct mantis_pci *mantis;

	dprintk(verbose, MANTIS_DEBUG, 1, "Mantis PCI IRQ");
	mantis = (struct mantis_pci *) dev_id;
	if (mantis == NULL)
		dprintk(verbose, MANTIS_DEBUG, 1, "Aeio, mantis ISR");

	return IRQ_NONE;	// temporarily
}

static int mantis_i2c_setup(struct mantis_pci *mantis)
{
	u32 config;

//	mmwrite(0x80, MANTIS_DMA_CTL); // MCU i2c read
	config = mmread(MANTIS_DMA_CTL);
	dprintk(verbose, MANTIS_DEBUG, 1, "Mantis Ctl reg=0x%04x", config);

	return 0;
}

static int mantis_reg_dump(struct mantis_pci *mantis)
{
	u32 ctlreg, intstat, intmask, i2cdata;

	ctlreg = mmread(MANTIS_DMA_CTL);
	intstat = mmread(MANTIS_INT_STAT);
	intmask = mmread(MANTIS_INT_MASK);
	i2cdata = mmread(MANTIS_I2C_DATA);
	dprintk(verbose, MANTIS_DEBUG, 1, "CTL_REG=0x%04x, INT_STAT=0x%04x, \
		INT_MASK=0x%04x, I2C_DATA=0x%04x", ctlreg, intstat,		\
		intmask, i2cdata);

	return 0;
}

static int __devinit mantis_pci_probe(struct pci_dev *pdev,
				const struct pci_device_id *mantis_pci_table)
{
	u8 revision, latency;
	struct mantis_pci *mantis;

	mantis = (struct mantis_pci *)
				kmalloc(sizeof (struct mantis_pci), GFP_KERNEL);
	if (mantis == NULL) {
		dprintk(verbose, MANTIS_ERROR, 1, "Out of memory");
		return -ENOMEM;
	}
	if (pci_enable_device(pdev)) {
		dprintk(verbose, MANTIS_ERROR, 1, "Mantis PCI enable failed");
		goto err;
	}
	dprintk(verbose, MANTIS_ERROR, 1, "<2:>IRQ=%d", pdev->irq);

	dprintk(verbose, MANTIS_ERROR, 1, "Got a device");
	if (request_irq(pdev->irq, mantis_pci_irq, SA_SHIRQ | SA_INTERRUPT, 
						DRIVER_NAME, mantis) < 0) {
	dprintk(verbose, MANTIS_DEBUG, 1, "We got an IRQ");
	return 0;

err:
	dprintk(verbose, MANTIS_DEBUG, 1, "<freak out>");
	kfree(mantis);
	return -ENODEV;
}



static void __devexit mantis_pci_remove(struct pci_dev *pdev)
{
	free_irq(pdev->irq, pdev);
	pci_disable_device(pdev);
}

static struct pci_driver mantis_pci_driver = {
	.name = DRIVER_NAME,
	.id_table = mantis_pci_table,
	.probe = mantis_pci_probe,
	.remove = mantis_pci_remove,
};

static int __devinit mantis_pci_init(void)
{
	return pci_register_driver(&mantis_pci_driver);
}

static void __devexit mantis_pci_exit(void)
{
	pci_unregister_driver(&mantis_pci_driver);
}

module_init(mantis_pci_init);
module_exit(mantis_pci_exit);

MODULE_DESCRIPTION("Mantis PCI DTV bridge driver");
MODULE_AUTHOR("Manu Abraham");
MODULE_LICENSE("GPL");

--------------070503070502060108070501
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

journal
[   33.482171] EXT3-fs: mounted filesystem with ordered data mode.
[   33.482183] fill_kobj_path: path = '/block/hda/hda7'
[   36.826992] kobject 3c59x: registering. parent: <NULL>, set: module
[   36.827015] kobject_hotplug
[   36.827022] fill_kobj_path: path = '/module/3c59x'
[   36.827027] kobject_hotplug: /bin/true module seq=765 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/module/3c59x SUBSYSTEM=module
[   36.828167] kobject 3c59x: registering. parent: <NULL>, set: drivers
[   36.828178] kobject_hotplug
[   36.828185] fill_kobj_path: path = '/bus/pci/drivers/3c59x'
[   36.828189] kobject_hotplug: /bin/true drivers seq=766 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/bus/pci/drivers/3c59x SUBSYSTEM=drivers
[   36.828993] 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
[   36.829001] 0000:02:0a.0: 3Com PCI 3c905C Tornado at 0xdc00. Vers LK1.1.19
[   36.850753] kobject eth0: registering. parent: net, set: class_obj
[   36.850768] kobject_hotplug
[   36.850774] fill_kobj_path: path = '/class/net/eth0'
[   36.850780] fill_kobj_path: path = '/devices/pci0000:00/0000:00:1e.0/0000:02:0a.0'
[   36.850785] kobject_hotplug: /bin/true net seq=767 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/net/eth0 SUBSYSTEM=net
[   42.163238] kobject_hotplug
[   42.163247] fill_kobj_path: path = '/class/vc/vcs1'
[   42.163252] kobject_hotplug: /sbin/hotplug vc seq=768 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcs1 SUBSYSTEM=vc
[   42.164164] kobject vcs1: cleaning up
[   42.164172] kobject_hotplug
[   42.164178] fill_kobj_path: path = '/class/vc/vcsa1'
[   42.164183] kobject_hotplug: /sbin/hotplug vc seq=769 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcsa1 SUBSYSTEM=vc
[   42.164985] kobject vcsa1: cleaning up
[   42.193854] kobject vcs1: registering. parent: vc, set: class_obj
[   42.193876] kobject_hotplug
[   42.193884] fill_kobj_path: path = '/class/vc/vcs1'
[   42.193889] kobject_hotplug: /sbin/hotplug vc seq=770 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs1 SUBSYSTEM=vc
[   42.210099] kobject vcsa1: registering. parent: vc, set: class_obj
[   42.210116] kobject_hotplug
[   42.210123] fill_kobj_path: path = '/class/vc/vcsa1'
[   42.210128] kobject_hotplug: /sbin/hotplug vc seq=771 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa1 SUBSYSTEM=vc
[   42.258941] kobject vcs3: registering. parent: vc, set: class_obj
[   42.258959] kobject_hotplug
[   42.258965] fill_kobj_path: path = '/class/vc/vcs3'
[   42.258971] kobject_hotplug: /sbin/hotplug vc seq=772 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs3 SUBSYSTEM=vc
[   42.273907] kobject vcsa3: registering. parent: vc, set: class_obj
[   42.273926] kobject_hotplug
[   42.273933] fill_kobj_path: path = '/class/vc/vcsa3'
[   42.273938] kobject_hotplug: /sbin/hotplug vc seq=773 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa3 SUBSYSTEM=vc
[   42.291185] kobject_hotplug
[   42.291194] fill_kobj_path: path = '/class/vc/vcs3'
[   42.291199] kobject_hotplug: /sbin/hotplug vc seq=774 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcs3 SUBSYSTEM=vc
[   42.292042] kobject vcs3: cleaning up
[   42.292049] kobject_hotplug
[   42.292055] fill_kobj_path: path = '/class/vc/vcsa3'
[   42.292060] kobject_hotplug: /sbin/hotplug vc seq=775 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcsa3 SUBSYSTEM=vc
[   42.292856] kobject vcsa3: cleaning up
[   42.320905] kobject vcs3: registering. parent: vc, set: class_obj
[   42.320922] kobject_hotplug
[   42.320929] fill_kobj_path: path = '/class/vc/vcs3'
[   42.320934] kobject_hotplug: /sbin/hotplug vc seq=776 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs3 SUBSYSTEM=vc
[   42.339130] kobject vcsa3: registering. parent: vc, set: class_obj
[   42.339148] kobject_hotplug
[   42.339155] fill_kobj_path: path = '/class/vc/vcsa3'
[   42.339160] kobject_hotplug: /sbin/hotplug vc seq=777 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa3 SUBSYSTEM=vc
[   42.359945] kobject vcs2: registering. parent: vc, set: class_obj
[   42.359962] kobject_hotplug
[   42.359969] fill_kobj_path: path = '/class/vc/vcs2'
[   42.359974] kobject_hotplug: /sbin/hotplug vc seq=778 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs2 SUBSYSTEM=vc
[   42.374822] kobject vcsa2: registering. parent: vc, set: class_obj
[   42.374840] kobject_hotplug
[   42.374847] fill_kobj_path: path = '/class/vc/vcsa2'
[   42.374852] kobject_hotplug: /sbin/hotplug vc seq=779 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa2 SUBSYSTEM=vc
[   42.392705] kobject_hotplug
[   42.392713] fill_kobj_path: path = '/class/vc/vcs2'
[   42.392719] kobject_hotplug: /sbin/hotplug vc seq=780 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcs2 SUBSYSTEM=vc
[   42.393568] kobject vcs2: cleaning up
[   42.393576] kobject_hotplug
[   42.393582] fill_kobj_path: path = '/class/vc/vcsa2'
[   42.393587] kobject_hotplug: /sbin/hotplug vc seq=781 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcsa2 SUBSYSTEM=vc
[   42.394385] kobject vcsa2: cleaning up
[   42.423395] kobject vcs2: registering. parent: vc, set: class_obj
[   42.423412] kobject_hotplug
[   42.423419] fill_kobj_path: path = '/class/vc/vcs2'
[   42.423424] kobject_hotplug: /sbin/hotplug vc seq=782 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs2 SUBSYSTEM=vc
[   42.438350] kobject vcsa2: registering. parent: vc, set: class_obj
[   42.438368] kobject_hotplug
[   42.438375] fill_kobj_path: path = '/class/vc/vcsa2'
[   42.438380] kobject_hotplug: /sbin/hotplug vc seq=783 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa2 SUBSYSTEM=vc
[   42.455761] kobject vcs4: registering. parent: vc, set: class_obj
[   42.455778] kobject_hotplug
[   42.455785] fill_kobj_path: path = '/class/vc/vcs4'
[   42.455790] kobject_hotplug: /sbin/hotplug vc seq=784 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs4 SUBSYSTEM=vc
[   42.471838] kobject vcs5: registering. parent: vc, set: class_obj
[   42.471855] kobject_hotplug
[   42.471862] fill_kobj_path: path = '/class/vc/vcs5'
[   42.471867] kobject_hotplug: /sbin/hotplug vc seq=785 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs5 SUBSYSTEM=vc
[   42.488958] kobject vcs6: registering. parent: vc, set: class_obj
[   42.488978] kobject_hotplug
[   42.488985] fill_kobj_path: path = '/class/vc/vcs6'
[   42.488990] kobject_hotplug: /sbin/hotplug vc seq=786 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs6 SUBSYSTEM=vc
[   42.504385] kobject vcsa4: registering. parent: vc, set: class_obj
[   42.504402] kobject_hotplug
[   42.504409] fill_kobj_path: path = '/class/vc/vcsa4'
[   42.504414] kobject_hotplug: /sbin/hotplug vc seq=787 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa4 SUBSYSTEM=vc
[   42.519789] kobject_hotplug
[   42.519797] fill_kobj_path: path = '/class/vc/vcs4'
[   42.519803] kobject_hotplug: /sbin/hotplug vc seq=788 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcs4 SUBSYSTEM=vc
[   42.520640] kobject vcs4: cleaning up
[   42.520648] kobject_hotplug
[   42.520654] fill_kobj_path: path = '/class/vc/vcsa4'
[   42.520659] kobject_hotplug: /sbin/hotplug vc seq=789 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcsa4 SUBSYSTEM=vc
[   42.521447] kobject vcsa4: cleaning up
[   42.540779] kobject vcs4: registering. parent: vc, set: class_obj
[   42.540795] kobject_hotplug
[   42.540802] fill_kobj_path: path = '/class/vc/vcs4'
[   42.540807] kobject_hotplug: /sbin/hotplug vc seq=790 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs4 SUBSYSTEM=vc
[   42.556815] kobject vcsa4: registering. parent: vc, set: class_obj
[   42.556833] kobject_hotplug
[   42.556840] fill_kobj_path: path = '/class/vc/vcsa4'
[   42.556845] kobject_hotplug: /sbin/hotplug vc seq=791 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa4 SUBSYSTEM=vc
[   42.575409] kobject vcsa5: registering. parent: vc, set: class_obj
[   42.575427] kobject_hotplug
[   42.575433] fill_kobj_path: path = '/class/vc/vcsa5'
[   42.575438] kobject_hotplug: /sbin/hotplug vc seq=792 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa5 SUBSYSTEM=vc
[   42.581448] kobject_hotplug
[   42.581456] fill_kobj_path: path = '/class/vc/vcs5'
[   42.581461] kobject_hotplug: /sbin/hotplug vc seq=793 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcs5 SUBSYSTEM=vc
[   42.582313] kobject vcs5: cleaning up
[   42.582321] kobject_hotplug
[   42.582327] fill_kobj_path: path = '/class/vc/vcsa5'
[   42.582332] kobject_hotplug: /sbin/hotplug vc seq=794 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcsa5 SUBSYSTEM=vc
[   42.583166] kobject vcsa5: cleaning up
[   42.589803] kobject vcs5: registering. parent: vc, set: class_obj
[   42.589820] kobject_hotplug
[   42.589827] fill_kobj_path: path = '/class/vc/vcs5'
[   42.589832] kobject_hotplug: /sbin/hotplug vc seq=795 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs5 SUBSYSTEM=vc
[   42.592513] kobject vcsa5: registering. parent: vc, set: class_obj
[   42.592534] kobject_hotplug
[   42.592541] fill_kobj_path: path = '/class/vc/vcsa5'
[   42.592546] kobject_hotplug: /sbin/hotplug vc seq=796 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa5 SUBSYSTEM=vc
[   42.607755] kobject vcsa6: registering. parent: vc, set: class_obj
[   42.607779] kobject_hotplug
[   42.607786] fill_kobj_path: path = '/class/vc/vcsa6'
[   42.607791] kobject_hotplug: /sbin/hotplug vc seq=797 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa6 SUBSYSTEM=vc
[   42.632824] kobject_hotplug
[   42.632833] fill_kobj_path: path = '/class/vc/vcs6'
[   42.632838] kobject_hotplug: /sbin/hotplug vc seq=798 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcs6 SUBSYSTEM=vc
[   42.633702] kobject vcs6: cleaning up
[   42.633710] kobject_hotplug
[   42.633716] fill_kobj_path: path = '/class/vc/vcsa6'
[   42.633720] kobject_hotplug: /sbin/hotplug vc seq=799 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcsa6 SUBSYSTEM=vc
[   42.634520] kobject vcsa6: cleaning up
[   42.662748] kobject vcs6: registering. parent: vc, set: class_obj
[   42.662765] kobject_hotplug
[   42.662772] fill_kobj_path: path = '/class/vc/vcs6'
[   42.662778] kobject_hotplug: /sbin/hotplug vc seq=800 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs6 SUBSYSTEM=vc
[   42.677662] kobject vcsa6: registering. parent: vc, set: class_obj
[   42.677679] kobject_hotplug
[   42.677686] fill_kobj_path: path = '/class/vc/vcsa6'
[   42.677691] kobject_hotplug: /sbin/hotplug vc seq=801 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa6 SUBSYSTEM=vc
[   50.284271] kobject i2c_core: registering. parent: <NULL>, set: module
[   50.284296] kobject_hotplug
[   50.284303] fill_kobj_path: path = '/module/i2c_core'
[   50.284308] kobject_hotplug: /sbin/hotplug module seq=802 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/module/i2c_core SUBSYSTEM=module
[   50.299681] subsystem i2c: registering
[   50.299686] kobject i2c: registering. parent: <NULL>, set: bus
[   50.299705] kobject devices: registering. parent: i2c, set: <NULL>
[   50.299722] kobject drivers: registering. parent: i2c, set: <NULL>
[   50.299740] kobject i2c_adapter: registering. parent: <NULL>, set: drivers
[   50.299757] kobject_hotplug
[   50.299763] fill_kobj_path: path = '/bus/i2c/drivers/i2c_adapter'
[   50.299768] kobject_hotplug: /sbin/hotplug drivers seq=803 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/bus/i2c/drivers/i2c_adapter SUBSYSTEM=drivers
[   50.315246] subsystem i2c-adapter: registering
[   50.315252] kobject i2c-adapter: registering. parent: <NULL>, set: class
[   50.360985] kobject mantis: registering. parent: <NULL>, set: module
[   50.361013] kobject_hotplug
[   50.361021] fill_kobj_path: path = '/module/mantis'
[   50.361026] kobject_hotplug: /sbin/hotplug module seq=804 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/module/mantis SUBSYSTEM=module
[   50.376403] kobject mantis: registering. parent: <NULL>, set: drivers
[   50.376420] kobject_hotplug
[   50.376427] fill_kobj_path: path = '/bus/pci/drivers/mantis'
[   50.376432] kobject_hotplug: /sbin/hotplug drivers seq=805 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/bus/pci/drivers/mantis SUBSYSTEM=drivers
[   50.391723] mantis_pci_probe: <2:>IRQ=23
[   50.391876] mantis_pci_probe: Got a device
[   50.392033] mantis_pci_probe: We got an IRQ
[   55.444402] Trying to free free IRQ23
[   55.444530] kobject mantis: unregistering
[   55.444533] kobject_hotplug
[   55.444540] fill_kobj_path: path = '/bus/pci/drivers/mantis'
[   55.444545] kobject_hotplug: /sbin/hotplug drivers seq=806 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/bus/pci/drivers/mantis SUBSYSTEM=drivers
[   55.459714] kobject mantis: cleaning up
[   55.460042] kobject mantis: unregistering
[   55.460046] kobject_hotplug
[   55.460052] fill_kobj_path: path = '/module/mantis'
[   55.460057] kobject_hotplug: /sbin/hotplug module seq=807 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/module/mantis SUBSYSTEM=module
[   55.475354] kobject mantis: cleaning up
[  958.765279] Unable to handle kernel paging request at virtual address f92a3542
[  958.768066]  printing eip:
[  958.770772] c0207487
[  958.773187] *pde = 01bc4067
[  958.775768] *pte = 00000000
[  958.778254] Oops: 0000 [#1]
[  958.780731] SMP DEBUG_PAGEALLOC
[  958.783270] Modules linked in: i2c_core 3c59x piix sd_mod
[  958.785930] CPU:    0
[  958.785931] EIP:    0060:[<c0207487>]    Not tainted VLI
[  958.785932] EFLAGS: 00010097   (2.6.13) 
[  958.793576] EIP is at vsnprintf+0x337/0x4c0
[  958.796309] eax: f92a3542   ebx: 0000000a   ecx: f92a3542   edx: fffffffe
[  958.799328] esi: f19ac122   edi: 00000000   ebp: f102bee4   esp: f102beac
[  958.802457] ds: 007b   es: 007b   ss: 0068
[  958.805509] Process cat (pid: 2410, threadinfo=f102b000 task=f1120b00)
[  958.805704] Stack: f102bef4 f19acfff 00000000 00000000 0000000a fffffffd 00000000 00000000 
[  958.809303]        ffffffff ffffffff f19acfff f59111b4 f2195bcc 00000017 f102bf00 c01804f6 
[  958.813137]        f19ac120 00000ee0 c036756e f102bf14 00000008 f102bf28 c0105a04 f59111b4 
[  958.817158] Call Trace:
[  958.824921]  [<c0103e6f>] show_stack+0x7f/0xa0
[  958.829274]  [<c0104020>] show_registers+0x160/0x1d0
[  958.833740]  [<c0104250>] die+0x100/0x180
[  958.838228]  [<c0114ee9>] do_page_fault+0x369/0x6ed
[  958.842704]  [<c0103a93>] error_code+0x4f/0x54
[  958.847464]  [<c01804f6>] seq_printf+0x36/0x60
[  958.852287]  [<c0105a04>] show_interrupts+0x2d4/0x3d0
[  958.857008]  [<c017fff9>] seq_read+0x1c9/0x2c0
[  958.862035]  [<c015ead8>] vfs_read+0xb8/0x190
[  958.867131]  [<c015ee8b>] sys_read+0x4b/0x80
[  958.872091]  [<c0102f23>] sysenter_past_esp+0x54/0x75
[  958.877289] Code: ff c7 45 ec 08 00 00 00 83 cf 01 eb ba 8b 45 14 8b 55 e8 83 45 14 04 8b 08 b8 c5 6b 36 c0 81 f9 ff 0f 00 00 0f 46 c8 89 c8 eb 06 <80> 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 75 1d 
[  958.889797]  

--------------070503070502060108070501--
