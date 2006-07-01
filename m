Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbWGAJlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbWGAJlR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 05:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWGAJlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 05:41:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19423 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932490AbWGAJlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 05:41:16 -0400
Subject: Re: [patch] lockdep, annotate slocks: turn lockdep off for them
From: Arjan van de Ven <arjan@infradead.org>
To: Miles Lane <miles.lane@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Herbert Xu <herbert@gondor.apana.org.au>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <a44ae5cd0606301545s33496174lcd7136d8bf41897@mail.gmail.com>
References: <a44ae5cd0606291201v659b4235sfa9941aa3b18e766@mail.gmail.com>
	 <20060630065041.GB6572@elte.hu> <20060630072231.GB7057@elte.hu>
	 <20060630091850.GA10713@elte.hu>
	 <20060630111734.GA22202@gondor.apana.org.au>
	 <20060630113758.GA18504@elte.hu>
	 <a44ae5cd0606301321y6ce6b7dbo2b405d3d76a670f1@mail.gmail.com>
	 <20060630203804.GA1950@elte.hu>
	 <a44ae5cd0606301545s33496174lcd7136d8bf41897@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 11:41:06 +0200
Message-Id: <1151746867.3195.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-30 at 15:45 -0700, Miles Lane wrote:
> Okay, I rebuilt my kernel with your combo patch applied.
> Then, I inserted my US Robotics USR2210 PCMCIA wifi card,
> ran "pccardutil eject", popped out the card and then inserted
> a Compaq iPaq wifi card.  This triggered the following.
> 
> [ INFO: possible circular locking dependency detected ]
> -------------------------------------------------------
> syslogd/1886 is trying to acquire lock:
>  (&dev->queue_lock){-+..}, at: [<c11a50b5>] dev_queue_xmit+0x120/0x24b
> 
> but task is already holding lock:
>  (&dev->_xmit_lock){-+..}, at: [<c11a5118>] dev_queue_xmit+0x183/0x24b
> 
> which lock already depends on the new lock.


ok this appears to be hostap playing games... it has 2 network devices
for one piece of hardware and one calls the other via the networking
layer; there is thankfully a natural ordering between the two, so just
making the slave one a separate type ought to make this work.

Can you test the patch below?

---
 drivers/net/wireless/hostap/hostap_hw.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: linux-2.6.17-mm4/drivers/net/wireless/hostap/hostap_hw.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/net/wireless/hostap/hostap_hw.c
+++ linux-2.6.17-mm4/drivers/net/wireless/hostap/hostap_hw.c
@@ -3096,6 +3096,14 @@ static void prism2_clear_set_tim_queue(l
 }
 
 
+/*
+ * HostAP uses two layers of net devices, where the inner
+ * layer gets called all the time from the outer layer.
+ * This is a natural nesting, which needs a split lock type.
+ */
+static struct lock_class_key hostap_netdev_xmit_lock_key;
+
+
 static struct net_device *
 prism2_init_local_data(struct prism2_helper_functions *funcs, int card_idx,
 		       struct device *sdev)
@@ -3260,6 +3268,8 @@ while (0)
 	SET_NETDEV_DEV(dev, sdev);
 	if (ret >= 0)
 		ret = register_netdevice(dev);
+
+	lockdep_set_class(&dev->_xmit_lock, &hostap_netdev_xmit_lock_key);
 	rtnl_unlock();
 	if (ret < 0) {
 		printk(KERN_WARNING "%s: register netdevice failed!\n",


