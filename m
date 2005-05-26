Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVEZXwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVEZXwZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 19:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVEZXwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 19:52:25 -0400
Received: from smtp05.auna.com ([62.81.186.15]:34028 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S261855AbVEZXwE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 19:52:04 -0400
Date: Thu, 26 May 2005 23:51:58 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.12-rc3-mm3: ALSA broken ?
To: linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>
References: <20050504221057.1e02a402.akpm@osdl.org>
	<1115510869l.7472l.0l@werewolf.able.es>
	<1115594680l.7540l.0l@werewolf.able.es> <s5hd5rx2656.wl@alsa2.suse.de>
	<1115936836l.8448l.1l@werewolf.able.es> <s5hvf5nsb2r.wl@alsa2.suse.de>
	<1116331359l.7364l.0l@werewolf.able.es> <s5hll6eoxhf.wl@alsa2.suse.de>
	<1116369585l.8840l.0l@werewolf.able.es> <s5hoeb8sleq.wl@alsa2.suse.de>
In-Reply-To: <s5hoeb8sleq.wl@alsa2.suse.de> (from tiwai@suse.de on Wed May
	18 15:39:41 2005)
X-Mailer: Balsa 2.3.2
Message-Id: <1117151518l.7637l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.219.120] Login:jamagallon@able.es Fecha:Fri, 27 May 2005 01:51:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.18, Takashi Iwai wrote:
> At Tue, 17 May 2005 22:39:45 +0000,
> J.A. Magallon wrote:
> > 
> > 
> > On 05.17, Takashi Iwai wrote:
> > ...
> > > > 
> > > > Example: go into 4ch mode. Check this control. Then switch to 6ch mode.
> > > > The Center jack has no sound (it should, shouldn't ?). Check it and voilà.
> > > > It looks that the logic in the channel selection needs to set this flag also...
> > > 
> > > Yep, you're right.  Try the patch below.
> > > 
> > > 
> > 
> > Thanks, this patch worked. When in 6ch mode, the boolen flag we talk about
> > still controls if the line jack is input or output. In 4ch mode, it is always
> > input. If i chech it, switching to 6ch does not toggle it. They are
> > independent controls.
> > 
> > Anyways. I can't get rid of the flag. It is initialized to on by default.
> > Isn't strange to have two ways of controlling this ?
> > 

Yehaaa, I got it...
There was a bug in your last patch.
This:

+	snd_ac97_update_bits(ac97, AC97_AD_SERIAL_CFG, 9 << 11,
+			     is_shared_micin(ac97) ? 0 : 9 << 11);

should be

+	snd_ac97_update_bits(ac97, AC97_AD_SERIAL_CFG, 1 << 9,
+			     is_shared_micin(ac97) ? 0 : 1 << 9);

Whit this, I can control the output just with the 2/4/6 ch mode, and get rid
of the 'Center as mic' flag...

btw, why the hell don't you use something as stupid as 

#define bit(n) (1<<(n))

???

A side note. In the process of solving all this, I tried to generate a patch
for 1.0.9rc4a against -mm. I noticed some things:
- Your code reverts some in-kernel changes related to
    if (ptr)
        kfree(ptr)
  The if is killed in mainline, as kfree accepts null pointers.

- When linking I got:
if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map
2.6.11-jam20; fi
WARNING: /lib/modules/2.6.11-jam20/kernel/sound/soundcore.ko needs unknown
symbol class_simple_device_add
WARNING: /lib/modules/2.6.11-jam20/kernel/sound/soundcore.ko needs unknown
symbol class_simple_destroy
WARNING: /lib/modules/2.6.11-jam20/kernel/sound/soundcore.ko needs unknown
symbol class_simple_device_remove
WARNING: /lib/modules/2.6.11-jam20/kernel/sound/soundcore.ko needs unknown
symbol class_simple_create
WARNING: /lib/modules/2.6.11-jam20/kernel/sound/core/snd.ko needs unknown
symbol class_simple_device_add
WARNING: /lib/modules/2.6.11-jam20/kernel/sound/core/snd.ko needs unknown
symbol class_simple_device_remove

I think all this have been unexported/killed...

Hope this helps.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam20 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


