Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263851AbUECSqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUECSqi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 14:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263864AbUECSqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 14:46:38 -0400
Received: from pochacco.sd.dreamhost.com ([66.33.206.17]:40362 "EHLO
	pochacco.sd.dreamhost.com") by vger.kernel.org with ESMTP
	id S263851AbUECSqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 14:46:02 -0400
Message-ID: <3580.171.64.70.92.1083609961.spork@webmail.coverity.com>
Date: Mon, 3 May 2004 11:46:01 -0700 (PDT)
Subject: [CHECKER] Resource leaks in driver shutdown functions
From: "Ken Ashcraft" <ken@coverity.com>
To: linux-kernel@vger.kernel.org, linux@coverity.com
Cc: linux-ns83820@kvack.org, alfred@ccac.rwth-aachen.de, aarnold@elsa.de,
       sailer@ife.ee.ethz.ch, maxk@qualcomm.com, andrew.grover@intel.com,
       paul.s.diefenbaugh@intel.com, webvenza@libero.it, acme@conectiva.com.br,
       niemeyer@conectiva.com, becker@scyld.com, weisd3458@uni.edu,
       thorn@daimi.aau.dk, hiro@sanpo.t.u-tokyo.ac.jp, gw4pts@gw4pts.ampr.org,
       100136.3530@compuserve.com, gniibe@mri.co.jp, zimerman@mailandnews.com
Reply-To: ken@coverity.com
User-Agent: DreamHost Webmail
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When device drivers have constructor (ctor) functions that allocate
resources, those resources must be freed in the corresponding destructor
(dtor) functions.  What I've done is pair ctor/dtor functions where I
could in the drivers (i.e. init/shutdown, open/close, attach/detach, etc.)
and then found functions like request_irq/free_irq that should be paired
within those ctor/dtor pairs.  Any dtor that doesn't free a resource
allocated in the ctor is marked as an error.  The resource allocation line
numbers are given in the error messages.

The resource allocation/freeing functions in question below are:
irq_request/free_irq
netif_start_queue/netif_stop_queue
kmalloc/kfree
ei_open/ei_close
netif_device_attach/netif_device_detach
parport_register_device/parport_unregister_device

If these functions do not always need to be paired, I would appreciate an
explanation.

This is an experimental checker, so be warned that these reports are not
necessarily valid.

If you are CC'd on this email, it is because I think you are the
maintainer for some of the code below.  Search for your email address
below to find it.

Thanks for your feedback,
Ken Ashcraft

#  Total 				  = 14
# BUGs	|	File Name
1	|	/drivers/acpi/thermal.c
1	|	/drivers/usb/serial/ir-usb.c
1	|	/drivers/net/wireless/wl3501_cs.c
1	|	/drivers/net/sis900.c
1	|	/drivers/net/ns83820.c
1	|	/drivers/net/smc-ultra32.c
1	|	/drivers/net/tokenring/lanstreamer.c
1	|	/drivers/net/hamradio/hdlcdrv.c
1	|	/drivers/net/plip.c
1	|	/drivers/net/smc-mca.c
1	|	/drivers/net/smc-ultra.c
1	|	/drivers/bluetooth/hci_vhci.c
1	|	/drivers/net/ibmlana.c
1	|	/drivers/net/rcpci45.c
---------------------------------------------------------
[BUG] Pete Popov and Brian Moyle, ported by Alan Cox
/home/kash/linux/2.6.3/linux-2.6.3/drivers/net/rcpci45.c:731:RCclose:ERROR:INTERFACE_A_B:
Not calling free_irq. See RCopen:339 [COUNTER=request_irq-free_irq]
[fit=1] [fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=97] [counter=2] [z =
4.47241827790349] [fn-z = -2]
	} else
		printk (KERN_WARNING "%s: unexpected timer irq\n", dev->name);
}

static int

Error --->
RCclose (struct net_device *dev)
{
	PDPA pDpa = dev->priv;

---------------------------------------------------------
[BUG] linux-ns83820@kvack.org
/home/kash/linux/2.6.3/linux-2.6.3/drivers/net/ns83820.c:1385:ns83820_stop:ERROR:INTERFACE_A_B:
Not calling netif_stop_queue. See ns83820_open:1507
[COUNTER=netif_start_queue-netif_stop_queue] [fit=2] [fit_fn=3] [fn_ex=0]
[fn_counter=1] [ex=99] [counter=5] [z = 3.87329366897913] [fn-z = -2]
		schedule();
	} while (readl(dev->base + CR) & which);
	Dprintk("okay!\n");
}


