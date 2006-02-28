Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751872AbWB1BER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbWB1BER (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 20:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbWB1BER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 20:04:17 -0500
Received: from smtpq3.groni1.gr.home.nl ([213.51.130.202]:40102 "EHLO
	smtpq3.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1751872AbWB1BEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 20:04:16 -0500
Message-ID: <4403A1CD.6030203@keyaccess.nl>
Date: Tue, 28 Feb 2006 02:05:17 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org, ambx1@neo.rr.com
Subject: Re: Linux v2.6.16-rc5
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>	<4403586C.2020004@keyaccess.nl> <20060227145120.0712eaac.akpm@osdl.org> <44038BFE.6090907@keyaccess.nl>
In-Reply-To: <44038BFE.6090907@keyaccess.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:

> All ALSA ISA card drivers, not just CS4236, use the same interface to 
> PnP (the pnp_card_driver struct) meaning they would all appear to be 
> broken in that exact same way as well. Or rather, _any_ ISA-PnP driver 
> using that pnp_card_driver interface (there's also drivers using the 
> pnp_driver interface -- those appear to be okay). CS4236 isn't doing 
> anything special...

If it helps any, I can at least confirm that it's nothing ALSA or CS4236 
specific. This is a minimal, skeleton, pnp_card driver:

=== foo.c

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/pnp.h>

MODULE_LICENSE("GPL");

static struct pnp_card_device_id foo_pnp_card_device_id_table[] = {
         { .id = "CSCa836", .devs = { { "CSCa800" } } },
         /* --- */
         { .id = "" }
};

MODULE_DEVICE_TABLE(pnp_card, foo_pnp_card_device_id_table);

static int foo_pnp_probe(struct pnp_card_link *pcard,
	const struct pnp_card_device_id *pid)
{
         struct pnp_dev *pdev;

         printk(KERN_INFO "%s\n", __FUNCTION__);

         pdev = pnp_request_card_device(pcard, pid->devs[0].id, NULL);
         if (!pdev || pnp_activate_dev(pdev) < 0)
                 return -ENODEV;

         // allocate, enable.

         return 0;
}

static void foo_pnp_remove(struct pnp_card_link *pcard)
{
         printk(KERN_INFO "%s\n", __FUNCTION__);

         // disable, deallocate.
}

static struct pnp_card_driver foo_pnp_card_driver = {
         .name           = "foo",
         .id_table       = foo_pnp_card_device_id_table,
         .flags          = PNP_DRIVER_RES_DISABLE,
         .probe          = foo_pnp_probe,
         .remove         = foo_pnp_remove
};

int __init foo_init(void)
{
         return pnp_register_card_driver(&foo_pnp_card_driver);
}

void __exit foo_exit(void)
{
         pnp_unregister_card_driver(&foo_pnp_card_driver);
}

module_init(foo_init);
module_exit(foo_exit);

===

compile with

=== Makefile

ifneq ($(KERNELRELEASE),)

obj-m   := foo.o

else

default:
         $(MAKE) -C /lib/modules/$(shell uname -r)/build M=$(shell pwd)

clean:
         $(MAKE) -C /lib/modules/$(shell uname -r)/build M=$(shell pwd) 
clean

endif

===

This ofcourse needs ISA-PnP support in the kernel, and actually loading 
it requires replacing the PnP IDs with IDs actually present (these are 
from my CS4236 soundcard).

With 2.6.15.4 and with 2.6.16-rc with Adam's fix applied, an "insmod 
foo.ko && rmmod foo" shows the following in dmesg (this needs the PnP 
debug messages selectable in menuconfig):

   pnp: the driver 'foo' has been registered
   foo_pnp_probe
   pnp: match found with the PnP device '01:01.00' and the driver 'foo'
   pnp: Device 01:01.00 activated.
   foo_pnp_remove
   pnp: Device 01:01.00 disabled.
   pnp: the driver 'foo' has been unregistered

which is as it should be. On 2.6.16-rc without Adam's fix, both the 
"pnp: match found with" and the "foo_pnp_remove" lines are missing:

   pnp: the driver 'foo' has been registered
   foo_pnp_probe
   pnp: Device 01:01.00 activated.
   pnp: Device 01:01.00 disabled.
   pnp: the driver 'foo' has been unregistered

Of course, with this skeleton driver that's not much of a problem, but 
in real drivers it certainly is; in pnp_remove you'd deactivate and 
deallocate anything that was allocated and activated in/through the 
pnp_probe method -- all things associated with this instance of the 
card, normally.

I can also confirm that a driver using the "pnp_driver" interface isn't 
affected by the bug. Same skeleton-type driver:

=== bar.c

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/pnp.h>

MODULE_LICENSE("GPL");

static struct pnp_device_id bar_pnp_device_id_table[] = {
         { .id = "CSCa800" },
         /* --- */
         { .id = "" }
};

MODULE_DEVICE_TABLE(pnp, bar_pnp_device_id_table);

static int bar_pnp_probe(struct pnp_dev *pdev,
	const struct pnp_device_id *pid)
{
         printk(KERN_INFO "%s\n", __FUNCTION__);

         if (pnp_activate_dev(pdev) < 0)
                 return -ENODEV;

         // allocate, enable.

         return 0;
}

static void bar_pnp_remove(struct pnp_dev *pdev)
{
         printk(KERN_INFO "%s\n", __FUNCTION__);

         // disable, deallocate.
}

static struct pnp_driver bar_pnp_driver = {
         .name           = "bar",
         .id_table       = bar_pnp_device_id_table,
         .flags          = PNP_DRIVER_RES_DISABLE,
         .probe          = bar_pnp_probe,
         .remove         = bar_pnp_remove
};

int __init bar_init(void)
{
         return pnp_register_driver(&bar_pnp_driver);
}

void __exit bar_exit(void)
{
         pnp_unregister_driver(&bar_pnp_driver);
}

module_init(bar_init);
module_exit(bar_exit);

===

2.6.15.4, 2.6.16-rc with or without Adam's fix:

   pnp: the driver 'bar' has been registered
   pnp: match found with the PnP device '01:01.00' and the driver 'bar'
   bar_pnp_probe
   pnp: Device 01:01.00 activated.
   bar_pnp_remove
   pnp: Device 01:01.00 disabled.
   pnp: the driver 'bar' has been unregistered

So that's all fine. As said though, all ALSA drivers for one are using 
the card_driver interface, and are therefore all broken currently.

Rene.

