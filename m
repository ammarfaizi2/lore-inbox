Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030473AbVIOOuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbVIOOuQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 10:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030475AbVIOOuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 10:50:16 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:56741 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1030473AbVIOOuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 10:50:13 -0400
Message-ID: <4329877A.4090809@linuxtv.org>
Date: Thu, 15 Sep 2005 18:38:50 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI driver
References: <4327EE94.2040405@kromtek.com> <200509151018.20322@bilbo.math.uni-mannheim.de> <4329362A.1030201@linuxtv.org> <200509151148.57779@bilbo.math.uni-mannheim.de>
In-Reply-To: <200509151148.57779@bilbo.math.uni-mannheim.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PopBeforeSMTPSenders: manu@kromtek.com
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

Rolf Eike Beer wrote:

>
>You must check here if this interrupt was really from your device. If not, you 
>must return IRQ_NONE. You have requested your interrupt as a shared one so 
>this may happen at any time.
>
>  
>
Fixed this one, temporarily ..

>>static int mantis_i2c_setup(struct mantis_pci *mantis)
>>{
>>   u32 config = 0;
>>    
>>
>
>You don't need to set this here, you will overwrite it anyway before looking 
>at it.
>
>  
>
Oh, that was the remnants of some i2c tests that i was trying to do .. 
The other i2c parts i removed for testing  ..

>
>Also you will get wrong assignements here. You must call pci_enable_device() 
>_first_, it will set up the BARs of that device. Also I think 
>pci_request_regions() might be a better way to get this assignements.
>
>  
>
Fixed that one too ..

>>    
>>
>
>pci_release_regions(pdev);
>
>  
>
Fixed ..

So it now looks like this but i have another problem now, after 
consecutive, load/unload, i get an oops ..


-----------------------------------------------------------------

[  330.625715] mantis_pci_probe: <1:>IRQ=23
[  330.631130] mantis_pci_probe: <2:>IRQ=23
[  330.636138] mantis_pci_probe: Got a device
[  330.641635] mantis_pci_probe: We got an IRQ
[  330.647189] mantis_pci_probe: We finally enabled the device
[  330.652468] Mantis Rev 1, irq: 23, latency: 32
[  330.652577]  		memory: 0xefeff000, mmio: f9218000
[  332.615009] mantis_pci_remove: Removing -->Mantis irq: 23, 		latency: 32
[  332.615011]  memory: 0xefeff000, mmio: 0xf9218000
[  332.627714] Trying to free free IRQ23
[  334.131573] mantis_pci_probe: <1:>IRQ=23
[  334.138602] mantis_pci_probe: <2:>IRQ=23
[  334.145178] mantis_pci_probe: Got a device
[  334.152287] mantis_pci_probe: We got an IRQ
[  334.159038] mantis_pci_probe: We finally enabled the device
[  334.166326] Mantis Rev 1, irq: 23, latency: 32
[  334.166437]  		memory: 0xefeff000, mmio: f92a4000
[  335.716624] mantis_pci_remove: Removing -->Mantis irq: 23, 		latency: 32
[  335.716626]  memory: 0xefeff000, mmio: 0xf92a4000
[  335.732424] Trying to free free IRQ23
[  337.110714] mantis_pci_probe: <1:>IRQ=23
[  337.118943] mantis_pci_probe: <2:>IRQ=23
[  337.127573] mantis_pci_probe: Got a device
[  337.135847] Unable to handle kernel paging request at virtual address f92bd772
[  337.144907]  printing eip:
[  337.153542] c013e87f
[  337.162663] *pde = 37ecf067
[  337.171417] *pte = 00000000
[  337.180682] Oops: 0000 [#1]
[  337.189583] SMP 
[  337.198762] Modules linked in: mantis i2c_core mb86a15 dvb_core 3c59x piix sd_mod
[  337.208187] CPU:    0
[  337.208188] EIP:    0060:[<c013e87f>]    Not tainted VLI
[  337.208189] EFLAGS: 00010286   (2.6.13) 
[  337.235401] EIP is at name_unique+0x2f/0x60
[  337.244234] eax: 00000b4d   ebx: f6594ee0   ecx: 00000001   edx: f678e520
[  337.252586] esi: f92a7773   edi: f92bd772   ebp: f6594ee0   esp: f4a3fdb0
[  337.261383] ds: 007b   es: 007b   ss: 0068
[  337.269415] Process modprobe (pid: 2554, threadinfo=f4a3f000 task=f63e7a20)
[  337.269680] Stack: 00000000 00000017 00000017 c013e92f 00000017 f6594ee0 00000046 000030ec 
[  337.278569]        000030bb c0103a04 000030ec 00000000 000030ec 000030bb 00000296 00000008 
[  337.287187]        00000001 f92bd000 00000000 c0110cca c0429250 00000008 c011cbfd 000030bb 
[  337.296352] Call Trace:
[  337.314072]  [<c013e92f>] register_handler_proc+0x7f/0xe0
[  337.323270]  [<c0103a04>] apic_timer_interrupt+0x1c/0x24
[  337.332356]  [<c0110cca>] smp_call_function+0x11a/0x170
[  337.341707]  [<c011cbfd>] release_console_sem+0x7d/0xc0
[  337.350561]  [<c011ca54>] vprintk+0x194/0x240
[  337.359944]  [<c0110b53>] flush_tlb_all+0x33/0x40
[  337.368978]  [<c013dfc9>] setup_irq+0xd9/0x120
[  337.378465]  [<f92a6000>] mantis_pci_irq+0x0/0x60 [mantis]
[  337.387679]  [<c013e1a5>] request_irq+0x85/0xa0
[  337.397350]  [<f92a6238>] mantis_pci_probe+0x138/0x3e0 [mantis]
[  337.406839]  [<f92a6000>] mantis_pci_irq+0x0/0x60 [mantis]
[  337.416374]  [<c020f38f>] __pci_device_probe+0x5f/0x70
[  337.426156]  [<c020f3cf>] pci_device_probe+0x2f/0x50
[  337.435457]  [<c0247c38>] driver_probe_device+0x38/0xb0
[  337.445227]  [<c0247d30>] __driver_attach+0x0/0x60
[  337.454521]  [<c0247d80>] __driver_attach+0x50/0x60
[  337.464090]  [<c0247219>] bus_for_each_dev+0x69/0x80
[  337.473215]  [<c0247db5>] driver_attach+0x25/0x30
[  337.482410]  [<c0247d30>] __driver_attach+0x0/0x60
[  337.492096]  [<c024776d>] bus_add_driver+0x8d/0xe0
[  337.501394]  [<c020f69b>] pci_register_driver+0x7b/0xa0
[  337.511118]  [<f92a65cf>] mantis_pci_init+0xf/0x20 [mantis]
[  337.520399]  [<c0139032>] sys_init_module+0x162/0x200
[  337.530161]  [<c0102f5f>] sysenter_past_esp+0x54/0x75
[  337.539433] Code: 44 24 10 8b 5c 24 14 c1 e0 07 8b 90 88 18 42 c0 85 d2 74 33 90 8d b4 26 00 00 00 00 39 da 74 20 8b 7a 0c 85 ff 74 19 8b 73 0c ac <ae> 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 31 c9 85 c0 74 0c 
[  337.560185]  


-----------------------------------------------------------------
#include <asm/io.h>
#include <asm/pgtable.h>
#include <asm/page.h>
#include <linux/interrupt.h>
#include <linux/kmod.h>
#include <linux/vmalloc.h>
#include <linux/init.h>
#include <linux/sched.h>
#include <linux/device.h>
#include "mantis_common.h"
#include "mantis_dma.h"
#include "mantis_i2c.h"
#include "mantis_eeprom.h"

unsigned int verbose = 1;
module_param(verbose, int, 0644);
MODULE_PARM_DESC(verbose, "verbose startup messages, default is 1 (yes)");

#define PCI_VENDOR_ID_MANTIS            0x1822
#define PCI_DEVICE_ID_MANTIS_R11        0x4e35
#define DRIVER_NAME                "Mantis"

static struct pci_device_id mantis_pci_table[] = {
    { PCI_DEVICE(PCI_VENDOR_ID_MANTIS, PCI_DEVICE_ID_MANTIS_R11) },
    { 0 },
};

MODULE_DEVICE_TABLE(pci, mantis_pci_table);

static irqreturn_t mantis_pci_irq(int irq, void *dev_id, struct pt_regs 
*regs)
{
    struct mantis_pci *mantis;
   
    dprintk(verbose, MANTIS_DEBUG, 1, "Mantis PCI IRQ");
    mantis = (struct mantis_pci *) dev_id;
    if (mantis == NULL)
        dprintk(verbose, MANTIS_DEBUG, 1, "Aeio, mantis ISR");
   
    /*    Events
     *    (1) PCMCIA insert
     *    (2) PCMCIA extract
     *    (3) I2C complete
     */
/*   
    return IRQ_HANDLED;
*/
    return IRQ_NONE;    // temporary, for now
}

static int mantis_i2c_setup(struct mantis_pci *mantis)
{
    u32 config = 0;
   
//    mmwrite(0x80, MANTIS_DMA_CTL); // MCU i2c read
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
        INT_MASK=0x%04x, I2C_DATA=0x%04x", ctlreg, intstat,        \
        intmask, i2cdata);
   
    return 0;
}

static int __devinit mantis_pci_probe(struct pci_dev *pdev,
                const struct pci_device_id *mantis_pci_table)
{
    u8 revision, latency;
//    u8 data[2];   
    struct mantis_pci *mantis;
   
    dprintk(verbose, MANTIS_ERROR, 1, "<1:>IRQ=%d", pdev->irq);
    if (pci_enable_device(pdev)) {
        dprintk(verbose, MANTIS_ERROR, 1, "Mantis PCI enable failed");
        goto err;       
    }
    dprintk(verbose, MANTIS_ERROR, 1, "<2:>IRQ=%d", pdev->irq);

    mantis = (struct mantis_pci *)
                kmalloc(sizeof (struct mantis_pci), GFP_KERNEL);
    if (mantis == NULL) {
        dprintk(verbose, MANTIS_ERROR, 1, "Out of memory");
        return -ENOMEM;
    }
    dprintk(verbose, MANTIS_ERROR, 1, "Got a device");
    mantis->mantis_addr = pci_resource_start(pdev, 0);
    if (!request_mem_region(pci_resource_start(pdev, 0),
        pci_resource_len(pdev, 0), DRIVER_NAME)) {
        dprintk(verbose, MANTIS_ERROR, 1, "Request mem region failed");
        goto err0;
    }
    if ((mantis->mantis_mmio =
                ioremap(mantis->mantis_addr, 0x1000)) == NULL) {
        dprintk(verbose, MANTIS_ERROR, 1, "IO remap failed");
        goto err1;
    }
    mmwrite(0, MANTIS_INT_STAT);
    if (request_irq(pdev->irq, mantis_pci_irq, SA_SHIRQ |
                SA_INTERRUPT, DRIVER_NAME, mantis) < 0) {
        dprintk(verbose, MANTIS_ERROR, 1, "Mantis IRQ reg failed");
        goto err2;
    }
    dprintk(verbose, MANTIS_DEBUG, 1, "We got an IRQ");
    dprintk(verbose, MANTIS_DEBUG, 1, "We finally enabled the device");
    pci_set_master(pdev);
    pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &latency);
    pci_read_config_byte(pdev, PCI_CLASS_REVISION, &revision);
    mantis->latency = latency;
    mantis->revision = revision;
    if (!latency) {
        pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 32);
    }
    pci_set_drvdata(pdev, mantis);   
    dprintk(verbose, MANTIS_ERROR, 0, "Mantis Rev %d, ", mantis->revision);
    dprintk(verbose, MANTIS_ERROR, 0, "irq: %d, latency: %d\n \
        memory: 0x%04x, mmio: %p\n", pdev->irq, mantis->latency,    \
        mantis->mantis_addr, mantis->mantis_mmio);
   
    return 0;   
err2:
    if (mantis->mantis_mmio)
        iounmap(mantis->mantis_mmio);
err1:
    release_mem_region(pci_resource_start(pdev, 0),
                pci_resource_len(pdev, 0));
err0:
    kfree(mantis);
err:
    return -ENODEV;
}

static void __devexit mantis_pci_remove(struct pci_dev *pdev)
{
    struct mantis_pci *mantis = pci_get_drvdata(pdev);
    if (mantis == NULL) {
        dprintk(verbose, MANTIS_ERROR, 1, "Aeio, MAntis NULL ptr");
        return;
    }
    dprintk(verbose, MANTIS_ERROR, 1, "Removing -->Mantis irq: %d, \
        latency: %d\n memory: 0x%04x, mmio: 0x%p",
        pdev->irq, mantis->latency, mantis->mantis_addr,
        mantis->mantis_mmio);

    free_irq(pdev->irq, pdev);
//    release_mem_region(pci_resource_start(pdev, 0),
//        pci_resource_len(pdev, 0));
    pci_release_regions(pdev);
    pci_set_drvdata(pdev, NULL);
    pci_disable_device(pdev);
    kfree(mantis);
}

static struct pci_driver mantis_pci_driver = {
    .name = "Mantis PCI combo driver",
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

Manu




