Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267594AbTA3RoW>; Thu, 30 Jan 2003 12:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267583AbTA3RoV>; Thu, 30 Jan 2003 12:44:21 -0500
Received: from postal2.lbl.gov ([131.243.248.26]:24992 "EHLO postal2.lbl.gov")
	by vger.kernel.org with ESMTP id <S267588AbTA3RoS>;
	Thu, 30 Jan 2003 12:44:18 -0500
Message-ID: <3E39669F.20302@lbl.gov>
Date: Thu, 30 Jan 2003 09:53:35 -0800
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021017
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre4
References: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>	 <3E384D41.9080605@lbl.gov>	 <1043926998.28133.21.camel@irongate.swansea.linux.org.uk>	 <3E395C30.6040903@lbl.gov>	 <1043950661.31674.12.camel@irongate.swansea.linux.org.uk>	 <3E396032.2000503@lbl.gov> <1043951291.31674.17.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> On Thu, 2003-01-30 at 17:26, Thomas Davis wrote:
>
> >>FM801 is still the card not the codec. Somewhere on the FM801 is a 
> 48pin AC97 codec,
> >>it may even vary by card version, much like I have intel i810 audio 
> with a variety
> >>of codec devices.
> >>
> >
> >Yes, I agree on that..  I'm just trying to get the name "Forte Media
> >FM801" instead of "Unknown" to show up in the ac97 list.
>
>
> Why ? How do you even know the codec is made by forte media ?
>

because the forte driver does this:

[tdavis@lanshark sound]$ grep ac97 forte.c
#include <linux/ac97_codec.h>
         spinlock_t              ac97_lock;
         struct ac97_codec       *ac97;
  * forte_ac97_wait:
forte_ac97_wait (struct forte_chip *chip)
  * forte_ac97_read:
forte_ac97_read (struct ac97_codec *codec, u8 reg)
         spin_lock (&chip->ac97_lock);
         if (forte_ac97_wait (chip)) {
                 printk (KERN_ERR PFX "ac97_read: Serial bus busy\n");
         if (forte_ac97_wait (chip)) {
                 printk (KERN_ERR PFX "ac97_read: Bus busy reading reg 
0x%x\n",
                 printk (KERN_ERR PFX "ac97_read: Invalid data port");
         spin_unlock (&chip->ac97_lock);
  * forte_ac97_write:
forte_ac97_write (struct ac97_codec *codec, u8 reg, u16 val)
         spin_lock (&chip->ac97_lock);
         if (forte_ac97_wait (chip)) {
                 printk (KERN_ERR PFX "ac97_write: Serial bus busy\n");
         if (forte_ac97_wait (chip)) {
                 printk (KERN_ERR PFX "ac97_write: Bus busy after write\n");
         spin_unlock (&chip->ac97_lock);
         file->private_data = chip->ac97;
         struct ac97_codec *codec = (struct ac97_codec *) 
file->private_data;
         if (!create_proc_read_entry("driver/forte/ac97", 0, 0, 
ac97_read_proc, forte->ac97)) {
         remove_proc_entry ("driver/forte/ac97", NULL);
         struct ac97_codec *codec;
         if ((codec = kmalloc (sizeof (struct ac97_codec), GFP_KERNEL)) 
== NULL)
         memset (codec, 0, sizeof (struct ac97_codec));
         codec->codec_read = forte_ac97_read;
         codec->codec_write = forte_ac97_write;
         if (ac97_probe_codec (codec) == 0) {
         chip->ac97 = codec;
         spin_lock_init (&chip->ac97_lock);
         unregister_sound_mixer (chip->ac97->dev_mixer);

ie, it has a ac97 support in the driver, it calls ac97_probe_codec?

Is that enough or not?

