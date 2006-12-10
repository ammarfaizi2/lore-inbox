Return-Path: <linux-kernel-owner+w=401wt.eu-S1762359AbWLJTCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762359AbWLJTCK (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 14:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762711AbWLJTCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 14:02:09 -0500
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:48209 "EHLO
	rwcrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762708AbWLJTCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 14:02:08 -0500
Date: Sun, 10 Dec 2006 11:02:02 -0800
From: Maxime Austruy <maxime@tralhalla.org>
To: matthieu castet <castet.matthieu@free.fr>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Daniel Drake <dsd@gentoo.org>, Ulrich Kunitz <kune@deine-taler.de>
Subject: Re: 2.6.19 lot's of oops in  mmx_copy_page/ mmx_clear_page functions
Message-ID: <20061210190202.GA16992@tralhalla.org>
References: <457BF038.6080003@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457BF038.6080003@free.fr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Matthieu,

On Sun, Dec 10, 2006 at 12:32:08PM +0100, matthieu castet wrote:
> Hi,
> 
> with 2.6.19 I got some random crash and I got kernel opps.
> There all happens in  mmx_copy_page/ mmx_clear_page functions with 
> differents process : Xorg, cat, mozilla, ...
> 
> 
> What could be the cause of these crashes ?
> What can I provide in order to debug this ?

FWIW, I've seen the same oops on my box. My instance was caused by a
combination of:
 . zd1211rw calling ieee80211_rx in irq context while it's supposed to
   be called in softirq,
 . crypto code only expecting to be called in softirq/user context but
   not enforcing it.  Consequently, it ends up doing 
      v = kmap_atomic(..., KM_USER0);
   even when invoked by the zd1211rw driver in irq context, causing some
   corruption.

Given that you have zd1211rw insmod'd, that could be it.  I have some
hacks that work around this bug, but Ulrich has a patch ready that
should fix this. Thanks,

Max

> 
> 
> Thanks
> 
> Matthieu CASTET
> 
> 
> 
> BUG: unable to handle kernel paging request at virtual address fffb9000
>  printing eip:
> c01be1bd
> *pde = 00002067
> Oops: 0000 [#1]
> PREEMPT
> Modules linked in: michael_mic arc4 ecb ieee80211_crypt_tkip ehci_hcd 
> videodev v4l1_compat v4l2_common nfs nfsd exportfs lockd sunrpc sd_mod 
> sg sr_mod ppdev lp autofs4 button processor ipt_TOS ipt_MASQUERADE 
> ipt_ULOG ipt_LOG xt_tcpudp xt_state ipt_REJECT ipt_iprange xt_conntrack 
> iptable_mangle ip_nat_irc ip_nat_ftp iptable_nat ip_nat ip_conntrack_irc 
> ip_conntrack_ftp ip_conntrack iptable_filter ip_tables x_tables ide_cd 
> cdrom pcspkr snd_mpu401 ns558 parport_pc parport 8250_pnp 8250 
> serial_core floppy snd_via82xx snd_mpu401_uart emu10k1_gp gameport 
> snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul 
> snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq snd_emu10k1 
> snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss 
> snd_pcm snd_seq_device snd_timer snd_page_alloc snd_util_mem snd_hwdep 
> snd soundcore mii zd1211rw firmware_class ieee80211softmac ieee80211 
> ieee80211_crypt via_agp agpgart clip atm nls_iso8859_1 nls_cp437 vfat 
> fat nls_base reiserfs w83627hf hwmon_vid i2c_isa i2c_core evdev rtc
> CPU:    0
> EIP:    0060:[<c01be1bd>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.19 #1)
> EIP is at mmx_copy_page+0x51/0x123
> eax: fffb9000   ebx: e2db9000   ecx: 00000000   edx: e2db9000
> esi: fffb9000   edi: e2db9000   ebp: c17e6040   esp: f671defc
> ds: 007b   es: 007b   ss: 0068
> Process automount (pid: 11921, ti=f671c000 task=f7cf0050 task.ti=f671c000)
> Stack: fffb9000 eb216040 c0140045 8001003c f5c95e40 f4ee2abc c145b720 
> 00000000
>        3f302065 f4ee2afc eb216040 f5c95e40 c014145f eb216040 f4f8a800 
> f4ee2afc
>        3f302065 393b4393 8001003c f4ee2abc 00000040 f4f8a800 00000000 
> f671df94
> Call Trace:
>  [<c0140045>] do_wp_page+0x291/0x414
>  [<c014145f>] __handle_mm_fault+0x7d2/0x873
>  [<c0112593>] do_page_fault+0x213/0x4dc
>  [<c0112380>] do_page_fault+0x0/0x4dc
>  [<c02a01e1>] error_code+0x39/0x40
>  =======================
> Code: f4 ff 0f 0d 06 0f 0d 46 40 0f 0d 86 80 00 00 00 0f 0d 86 c0 00 00 
> 00 0f 0d 86 00 01 00 00 31 c9 89 fa 89 f0 0f 0d 80 40 01 00 00 <0f> 6f 
> 00 0f e7 02 0f 6f 48 08 0f e7 4a 08 0f 6f 50 10 0f e7 52
> EIP: [<c01be1bd>] mmx_copy_page+0x51/0x123 SS:ESP 0068:f671defc
>  <6>note: automount[11921] exited with preempt_count 3
> 
> 
> 
> Sumary of Others failures :
> /var/log/syslog:Dec 10 10:40:14 localhost kernel: BUG: unable to handle 
> kernel paging request at virtual address fffb9b20
> /var/log/syslog:Dec 10 10:40:14 localhost kernel: EIP is at 
> mmx_clear_page+0x38/0x7e
> /var/log/syslog:Dec 10 10:40:14 localhost kernel: Process iceape-bin 
> (pid: 7061, ti=f7410000 task=eeb5a070 task.ti=f7410000)
> /var/log/syslog:Dec 10 10:40:14 localhost kernel: EIP: [<c01be406>] 
> mmx_clear_page+0x38/0x7e SS:ESP 0068:f7411eb0
> /var/log/syslog:Dec 10 10:40:24 localhost kernel: BUG: unable to handle 
> kernel paging request at virtual address fffb9a60
> /var/log/syslog:Dec 10 10:40:24 localhost kernel: EIP is at 
> mmx_clear_page+0x38/0x7e
> /var/log/syslog:Dec 10 10:40:24 localhost kernel: Process cc1 (pid: 
> 21797, ti=d62ea000 task=e86eb070 task.ti=d62ea000)
> /var/log/syslog:Dec 10 10:40:24 localhost kernel: EIP: [<c01be406>] 
> mmx_clear_page+0x38/0x7e SS:ESP 0068:d62ebeb0
> /var/log/syslog:Dec 10 11:12:37 localhost kernel: BUG: unable to handle 
> kernel paging request at virtual address fffb9000
> /var/log/syslog:Dec 10 11:12:37 localhost kernel: EIP is at 
> mmx_copy_page+0x51/0x123
> /var/log/syslog:Dec 10 11:12:37 localhost kernel: Process automount 
> (pid: 11921, ti=f671c000 task=f7cf0050 task.ti=f671c000)
> /var/log/syslog:Dec 10 11:12:37 localhost kernel: EIP: [<c01be1bd>] 
> mmx_copy_page+0x51/0x123 SS:ESP 0068:f671defc
> /var/log/syslog.0:Dec  9 19:21:50 localhost kernel: Process modprobe 
> (pid: 20516, ti=ee3d8000 task=f649f580 task.ti=ee3d8000)
> /var/log/syslog.0:Dec  9 22:15:15 localhost kernel: BUG: unable to 
> handle kernel paging request at virtual address fffb9000
> /var/log/syslog.0:Dec  9 22:15:15 localhost kernel: EIP is at 
> mmx_clear_page+0x29/0x7e
> /var/log/syslog.0:Dec  9 22:15:15 localhost kernel: Process Xorg (pid: 
> 9479, ti=d4ae0000 task=f671ca90 task.ti=d4ae0000)
> /var/log/syslog.0:Dec  9 22:15:15 localhost kernel: EIP: [<c01be3f7>] 
> mmx_clear_page+0x29/0x7e SS:ESP 0068:d4ae1eb0
> /var/log/syslog.0:Dec  9 22:15:15 localhost kernel:  [<c01be3f7>] 
> mmx_clear_page+0x29/0x7e
> /var/log/syslog.0:Dec  9 22:15:15 localhost kernel:  [<c01be3f7>] 
> mmx_clear_page+0x29/0x7e
> /var/log/syslog.0:Dec 10 00:06:31 localhost kernel: BUG: unable to 
> handle kernel paging request at virtual address fffb9340
> /var/log/syslog.0:Dec 10 00:06:31 localhost kernel: EIP is at 
> mmx_clear_page+0x29/0x7e
> /var/log/syslog.0:Dec 10 00:06:31 localhost kernel: Process Xorg (pid: 
> 10450, ti=c758e000 task=d42fa030 task.ti=c758e000)
> /var/log/syslog.0:Dec 10 00:06:31 localhost kernel: EIP: [<c01be3f7>] 
> mmx_clear_page+0x29/0x7e SS:ESP 0068:c758feb0
> /var/log/syslog.0:Dec 10 00:06:31 localhost kernel:  [<c01be3f7>] 
> mmx_clear_page+0x29/0x7e
> /var/log/syslog.0:Dec 10 00:06:31 localhost kernel:  [<c01be3f7>] 
> mmx_clear_page+0x29/0x7e
> /var/log/syslog.0:Dec 10 10:23:00 localhost kernel: BUG: unable to 
> handle kernel paging request at virtual address fffb9000
> /var/log/syslog.0:Dec 10 10:23:00 localhost kernel: EIP is at 
> mmx_copy_page+0x51/0x123
> /var/log/syslog.0:Dec 10 10:23:00 localhost kernel: Process cat (pid: 
> 8977, ti=db79c000 task=df987030 task.ti=db79c000)
> /var/log/syslog.0:Dec 10 10:23:00 localhost kernel: EIP: [<c01be1bd>] 
> mmx_copy_page+0x51/0x123 SS:ESP 0068:db79ddc8
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
