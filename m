Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932740AbWBUPvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932740AbWBUPvi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 10:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbWBUPvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 10:51:38 -0500
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:55252 "EHLO
	smtpq1.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S932740AbWBUPvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 10:51:37 -0500
Message-ID: <43FB3718.6060503@keyaccess.nl>
Date: Tue, 21 Feb 2006 16:51:52 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Adam Belay <ambx1@neo.rr.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       alsa-devel@alsa-project.org
Subject: Re: snd-cs4236 (possibly all isa-pnp cards or all alsa isa-pnp cards)
 broken in 2.6.16-rc4
References: <43F9F9F2.4070203@keyaccess.nl> <s5hu0askd7e.wl%tiwai@suse.de>
In-Reply-To: <s5hu0askd7e.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:

> Rene Herman wrote:

>> I noticed on 2.6.16-rc4 that my MPU-401 wasn't functional, due to a
>> simple copy & paste error in sound/isa/cs423x/cs4236.c:
> 
> Thanks, I applied it to ALSA CVS tree, too.

The patch Adam sent fixes the ".remove not called" issue. It _also_ 
fixes the OOPS in snd_timer_free() I sent along, so that one wasn't 
independent. During testing, I uncovered one more bug though.

After using aplaymidi (to test cs4236 mpu401), which pulls in 
snd-seq-oss, modprobe -r snd-cs4236 tells me:

"ALSA sound/core/device.c:106: device free eee4e000 (from f099153d), not 
found"

That then stays until reboot, with a different device address each time.

f099153d is snd_opl3_free_seq_oss() here. For now I've stuck a 
dump_stack() in there, which treats me to:

===
  [<f099152e>] snd_opl3_free_seq_oss+0x8/0x20 [snd_opl3_synth]
  [<f099044f>] snd_opl3_seq_delete_device+0x17/0x3c [snd_opl3_synth]
  [<f08f06ec>] free_device+0x4b/0x8e [snd_seq_device]
  [<f08f02da>] snd_seq_device_free+0x88/0xa9 [snd_seq_device]
  [<f09579a2>] snd_device_free+0x8b/0xf0 [snd]
  [<f0957ccd>] snd_device_free_all+0x67/0x7a [snd]
  [<f0953d01>] snd_card_free+0x111/0x1f3 [snd]
  [<c0134464>] zap_pte_range+0x1cf/0x1ec
  [<c026a76e>] wait_for_completion+0xc4/0xdf
  [<c010ea9b>] complete+0x2e/0x5c
  [<c010eaa9>] complete+0x3c/0x5c
  [<f096b7f9>] snd_cs423x_pnpc_remove+0xb/0x14 [snd_cs4236]
  [<c01c148b>] card_remove_first+0x2f/0x4a
  [<c01c1e3d>] pnp_device_remove+0x18/0x2d
  [<c01e149d>] __device_release_driver+0x53/0x6b
  [<c01e156a>] driver_detach+0x91/0xbf
  [<c01e0fac>] bus_remove_driver+0x27/0x41
  [<c01e181b>] driver_unregister+0xb/0x13
  [<c01c1f46>] pnp_unregister_driver+0xb/0x1b
  [<f096b826>] snd_cs423x_unregister_all+0x14/0x36 [snd_cs4236]
  [<c0126529>] sys_delete_module+0x12b/0x155
  [<c0137f6c>] do_munmap+0xe2/0xef
  [<c0137fae>] sys_munmap+0x35/0x4d
  [<c0102551>] syscall_call+0x7/0xb
ALSA sound/core/device.c:106: device free eee4e000 (from f099153d), not 
found
pnp: Device 01:01.03 disabled.
pnp: Device 01:01.02 disabled.
pnp: Device 01:01.00 disabled.
pnp: the driver 'cs4236_isapnp' has been unregistered
===

I'll try and see if I can find anything later, but if you could, please 
beat me to it. I'm not even quite sure what that oss sequencer thing is...

Rene.
