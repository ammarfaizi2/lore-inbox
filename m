Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262371AbSI2CRf>; Sat, 28 Sep 2002 22:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262372AbSI2CRf>; Sat, 28 Sep 2002 22:17:35 -0400
Received: from [61.149.36.14] ([61.149.36.14]:62981 "HELO bj.soulinfo.com")
	by vger.kernel.org with SMTP id <S262371AbSI2CRd>;
	Sat, 28 Sep 2002 22:17:33 -0400
Date: Sun, 29 Sep 2002 10:15:53 +0800
From: Hu Gang <hugang@soulinfo.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: problem abort software suspend.
Message-Id: <20020929101553.5ed77a54.hugang@soulinfo.com>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.8.2claws28 (GTK+ 1.2.10; i386-linux-debian-i386-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.5J1RqPy'M(DR:C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.5J1RqPy'M(DR:C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Pavel Machek:
  
  I found result, That why my laptop without PM can do suspend/resume and with the PM can Not do suspend/resume. 
  The problem is in 3c59x modules.
  I write an mini script do suspend and resume. When stop the net interface and remove the 3c59x all is fine. But not remove the 3c59x modules, in resume will panic.
  After it, I do the follow test. Change the 3c59x code. Now suspend and resume, the kernel not panic, and all is fine. But I see the "recall resume" from dmesg command, So that is the problem.

 Summarize: In resume progress have overlay device resume. 

I thinks add the check code in low level driver is not good idea. 
----------------------------------------------------patch code-----------
 #ifdef CONFIG_PM
-
+static int in_suspend = 0;
 static int vortex_suspend (struct pci_dev *pdev, u32 state)
 {
        struct net_device *dev = pci_get_drvdata(pdev);
 
+       if (in_suspend == 1) {
+               printk("recall suspend\n");
+               return 0;
+       }
+       printk("doing vortex suspend\n");
+       in_suspend = 1;
+
        if (dev && dev->priv) {
                if (netif_running(dev)) {
                        netif_device_detach(dev);
@@ -904,6 +911,13 @@
 static int vortex_resume (struct pci_dev *pdev)
 {
        struct net_device *dev = pci_get_drvdata(pdev);
+       
+       if (in_suspend == 0) {
+               printk("recall resume\n");
+               return 0;
+       }
+       printk("doing vortex resume\n");
+       in_suspend = 0;
 
        if (dev && dev->priv) {
                if (netif_running(dev)) {

 
  
 


 

-- 
		- Hu Gang



--=.5J1RqPy'M(DR:C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9lmJZPM4uCy7bAJgRAomdAJsH/UnJ7ccU1KnV8CinQQFl8gAdxACggZ04
Q7xNEPQLofyxTLO7BYrx9yE=
=nAxQ
-----END PGP SIGNATURE-----

--=.5J1RqPy'M(DR:C--
