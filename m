Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310306AbSCGWNb>; Thu, 7 Mar 2002 17:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310251AbSCGWNV>; Thu, 7 Mar 2002 17:13:21 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:48539 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S310231AbSCGWNG>; Thu, 7 Mar 2002 17:13:06 -0500
Message-Id: <5.1.0.14.2.20020307141124.084dbde8@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 07 Mar 2002 14:11:37 -0800
To: Robert Love <rml@tech9.net>, Frode Isaksen <fisaksen@bewan.com>
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: [PATCH] ATM locking fix. [Re: [PATCH] spinlock not locked when
  unlocking in atm_dev_register]
Cc: mitch@sfgoth.com, linux-kernel@vger.kernel.org,
        marcelo Tosatti <marcelo@conectiva.com.br>, alan@redhat.com,
        alan@lxorguk.ukuu.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

Some time ago I promised a patch that fixes ATM device allocation code.
Fix that Alan's got in his 2.4.19-pre2-ac3 is wrong because it just removes 
locking instead of fixing it.
So here goes my patch. Tested on dual Athlon box.

Marcelo, Alan, please apply.

Patch URL:
	http://bluez.sf.net/atm.patch-2.4.19-pre2.gz


--- linux/net/atm/resources.c.orig	Thu Mar  7 13:56:00 2002
+++ linux/net/atm/resources.c	Thu Mar  7 13:56:40 2002
@@ -32,7 +32,7 @@
  {
  	struct atm_dev *dev;

-	dev = kmalloc(sizeof(*dev),GFP_KERNEL);
+	dev = kmalloc(sizeof(*dev), GFP_ATOMIC);
  	if (!dev) return NULL;
  	memset(dev,0,sizeof(*dev));
  	dev->type = type;
@@ -40,32 +40,24 @@
  	dev->link_rate = ATM_OC3_PCR;
  	dev->next = NULL;

-	spin_lock(&atm_dev_lock);
-
  	dev->prev = last_dev;

  	if (atm_devs) last_dev->next = dev;
  	else atm_devs = dev;
  	last_dev = dev;
-	spin_unlock(&atm_dev_lock);
  	return dev;
  }


  static void free_atm_dev(struct atm_dev *dev)
  {
-	spin_lock (&atm_dev_lock);
-	
  	if (dev->prev) dev->prev->next = dev->next;
  	else atm_devs = dev->next;
  	if (dev->next) dev->next->prev = dev->prev;
  	else last_dev = dev->prev;
  	kfree(dev);
-	
-	spin_unlock (&atm_dev_lock);
  }

-
  struct atm_dev *atm_find_dev(int number)
  {
  	struct atm_dev *dev;
@@ -75,17 +67,18 @@
  	return NULL;
  }

-
  struct atm_dev *atm_dev_register(const char *type,const struct atmdev_ops 
*ops,
      int number,atm_dev_flags_t *flags)
  {
-	struct atm_dev *dev;
+	struct atm_dev *dev = NULL;
+
+	spin_lock(&atm_dev_lock);

  	dev = alloc_atm_dev(type);
  	if (!dev) {
  		printk(KERN_ERR "atm_dev_register: no space for dev %s\n",
  		    type);
-		return NULL;
+		goto done;
  	}
  	if (number != -1) {
  		if (atm_find_dev(number)) {
@@ -93,8 +86,7 @@
  			return NULL;
  		}
  		dev->number = number;
-	}
-	else {
+	} else {
  		dev->number = 0;
  		while (atm_find_dev(dev->number)) dev->number++;
  	}
@@ -102,20 +94,23 @@
  	dev->dev_data = NULL;
  	barrier();
  	dev->ops = ops;
-	if (flags) dev->flags = *flags;
-	else memset(&dev->flags,0,sizeof(dev->flags));
+	if (flags)
+		dev->flags = *flags;
+	else
+		memset(&dev->flags,0,sizeof(dev->flags));
  	memset((void *) &dev->stats,0,sizeof(dev->stats));
  #ifdef CONFIG_PROC_FS
  	if (ops->proc_read)
  		if (atm_proc_dev_register(dev) < 0) {
  			printk(KERN_ERR "atm_dev_register: "
  			    "atm_proc_dev_register failed for dev %s\n",type);
-			spin_unlock (&atm_dev_lock);		
  			free_atm_dev(dev);
-			return NULL;
+			goto done;
  		}
  #endif
-	spin_unlock (&atm_dev_lock);		
+
+done:
+	spin_unlock(&atm_dev_lock);
  	return dev;
  }

@@ -125,10 +120,11 @@
  #ifdef CONFIG_PROC_FS
  	if (dev->ops->proc_read) atm_proc_dev_deregister(dev);
  #endif
+	spin_lock(&atm_dev_lock);
  	free_atm_dev(dev);
+	spin_unlock(&atm_dev_lock);
  }

-
  void shutdown_atm_dev(struct atm_dev *dev)
  {
  	if (dev->vccs) {
@@ -146,7 +142,6 @@
  	kfree(sk->protinfo.af_atm);
  }

-
  struct sock *alloc_atm_vcc_sk(int family)
  {
  	struct sock *sk;


