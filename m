Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129705AbQKEDkK>; Sat, 4 Nov 2000 22:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129689AbQKEDkA>; Sat, 4 Nov 2000 22:40:00 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:1555 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129625AbQKEDju>;
	Sat, 4 Nov 2000 22:39:50 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Andi Kleen <ak@suse.de>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        "Hen, Shmulik" <shmulik.hen@intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: Re: Locking Between User Context and Soft IRQs in 2.4.0 
In-Reply-To: Your message of "Sun, 05 Nov 2000 12:28:55 +1100."
             <3A04B7D7.6B47B503@uow.edu.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 05 Nov 2000 14:39:43 +1100
Message-ID: <9277.973395583@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Nov 2000 12:28:55 +1100, 
Andrew Morton <andrewm@uow.edu.au> wrote:
>          CPU0                              CPU1
>
>        rtnl_lock()
>         dev_ifsioc()
>          dev_change_flags()
>           dev_open();
>            dev->open();
>            vortex_open()
>                                        sys_delete_module()
>                                        if (!__MOD_IN_USE)
>                                         free_module()

If dev->open() calls try_inc_use_count() before it enters the module
you will lock out concurrent module unload via module unload_lock.
There is no need for another module semaphore.

Also there is no need to test dev->owner, try_inc_use_count() already
does that.

        /*
         *      Call device private open method
         */

	ret = -ENODEV;
	if (try_inc_mod_count(dev->owner)) {
		if (dev->open && (ret = dev->open(dev)) && dev->owner)
			__MOD_DEC_USE_COUNT(dev->owner);
	}

In dev_close()

        /*
         *      Call device private close method
         */

	if (dev->owner)
		__MOD_DEC_USE_COUNT(dev->owner);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