Error --->
static int ns83820_stop(struct net_device *ndev)
{
	struct ns83820 *dev = PRIV(ndev);

---------------------------------------------------------
[BUG] alfred@ccac.rwth-aachen.de, aarnold@elsa.de
/home/kash/linux/2.6.3/linux-2.6.3/drivers/net/ibmlana.c:799:ibmlana_close:ERROR:INTERFACE_A_B:
Not calling netif_stop_queue. See ibmlana_open:793
[COUNTER=netif_start_queue-netif_stop_queue] [fit=2] [fit_fn=4] [fn_ex=0]
[fn_counter=1] [ex=99] [counter=5] [z = 3.87329366897913] [fn-z = -2]
	return 0;
}

/* close driver.  Shut down board and free allocated resources */


Error --->
static int ibmlana_close(struct net_device *dev)
{
	/* turn off board */

---------------------------------------------------------
[BUG] sailer@ife.ee.ethz.ch
/home/kash/linux/2.6.3/linux-2.6.3/drivers/net/hamradio/hdlcdrv.c:582:hdlcdrv_close:ERROR:INTERFACE_A_B:
Not calling netif_stop_queue. See hdlcdrv_open:573
[COUNTER=netif_start_queue-netif_stop_queue] [fit=2] [fit_fn=5] [fn_ex=0]
[fn_counter=1] [ex=99] [counter=5] [z = 3.87329366897913] [fn-z = -2]
/* --------------------------------------------------------------------- */
/*
 * The inverse routine to hdlcdrv_open().
 */


Error --->
static int hdlcdrv_close(struct net_device *dev)
{
	struct hdlcdrv_state *s;
	int i = 0;
---------------------------------------------------------
[BUG]
/home/kash/linux/2.6.3/linux-2.6.3/drivers/usb/serial/ir-usb.c:329:ir_close:ERROR:INTERFACE_A_B:
Not calling kfree. See ir_open:293 [COUNTER=kmalloc-kfree] [fit=3]
[fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=105] [counter=13] [z =
2.43952273743055] [fn-z = -2]
		dev_err(&port->dev, "%s - failed submitting read urb, error %d\n",
__FUNCTION__, result);

	return result;
}


Error --->
static void ir_close (struct usb_serial_port *port, struct file * filp)
{
	struct usb_serial *serial;

---------------------------------------------------------
[BUG] maxk@qualcomm.com looks like a leak of private_data
/home/kash/linux/2.6.3/linux-2.6.3/drivers/bluetooth/hci_vhci.c:300:hci_vhci_chr_close:ERROR:INTERFACE_A_B:
Not calling kfree. See hci_vhci_chr_open:269 [COUNTER=kmalloc-kfree]
[fit=3] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=105] [counter=13] [z =
2.43952273743055] [fn-z = -2]

	file->private_data = hci_vhci;
	return 0;
}


Error --->
static int hci_vhci_chr_close(struct inode *inode, struct file *file)
{
	struct hci_vhci_struct *hci_vhci = (struct hci_vhci_struct *)
file->private_data;

---------------------------------------------------------
[BUG] streamer_open has a bunch of memory leaks on error paths too
/home/kash/linux/2.6.3/linux-2.6.3/drivers/net/tokenring/lanstreamer.c:1202:streamer_close:ERROR:INTERFACE_A_B:
Not calling kfree. See streamer_open:774 [COUNTER=kmalloc-kfree] [fit=3]
[fit_fn=10] [fn_ex=0] [fn_counter=1] [ex=105] [counter=13] [z =
2.43952273743055] [fn-z = -2]
		return 1;
	}
}



Error --->
static int streamer_close(struct net_device *dev)
{
	struct streamer_private *streamer_priv =
	    (struct streamer_private *) dev->priv;
---------------------------------------------------------
[BUG] andrew.grover@intel.com, paul.s.diefenbaugh@intel.com
/home/kash/linux/2.6.3/linux-2.6.3/drivers/acpi/thermal.c:1290:acpi_thermal_remove:ERROR:INTERFACE_A_B:
Not calling kfree. See acpi_thermal_add:1243 [COUNTER=kmalloc-kfree]
[fit=3] [fit_fn=7] [fn_ex=0] [fn_counter=1] [ex=105] [counter=13] [z =
2.43952273743055] [fn-z = -2]
	return_VALUE(result);
}


static int

Error --->
acpi_thermal_remove (
	struct acpi_device	*device,
	int			type)
{
---------------------------------------------------------
[BUG] webvenza@libero.it
/home/kash/linux/2.6.3/linux-2.6.3/drivers/net/sis900.c:2191:sis900_suspend:ERROR:INTERFACE_A_B:
Not calling netif_device_detach. See sis900_resume:2229
[COUNTER=netif_device_attach-netif_device_detach] [fit=4] [fit_fn=2]
[fn_ex=0] [fn_counter=1] [ex=18] [counter=2] [z = 1.11803398874989] [fn-z
= -2]
	pci_set_drvdata(pci_dev, NULL);
}

