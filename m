Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVCIDDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVCIDDI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 22:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVCIDDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 22:03:08 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:28059 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261439AbVCIDC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 22:02:58 -0500
Subject: Re: [Alsa-devel] Re: intel 8x0 went silent in 2.6.11
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Canter <marcus@vfxcomputing.com>
Cc: Takashi Iwai <tiwai@suse.de>, Pierre Ossman <drzeus-list@drzeus.cx>,
       Andrew Morton <akpm@osdl.org>, nish.aravamudan@gmail.com,
       linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.62.0503082050270.3821@krusty.vfxcomputing.com>
References: <4227085C.7060104@drzeus.cx>
	 <29495f1d05030309455a990c5b@mail.gmail.com>
	 <Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>
	 <1109875926.2908.26.camel@mindpipe>
	 <Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>
	 <1109876978.2908.31.camel@mindpipe>
	 <Pine.LNX.4.62.0503031527550.30702@krusty.vfxcomputing.com>
	 <20050303154929.1abd0a62.akpm@osdl.org> <4227ADE7.3080100@drzeus.cx>
	 <4228D013.8010307@drzeus.cx> <s5hmztfwon1.wl@alsa2.suse.de>
	 <422CB68A.1050900@drzeus.cx> <s5hekerurz8.wl@alsa2.suse.de>
	 <422CFB6E.1020002@drzeus.cx> <s5h1xaquzf0.wl@alsa2.suse.de>
	 <Pine.LNX.4.62.0503082050270.3821@krusty.vfxcomputing.com>
Content-Type: multipart/mixed; boundary="=-FJZigvHJNOcnzt2N+89+"
Date: Tue, 08 Mar 2005 22:02:52 -0500
Message-Id: <1110337373.7123.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FJZigvHJNOcnzt2N+89+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-03-08 at 20:53 -0500, Mark Canter wrote:
> I think I've gone through every possible value here from asound.state to 
> each setting in KDE itself.  Still, the only sound that works is the one 
> coming from line-out, without the port replicator, no sound exists 
> whatsoever.  Both of the below controls are set to false in asound.state 
> and cooresponding KDE settings in kmix.
> 
> I think the concern becomes though, regardless of what kde was doing after 
> the fact, this condition didn't exits in <= 2.6.10 when no other 
> applications where changed around it.

If you revert both the attached patches, does it work?

They are against alsa CVS, so to back these patches out from your 2.6.11
tree do this:

  cd linux-2.6.11/sound/pci/ac97
  patch -p0 -R < ac97-2.patch
  patch -p0 -R < ac97.patch

Lee





--=-FJZigvHJNOcnzt2N+89+
Content-Disposition: attachment; filename=ac97-2.patch
Content-Type: text/x-patch; name=ac97-2.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: ac97_patch.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_patch.c,v
retrieving revision 1.69
retrieving revision 1.70
diff -u -r1.69 -r1.70
--- ac97_patch.c	17 Jan 2005 13:47:20 -0000	1.69
+++ ac97_patch.c	20 Jan 2005 11:43:19 -0000	1.70
@@ -1113,6 +1113,7 @@
 	switch (subid) {
 	case 0x103c0890: /* HP nc6000 */
 	case 0x103c006d: /* HP nx9105 */
+	case 0x17340088: /* FSC Scenic-W */
 		/* enable headphone jack sense */
 		snd_ac97_update_bits(ac97, AC97_AD_JACK_SPDIF, 1<<11, 1<<11);
 		break;

--=-FJZigvHJNOcnzt2N+89+
Content-Disposition: attachment; filename=ac97.patch
Content-Type: text/x-patch; name=ac97.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: ac97_patch.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_patch.c,v
retrieving revision 1.68
retrieving revision 1.69
diff -u -r1.68 -r1.69
--- ac97_patch.c	11 Jan 2005 15:57:20 -0000	1.68
+++ ac97_patch.c	17 Jan 2005 13:47:20 -0000	1.69
@@ -1107,13 +1107,25 @@
 #endif
 };
 
+static void check_ad1981_hp_jack_sense(ac97_t *ac97)
+{
+	u32 subid = ((u32)ac97->subsystem_vendor << 16) | ac97->subsystem_device;
+	switch (subid) {
+	case 0x103c0890: /* HP nc6000 */
+	case 0x103c006d: /* HP nx9105 */
+		/* enable headphone jack sense */
+		snd_ac97_update_bits(ac97, AC97_AD_JACK_SPDIF, 1<<11, 1<<11);
+		break;
+	}
+}
+
 int patch_ad1981a(ac97_t *ac97)
 {
 	patch_ad1881(ac97);
 	ac97->build_ops = &patch_ad1981a_build_ops;
 	snd_ac97_update_bits(ac97, AC97_AD_MISC, AC97_AD198X_MSPLT, AC97_AD198X_MSPLT);
 	ac97->flags |= AC97_STEREO_MUTES;
-	snd_ac97_update_bits(ac97, AC97_AD_JACK_SPDIF, 1<<11, 1<<11); /* HP jack sense */
+	check_ad1981_hp_jack_sense(ac97);
 	return 0;
 }
 
@@ -1144,7 +1156,7 @@
 	ac97->build_ops = &patch_ad1981b_build_ops;
 	snd_ac97_update_bits(ac97, AC97_AD_MISC, AC97_AD198X_MSPLT, AC97_AD198X_MSPLT);
 	ac97->flags |= AC97_STEREO_MUTES;
-	snd_ac97_update_bits(ac97, AC97_AD_JACK_SPDIF, 1<<11, 1<<11); /* HP jack sense */
+	check_ad1981_hp_jack_sense(ac97);
 	return 0;
 }

--=-FJZigvHJNOcnzt2N+89+--

