Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVE0Gzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVE0Gzb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 02:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVE0Gzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 02:55:31 -0400
Received: from smtp06.auna.com ([62.81.186.16]:47600 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S261910AbVE0Gyf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 02:54:35 -0400
Date: Fri, 27 May 2005 06:54:30 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.12-rc3-mm3: ALSA broken ?
To: Andrew Morton <akpm@osdl.org>
Cc: alsa-devel@lists.sourceforge.net,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20050504221057.1e02a402.akpm@osdl.org>
	<1115510869l.7472l.0l@werewolf.able.es>
	<1115594680l.7540l.0l@werewolf.able.es>
	<20050526001828.0b3959f6.akpm@osdl.org>
In-Reply-To: <20050526001828.0b3959f6.akpm@osdl.org> (from akpm@osdl.org on
	Thu May 26 09:18:28 2005)
X-Mailer: Balsa 2.3.2
Message-Id: <1117176870l.7211l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.219.120] Login:jamagallon@able.es Fecha:Fri, 27 May 2005 08:54:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.26, Andrew Morton wrote:
> "J.A. Magallon" <jamagallon@able.es> wrote:
> >
> > 
> > On 05.08, J.A. Magallon wrote:
> > > 
> > > On 05.05, Andrew Morton wrote:
> > > > 
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm3/
> > > > 
> > > > - device mapper updates
> > > > 
> > > > - more UML updates
> > > > 
> > > > - -mm seems unusually stable at present.
> > > > 
> > > 
> > > Ehem, is ALSA broken ?
> > > 
> > > I can't spread stereo output to 4 channel. More specific, I can't switch
> > > one of my female jacks between in and out.
> > > 
> > > Long explanation: I have an
> > > 
> > > 00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
> > > 
> > > It has three outputs. One is always output, for normal stereo or front in 4
> > > channel. One other is LineIn/Back-for-4-channel. And the third is
> > > Mic/Bass-Center.
> > > 
> > > In 2.6.11 I have two
> > > toggles in ALSA: 'Spread front to center...' and 'surround jack as input'
> > > Adjusting both I could get to duplicate the output in the Back jack.
> > > In 2.6.12-rc3-mm3 there is no way to get this working.
> > > 
> > 

> 
> Could we have an update on this please?  Do these problems persist in
> 2.6.12-rc5 and/or 2.6.12-rc5-mm1?
> 

Finally I got it. There was a buglet in original patch. Working patch follows.
Verified in... just my box (intel onboard sound). Against rc5-mm1.

--- linux/sound/pci/ac97/ac97_patch.c	11 May 2005 11:00:17 -0000	1.82
+++ linux/sound/pci/ac97/ac97_patch.c	13 May 2005 09:35:19 -0000
@@ -1526,13 +1526,8 @@
 		.get = snd_ac97_ad1888_downmix_get,
 		.put = snd_ac97_ad1888_downmix_put
 	},
-#if 0
-	AC97_SINGLE("Surround Jack as Input", AC97_AD_MISC, 12, 1, 0),
-	AC97_SINGLE("Center/LFE Jack as Input", AC97_AD_MISC, 11, 1, 0),
-#else
 	AC97_SURROUND_JACK_MODE_CTL,
 	AC97_CHANNEL_MODE_CTL,
-#endif
 };
 
 static int patch_ad1888_specific(ac97_t *ac97)
@@ -1598,10 +1598,21 @@
 }
 
 static const snd_kcontrol_new_t snd_ac97_ad1985_controls[] = {
-	AC97_SINGLE("Center/LFE Jack as Mic", AC97_AD_SERIAL_CFG, 9, 1, 0),
 	AC97_SINGLE("Exchange Center/LFE", AC97_AD_SERIAL_CFG, 3, 1, 0)
 };
 
+static void ad1985_update_jacks(ac97_t *ac97)
+{
+	/* shared Line-In */
+	snd_ac97_update_bits(ac97, AC97_AD_MISC, 1 << 12,
+			     is_shared_linein(ac97) ? 0 : 1 << 12);
+	/* shared Mic */
+	snd_ac97_update_bits(ac97, AC97_AD_MISC, 1 << 11,
+			     is_shared_micin(ac97) ? 0 : 1 << 11);
+	snd_ac97_update_bits(ac97, AC97_AD_SERIAL_CFG, 1 << 9,
+			     is_shared_micin(ac97) ? 0 : 1 << 9);
+}
+
 static int patch_ad1985_specific(ac97_t *ac97)
 {
 	int err;
@@ -1617,7 +1624,7 @@
 #ifdef CONFIG_PM
 	.resume = ad18xx_resume,
 #endif
-	.update_jacks = ad1888_update_jacks,
+	.update_jacks = ad1985_update_jacks,
 };
 
 int patch_ad1985(ac97_t * ac97)


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam20 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


