Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbVKOQoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbVKOQoI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbVKOQoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:44:08 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:50099 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S964893AbVKOQoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:44:07 -0500
From: Duncan Sands <baldrick@free.fr>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.15-rc1-git1: BTTV: no picture with grabdisplay; later, an Oops
Date: Tue, 15 Nov 2005 17:44:03 +0100
User-Agent: KMail/1.8.3
Cc: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org,
       mchehab@brturbo.com.br
References: <20051115141305.049CF14200@rhn.tartu-labor> <Pine.LNX.4.61.0511151508110.3622@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0511151508110.3622@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511151744.04320.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

On Tuesday 15 November 2005 16:15, Hugh Dickins wrote:
> On Tue, 15 Nov 2005, Meelis Roos wrote:
> > DS> When I change channels, a picture flashes onto the screen for a fraction of
> > DS> a second, then the screen becomes black.  The picture glimpsed seems to be =
> > DS> four
> > DS> copies of the tv show, arranged in a 2x2 matrix.
> > 
> > Similar "Bad address" and "Invalid argument" errors here. xawtv works
> > but only in overlay mode. tvtime tries non-overlay and gets these
> > errors. Card is Hauppauge WinTV with bt878. 2.6.14 works.
> 
> This is likely to be due to the PageReserved changes, as were other bttv
> problems reported.  We're still working on the right patch for that,
> or might even revert.  In the meanwhile you could try removing the
> " | VM_RESERVED" from mm/memory.c get_user_pages(), to see if that
> really does correct it (though it's not the whole of the right answer).

with this change, I can't get as far as selecting channels (previous situation):
I consistently get the following Oops on starting xawtv (tried three times).
However, as well as your change I slimmed down my kernel config and turned on
CONFIG_DEBUG_PAGEALLOC, so it is not clear whether the change to memory.c is
responsable.  I will try again, reverting the memory.c change.

[4294993.999000] Unable to handle kernel paging request at virtual address cf81f000
[4294994.024000]  printing eip:
[4294994.033000] e0b6f738
[4294994.041000] *pde = 0003e067
[4294994.051000] *pte = 0f81f000
[4294994.060000] Oops: 0002 [#1]
[4294994.060000] DEBUG_PAGEALLOC
[4294994.060000] Modules linked in: af_packet md5 ipv6 usblp radeon drm tun video thermal processor fan button ipt_TOS ipt_MASQUERADE ipt_REJECT ipt_LOG ipt_state ipt_pkttype ipt_owner ipt_iprange ipt_multiport ipt_conntrack iptable_mangle ip_nat_irc ip_nat_tftp ip_nat_ftp iptable_nat ip_nat ip_conntrack_irc ip_conntrack_tftp ip_conntrack_ftp ip_conntrack iptable_filter ip_tables generic i2c_viapro uhci_hcd usbcore snd_bt87x tuner tvaudio bttv video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc tveeprom i2c_core videodev snd_cs46xx snd_rawmidi snd_seq_device snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc via_agp agpgart nls_cp437 ntfs ide_cd cdrom mousedev psmouse unix
[4294994.060000] CPU:    0
[4294994.060000] EIP:    0060:[<e0b6f738>]    Not tainted VLI
[4294994.060000] EFLAGS: 00210202   (2.6.15-rc1-git1)
[4294994.060000] EIP is at bttv_risc_packed+0x168/0x190 [bttv]
[4294994.060000] eax: 14000008   ebx: 00000408   ecx: cf81f000   edx: d17f5800
[4294994.060000] esi: 00000008   edi: d17f5800   ebp: d184ce6c   esp: d184ce54
[4294994.060000] ds: 007b   es: 007b   ss: 0068
[4294994.060000] Process xawtv (pid: 7506, threadinfo=d184c000 task=d5ba6ab0)
[4294994.060000] Stack: d059cfbc e0b83560 000000ff 000d8000 00000c00 d059cef8 d184ced4 e0b70fca
[4294994.060000]        00000c00 00000c00 00000c00 00000120 00000008 000001b1 d059cf1c d059cf1c
[4294994.060000]        c1753bf8 d184ceb4 e0b83560 aeaf0000 00000000 d059cef8 e0b72598 000d8000
[4294994.060000] Call Trace:
[4294994.060000]  [<c01039a7>] show_stack+0x97/0xd0
[4294994.060000]  [<c0103b55>] show_registers+0x155/0x1f0
[4294994.060000]  [<c0103d72>] die+0xe2/0x170
[4294994.060000]  [<c02c08cc>] do_page_fault+0x1ec/0x648
[4294994.060000]  [<c0103643>] error_code+0x4f/0x54
[4294994.060000]  [<e0b70fca>] bttv_buffer_risc+0x61a/0x640 [bttv]
[4294994.060000]  [<e0b667bb>] bttv_prepare_buffer+0xab/0x1a0 [bttv]
[4294994.060000]  [<e0b66958>] buffer_prepare+0x38/0x40 [bttv]
[4294994.060000]  [<e0a2a3cd>] videobuf_read_zerocopy+0x5d/0x100 [video_buf]
[4294994.060000]  [<e0a2a622>] videobuf_read_one+0x1b2/0x210 [video_buf]
[4294994.060000]  [<e0b69575>] bttv_read+0x115/0x120 [bttv]
[4294994.060000]  [<c0155923>] vfs_read+0x93/0x150
[4294994.060000]  [<c0155c8d>] sys_read+0x3d/0x70
[4294994.060000]  [<c0102b2f>] sysenter_past_esp+0x54/0x75
[4294994.060000] Code: 8d 5f 2c 0d 00 00 00 10 89 01 8b 42 08 89 41 04 2b 72 0c 83 c1 08 8b 03 83 c2 10 83 c3 10 39 c6 77 e1 89 f0 89 d7 0d 00 00 00 14 <89> 01 8b 42 08 89 41 04 83 c1 08 89 f0 e9 5f ff ff ff 0f 0b 6b
[4294994.060000]  <4>mtrr: 0xc0000000,0x10000000 overlaps existing 0xc0000000,0x8000000


> The OOPSes Duncan saw, I don't know about those: I wouldn't expect
> them to be due to this cause, but could be wrong.

I have been seeing occasional bttv related oopsen for a while now, since
2.6.14 at least.  The lack of a picture and associated error messages
from xawtv are new.  So likely you are right that they have different causes.

All the best,

Duncan.
