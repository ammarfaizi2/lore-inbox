Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbTAJMBI>; Fri, 10 Jan 2003 07:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262089AbTAJMBI>; Fri, 10 Jan 2003 07:01:08 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:20179 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S261545AbTAJMBG>; Fri, 10 Jan 2003 07:01:06 -0500
Date: Fri, 10 Jan 2003 13:09:53 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH]Re: spin_locks without smp.
In-Reply-To: <20030110114855.GO23814@holomorphy.com>
Message-ID: <Pine.LNX.4.51.0301101308410.25610@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0301101238560.6124@dns.toxicfilms.tv>
 <20030110114546.GN23814@holomorphy.com> <20030110114855.GO23814@holomorphy.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-23717851-352505684-1042200593=:25610"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---23717851-352505684-1042200593=:25610
Content-Type: TEXT/PLAIN; charset=US-ASCII

> On Fri, Jan 10, 2003 at 03:45:46AM -0800, William Lee Irwin III wrote:
> > Buggy on preempt. Remove the #ifdef
Yes sir. :)

Is that okay?

Maciej


--- linux/drivers/net/eexpress.c	2002-11-29 00:53:13.000000000 +0100
+++ linux.new/drivers/net/eexpress.c	2003-01-10 13:08:24.000000000 +0100
@@ -600,9 +600,7 @@
 static void eexp_timeout(struct net_device *dev)
 {
 	struct net_local *lp = (struct net_local *)dev->priv;
-#ifdef CONFIG_SMP
 	unsigned long flags;
-#endif
 	int status;

 	disable_irq(dev->irq);
@@ -612,9 +610,7 @@
 	 *	lets make it work first..
 	 */

-#ifdef CONFIG_SMP
 	spin_lock_irqsave(&lp->lock, flags);
-#endif

 	status = scb_status(dev);
 	unstick_cu(dev);
@@ -628,9 +624,7 @@
 		outb(0,dev->base_addr+SIGNAL_CA);
 	}
 	netif_wake_queue(dev);
-#ifdef CONFIG_SMP
 	spin_unlock_irqrestore(&lp->lock, flags);
-#endif
 }

 /*
@@ -640,9 +634,7 @@
 static int eexp_xmit(struct sk_buff *buf, struct net_device *dev)
 {
 	struct net_local *lp = (struct net_local *)dev->priv;
-#ifdef CONFIG_SMP
 	unsigned long flags;
-#endif

 #if NET_DEBUG > 6
 	printk(KERN_DEBUG "%s: eexp_xmit()\n", dev->name);
@@ -655,9 +647,7 @@
 	 *	lets make it work first..
 	 */

-#ifdef CONFIG_SMP
 	spin_lock_irqsave(&lp->lock, flags);
-#endif

 	{
 		unsigned short length = (ETH_ZLEN < buf->len) ? buf->len :
@@ -669,9 +659,7 @@
 	        eexp_hw_tx_pio(dev,data,length);
 	}
 	dev_kfree_skb(buf);
-#ifdef CONFIG_SMP
 	spin_unlock_irqrestore(&lp->lock, flags);
-#endif
 	enable_irq(dev->irq);
 	return 0;
 }
---23717851-352505684-1042200593=:25610
Content-Type: TEXT/plain; name="eexpress.c.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.51.0301101309530.25610@dns.toxicfilms.tv>
Content-Description: 
Content-Disposition: attachment; filename="eexpress.c.diff"

