Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273832AbRIXJjG>; Mon, 24 Sep 2001 05:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273833AbRIXJi5>; Mon, 24 Sep 2001 05:38:57 -0400
Received: from [217.6.75.131] ([217.6.75.131]:38368 "EHLO
	mail.internetwork-ag.de") by vger.kernel.org with ESMTP
	id <S273832AbRIXJiq>; Mon, 24 Sep 2001 05:38:46 -0400
Message-ID: <3BAF0133.573EF0B7@internetwork-ag.de>
Date: Mon, 24 Sep 2001 11:47:31 +0200
From: Till Immanuel Patzschke <tip@internetwork-ag.de>
Reply-To: tip@prs.de
Organization: interNetwork AG
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: tip@prs.de, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        laughing@shared-source.org
Subject: Re: [PATCH] 2.4.10-pre13: ATM drivers cause panic
In-Reply-To: <E15kpGn-0003YQ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm - patch works fine for me - no sleeps! The only spin_lock(&atm_dev_lock)
statement in my resource.c (the original from 2.4.10-pre13) is in free_atm_dev
BUT the problem is the unmatched spin_unlock(&atm_dev_lock) statements in
atm_dev_register...
Why not just protecting the atm_dev_queue in alloc_atm_dev, atm_find_dev, and
atm_free_dev individually PLUS removing the two spin_unlock statements in
atm_dev_register.

What do you think

(This is diffs from 2.4.10-pre13 ! BTW: Still the same in 2.4.10)

--- resources.c.bug     Fri Dec 29 23:35:47 2000
+++ resources.c.new     Mon Sep 24 11:39:42 2001
@@ -36,13 +36,16 @@
        if (!dev) return NULL;
        memset(dev,0,sizeof(*dev));
        dev->type = type;
-       dev->prev = last_dev;
        dev->signal = ATM_PHY_SIG_UNKNOWN;
        dev->link_rate = ATM_OC3_PCR;
        dev->next = NULL;
+
+       spin_lock(&atm_dev_lock);
+       dev->prev = last_dev;
        if (atm_devs) last_dev->next = dev;
        else atm_devs = dev;
        last_dev = dev;
+       spin_unlock(&atm_dev_lock);
        return dev;
 }

@@ -65,9 +68,13 @@
 {
        struct atm_dev *dev;

+       spin_lock(&atm_dev_lock);
        for (dev = atm_devs; dev; dev = dev->next)
-               if (dev->ops && dev->number == number) return dev;
-       return NULL;
+               if (dev->ops && dev->number == number) goto done;
+       dev=(atm_dev *)NULL;
+ done:
+       spin_unlock(&atm_dev_lock);
+       return dev;
 }


@@ -105,12 +112,10 @@
                if (atm_proc_dev_register(dev) < 0) {
                        printk(KERN_ERR "atm_dev_register: "
                            "atm_proc_dev_register failed for dev %s\n",type);
-                       spin_unlock (&atm_dev_lock);
                        free_atm_dev(dev);
                        return NULL;
                }
 #endif
-       spin_unlock (&atm_dev_lock);
        return dev;
 }



Alan Cox wrote:

> > seems a couple of spin_lock(s) and a spin_unlock was missing.
> > Why didn't this problem show up with earlier releases ???
> > Anyways, please find a (quick) patch below. It would be great if this patch or
> > any other similar could make it into the next release!
>
> How about
>
> static struct atm_dev *alloc_atm_dev(const char *type)
> {
>         struct atm_dev *dev;
>
>         dev = kmalloc(sizeof(*dev),GFP_KERNEL);
>         if (!dev) return NULL;
>         memset(dev,0,sizeof(*dev));
>         dev->type = type;
>         dev->signal = ATM_PHY_SIG_UNKNOWN;
>         dev->link_rate = ATM_OC3_PCR;
>         dev->next = NULL;
>
>         spin_lock(&atm_dev_lock);
>
>         dev->prev = last_dev;
>
>         if (atm_devs) last_dev->next = dev;
>         else atm_devs = dev;
>         last_dev = dev;
>         spin_unlock(&atm_dev_lock);
>         return dev;
> }
>
> instead. That seems to fix alloc_atm_dev safely. Refcounting wants adding
> to atm_dev objects too, its impossible currently to make atm_find_dev
> remotely safe
>
> Alan

--
Till Immanuel Patzschke                 mailto: tip@internetwork-ag.de
interNetwork AG                         Phone:  +49-(0)611-1731-121
Bierstadter Str. 7                      Fax:    +49-(0)611-1731-31
D-65189 Wiesbaden                       Web:    http://www.internetwork-ag.de



