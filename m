Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbUB2MiY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 07:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUB2MiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 07:38:24 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:55310 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262043AbUB2MiU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 07:38:20 -0500
To: "Nick Warne" <nick@ukfsn.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3 - 8139too timeout debug info
References: <4041BAA6.28283.2CEC419B@localhost>
	<4041D3B9.24667.2D4E3207@localhost>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 29 Feb 2004 21:38:09 +0900
In-Reply-To: <4041D3B9.24667.2D4E3207@localhost>
Message-ID: <87vflqt61a.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

"Nick Warne" <nick@ukfsn.org> writes:

> OK, I have patched as asked, and still get the problem.
> 
> Information here, 2 new files:
> 
> http://www.linicks.net/8139too_debug/
> 
> debug_with_patch01.txt
> 
> &
> 
> debug_with_patch01_patch02.txt

Thanks. Umm.. strange, already NAPI reverted.
Does these patches change the behavior?


debug + revert01 + revert02 + revert03

after

debug + revert01 + revert02 + revert03 + revert04

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=8139too-revert03.patch

---

 drivers/net/8139too.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)

diff -puN drivers/net/8139too.c~8139too-revert03 drivers/net/8139too.c
--- linux-2.6.4-rc1/drivers/net/8139too.c~8139too-revert03	2004-02-29 20:35:21.000000000 +0900
+++ linux-2.6.4-rc1-hirofumi/drivers/net/8139too.c	2004-02-29 21:29:49.000000000 +0900
@@ -1374,7 +1374,7 @@ static int rtl8139_open (struct net_devi
 
 	rtl8139_start_thread(dev);
 
-	printk("%s: revert02\n", dev->name);
+	printk("%s: revert03\n", dev->name);
 	spin_lock_irq(&tp->lock);
 	RTL8139_DUMP(dev);
 	spin_unlock_irq(&tp->lock);
@@ -2172,8 +2172,11 @@ static irqreturn_t rtl8139_interrupt (in
 	u16 status, ackstat;
 	int link_changed = 0; /* avoid bogus "uninit" warning */
 	int handled = 0;
+	int boguscnt = 20;
 
 	spin_lock (&tp->lock);
+	do {
+
 	status = RTL_R16 (IntrStatus);
 
 	/* shared irq? */
@@ -2216,6 +2219,9 @@ static irqreturn_t rtl8139_interrupt (in
 		if (status & TxErr)
 			RTL_W16 (IntrStatus, TxErr);
 	}
+
+		boguscnt--;
+	} while(boguscnt > 0);
  out:
 	spin_unlock (&tp->lock);
 

_

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=8139too-revert04.patch

---

 drivers/net/8139too.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)

diff -puN drivers/net/8139too.c~8139too-revert04 drivers/net/8139too.c
--- linux-2.6.4-rc1/drivers/net/8139too.c~8139too-revert04	2004-02-29 21:30:19.000000000 +0900
+++ linux-2.6.4-rc1-hirofumi/drivers/net/8139too.c	2004-02-29 21:31:05.000000000 +0900
@@ -1374,7 +1374,7 @@ static int rtl8139_open (struct net_devi
 
 	rtl8139_start_thread(dev);
 
-	printk("%s: revert03\n", dev->name);
+	printk("%s: revert04\n", dev->name);
 	spin_lock_irq(&tp->lock);
 	RTL8139_DUMP(dev);
 	spin_unlock_irq(&tp->lock);
@@ -2225,6 +2225,14 @@ static irqreturn_t rtl8139_interrupt (in
  out:
 	spin_unlock (&tp->lock);
 
+	if (boguscnt <= 0) {
+		printk (KERN_WARNING "%s: Too much work at interrupt, "
+			"IntrStatus=0x%4.4x.\n", dev->name, status);
+
+		/* Clear all interrupt sources. */
+		RTL_W16 (IntrStatus, 0xffff);
+	}
+
 	DPRINTK ("%s: exiting interrupt, intr_status=%#4.4x.\n",
 		 dev->name, RTL_R16 (IntrStatus));
 	return IRQ_RETVAL(handled);

_

--=-=-=--
