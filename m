Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWDFQUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWDFQUf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 12:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWDFQUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 12:20:34 -0400
Received: from mivlgu.ru ([81.18.140.87]:23508 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S1751261AbWDFQUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 12:20:33 -0400
Date: Thu, 6 Apr 2006 20:20:16 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: David Liontooth <liontooth@cogweb.net>
Cc: linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ricardo Cerqueira" <v4l@cerqueira.org>,
       "Mauro Carvalho Chehab" <mchehab@infradead.org>
Subject: Re: [2.6.16] saa7134 disable_ir oops
Message-Id: <20060406202016.05db1eca.vsu@altlinux.ru>
In-Reply-To: <44246C0E.3080306@cogweb.net>
References: <44246C0E.3080306@cogweb.net>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__6_Apr_2006_20_20_16_+0400_x/LufInjUZbe=rt7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__6_Apr_2006_20_20_16_+0400_x/LufInjUZbe=rt7
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 24 Mar 2006 14:00:46 -0800 David Liontooth wrote:

> On 2.6.16 mainline, I get an oops when inserting the saa7134 module with 
> the option "disable_ir=1", whether for a single card or several.
> 
> Gigabyte K8NS Ultra-939, LifeView FlyVideo-3000FM NTSC, athlon64 x2 
> 3800+, Debian sid. All four cards work great otherwise. The new 
> saa7134-alsa does not appear to be involved in the oops.
> 
> Issued:
> 
> sudo modprobe saa7134 card=2,2,2,2 tuner=43,43,43,43 video_nr=1,2,3,4
> vbi_nr=1,2,3,4 radio_nr=1,2,3,4 alsa=1,1,1,1 disable_ir=1,1,1,1
> sudo modprobe saa7134-alsa index=1,2,3,4
> 
> Got in dmesg:
> 
> Unable to handle kernel NULL pointer dereference at 0000000000000260 RIP:
> <ffffffff880d5a95>{:saa7134:saa7134_initdev+1452}
> PGD 3e607067 PUD 3b0b6067 PMD 0
> Oops: 0000 [1] SMP
> CPU 0
> Modules linked in: saa7134 video_buf compat_ioctl32 v4l2_common
> v4l1_compat ir_kbd_i2c ir_common videodev xfs exportfs snd_intel8x0
> snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore sk98lin
> snd_page_alloc psmouse pcspkr evdev parport_pc parport ehci_hcd
> i2c_nforce2 ohci_hcd i2c_core unix
> Pid: 7134, comm: modprobe Not tainted 2.6.16 #1
> RIP: 0010:[<ffffffff880d5a95>]
> <ffffffff880d5a95>{:saa7134:saa7134_initdev+1452}
[skip]

Other people algo get oops with disable_ir=1:

http://lkml.org/lkml/2006/2/20/122

Does the following patch fix things?

---

saa7134: Fix oops with disable_ir=1

When disable_ir=1 parameter is used, or when saa7134_input_init1()
fails for any other reason, dev->remote will remain NULL, and the
driver will oops in saa7134_hwinit2().  Therefore dev->remote must be
checked before dereferencing.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>

--- linux-2.6.16.orig/drivers/media/video/saa7134/saa7134-core.c	2006-03-20 08:53:29 +0300
+++ linux-2.6.16/drivers/media/video/saa7134/saa7134-core.c	2006-04-06 20:00:56 +0400
@@ -543,6 +543,8 @@ static irqreturn_t saa7134_irq(int irq, 
 		if (report & SAA7134_IRQ_REPORT_GPIO16) {
 			switch (dev->has_remote) {
 				case SAA7134_REMOTE_GPIO:
+					if (!dev->remote)
+						break;
 					if  (dev->remote->mask_keydown & 0x10000) {
 						saa7134_input_irq(dev);
 					}
@@ -559,6 +561,8 @@ static irqreturn_t saa7134_irq(int irq, 
 		if (report & SAA7134_IRQ_REPORT_GPIO18) {
 			switch (dev->has_remote) {
 				case SAA7134_REMOTE_GPIO:
+					if (!dev->remote)
+						break;
 					if ((dev->remote->mask_keydown & 0x40000) ||
 					    (dev->remote->mask_keyup & 0x40000)) {
 						saa7134_input_irq(dev);
@@ -671,7 +675,7 @@ static int saa7134_hwinit2(struct saa713
 		SAA7134_IRQ2_INTE_PE      |
 		SAA7134_IRQ2_INTE_AR;
 
-	if (dev->has_remote == SAA7134_REMOTE_GPIO) {
+	if (dev->has_remote == SAA7134_REMOTE_GPIO && dev->remote) {
 		if (dev->remote->mask_keydown & 0x10000)
 			irq2_mask |= SAA7134_IRQ2_INTE_GPIO16;
 		else if (dev->remote->mask_keydown & 0x40000)



--Signature=_Thu__6_Apr_2006_20_20_16_+0400_x/LufInjUZbe=rt7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFENT/DW82GfkQfsqIRAhBlAJ4haDDHhswUC+BYN0IG0BQjf55O7ACfcMNb
R7AXbplxTJu3BdOumG2btFM=
=kV3P
-----END PGP SIGNATURE-----

--Signature=_Thu__6_Apr_2006_20_20_16_+0400_x/LufInjUZbe=rt7--
