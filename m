Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129546AbQKEBbz>; Sat, 4 Nov 2000 20:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129247AbQKEBbp>; Sat, 4 Nov 2000 20:31:45 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:45749 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129034AbQKEBbd>; Sat, 4 Nov 2000 20:31:33 -0500
Message-ID: <3A04B7D7.6B47B503@uow.edu.au>
Date: Sun, 05 Nov 2000 12:28:55 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        "Hen, Shmulik" <shmulik.hen@intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: Re: Locking Between User Context and Soft IRQs in 2.4.0
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B27077@hasmsx52.iil.intel.com> <3A03DABD.AF4B9AD5@mandrakesoft.com> <20001104111909.A11500@gruyere.muc.suse.de> <3A042D04.5B3A7946@mandrakesoft.com> <20001104175659.A15475@gruyere.muc.suse.de> <3A044256.D8CD063C@mandrakesoft.com>,
		<3A044256.D8CD063C@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Nov 04, 2000 at 12:07:34PM -0500 <20001105013809.B21900@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Sat, Nov 04, 2000 at 12:07:34PM -0500, Jeff Garzik wrote:
> > Andi Kleen wrote:
> > > All the MOD_INC/DEC_USE_COUNT are done inside the modules themselves. There
> > > is nothing that would a driver prevent from being unloaded on a different
> > > CPU while it is already executing in ->open but has not yet executed the add
> > > yet or after it has executed the _DEC but it is still running in module code
> > > Normally the windows are pretty small, but very long running interrupt
> > > on one CPU hitting exactly in the wrong moment can change that.
> >
> > Module unload calls unregister_netdev, which grabs rtnl_lock.
> > dev->open runs under rtnl_lock.
> >
> > Given this, how can the driver be unloaded if dev->open is running?
> 
> It does not help, because when the semaphore synchronizes it is already
> too late -- free_module already did the zero module count check and
> nothing is going to stop it from unloading.

aaarrrggh!!!

          CPU0                              CPU1

        rtnl_lock()
         dev_ifsioc()
          dev_change_flags()
           dev_open();
            dev->open();
            vortex_open()
                                        sys_delete_module()
                                        if (!__MOD_IN_USE)
                                         free_module()
                                          mod->cleanup()
                                          vortex_cleanup()
                                           pci_unregister_driver()
            [ time passes ]                 drv->remove();
                                            vortex_remove_one()
                                             unregister_netdev()
                                              unregister_netdevice()
                                              rtnl_lock()        /* blocks */
            ...
            MOD_INC_USE_COUNT;
            ...
        rtnl_unlock()
                                              ...
                                         module_unmap();        /* Not good */


We can't even fix this with a lock_kernel wrapped around
the dev->owner stuff in dev_open(), because the netdevice's
open() can sleep.

<subliminalmessage>prumpf's patch</sumliminalmessage>

Perhaps the best thing to do here is to create a system-wide
semaphore for module unloading. So we do a down()/up()
in sys_delete_module() and do this in dev_open:

        /*
         *      Call device private open method
         */

        down(&mod_unload_sem);                  /* sync with sys_delete_module() */
        if (dev->owner == 0) {
                if (dev->open)
                        ret = dev->open(dev);
        } else {
                if (try_inc_mod_count(dev->owner)) {
                        if (dev->open) {
                                if ((ret = dev->open(dev)) != 0)
                                        __MOD_DEC_USE_COUNT(dev->owner);
                        }
                } else
                        ret = -ENODEV;
        }
        up(&mod_unload_sem);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
