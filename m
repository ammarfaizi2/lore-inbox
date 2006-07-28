Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751872AbWG1NOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbWG1NOX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 09:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751974AbWG1NOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 09:14:23 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:8708 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751390AbWG1NOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 09:14:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Hejbh8kQb0zDm5Z94TCkN6mjQGsLhOhgq4HHhShz0xCbwsJ/6bIcCuhMeorxLgw+D7+ivRZDRRafwnJ4xpLcgDM2XmWCMCrwUPy3rEEXwKpx3AgOeyjl12/CcIYpBWTNmIlcuK4QN7TQFLazoIgIF49Muj9+Sol1hWUklynKRpk=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: Sound problems with snd_hda on x86_64
Date: Fri, 28 Jul 2006 15:14:13 +0200
User-Agent: KMail/1.8.2
Cc: Andi Kleen <ak@suse.de>, PeiSen Hou <pshou@realtek.com.tw>,
       linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org
References: <200607281216.25214.vda.linux@googlemail.com> <200607281247.11986.vda.linux@googlemail.com> <s5hmzaunevd.wl%tiwai@suse.de>
In-Reply-To: <s5hmzaunevd.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607281514.14085.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 July 2006 13:33, Takashi Iwai wrote:
> > Why artsd attempts mmap at all then?
> 
> The app must try mmap.  From the application side, you can't know
> whether you're 32bit-emulation mode or it's really on 32bit
> architecture.  And, mmap is usually done automatically via alsa-lib
> plugin for optimization or soft-mixing purpose.

Well, alsa seems to have info about mmap-ability here:

static struct snd_pcm_hardware azx_pcm_hw = {
        .info =                 (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
                                 SNDRV_PCM_INFO_BLOCK_TRANSFER |
                                 SNDRV_PCM_INFO_MMAP_VALID |
                                 SNDRV_PCM_INFO_PAUSE /*|*/
                                 /*SNDRV_PCM_INFO_RESUME*/),
...
};

but it is not split into "can mmap data", "can mmap control/status".
When this one triggers:

snd_pcm_ioctl_compat()
...
        /*
         * When PCM is used on 32bit mode, we need to disable
         * mmap of PCM status/control records because of the size
         * incompatibility.
         */
        substream->no_mmap_ctrl = 1;

It does not clear any such flags. If there will be separate bits
for data and "status/control", should they be cleared here too?

What will happen if fd is opened in 64-bit process and then
process will exec a 32-bit one, _after_ doing ioctl
but _before_ mmap?! substream->no_mmap_ctrl will remain cleared.
Looks disastrous.

And still _now_ there is only one bit. Does it mean
"mmap works on data and status/control" or 
"mmap works on data and _maybe_ on status/control"?

Another matter. IIRC this mmap is not to the hardware
(hardware memory-mapped structures won't change layout when one
replaces 32bit kernel by 64bit one) but to some software alsa
structure. Can it be made more clever in this case, like
using 32bit structure for 32bit tasks? Or allowing 32bit tasks
to detect that structure is 64bit and they should use it?
Second one sounds saner.

Looks like real mess to me.
--
vda
