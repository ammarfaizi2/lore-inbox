Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131546AbRCUPml>; Wed, 21 Mar 2001 10:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131509AbRCUPmb>; Wed, 21 Mar 2001 10:42:31 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:44264 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S130940AbRCUPmO>;
	Wed, 21 Mar 2001 10:42:14 -0500
Message-ID: <3AB8CB8C.D055FC6E@mandrakesoft.com>
Date: Wed, 21 Mar 2001 10:41:00 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com, Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: PATCH 2.4.3.6: fix netdevice initialization
In-Reply-To: <3AB8BA16.A25C0929@mandrakesoft.com> <3AB8C6EE.5EF6BA90@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> We should propagate dev_alloc_name's return value:
> And register_netdevice's, so

ok


> More significantly, the driver probe functions now become:
> 
> xxx_probe()
> {
>         dev = alloc_etherdev(sizeof(xxx_private));
>         ...
>         printk(KERN_INFO "%s: stuff\n", dev->name);
>         ...
>         ret = register_netdev(dev);
>         if (ret < 0)
>                 kfree(ret);
>         return ret;
> }
> 
> yes?

correct.


> And the printk() will say "eth%d: stuff", so we'll need to
> change the messages:
> 
> -       printk(KERN_INFO "%s: stuff\n", dev->name);
> +       printk(KERN_INFO "xxx: stuff\n");
> 
> Correct?

correct.  For PCI drivers, change to something like

  printk(KERN_INFO "tulip(%s): stuff\n", pci_dev->slot_name);

> My quibble with this is things like wait_for_completion(),
> which are called from both the probe() function and
> the mainline driver code.  These also print dev->name,
> and there's no obvious fix for that.

hrm.  I'm not sure it's necessary to pass driver_name to alloc_etherdev
(to set dev->name), just to be able to reference solely from the driver
during the probe phase.  Further there is a dev->name size limit you
will run into with "myverylongdrivernameskimbosh."

Just pass 'name' arg to wait_for_completion ;-)

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
