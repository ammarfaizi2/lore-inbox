Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVC1XGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVC1XGO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 18:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVC1XGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 18:06:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:14562 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262111AbVC1XEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 18:04:20 -0500
Date: Mon, 28 Mar 2005 15:04:16 -0800
From: Chris Wright <chrisw@osdl.org>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: Chris Wright <chrisw@osdl.org>, Ali Akcaagac <aliakc@web.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel OOOPS in 2.6.11.6
Message-ID: <20050328230416.GP30522@shell0.pdx.osdl.net>
References: <1112008141.17962.1.camel@localhost> <20050328224430.GO28536@shell0.pdx.osdl.net> <2cd57c9005032814572b7e9bac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c9005032814572b7e9bac@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Coywolf Qi Hunt (coywolf@gmail.com) wrote:
> On Mon, 28 Mar 2005 14:44:30 -0800, Chris Wright <chrisw@osdl.org> wrote:
> > * Ali Akcaagac (aliakc@web.de) wrote:
> > > And happy easter to you all. Just got this while trying to delete some
> > > files on my system.
> > 
> > I'm curious, what was the virtual address the kernel was "Unable to handle..."
> > That part was left off this bug report.
> > 
> > > :  printing eip:
> > > : c021f089
> > > : *pde = 00000000
> > > : Oops: 0000 [#1]
> > > : PREEMPT
> > > : Modules linked in: snd_seq_midi snd_emu10k1_synth snd_emux_synth
> > > snd_seq_virmidi snd_seq_midi_event snd_seq_midi_emul snd_seq snd_emu10k1
> > > snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer
> > > snd_page_alloc snd_util_mem snd_hwdep snd soundcore parport_pc lp
> > > parport 8139too mii crc32
> > > : CPU:    0
> > > : EIP:    0060:[linvfs_open+89/160]    Not tainted VLI
> > > : EFLAGS: 00010282   (2.6.11.6)
> > > : EIP is at linvfs_open+0x59/0xa0
> > 
> > Nothing in the -stable series has changed either XFS or the core vfs
> > path on during file open.  Without a chance of reproducing or any more
> > information, it'll be tough to make much progress here.
> > 
> > > : eax: 00000000   ebx: c77ac06c   ecx: 00000001   edx: c021f030
> > > : esi: 00000000   edi: c77ac050   ebp: dffe41a0   esp: c2d95f14
> > > : ds: 007b   es: 007b   ss: 0068
> > > : Process mc (pid: 17862, threadinfo=c2d94000 task=d18d2a80)
> > > : Stack: c01561a9 dffe41a0 d73504c0 00000000 c77ac06c c015446b c77ac06c
> > > d73504c0
> > > :        00000001 ffffffe9 00008000 00008000 dc364000 c2d94000 c015426c
> > > cbcdff54
> > > :        dffe41a0 00008000 c2d95f60 cbcdff54 dffe41a0 bfffeef0 0d00ad72
> > > 00300001
> > > : Call Trace:
> > > :  [get_empty_filp+89/208] get_empty_filp+0x59/0xd0
> > > :  [dentry_open+491/672] dentry_open+0x1eb/0x2a0
> > > :  [filp_open+92/112] filp_open+0x5c/0x70
> > > :  [get_unused_fd+123/224] get_unused_fd+0x7b/0xe0
> > > :  [sys_open+73/144] sys_open+0x49/0x90
> > > :  [syscall_call+7/11] syscall_call+0x7/0xb
> > > : Code: 5b 3c b8 01 00 00 00 e8 c6 42 ef ff b8 00 e0 ff ff 21 e0 8b 40
> > > 08 a8 08 75 4d 85 f6 7c 0a 7f 32 81 fb ff ff ff 7f 77 2a 8b 47 14 <8b>
> > > 50 08 c7 44 24 04 00 00 00 00 89 04 24 ff 52 04 8b 5c 24 08
> > 
> > Best I can tell, you hit this:
> > 
> >  mov    0x8(%eax),%edx
> > 
> > with eax == 00000000.  This corresponds to a vp->v_fops (or rather
> > vp->v_bh.bh_first->bd_ops) deref.  So, looks like the vnode has a
> > NULL v_bh.bh_first (which looks like it's meant to be used to mean
> > uninitialized).  May check with XFS folks if they've seen this type
> > of bug.
> 
> I think it is f = kmem_cache_alloc(filp_cachep, GFP_KERNEL); returns an
> invalid pointer, then in memset(f, 0, sizeof(*f)); fault happens at address f.
> eax == 0 is to clear the memory in memset().

The trace indicates it's in linvfs_open
(EIP: 0060:[linvfs_open+89/160])
and the insturction dump at the end supports that.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
