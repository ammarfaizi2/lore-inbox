Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265245AbRF0EAp>; Wed, 27 Jun 2001 00:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265242AbRF0EAf>; Wed, 27 Jun 2001 00:00:35 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:42977 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265237AbRF0EAS>;
	Wed, 27 Jun 2001 00:00:18 -0400
Message-ID: <3B395A7A.848908C@mandrakesoft.com>
Date: Wed, 27 Jun 2001 00:00:58 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David T Eger <eger@cc.gatech.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI Power Management / Interrupt Context
In-Reply-To: <Pine.SOL.4.21.0106262208240.3824-100000@oscar.cc.gatech.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David T Eger wrote:
> when I read documentation (Documentation/pci.txt) which mentions that
> remove() can be called from interrupt context.

ignore that.  You can sleep in remove, and it will not be called from
interrupt context.


> Reading code in my sister frame buffer devices, I see that
> unregister_framebuffer() can fail.  I can easily see a nice happy console
> or user app diddling away on the framebuffer writing to the memory on the
> device, and then poof! someone yanks the card, processor takes an
> interrupt, and then... and then?  what to do?

if someone yanks the card, how is it going to deliver an interrupt to
the CPU?


> In fact, here's an interesting snippet from cyber2000fb.c:
> 
> static void __devexit cyberpro_remove(struct pci_dev *dev)
> {
>         struct cfb_info *cfb = (struct cfb_info *)dev->driver_data;
> 
>         if (cfb) {
>         /*
>         * If unregister_framebuffer fails, then
>         * we will be leaving hooks that could cause
>         * oopsen laying around.
>         */
>         if (unregister_framebuffer(&cfb->fb))
>                 printk(KERN_WARNING "%s: danger Will Robinson, "
>                         "danger danger!  Oopsen imminent!\n",
>         cfb->fb.fix.id);
>         cyberpro_unmap_smem(cfb);
>         cyberpro_unmap_mmio(cfb);
>         cyberpro_free_fb_info(cfb);
> 
>         /*
>         * Ensure that the driver data is no longer
>         * valid.
>         */
>         dev->driver_data = NULL;
>         if (cfb == int_cfb_info)
>         int_cfb_info = NULL;
>         }
> }
> 
> So, umm, is there a consensus on what to do if someone currently expects
> to be writing to memory that doesn't exist any more?

huh?  what are you talking about?  oops or random memory corruption
occurs.  there is no consensus necessary.

If you are worried about unregister_framebuffer failure, then don't
deallocate the memory, or sleep until unregister_framebuffer succeeds,
or any one of a number of workarounds.

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
