Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266602AbUFWRGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266602AbUFWRGB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 13:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266584AbUFWRFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 13:05:54 -0400
Received: from halon.barra.com ([144.203.11.1]:2713 "EHLO halon.barra.com")
	by vger.kernel.org with ESMTP id S266602AbUFWREc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 13:04:32 -0400
From: Fedor Karpelevitch <fedor@karpelevitch.net>
To: linux-kernel@vger.kernel.org
Subject: [BUG] ali5451 not resumed properly under 2.6.7 ( fine under 2.6.6 )
Date: Wed, 23 Jun 2004 10:04:17 -0700
User-Agent: KMail/1.6.2
Cc: matt_wu@acersoftech.com.cn
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406231004.27689.fedor@karpelevitch.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I upgraded to 2.6.7 recently and noticed that my ali5451 souncard 
stopped behaving properly after resuming. 

Basically after resume it produces no sound even though everything 
pretends that the card is working properly (mixer "changes" volume 
etc...). 
I found that executing something like 'alsactl -F power A5451 D1' 
makes it produce sound again although the volume is noticably lower 
than it should be.

2.6.6 works just fine.

I looked at the diff for ali5451.c and noticed that in ali_suspend a 
call to snd_pcm_suspend_all(chip->pcm) was added, but in ali_resume 
no call to resume pcm was added. Could that be the cause of the 
problem?

I will try adding that call and see if that fixes the problem.


here is that part of the diff:



+static int ali_suspend(snd_card_t *card, unsigned int state)
 {
+       ali_t *chip = snd_magic_cast(ali_t, card->pm_private_data, 
return -EINVAL);
        ali_image_t *im;
        int i, j;
 
        im = chip->image;
        if (! im)
- -               return;
+               return 0;
+
+       snd_pcm_suspend_all(chip->pcm);
+       snd_ac97_suspend(chip->ac97);
 
        spin_lock_irq(&chip->reg_lock);
        
@@ -1940,16 +1943,18 @@
        outl(0xffffffff, ALI_REG(chip, ALI_STOP));
 
        spin_unlock_irq(&chip->reg_lock);
+       return 0;
 }
 
- -static void ali_resume(ali_t *chip)
+static int ali_resume(snd_card_t *card, unsigned int state)
 {
+       ali_t *chip = snd_magic_cast(ali_t, card->pm_private_data, 
return -EINVAL);
        ali_image_t *im;
        int i, j;
 
        im = chip->image;
        if (! im)
- -               return;
+               return 0;
 
        pci_enable_device(chip->pci);
 
@@ -1967,27 +1972,15 @@
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA2bgYw4m50RG4juoRAqTqAJ4+oHXRvOjz6NZLUS82oxIh+d7SIACgl65l
hCtld2qftBglwS0V0gYNHAw=
=ZLy7
-----END PGP SIGNATURE-----
