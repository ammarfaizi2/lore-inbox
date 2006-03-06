Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752371AbWCFKdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbWCFKdh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 05:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbWCFKdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 05:33:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64693 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752370AbWCFKdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 05:33:36 -0500
Date: Mon, 6 Mar 2006 02:31:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: greg@kroah.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       davej@redhat.com
Subject: Re: Fw: Re: oops in choose_configuration()
Message-Id: <20060306023147.7a7d727f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603052043170.13139@g5.osdl.org>
References: <20060304121723.19fe9b4b.akpm@osdl.org>
	<Pine.LNX.4.64.0603041235110.22647@g5.osdl.org>
	<20060304213447.GA4445@kroah.com>
	<20060304135138.613021bd.akpm@osdl.org>
	<20060304221810.GA20011@kroah.com>
	<20060305154858.0fb0006a.akpm@osdl.org>
	<Pine.LNX.4.64.0603052043170.13139@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Sun, 5 Mar 2006, Andrew Morton wrote:
> > 
> > For several days I've been getting repeatable oopses in the -mm kernel. 
> > They occur once per ~30 boots, during initscripts.
> 
> Actually, having thought about this some more, I wonder if the bug isn't a 
> hell of a lot simpler than we've given it credit for.
> 
> I think you're running with CONFIG_PREEMPT_VOLUNTARY, right?

Yes.

> ...
> And CONFIG_PREEMPT_VOLUNTARY turns those false positives into potential 
> rescheduling events.

Yes.  A similar problem exists with CONFIG_PREEMPT_BKL - we're doing down()
inside lock_kenrel() in situations where we shouldn't be sleeping yet. 
That's one of the reasons why might_sleep() is suppressed early in boot. 
We assume that the down() won't be contented early in boot.  We were
looking at fixing all that up a month or so back, but the patches started
getting pretty ugly.

Still.  If either lock_kernel() or cond_resched() _do_ sleep, we'll
hopefully get scheduling-while-atomic warnings.

> index 12d291b..3454bb8 100644
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -4028,6 +4028,8 @@ static inline void __cond_resched(void)
>  	 */
>  	if (unlikely(preempt_count()))
>  		return;
> +	if (unlikely(system_state != SYSTEM_RUNNING))
> +		return;
>  	do {
>  		add_preempt_count(PREEMPT_ACTIVE);
>  		schedule();

It died after 35 reboots.

SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1141611448.702:3): policy loaded auid=4294967295
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
BUG: unable to handle kernel paging request at virtual address 464c4583
 printing eip:
*pde = 3f1ea067
Oops: 0002 [#1]
last sysfs file: /devices/pci0000:00/0000:00:1d.2/usb3/idVendor
Modules linked in: nvram snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq ide_cd cdrom snd_seq_device snd_pcm_oss ipw2200 snd_mixer_oss ieee80211 ieee80211_crypt ohci1394 snd_pcm ieee1394 uhci_hcd sg ehci_hcd joydev snd_timer snd soundcore i2c_i801 piix i2c_core hw_random snd_page_alloc generic ext3 jbd ide_disk ide_core
CPU:    0
EIP:    0060:[<c0128d66>]    Not tainted VLI
EFLAGS: 00010046   (2.6.16-rc5-mm2 #303) 
EIP is at prepare_to_wait+0x19/0x3b
eax: 464c457f   ebx: f776cf08   ecx: 00000246   edx: f776cf14
esi: f76fde00   edi: 00000041   ebp: f71378d0   esp: f776ced0
ds: 007b   es: 007b   ss: 0068
Process loadkeys (pid: 1119, threadinfo=f776c000 task=f7eaa030)
Stack: <0>f7137940 f776cefc f776cf1c c015db02 f7137940 f776cee8 00000000 f7eaa030 
       c0128e0b f776cf14 f776cf14 00000246 c02c0f02 c015dc4b 00000000 f7eaa030 
       c0128e0b f776cf14 f776cf14 c01a0a63 f776cf34 00000000 f76fde00 f7cbb240 
Call Trace:
 <c015db02> pipe_wait+0x66/0x90   <c0128e0b> autoremove_wake_function+0x0/0x2d
 <c02c0f02> __mutex_lock_slowpath+0x1e1/0x339   <c015dc4b> pipe_readv+0x58/0x25a
 <c0128e0b> autoremove_wake_function+0x0/0x2d   <c01a0a63> file_has_perm+0x87/0x8a
 <c015dd36> pipe_readv+0x143/0x25a   <c015de69> pipe_read+0x1c/0x20
 <c0153d36> vfs_read+0xae/0x14e   <c015405e> sys_read+0x3c/0x64
 <c0102a9b> sysenter_past_esp+0x54/0x75  
Code: 43 04 00 02 20 00 c7 42 0c 00 01 10 00 56 9d 5b 5e c3 57 89 cf 56 89 c6 53 89 d3 83 22 fe 9c 59 fa 8d 52 0c 39 53 0c 75 0d 8b 00 <89> 50 04 89 43 0c 89 72 04 89 16 83 7b 04 00 74 0b b8 00 f0 ff 


That's "\7fELF" again, plus 4 bytes.

Note that this time it's the sleeper that went splat - usually it's the
waker.


I don't think that a bisection search of mainline (adding the sched patches
each time) will be fruitful really.  Just breathing on this thing makes the
crashes go away.

