Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTKFA6p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 19:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTKFA6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 19:58:45 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:11182 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263298AbTKFA6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 19:58:41 -0500
Date: Wed, 5 Nov 2003 19:58:38 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       chrisw@osdl.org
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20031105195838.C32301@devserv.devel.redhat.com>
References: <20030924001334.A19940@devserv.devel.redhat.com> <Pine.LNX.4.44.0309271332080.2874-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0309271332080.2874-100000@localhost.localdomain>; from marcelo.tosatti@cyclades.com on Mon, Sep 29, 2003 at 02:48:33PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 02:48:33PM -0300, Marcelo Tosatti wrote:
> > > Date: Tue, 23 Sep 2003 13:15:15 -0700
> > > From: Chris Wright <chrisw@osdl.org>
> > 
> > > --- 1.38/sound/oss/ymfpci.c	Tue Aug 26 09:25:41 2003
> > > +++ edited/sound/oss/ymfpci.c	Tue Sep 23 12:42:45 2003
> > > @@ -2638,6 +2638,7 @@
> > >   out_free:
> > >  	if (codec->ac97_codec[0])
> > >  		ac97_release_codec(codec->ac97_codec[0]);
> > > +	kfree(codec);
> > >  	return -ENODEV;
> > >  }

I got around to fixing both missing kfrees and the schedule
under lock (for 2.4). Alan should be happy now.

-- Pete

P.S. I do not want to fix the 2.6. For crying out loud, the driver
was copied bit by bit from Jaroslav's ALSA code. Now that we
have ALSA in the kernel, can we let go already?  I do not see
why anyone would want to use my driver instead of Jaroslav's driver.

diff -ur -X dontdiff linux-2.4.23-pre9/drivers/sound/ymfpci.c linux-2.4.23-pre9-nip/drivers/sound/ymfpci.c
--- linux-2.4.23-pre9/drivers/sound/ymfpci.c	2003-11-05 11:44:34.000000000 -0800
+++ linux-2.4.23-pre9-nip/drivers/sound/ymfpci.c	2003-11-05 16:32:40.000000000 -0800
@@ -152,22 +152,19 @@
 	writel(val, codec->reg_area_virt + offset);
 }
 
-static int ymfpci_codec_ready(ymfpci_t *codec, int secondary, int sched)
+static int ymfpci_codec_ready(ymfpci_t *unit, int secondary)
 {
-	signed long end_time;
+	enum { READY_STEP = 10 };
 	u32 reg = secondary ? YDSXGR_SECSTATUSADR : YDSXGR_PRISTATUSADR;
+	int i;
 
-	end_time = jiffies + 3 * (HZ / 4);
-	do {
-		if ((ymfpci_readw(codec, reg) & 0x8000) == 0)
+	for (i = 0; i < ((3*1000)/4) / READY_STEP; i++) {
+		if ((ymfpci_readw(unit, reg) & 0x8000) == 0)
 			return 0;
-		if (sched) {
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout(1);
-		}
-	} while (end_time - (signed long)jiffies >= 0);
+		mdelay(READY_STEP);
+	}
 	printk(KERN_ERR "ymfpci_codec_ready: codec %i is not ready [0x%x]\n",
-	    secondary, ymfpci_readw(codec, reg));
+	    secondary, ymfpci_readw(unit, reg));
 	return -EBUSY;
 }
 
@@ -178,38 +175,35 @@
 
 	spin_lock(&codec->ac97_lock);
 	/* XXX Do make use of dev->id */
-	ymfpci_codec_ready(codec, 0, 0);
+	ymfpci_codec_ready(codec, 0);
 	cmd = ((YDSXG_AC97WRITECMD | reg) << 16) | val;
 	ymfpci_writel(codec, YDSXGR_AC97CMDDATA, cmd);
 	spin_unlock(&codec->ac97_lock);
 }
 
-static u16 _ymfpci_codec_read(ymfpci_t *unit, u8 reg)
+static u16 ymfpci_codec_read(struct ac97_codec *dev, u8 reg)
 {
+	ymfpci_t *unit = dev->private_data;
+	u16 ret;
 	int i;
 
-	if (ymfpci_codec_ready(unit, 0, 0))
-		return ~0;
+	spin_lock(&unit->ac97_lock);
+	if (ymfpci_codec_ready(unit, 0))
+		goto out_err;
 	ymfpci_writew(unit, YDSXGR_AC97CMDADR, YDSXG_AC97READCMD | reg);
-	if (ymfpci_codec_ready(unit, 0, 0))
-		return ~0;
+	if (ymfpci_codec_ready(unit, 0))
+		goto out_err;
 	if (unit->pci->device == PCI_DEVICE_ID_YAMAHA_744 && unit->rev < 2) {
 		for (i = 0; i < 600; i++)
 			ymfpci_readw(unit, YDSXGR_PRISTATUSDATA);
 	}
-	return ymfpci_readw(unit, YDSXGR_PRISTATUSDATA);
-}
-
-static u16 ymfpci_codec_read(struct ac97_codec *dev, u8 reg)
-{
-	ymfpci_t *unit = dev->private_data;
-	u16 ret;
-	
-	spin_lock(&unit->ac97_lock);
-	ret = _ymfpci_codec_read(unit, reg);
+	ret = ymfpci_readw(unit, YDSXGR_PRISTATUSDATA);
 	spin_unlock(&unit->ac97_lock);
-	
 	return ret;
+
+ out_err:
+	spin_unlock(&unit->ac97_lock);
+	return ~0;
 }
 
 /*
@@ -2123,7 +2117,7 @@
 	int i;
 
 	ymfpci_aclink_reset(unit->pci);
-	ymfpci_codec_ready(unit, 0, 1);		/* prints diag if not ready. */
+	ymfpci_codec_ready(unit, 0);		/* prints diag if not ready. */
 
 #ifdef CONFIG_SOUND_YMFPCI_LEGACY
 	/* XXX At this time the legacy registers are probably deprogrammed. */
@@ -2549,7 +2543,7 @@
 	    (char *)ent->driver_data, base, pcidev->irq);
 
 	ymfpci_aclink_reset(pcidev);
-	if (ymfpci_codec_ready(codec, 0, 1) < 0)
+	if (ymfpci_codec_ready(codec, 0) < 0)
 		goto out_unmap;
 
 #ifdef CONFIG_SOUND_YMFPCI_LEGACY
@@ -2625,6 +2619,7 @@
  out_release_region:
 	release_mem_region(pci_resource_start(pcidev, 0), 0x8000);
  out_free:
+	kfree(codec);
 	return -ENODEV;
 }
 
@@ -2652,6 +2647,7 @@
 		unload_uart401(&codec->mpu_data);
 	}
 #endif /* CONFIG_SOUND_YMFPCI_LEGACY */
+	kfree(codec);
 }
 
 MODULE_AUTHOR("Jaroslav Kysela");
