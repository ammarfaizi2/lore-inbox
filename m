Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272404AbTG1C7x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 22:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271007AbTG1C7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 22:59:53 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:12673 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S272404AbTG1C7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 22:59:51 -0400
Date: Sun, 27 Jul 2003 22:43:57 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Ruvolo <chris@ruvolo.net>, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net, Jaroslav Kysela <perex@suse.cz>
Subject: Re: 2.6.0-t1 garbage in /proc/ioports and oops
Message-ID: <20030727224357.GA27040@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@osdl.org>, Chris Ruvolo <chris@ruvolo.net>,
	linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net,
	Jaroslav Kysela <perex@suse.cz>
References: <20030718011101.GD15716@ruvolo.net> <20030717211533.77c0f943.akpm@osdl.org> <20030718150429.GE15716@ruvolo.net> <20030727163812.75b98b02.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030727163812.75b98b02.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27, 2003 at 04:38:12PM -0700, Andrew Morton wrote:
> Chris Ruvolo <chris@ruvolo.net> wrote:
> >
> > (adding alsa-devel)
> > 
> > On Thu, Jul 17, 2003 at 09:15:33PM -0700, Andrew Morton wrote:
> > > You could load all those modules one at a time, doing a `cat /proc/ioports'
> > > after each one.  One sneaky way of doing that would be to make your
> > > modprobe executable be:
> > 
> > Ok, this let me track it down to the ALSA snd-sbawe module.  I did not have
> > isapnp compiled into the kernel and was relying on the userspace isapnp to
> > configure the device (carried over from 2.4).  Apparently the module didn't
> > like this.
> 
> OK, thanks for that.
> 
> >From my reading, snd_sb16_probe() is, in the case of !CONFIG_PNP, doing:
> 
> 	/* block the 0x388 port to avoid PnP conflicts */
> 	acard->fm_res = request_region(0x388, 4, "SoundBlaster FM");
> 
> but this reservation is never undone.  So later, after the module is
> unloaded, a read of /proc/ioports is oopsing when trying to access that
> string "SoundBlaster FM".  Because it now resides in vfree'd memory.
> 
> The fix would be to run release_region() either at the end of
> snd_sb16_probe() or on module unload.
> 
> Adam or Jaroslav, could you please take care of this?
> 
> Thanks.

I believe this will fix it.  Testing would be appreciated.

Thanks,
Adam

--- a/sound/isa/sb/sb16.c	2003-07-14 03:37:15.000000000 +0000
+++ b/sound/isa/sb/sb16.c	2003-07-27 22:33:22.000000000 +0000
@@ -350,6 +350,18 @@
 
 #endif /* CONFIG_PNP */
 
+static void snd_sb16_free(snd_card_t *card)
+{
+	struct snd_card_sb16 *acard = (struct snd_card_sb16 *) card->private_data;
+
+	if (acard == NULL)
+		return;
+	if (acard->fm_res) {
+		release_resource(acard->fm_res);
+		kfree_nocheck(acard->fm_res);
+	}
+}
+
 static int __init snd_sb16_probe(int dev,
 				 struct pnp_card_link *pcard,
 				 const struct pnp_card_device_id *pid)
@@ -374,6 +386,7 @@
 	if (card == NULL)
 		return -ENOMEM;
 	acard = (struct snd_card_sb16 *) card->private_data;
+	card->private_free = snd_sb16_free;
 #ifdef CONFIG_PNP
 	if (isapnp[dev]) {
 		if ((err = snd_card_sb16_pnp(dev, acard, pcard, pid))) {
