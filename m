Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270681AbTGNPoR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 11:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270691AbTGNPoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 11:44:16 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:52616 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S270681AbTGNPoK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 11:44:10 -0400
Date: Mon, 14 Jul 2003 08:59:55 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Max Valdez <maxvalde@fis.unam.mx>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: no sound on 2.5.75-mm1 (emu10k1 loaded)
Message-ID: <20030714085955.A7342@beaverton.ibm.com>
References: <1058115661.6491.6.camel@garaged.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1058115661.6491.6.camel@garaged.homeip.net>; from maxvalde@fis.unam.mx on Sun, Jul 13, 2003 at 12:01:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 12:01:02PM -0500, Max Valdez wrote:

> fool, but I just can't find it, here is my config attached, a dmesg and
> lsmod. There is no /dev/dsp device, no /dev/sound either.

> Module                  Size  Used by
> mousedev                7260  - 
> usbcore               102964  - 
> nfs                   103468  - 
> lockd                  60080  - 
> sunrpc                134820  - 
> emu10k1                74688  - 
> sound                  82444  - 
> soundcore               6784  - 
> ac97_codec             13408  - 
> aic7xxx               213488  - 
> 3c59x                  31240  - 
> sg                     31020  - 
> sd_mod                 12000  - 
> st                     34548  - 
> sr_mod                 14016  - 
> scsi_mod               69068  - 
> cdrom                  33664  - 

Max -

I'm running fine with emu10k1.

I was missing /dev/dsp (well could not correctly open it, no devfs), I
think the missing modules were the snd_pcm and snd_pcm_oss. Anyway, I setup
my /etc/modprobe.conf (not /etc/modules.conf) using generate_modprobe.conf
to generate the base file.

The "sound" portion of my modprobe.conf has:

---------------------------
alias char-major-116 snd
alias sound-slot-0 snd_emu10k1

alias char_major_14 soundcore
install sound-slot-0 /sbin/modprobe --ignore-install sound-slot-0 && { /bin/aumix-minimal -f /etc/.aumixrc -L >/dev/null 2>&1 || :; }
remove sound-slot-0 { /bin/aumix-minimal -f /etc/.aumixrc -S >/dev/null 2>&1 || :; }; /sbin/modprobe -r --ignore-remove sound-slot-0

alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

install sound_slot_1 /bin/true
install sound_service_1_0 /bin/true
---------------------------

And I have these modules loaded:

Module                  Size  Used by
snd_pcm_oss            50020  0 
snd_mixer_oss          14976  2 snd_pcm_oss
snd_emu10k1            80196  1 
snd_rawmidi            19456  1 snd_emu10k1
snd_pcm                80960  2 snd_pcm_oss,snd_emu10k1
snd_timer              20416  1 snd_pcm
snd_seq_device          6532  2 snd_emu10k1,snd_rawmidi
snd_ac97_codec         42884  1 snd_emu10k1
snd_page_alloc          7908  2 snd_emu10k1,snd_pcm
snd_util_mem            3424  1 snd_emu10k1
snd_hwdep               6752  1 snd_emu10k1
snd                    42592  10 snd_pcm_oss,snd_mixer_oss,snd_emu10k1,snd_rawmidi,snd_pcm,snd_timer,snd_seq_device,snd_ac97_codec,snd_util_mem,snd_hwdep
soundcore               7104  2 snd
r128                   83544  24 
binfmt_misc             8072  0 
nfs                    87756  2 
lockd                  60256  2 nfs,[unsafe]
sunrpc                113728  5 nfs,lockd
8139too                19680  0 
mii                     4128  1 8139too
crc32                   4096  1 8139too
ide_scsi               12288  0 
scsi_mod              102156  1 ide_scsi
vfat                   12960  2 
fat                    40736  1 vfat

-- Patrick Mansfield