#ifdef CONFIG_PM


Error --->
static int sis900_suspend(struct pci_dev *pci_dev, u32 state)
{
	struct net_device *net_dev = pci_get_drvdata(pci_dev);
	struct sis900_private *sis_priv = net_dev->priv;
---------------------------------------------------------
[BUG] acme@conectiva.com.br, niemeyer@conectiva.com
/home/kash/linux/2.6.3/linux-2.6.3/drivers/net/wireless/wl3501_cs.c:1286:wl3501_close:ERROR:INTERFACE_A_B:
Not calling netif_device_detach. See wl3501_open:1423
[COUNTER=netif_device_attach-netif_device_detach] [fit=4] [fit_fn=1]
[fn_ex=0] [fn_counter=1] [ex=18] [counter=2] [z = 1.11803398874989] [fn-z
= -2]
fail:
	printk(KERN_WARNING "%s: failed!\n", __FUNCTION__);
	goto out;
}


Error --->
static int wl3501_close(struct net_device *dev)
{
	struct wl3501_card *this = dev->priv;
	int rc = -ENODEV;
---------------------------------------------------------
[BUG]
/home/kash/linux/2.6.3/linux-2.6.3/drivers/net/smc-ultra32.c:301:ultra32_close:ERROR:INTERFACE_A_B:
Not calling ei_close. See ultra32_open:297 [COUNTER=ei_open-ei_close]
[fit=9] [fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=13] [counter=3] [z =
0.125] [fn-z = -2]
	outb(0xff, dev->base_addr + EN0_ERWCNT);
	ei_open(dev);
	return 0;
}


Error --->
static int ultra32_close(struct net_device *dev)
{
	int ioaddr = dev->base_addr - ULTRA32_NIC_OFFSET; /* CMDREG */

---------------------------------------------------------
[BUG] becker@scyld.com
/home/kash/linux/2.6.3/linux-2.6.3/drivers/net/smc-ultra.c:511:ultra_close_card:ERROR:INTERFACE_A_B:
Not calling ei_close. See ultra_open:386 [COUNTER=ei_open-ei_close]
[fit=9] [fit_fn=3] [fn_ex=0] [fn_counter=1] [ex=13] [counter=3] [z =
0.125] [fn-z = -2]
	/* An extra odd byte is OK here as well. */
	outsw(ioaddr + IOPD, buf, (count+1)>>1);
}

static int

Error --->
ultra_close_card(struct net_device *dev)
{
	int ioaddr = dev->base_addr - ULTRA_NIC_OFFSET; /* CMDREG */

---------------------------------------------------------
[BUG] weisd3458@uni.edu does the steps of ei_close but in wrong order and
without holding locks
/home/kash/linux/2.6.3/linux-2.6.3/drivers/net/smc-mca.c:432:ultramca_close_card:ERROR:INTERFACE_A_B:
Not calling ei_close. See ultramca_open:365 [COUNTER=ei_open-ei_close]
[fit=9] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=13] [counter=3] [z =
0.125] [fn-z = -2]
	unsigned long shmem = dev->mem_start + ((start_page - START_PG) << 8);

	isa_memcpy_toio(shmem, buf, count);
}


Error --->
static int ultramca_close_card(struct net_device *dev)
{
	int ioaddr = dev->base_addr - ULTRA_NIC_OFFSET; /* ASIC addr */

---------------------------------------------------------
[BUG] (becker@scyld.com, thorn@daimi.aau.dk, hiro@sanpo.t.u-tokyo.ac.jp,
gw4pts@gw4pts.ampr.org, 100136.3530@compuserve.com, gniibe@mri.co.jp,
zimerman@mailandnews.com) parport_unregister_device called in
plip_cleanup_module.  Looks like if we call, plip_attach, plip_detach,
plip_attach, the first nl->pardev is lost
/home/kash/linux/2.6.3/linux-2.6.3/drivers/net/plip.c:1331:plip_detach:ERROR:INTERFACE_A_B:
Not calling parport_unregister_device. See plip_attach:1292
[COUNTER=parport_register_device-parport_unregister_device] [fit=10]
[fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=3] [counter=1] [z = -0.25] [fn-z =
-2]
	return;
}

/* plip_detach() is called (by the parport code) when a port is
 * no longer available to use. */

Error --->
static void plip_detach (struct parport *port)
{
	/* Nothing to do */
}


