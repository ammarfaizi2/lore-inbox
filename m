Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129109AbQKFJ4g>; Mon, 6 Nov 2000 04:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129094AbQKFJ41>; Mon, 6 Nov 2000 04:56:27 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:20928 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129050AbQKFJ4L>; Mon, 6 Nov 2000 04:56:11 -0500
Message-ID: <3A068025.38D62785@uow.edu.au>
Date: Mon, 06 Nov 2000 20:55:49 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Gortmaker <p_gortmaker@yahoo.com>
CC: Keith Owens <kaos@ocs.com.au>, Andi Kleen <ak@suse.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "Hen, Shmulik" <shmulik.hen@intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: Re: Locking Between User Context and Soft IRQs in 2.4.0
In-Reply-To: Your message of "Sun, 05 Nov 2000 14:39:43 +1100."
			             <9277.973395583@ocs3.ocs-net> <9368.973396061@ocs3.ocs-net> <3A054872.8D88EF95@uow.edu.au> <3A06155C.796995DD@yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Gortmaker wrote:
> 
> Assuming that nobody has all the MOD_..._USE_COUNT things culled
> from a tree somewhere already, I quickly hacked up the following
> script for drivers/net:

Looks good.  There's also drivers/isdn and possibly other places.

> ...
> We might want to filter the file list created by grep against VERSION_CODE
> as people with that in their driver(s) probably don't want the wholesale
> deletion of MOD_*_COUNT. (OTOH, drivers that have VERSION_CODE that
> supports 2.0.38 or oddball 2.3.x versions could probably be pruned...)

I think you're right.  eepro100 and acenic seriously care about 2.2-compatibility
but AFAICT the others just pretend to.

> That still leaves the addition of dev->owner = THIS_MODULE into
> each device probe.  One *hackish* way to do this without having to
> deal with each driver could be something like this in netdevice.h
> 
> - extern void ether_setup(struct net_device *dev);
> + extern void __ether_setup(struct net_device *dev);
> + static inline void ether_setup(struct net_device *dev){
> +       dev->owner = THIS_MODULE;
> +       __ether_setup(dev);
> + }
> 
> Ugh. Probably should just add it to each probe and be done with it...

mm..  Seeing as failure to set dev->owner is a fatal mistake,
it would be good to enforce this via the compiler type system.

How about making THIS_MODULE an argument to register_netdevice()
and, hence, register_netdev() and init_etherdev()?

> Paul. (aka. monkey #937)

:)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
