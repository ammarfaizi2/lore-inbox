Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266344AbUGJSbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUGJSbr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 14:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266338AbUGJSbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 14:31:45 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:57867 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266334AbUGJSba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 14:31:30 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: [OOPS] linux-2.6.7-bk20: possible use-after-free in platform_device_unregister()
Date: Sat, 10 Jul 2004 21:31:10 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407102131.10194.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I compile kernels with
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y

Kernel oopsed while probing for devices in depca.c:

static void __init depca_platform_probe (void)
{
        int i;
        struct platform_device *pldev;

        for (i = 0; depca_io_ports[i].iobase; i++) {
                depca_io_ports[i].device = NULL;

                /* if an address has been specified on the command
                 * line, use it (if valid) */
                if (io && io != depca_io_ports[i].iobase)
                        continue;

                if (!(pldev = kmalloc (sizeof (*pldev), GFP_KERNEL)))
                        continue;

                memset (pldev, 0, sizeof (*pldev));
                pldev->name = depca_string;
                pldev->id   = i;
                pldev->dev.platform_data = (void *) depca_io_ports[i].iobase;
                pldev->dev.release       = depca_platform_release;
                depca_io_ports[i].device = pldev;

                if (platform_device_register (pldev)) {
                        kfree (pldev);
                        depca_io_ports[i].device = NULL;
                        continue;
                }

                if (!pldev->dev.driver) {
                /* The driver was not bound to this device, there was
                 * no hardware at this address. Unregister it, as the
                 * release fuction will take care of freeing the
                 * allocated structure */

                        depca_io_ports[i].device = NULL;
===>                    platform_device_unregister (pldev);
                }
        }
}

void platform_device_unregister(struct platform_device * pdev)
{
        int i;

        if (pdev) {
                device_unregister(&pdev->dev);

                for (i = 0; i < pdev->num_resources; i++) {
                        struct resource *r = &pdev->resource[i];
===>                    if (r->flags & (IORESOURCE_MEM|IORESOURCE_IO))
                                release_resource(r);
                }
        }
}

That if() corresponds to "testl  $0x300,0xc(%eax)" instruction in assembler.
%eax == 6b6b6b6b there at that moment (looks like poison). oops.

I verified that pdev->num_resources==0 upon entry to
platform_device_unregister().

device_unregister() must be deallocating *pdev, poisoning
its contents. pdev->num_resources!=0, and pdev->resource[i]
is garbage too.

However, I don't see where does it free *pdev.

Source of device_unregister() is below for easy reference.
--
vda

void device_unregister(struct device * dev)
{
        pr_debug("DEV: Unregistering device. ID = '%s'\n", dev->bus_id);
        device_del(dev);
        put_device(dev);
}

void device_del(struct device * dev)
{
        struct device * parent = dev->parent;

        down_write(&devices_subsys.rwsem);
        if (parent)
                list_del_init(&dev->node);
        up_write(&devices_subsys.rwsem);

        /* Notify the platform of the removal, in case they
         * need to do anything...
         */
        if (platform_notify_remove)
                platform_notify_remove(dev);
        bus_remove_device(dev);
        device_pm_remove(dev);
        kobject_del(&dev->kobj);
        if (parent)
                put_device(parent);
}

