Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbTEPBEK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 21:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264336AbTEPBEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 21:04:10 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:50780 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264330AbTEPBEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 21:04:05 -0400
Date: Thu, 15 May 2003 18:12:11 -0700
From: Andrew Morton <akpm@digeo.com>
To: "David S. Miller" <davem@redhat.com>
Cc: lists@mdiehl.de, linux-kernel@vger.kernel.org, jt@hpl.hp.com
Subject: Re: [2.5.69] rtnl-deadlock with usermodehelper and keventd
Message-Id: <20030515181211.5853fd18.akpm@digeo.com>
In-Reply-To: <20030515.175348.45895365.davem@redhat.com>
References: <PAO-EX01Cv3uS7sBdxk00001183@pao-ex01.pao.digeo.com>
	<20030515.175348.45895365.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 May 2003 01:16:51.0874 (UTC) FILETIME=[D4D3A020:01C31B48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> wrote:
>
> 
> Way too invasive, and this adds bugs to the ipmr.c code.

Thought you'd say that.

My mail client munched the context.  For reference:

> Martin Diehl <lists@mdiehl.de> wrote:
> >
> > 
> > [ unregister_netdevice calls call_usermodehelper which waits for keventd to
> >   pick up the subprocess_info, but keventd is blocked on rtnl_lock, which
> >   unregister_netdev took ]
> >
> 
> The nice way to fix this is to change unregister_netdev so it runs
> net_run_sbin_hotplug() outside rtnl_lock.
> 
> Problem is, it's hard.  I just knocked up the below patch, and it still
> needs work.  Mainly because of the tremendously deep codepaths which call
> unregister_netdevice(), knowing that they are under rtnl_lock().
> 
> It would be nice to clean all that up, and this patch actually contains
> good cleanups and a couple of bugfixes.  But I don't think it's going to
> get there.
> 
> 
> The other way to fix it is to make call_usermodehelper() more async.  That
> means kmallocing the sub_info, the work struct and the string arrays and
> all the strings.  This is more general, and will probably fix other
> keventd-related deadlocks.  But it is unattractive.
> 
> 
> Or we could change linkwatch to not take rtnl_lock() by some means.  That's
> even less general.
> 
> 
> David, any comments?  You think the below approach shuld be pursued?


"David S. Miller" <davem@redhat.com> wrote:
>
> I'd much rather see /sbin/hotplug be able to handle things
> asynchonously.

Yeah, I'm inclined to agree.  I'll take a look at it.


Meanwhile please take a look at the leftover cleanups.  It fixes a bug in
drivers/net/hamradio/dmascc.c too.


 25-akpm/drivers/net/hamradio/dmascc.c  |    4 +---
 25-akpm/drivers/net/irda/ali-ircc.c    |    7 ++-----
 25-akpm/drivers/net/irda/donauboe.c    |    7 +------
 25-akpm/drivers/net/irda/irda-usb.c    |   10 ++++------
 25-akpm/drivers/net/irda/irport.c      |    7 ++-----
 25-akpm/drivers/net/irda/irtty.c       |    7 ++-----
 25-akpm/drivers/net/irda/nsc-ircc.c    |    7 ++-----
 25-akpm/drivers/net/irda/sa1100_ir.c   |    7 ++-----
 25-akpm/drivers/net/irda/toshoboe.c    |    8 ++------
 25-akpm/drivers/net/irda/w83977af_ir.c |    7 ++-----
 10 files changed, 20 insertions(+), 51 deletions(-)

diff -puN drivers/net/hamradio/dmascc.c~unregister_netdev-cleanup drivers/net/hamradio/dmascc.c
--- 25/drivers/net/hamradio/dmascc.c~unregister_netdev-cleanup	Thu May 15 18:05:29 2003
+++ 25-akpm/drivers/net/hamradio/dmascc.c	Thu May 15 18:05:29 2003
@@ -325,9 +325,7 @@ void cleanup_module(void) {
     /* Unregister devices */
     for (i = 0; i < 2; i++) {
       if (info->dev[i].name)
-	rtnl_lock();
-	unregister_netdevice(&info->dev[i]);
-	rtnl_unlock();
+	unregister_netdev(&info->dev[i]);
     }
 
     /* Reset board */
diff -puN drivers/net/irda/ali-ircc.c~unregister_netdev-cleanup drivers/net/irda/ali-ircc.c
--- 25/drivers/net/irda/ali-ircc.c~unregister_netdev-cleanup	Thu May 15 18:05:29 2003
+++ 25-akpm/drivers/net/irda/ali-ircc.c	Thu May 15 18:05:29 2003
@@ -390,11 +390,8 @@ static int __exit ali_ircc_close(struct 
         iobase = self->io.fir_base;
 
 	/* Remove netdevice */
-	if (self->netdev) {
-		rtnl_lock();
-		unregister_netdevice(self->netdev);
-		rtnl_unlock();
-	}
+	if (self->netdev)
+		unregister_netdev(self->netdev);
 
 	/* Release the PORT that this driver is using */
 	IRDA_DEBUG(4, "%s(), Releasing Region %03x\n", __FUNCTION__, self->io.fir_base);
diff -puN drivers/net/irda/donauboe.c~unregister_netdev-cleanup drivers/net/irda/donauboe.c
--- 25/drivers/net/irda/donauboe.c~unregister_netdev-cleanup	Thu May 15 18:05:29 2003
+++ 25-akpm/drivers/net/irda/donauboe.c	Thu May 15 18:05:29 2003
@@ -1577,12 +1577,7 @@ toshoboe_close (struct pci_dev *pci_dev)
     }
 
   if (self->netdev)
-    {
-      /* Remove netdevice */
-      rtnl_lock ();
-      unregister_netdevice (self->netdev);
-      rtnl_unlock ();
-    }
+      unregister_netdev(self->netdev);
 
   kfree (self->ringbuf);
   self->ringbuf = NULL;
diff -puN drivers/net/irda/irda-usb.c~unregister_netdev-cleanup drivers/net/irda/irda-usb.c
--- 25/drivers/net/irda/irda-usb.c~unregister_netdev-cleanup	Thu May 15 18:05:29 2003
+++ 25-akpm/drivers/net/irda/irda-usb.c	Thu May 15 18:05:29 2003
@@ -1231,12 +1231,10 @@ static inline int irda_usb_close(struct 
 	ASSERT(self != NULL, return -1;);
 
 	/* Remove netdevice */
-	if (self->netdev) {
-		rtnl_lock();
-		unregister_netdevice(self->netdev);
-		self->netdev = NULL;
-		rtnl_unlock();
-	}
+	if (self->netdev)
+		unregister_netdev(self->netdev);
+	self->netdev = NULL;
+
 	/* Remove the speed buffer */
 	if (self->speed_buff != NULL) {
 		kfree(self->speed_buff);
diff -puN drivers/net/irda/irport.c~unregister_netdev-cleanup drivers/net/irda/irport.c
--- 25/drivers/net/irda/irport.c~unregister_netdev-cleanup	Thu May 15 18:05:29 2003
+++ 25-akpm/drivers/net/irda/irport.c	Thu May 15 18:05:29 2003
@@ -256,11 +256,8 @@ int irport_close(struct irport_cb *self)
 	self->dongle = NULL;
 	
 	/* Remove netdevice */
-	if (self->netdev) {
-		rtnl_lock();
-		unregister_netdevice(self->netdev);
-		rtnl_unlock();
-	}
+	if (self->netdev)
+		unregister_netdev(self->netdev);
 
 	/* Release the IO-port that this driver is using */
 	IRDA_DEBUG(0 , "%s(), Releasing Region %03x\n", 
diff -puN drivers/net/irda/irtty.c~unregister_netdev-cleanup drivers/net/irda/irtty.c
--- 25/drivers/net/irda/irtty.c~unregister_netdev-cleanup	Thu May 15 18:05:29 2003
+++ 25-akpm/drivers/net/irda/irtty.c	Thu May 15 18:05:29 2003
@@ -282,11 +282,8 @@ static void irtty_close(struct tty_struc
 	self->dongle = NULL;
 
 	/* Remove netdevice */
-	if (self->netdev) {
-		rtnl_lock();
-		unregister_netdevice(self->netdev);
-		rtnl_unlock();
-	}
+	if (self->netdev)
+		unregister_netdev(self->netdev);
 	
 	self = hashbin_remove(irtty, (int) self, NULL);
 
diff -puN drivers/net/irda/nsc-ircc.c~unregister_netdev-cleanup drivers/net/irda/nsc-ircc.c
--- 25/drivers/net/irda/nsc-ircc.c~unregister_netdev-cleanup	Thu May 15 18:05:29 2003
+++ 25-akpm/drivers/net/irda/nsc-ircc.c	Thu May 15 18:05:29 2003
@@ -391,11 +391,8 @@ static int __exit nsc_ircc_close(struct 
         iobase = self->io.fir_base;
 
 	/* Remove netdevice */
-	if (self->netdev) {
-		rtnl_lock();
-		unregister_netdevice(self->netdev);
-		rtnl_unlock();
-	}
+	if (self->netdev)
+		unregister_netdev(self->netdev);
 
 	/* Release the PORT that this driver is using */
 	IRDA_DEBUG(4, "%s(), Releasing Region %03x\n", 
diff -puN drivers/net/irda/sa1100_ir.c~unregister_netdev-cleanup drivers/net/irda/sa1100_ir.c
--- 25/drivers/net/irda/sa1100_ir.c~unregister_netdev-cleanup	Thu May 15 18:05:29 2003
+++ 25-akpm/drivers/net/irda/sa1100_ir.c	Thu May 15 18:05:29 2003
@@ -1122,11 +1122,8 @@ static void __exit sa1100_irda_exit(void
 {
 	struct net_device *dev = dev_get_drvdata(&sa1100ir_device.dev);
 
-	if (dev) {
-		rtnl_lock();
-		unregister_netdevice(dev);
-		rtnl_unlock();
-	}
+	if (dev)
+		unregister_netdev(dev);
 
 	sys_device_unregister(&sa1100ir_device);
 	driver_unregister(&sa1100ir_driver);
diff -puN drivers/net/irda/toshoboe.c~unregister_netdev-cleanup drivers/net/irda/toshoboe.c
--- 25/drivers/net/irda/toshoboe.c~unregister_netdev-cleanup	Thu May 15 18:05:29 2003
+++ 25-akpm/drivers/net/irda/toshoboe.c	Thu May 15 18:05:29 2003
@@ -679,12 +679,8 @@ toshoboe_remove (struct pci_dev *pci_dev
       self->recv_bufs[i] = NULL;
     }
 
-  if (self->netdev) {
-	  /* Remove netdevice */
-	  rtnl_lock();
-	  unregister_netdevice(self->netdev);
-	  rtnl_unlock();
-  }
+  if (self->netdev)
+	  unregister_netdev(self->netdev);
 
   kfree (self->taskfilebuf);
   self->taskfilebuf = NULL;
diff -puN drivers/net/irda/w83977af_ir.c~unregister_netdev-cleanup drivers/net/irda/w83977af_ir.c
--- 25/drivers/net/irda/w83977af_ir.c~unregister_netdev-cleanup	Thu May 15 18:05:29 2003
+++ 25-akpm/drivers/net/irda/w83977af_ir.c	Thu May 15 18:05:29 2003
@@ -299,11 +299,8 @@ static int w83977af_close(struct w83977a
 #endif /* CONFIG_USE_W977_PNP */
 
 	/* Remove netdevice */
-	if (self->netdev) {
-		rtnl_lock();
-		unregister_netdevice(self->netdev);
-		rtnl_unlock();
-	}
+	if (self->netdev)
+		unregister_netdev(self->netdev);
 
 	/* Release the PORT that this driver is using */
 	IRDA_DEBUG(0 , "%s(), Releasing Region %03x\n", 

_

