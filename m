Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310410AbSCBSTV>; Sat, 2 Mar 2002 13:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310415AbSCBSTN>; Sat, 2 Mar 2002 13:19:13 -0500
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:12009 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S310410AbSCBSS5>; Sat, 2 Mar 2002 13:18:57 -0500
From: Chris Rankin <cj.rankin@ntlworld.com>
Message-Id: <200203021818.g22IIo27021932@twopit.underworld>
Subject: NOW have 'D-state' processes in 2.4.17 !!!
To: andrea@suse.de, rgooch@vindaloo.ras.ucalgary.ca
Date: Sat, 2 Mar 2002 18:18:50 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[Linux 2.4.17, SMP, devfs, 1.2 GB memory, compiled with gcc-2.95.3,
root partition using EXT3]

I upgraded to 2.4.18 a few days ago, but immediately downgraded
because I suddenly had lots of 'D-state' processes. Well I have now
produced a suspiciously-similar-looking D-state process using 2.4.17,
and I strongly suspect that either EXT3 or ALSA is somehow involved
because mounting my root partition as EXT3 and adding the latest CVS
ALSA modules are the only changes that I have made from my previous
reliable 2.4.17 setup.

The trace of the misbehaving process looks almost exactly like the
last trace from 2.4.18, except this time I have run it through
ksymoops:

Proc;  wine
>>EIP; f6b2c780 <_end+36829cb4/38556534>   <=====
Trace; c0105af4 <__down+6c/c8>
Trace; c0105c90 <__down_failed+8/c>
Trace; fb3297c6 <[snd-pcm].text.end+238/612>
Trace; fb323c0c <[snd-pcm]snd_pcm_playback_ioctl1+6c/340>
Trace; c0143474 <kill_fasync+2c/48>
Trace; c015a710 <ext3_get_block_handle+bc/2a8>
Trace; c015a710 <ext3_get_block_handle+bc/2a8>
Trace; c012eeae <__alloc_pages+32/164>
Trace; fb326214 <[snd-pcm]snd_pcm_hw_constraint_minmax+34/40>
Trace; fb3230d8 <[snd-pcm]snd_pcm_hw_constraints_complete+138/160>
Trace; fb3e72a0 <[snd-pcm-oss]snd_pcm_oss_open_file+100/220>
Trace; fb3e751e <[snd-pcm-oss]snd_pcm_oss_open+15e/270>
Trace; fb3e7540 <[snd-pcm-oss]snd_pcm_oss_open+180/270>
Trace; c013f600 <link_path_walk+6c0/850>
Trace; c013ead0 <vfs_permission+74/f0>
Trace; c0170b08 <devfs_open+b8/168>
Trace; fb324284 <[snd-pcm]snd_pcm_kernel_playback_ioctl+34/40>
Trace; fb3e6388 <[snd-pcm-oss]snd_pcm_oss_reset+18/50>
Trace; c01437a6 <sys_ioctl+1ba/214>
Trace; c0106dba <system_call+32/38>

Even more interestingly, this process was freed when I killed the
second wine process. This second process's trace looks like this:

Proc;  wine
>>EIP; e0ce3c58 <_end+209e118c/38556534>   <=====
Trace; c011388a <schedule_timeout+7a/9c>
Trace; c01137b0 <process_timeout+0/60>
Trace; fb3222b2 <[snd-pcm]snd_pcm_playback_drain+162/280>
Trace; fb323c5c <[snd-pcm]snd_pcm_playback_ioctl1+bc/340>
Trace; fb3304f2 <[snd-emu10k1]snd_emu10k1_capture_prepare+52/130>
Trace; fb330590 <[snd-emu10k1]snd_emu10k1_capture_prepare+f0/130>
Trace; fb322010 <[snd-pcm]snd_pcm_prepare+e0/1b0>
Trace; c01ffdd6 <__delay+12/28>
Trace; c01ffe44 <__const_udelay+28/34>
Trace; f88da65a <[eepro100]speedo_start_xmit+162/1f0>
Trace; c0162a5e <do_get_write_access+5f6/61c>
Trace; c0163d64 <__journal_file_buffer+e4/21c>
Trace; c016312c <journal_dirty_metadata+1a4/1cc>
Trace; c015cb9e <ext3_do_update_inode+2fa/398>
Trace; c015cc06 <ext3_do_update_inode+362/398>
Trace; c015d00e <ext3_mark_iloc_dirty+22/48>
Trace; c015d01e <ext3_mark_iloc_dirty+32/48>
Trace; c015d108 <ext3_mark_inode_dirty+28/34>
Trace; c015d1c2 <ext3_dirty_inode+ae/118>
Trace; c0148c12 <__mark_inode_dirty+2e/98>
Trace; c01577e8 <ext3_free_blocks+5a0/5ac>
Trace; c011fa74 <wake_up_parent+1c/30>
Trace; c011fb3a <do_notify_parent+b2/bc>
Trace; c0128984 <filemap_nopage+bc/1f8>
Trace; c01137a6 <reschedule_idle+25e/268>
Trace; fb324284 <[snd-pcm]snd_pcm_kernel_playback_ioctl+34/40>
Trace; c01c53ae <sock_def_wakeup+32/40>
Trace; fb3e64a6 <[snd-pcm-oss]snd_pcm_oss_sync+e6/180>
Trace; fb3e7648 <[snd-pcm-oss]snd_pcm_oss_release+18/80>
Trace; c01362b4 <fput+4c/e8>
Trace; c013514a <filp_close+aa/b4>
Trace; c01191f8 <put_files_struct+58/c0>
Trace; c01199ce <do_exit+12e/27c>
Trace; c0119b42 <sys_exit+e/10>
Trace; c0106dba <system_call+32/38>

Is any of this useful to anybody?
Cheers,
Chris
