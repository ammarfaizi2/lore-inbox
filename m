Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274272AbRIYA0o>; Mon, 24 Sep 2001 20:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274277AbRIYA0k>; Mon, 24 Sep 2001 20:26:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19850 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274272AbRIYAZq>;
	Mon, 24 Sep 2001 20:25:46 -0400
Date: Mon, 24 Sep 2001 17:26:08 -0700 (PDT)
Message-Id: <20010924.172608.105430357.davem@redhat.com>
To: kash@stanford.edu
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
Subject: Re: [CHECKER] two probable security holes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.31.0109181355560.15933-100000@saga18.Stanford.EDU>
In-Reply-To: <Pine.GSO.4.31.0109181355560.15933-100000@saga18.Stanford.EDU>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ken Ashcraft <kash@stanford.edu>
   Date: Tue, 18 Sep 2001 14:29:57 -0700 (PDT)

   Watch ifr.ifr_name.
   
Hi Ken, I believe there is some bug in your new checker algorithms for
this case.

                   struct ifreq ifr;
                   int err;
   Start--->
                   if (copy_from_user(&ifr, (void *)arg, sizeof(ifr)))
                           return -EFAULT;
                   ifr.ifr_name[IFNAMSIZ-1] = '\0';

ifreq copied safely to kernel space, ifr.ifr_name[] is inside the
struct and NOT a user pointer.

                   err = tun_set_iff(file, &ifr);

Pass address of kernel ifreq.

                   if (*ifr->ifr_name)
                           name = ifr->ifr_name;
   
                   if ((err = dev_alloc_name(&tun->dev, name)) < 0)
                           goto failed;

Perfectly fine still, name always points to kernel memory.
   
   int dev_alloc_name(struct net_device *dev, const char *name)
   {
 ...

           for (i = 0; i < 100; i++) {
   Error--->
   	       sprintf(buf,name,i);

Still fine, as stated "name" is pointing to kernel memory.

Perhaps your code is being confused by "ifreq->if_name" being
an array.

Franks a lot,
David S. Miller
davem@redhat.com