LS0tIGxpbnV4L2RyaXZlcnMvbmV0L2VleHByZXNzLmMJMjAwMi0xMS0yOSAw
MDo1MzoxMy4wMDAwMDAwMDAgKzAxMDANCisrKyBsaW51eC5uZXcvZHJpdmVy
cy9uZXQvZWV4cHJlc3MuYwkyMDAzLTAxLTEwIDEzOjA4OjI0LjAwMDAwMDAw
MCArMDEwMA0KQEAgLTYwMCw5ICs2MDAsNyBAQA0KIHN0YXRpYyB2b2lkIGVl
eHBfdGltZW91dChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQ0KIHsNCiAJc3Ry
dWN0IG5ldF9sb2NhbCAqbHAgPSAoc3RydWN0IG5ldF9sb2NhbCAqKWRldi0+
cHJpdjsNCi0jaWZkZWYgQ09ORklHX1NNUA0KIAl1bnNpZ25lZCBsb25nIGZs
YWdzOw0KLSNlbmRpZg0KIAlpbnQgc3RhdHVzOw0KIAkNCiAJZGlzYWJsZV9p
cnEoZGV2LT5pcnEpOw0KQEAgLTYxMiw5ICs2MTAsNyBAQA0KIAkgKglsZXRz
IG1ha2UgaXQgd29yayBmaXJzdC4uDQogCSAqLw0KIAkgDQotI2lmZGVmIENP
TkZJR19TTVANCiAJc3Bpbl9sb2NrX2lycXNhdmUoJmxwLT5sb2NrLCBmbGFn
cyk7DQotI2VuZGlmDQogDQogCXN0YXR1cyA9IHNjYl9zdGF0dXMoZGV2KTsN
CiAJdW5zdGlja19jdShkZXYpOw0KQEAgLTYyOCw5ICs2MjQsNyBAQA0KIAkJ
b3V0YigwLGRldi0+YmFzZV9hZGRyK1NJR05BTF9DQSk7DQogCX0NCiAJbmV0
aWZfd2FrZV9xdWV1ZShkZXYpOwkNCi0jaWZkZWYgQ09ORklHX1NNUA0KIAlz
cGluX3VubG9ja19pcnFyZXN0b3JlKCZscC0+bG9jaywgZmxhZ3MpOw0KLSNl
bmRpZg0KIH0NCiANCiAvKg0KQEAgLTY0MCw5ICs2MzQsNyBAQA0KIHN0YXRp
YyBpbnQgZWV4cF94bWl0KHN0cnVjdCBza19idWZmICpidWYsIHN0cnVjdCBu
ZXRfZGV2aWNlICpkZXYpDQogew0KIAlzdHJ1Y3QgbmV0X2xvY2FsICpscCA9
IChzdHJ1Y3QgbmV0X2xvY2FsICopZGV2LT5wcml2Ow0KLSNpZmRlZiBDT05G
SUdfU01QDQogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQotI2VuZGlmDQogDQog
I2lmIE5FVF9ERUJVRyA+IDYNCiAJcHJpbnRrKEtFUk5fREVCVUcgIiVzOiBl
ZXhwX3htaXQoKVxuIiwgZGV2LT5uYW1lKTsNCkBAIC02NTUsOSArNjQ3LDcg
QEANCiAJICoJbGV0cyBtYWtlIGl0IHdvcmsgZmlyc3QuLg0KIAkgKi8NCiAJ
IA0KLSNpZmRlZiBDT05GSUdfU01QDQogCXNwaW5fbG9ja19pcnFzYXZlKCZs
cC0+bG9jaywgZmxhZ3MpOw0KLSNlbmRpZg0KICAgDQogCXsNCiAJCXVuc2ln
bmVkIHNob3J0IGxlbmd0aCA9IChFVEhfWkxFTiA8IGJ1Zi0+bGVuKSA/IGJ1
Zi0+bGVuIDoNCkBAIC02NjksOSArNjU5LDcgQEANCiAJICAgICAgICBlZXhw
X2h3X3R4X3BpbyhkZXYsZGF0YSxsZW5ndGgpOw0KIAl9DQogCWRldl9rZnJl
ZV9za2IoYnVmKTsNCi0jaWZkZWYgQ09ORklHX1NNUA0KIAlzcGluX3VubG9j
a19pcnFyZXN0b3JlKCZscC0+bG9jaywgZmxhZ3MpOw0KLSNlbmRpZg0KIAll
bmFibGVfaXJxKGRldi0+aXJxKTsNCiAJcmV0dXJuIDA7DQogfQ0K

---23717851-352505684-1042200593=:25610--
