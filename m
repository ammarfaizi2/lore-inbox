Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270825AbRIVN1u>; Sat, 22 Sep 2001 09:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270257AbRIVN1k>; Sat, 22 Sep 2001 09:27:40 -0400
Received: from [217.6.75.131] ([217.6.75.131]:19931 "EHLO
	mail.internetwork-ag.de") by vger.kernel.org with ESMTP
	id <S270825AbRIVN13>; Sat, 22 Sep 2001 09:27:29 -0400
Message-ID: <3BAC93D4.65E17AA6@internetwork-ag.de>
Date: Sat, 22 Sep 2001 15:36:20 +0200
From: Till Immanuel Patzschke <tip@internetwork-ag.de>
Reply-To: tip@prs.de
Organization: interNetwork AG
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: laughing@shared-source.org
Subject: [PATCH] 2.4.10-pre13: ATM drivers cause panic
In-Reply-To: <E15kU3r-0000bv-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

seems a couple of spin_lock(s) and a spin_unlock was missing.
Why didn't this problem show up with earlier releases ???
Anyways, please find a (quick) patch below. It would be great if this patch or
any other similar could make it into the next release!
Thanks,

Immanuel


diff -Naur net/atm/resources.c.bug net/atm/resources.c
--- net/atm/resources.c.bug     Fri Dec 29 23:35:47 2000
+++ net/atm/resources.c Sat Sep 22 15:31:35 2001
@@ -76,14 +76,17 @@
 {
        struct atm_dev *dev;
 
+       spin_lock (&atm_dev_lock);
        dev = alloc_atm_dev(type);
        if (!dev) {
                printk(KERN_ERR "atm_dev_register: no space for dev %s\n",
                    type);
+               spin_unlock (&atm_dev_lock);
                return NULL;
        }
        if (number != -1) {
                if (atm_find_dev(number)) {
+                       spin_unlock (&atm_dev_lock);
                        free_atm_dev(dev);
                        return NULL;
                }


--
Till Immanuel Patzschke                 mailto: tip@internetwork-ag.de
interNetwork AG                         Phone:  +49-(0)611-1731-121
Bierstadter Str. 7                      Fax:    +49-(0)611-1731-31
D-65189 Wiesbaden                       Web:    http://www.internetwork-ag.de
