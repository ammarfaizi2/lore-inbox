Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261409AbSJMDWD>; Sat, 12 Oct 2002 23:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbSJMDWD>; Sat, 12 Oct 2002 23:22:03 -0400
Received: from [218.245.208.194] ([218.245.208.194]:9088 "EHLO localhost")
	by vger.kernel.org with ESMTP id <S261409AbSJMDWA>;
	Sat, 12 Oct 2002 23:22:00 -0400
Date: Sun, 13 Oct 2002 11:20:19 +0800
From: Hu Gang <hugang@soulinfo.com>
To: linux-kernel@vger.kernel.org
Subject: patch for 2.5.42. 2/2
Message-Id: <20021013112019.496010fc.hugang@soulinfo.com>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.8.2claws28 (GTK+ 1.2.10; i386-linux-debian-i386-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.E+iy0nCG0FoT7="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.E+iy0nCG0FoT7=
Content-Type: multipart/mixed;
 boundary="Multipart_Sun__13_Oct_2002_11:20:19_+0800_0b924990"


--Multipart_Sun__13_Oct_2002_11:20:19_+0800_0b924990
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Pavel Machek:

With this patch, My machine has work very fine. Without it my machine will hangup/Oops in suspend/resume.
By the way, If i'm right , I can change other driver in kernel to this model.

--- linux-2.5.42/sound/pci/intel8x0.c	Sat Oct 12 21:24:58 2002
+++ linux-2.5.42-suspend/sound/pci/intel8x0.c	Sat Oct 12 21:21:12 2002
@@ -1891,6 +1891,8 @@
 {
 	snd_card_t *card = chip->card;
 
+	if (chip->in_suspend) 
+		return;
 	chip->in_suspend = 1;
 	snd_power_lock(card);
 	if (card->power_state == SNDRV_CTL_POWER_D3hot)
@@ -1909,7 +1911,10 @@
 	snd_card_t *card = chip->card;
 	int i;
 
+	if (!chip->in_suspend)
+		return;
 	snd_power_lock(card);
+	chip->in_suspend = 0;
 	if (card->power_state == SNDRV_CTL_POWER_D0)
 		goto __skip;
 
@@ -1919,7 +1924,6 @@
 		if (chip->ac97[i])
 			snd_ac97_resume(chip->ac97[i]);
 
-	chip->in_suspend = 0;
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
       __skip:
       	snd_power_unlock(card);
--- linux-2.5.42/drivers/net/3c59x.c	Sat Oct 12 21:25:00 2002
+++ linux-2.5.42-suspend/drivers/net/3c59x.c	Sat Oct 12 21:20:48 2002
@@ -809,6 +809,9 @@
 	spinlock_t lock;					/* Serialise access to device & its vortex_private */
 	spinlock_t mdio_lock;				/* Serialise access to mdio hardware */
 	u32 power_state[16];
+#ifdef CONFIG_PM
+	int in_suspend;
+#endif
 };
 
 /* The action to take with a media selection timer tick.
@@ -893,6 +896,10 @@
 	struct net_device *dev = pci_get_drvdata(pdev);
 
 	if (dev && dev->priv) {
+		struct vortex_private *vp = dev->priv;
+		if (vp->in_suspend)
+			return 0;
+		vp->in_suspend = 1;
 		if (netif_running(dev)) {
 			netif_device_detach(dev);
 			vortex_down(dev);
@@ -906,6 +913,10 @@
 	struct net_device *dev = pci_get_drvdata(pdev);
 
 	if (dev && dev->priv) {
+		struct vortex_private *vp = dev->priv;
+		if (!vp->in_suspend)
+			return 0;
+		vp->in_suspend = 1;
 		if (netif_running(dev)) {
 			vortex_up(dev);
 			netif_device_attach(dev);


-- 
		- Hu Gang



--Multipart_Sun__13_Oct_2002_11:20:19_+0800_0b924990
Content-Type: text/plain;
 name="00000004.mimetmp"
Content-Disposition: attachment;
 filename="00000004.mimetmp"
Content-Transfer-Encoding: 7bit

Hello Pavel Machek:

With this patch, My machine has work very fine. Without it my machine will hangup/Oops in suspend/resume.
By the way, If i'm right , I can change other driver in kernel to this model.

--- linux-2.5.42/sound/pci/intel8x0.c	Sat Oct 12 21:24:58 2002
+++ linux-2.5.42-suspend/sound/pci/intel8x0.c	Sat Oct 12 21:21:12 2002
@@ -1891,6 +1891,8 @@
 {
 	snd_card_t *card = chip->card;
 
+	if (chip->in_suspend) 
+		return;
 	chip->in_suspend = 1;
 	snd_power_lock(card);
 	if (card->power_state == SNDRV_CTL_POWER_D3hot)
@@ -1909,7 +1911,10 @@
 	snd_card_t *card = chip->card;
 	int i;
 
+	if (!chip->in_suspend)
+		return;
 	snd_power_lock(card);
+	chip->in_suspend = 0;
 	if (card->power_state == SNDRV_CTL_POWER_D0)
 		goto __skip;
 
@@ -1919,7 +1924,6 @@
 		if (chip->ac97[i])
 			snd_ac97_resume(chip->ac97[i]);
 
-	chip->in_suspend = 0;
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
       __skip:
       	snd_power_unlock(card);
--- linux-2.5.42/drivers/net/3c59x.c	Sat Oct 12 21:25:00 2002
+++ linux-2.5.42-suspend/drivers/net/3c59x.c	Sat Oct 12 21:20:48 2002
@@ -809,6 +809,9 @@
 	spinlock_t lock;					/* Serialise access to device & its vortex_private */
 	spinlock_t mdio_lock;				/* Serialise access to mdio hardware */
 	u32 power_state[16];
+#ifdef CONFIG_PM
+	int in_suspend;
+#endif
 };
 
 /* The action to take with a media selection timer tick.
@@ -893,6 +896,10 @@
 	struct net_device *dev = pci_get_drvdata(pdev);
 
 	if (dev && dev->priv) {
+		struct vortex_private *vp = dev->priv;
+		if (vp->in_suspend)
+			return 0;
+		vp->in_suspend = 1;
 		if (netif_running(dev)) {
 			netif_device_detach(dev);
 			vortex_down(dev);
@@ -906,6 +913,10 @@
 	struct net_device *dev = pci_get_drvdata(pdev);
 
 	if (dev && dev->priv) {
+		struct vortex_private *vp = dev->priv;
+		if (!vp->in_suspend)
+			return 0;
+		vp->in_suspend = 1;
 		if (netif_running(dev)) {
 			vortex_up(dev);
 			netif_device_attach(dev);


-- 
		- Hu Gang



--Multipart_Sun__13_Oct_2002_11:20:19_+0800_0b924990
Content-Type: application/pgp-signature;
 name="00000003.mimetmp"
Content-Disposition: attachment;
 filename="00000003.mimetmp"
Content-Transfer-Encoding: base64

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuMi4wIChHTlUv
TGludXgpCgppRDhEQlFFOXFDVnVQTTR1Q3k3YkFKZ1JBa2NwQUo5Q3c5KzRKUGduWmJic1VFUWZX
b1FYbDIrWkt3Q2VKK2FFCjJEVDNmMzRob1JRaGV0aEJCajFtVU9nPQo9UzJzbAotLS0tLUVORCBQ
R1AgU0lHTkFUVVJFLS0tLS0KDQo=

--Multipart_Sun__13_Oct_2002_11:20:19_+0800_0b924990--

--=.E+iy0nCG0FoT7=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9qOZ1PM4uCy7bAJgRAgHlAJ9SPWc2rXWIgICHneePAygMhgy7hACcD6Wk
BOVUWhFxn8fZn7zHEMNaDeM=
=4MR0
-----END PGP SIGNATURE-----

--=.E+iy0nCG0FoT7=--
