Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314707AbSGQO0M>; Wed, 17 Jul 2002 10:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSGQO0M>; Wed, 17 Jul 2002 10:26:12 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:60592 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314707AbSGQO0L>;
	Wed, 17 Jul 2002 10:26:11 -0400
Date: Wed, 17 Jul 2002 16:29:04 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stelian Pop <stelian.pop@fr.alcove.com>, Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: input subsystem config ?
Message-ID: <20020717162904.B19935@ucw.cz>
References: <20020716143415.GO7955@tahoe.alcove-fr> <20020717095618.GD14581@tahoe.alcove-fr> <20020717120135.A12452@ucw.cz> <20020717101001.GE14581@tahoe.alcove-fr> <20020717140804.B12529@ucw.cz> <20020717132459.GF14581@tahoe.alcove-fr> <20020717154448.A19761@ucw.cz> <20020717135823.GG14581@tahoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020717135823.GG14581@tahoe.alcove-fr>; from stelian.pop@fr.alcove.com on Wed, Jul 17, 2002 at 03:58:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 03:58:23PM +0200, Stelian Pop wrote:
> On Wed, Jul 17, 2002 at 03:44:48PM +0200, Vojtech Pavlik wrote:
> 
> > Try this patch, 
> 
> It doesn't change anything:
>
> > if it doesn't work, we'll have to try more changes, like
> > trying to skip the AUX port detection that might confuse the chip ....
> 
> I should enhance however that it works with the old pc_keyb driver.

Yes, I know. That's why I suggested skipping the detection, as the
pc_keyb driver doesn't do that.

Try this:

--- i8042.c.old	Wed Jul 17 16:05:57 2002
+++ i8042.c	Wed Jul 17 16:27:54 2002
@@ -571,6 +571,8 @@
 
 	i8042_flush();
 
+#if 0
+
 /*
  * Internal loopback test - filters out AT-type i8042's
  */
@@ -621,6 +625,11 @@
 	i8042_ctr &= ~I8042_CTR_AUXINT;
 
 	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR))
+		return -1;
+
+#endif
+
+	if (i8042_command(&param, I8042_CMD_AUX_ENABLE))
 		return -1;
 
 	return 0;

> I don't know the internals but it may give you a hint...
> 
> > Btw, what's the exact chipset involved?
> 
> It's a Sony VAIO Picturebook C1VE, lspci:
> 00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge
> 00:00.1 RAM memory: Transmeta Corporation SDRAM controller
> 00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
> 00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
> 00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
> 00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
> 00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
> 00:08.0 FireWire (IEEE 1394): Texas Instruments TSB43AA22 IEEE-1394 Controller (PHY/Link Integrated) (rev 02)
> 00:09.0 Multimedia audio controller: Yamaha Corporation YMF-754 [DS-1E Audio Controller]
> 00:0b.0 Multimedia controller: Kawasaki Steel Corporation: Unknown device ff01 (rev 01)
> 00:0c.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
> 00:0d.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M (rev 64)

Oh my. So likely there the i8042 chip is implemented in software
entirely ...

-- 
Vojtech Pavlik
SuSE Labs
