Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271798AbRIVQAN>; Sat, 22 Sep 2001 12:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271809AbRIVQAD>; Sat, 22 Sep 2001 12:00:03 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38924 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271798AbRIVP7r>; Sat, 22 Sep 2001 11:59:47 -0400
Subject: Re: [PATCH] 2.4.10-pre13: ATM drivers cause panic
To: tip@prs.de
Date: Sat, 22 Sep 2001 17:04:45 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org),
        laughing@shared-source.org
In-Reply-To: <3BAC93D4.65E17AA6@internetwork-ag.de> from "Till Immanuel Patzschke" at Sep 22, 2001 03:36:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kpGn-0003YQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> seems a couple of spin_lock(s) and a spin_unlock was missing.
> Why didn't this problem show up with earlier releases ???
> Anyways, please find a (quick) patch below. It would be great if this patch or
> any other similar could make it into the next release!

How about

static struct atm_dev *alloc_atm_dev(const char *type)
{
 	struct atm_dev *dev;

	dev = kmalloc(sizeof(*dev),GFP_KERNEL);
	if (!dev) return NULL;
	memset(dev,0,sizeof(*dev));
	dev->type = type;
        dev->signal = ATM_PHY_SIG_UNKNOWN;
        dev->link_rate = ATM_OC3_PCR;
        dev->next = NULL;

        spin_lock(&atm_dev_lock);

        dev->prev = last_dev;

	if (atm_devs) last_dev->next = dev;
	else atm_devs = dev;
	last_dev = dev;
	spin_unlock(&atm_dev_lock);
	return dev;
}

instead. That seems to fix alloc_atm_dev safely. Refcounting wants adding
to atm_dev objects too, its impossible currently to make atm_find_dev
remotely safe

Alan

