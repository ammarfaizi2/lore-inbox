Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVAAKlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVAAKlG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 05:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVAAKlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 05:41:06 -0500
Received: from dhcp93115068.columbus.rr.com ([24.93.115.68]:12046 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S261378AbVAAKk5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 05:40:57 -0500
Date: Sat, 1 Jan 2005 05:40:54 -0500
From: Joseph Fannin <jhf@rivenstone.net>
To: Dave Airlie <airlied@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [bk pull] drm core/personality split
Message-ID: <20050101104054.GA14904@samarkand.rivenstone.net>
Mail-Followup-To: Dave Airlie <airlied@gmail.com>,
	Dave Airlie <airlied@linux.ie>, torvalds@osdl.org,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0412300733380.25314@skynet> <21d7e997041229234860454564@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <21d7e997041229234860454564@mail.gmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2004 at 06:48:25PM +1100, Dave Airlie wrote:
> http://www.skynet.ie/~airlied/patches/dri/drm_core_split-26bk.diff

    Applying this patch to 2.6.10 shows that the oops-and-crash in
i810_mmap_buffers I reported in the bk-drm (and -mm) tree is
here. :(  Vanilla 2.6.10 is fine.

    I'll repeat what I worked out about this for anyone interested; I
was able to get the i810 DRM working again by reverting this change:
http://drm.bkbits.net:8080/drm-2.6/cset@418a0608l2KOkX2bWPW4DYyiQfa69A?nav=index.html|ChangeSet@-4w

    I made this patch with some ignorant copy-and-paste coding, which
is wrong but works for me:

diff -aurN a/drivers/char/drm/i810_drv.c b/drivers/char/drm/i810_drv.c
--- a/drivers/char/drm/i810_drv.c       2004-11-26 23:18:35.000000000 -0500
+++ b/drivers/char/drm/i810_drv.c       2004-11-26 23:38:36.000000000 -0500
@@ -112,7 +112,7 @@
                .open = drm_open,
                .release = drm_release,
                .ioctl = drm_ioctl,
-               .mmap = i810_mmap_buffers,
+               .mmap = drm_mmap,
                .poll = drm_poll,
                .fasync = drm_fasync,
        },

    A copy of the Oops output (this one from 2.6.10-rc2-mm1):

 Unable to handle kernel NULL pointer dereference at virtual address 00000038
  printing eip:
 c0235d04
 *pde = 08aed067
 *pte = 00000000
 Oops: 0000 [#1]
 PREEMPT 
 Modules linked in: lp af_packet 3c59x mii yenta_socket pcmcia_core snd_intel8x0
snd_ac97_codec i2c_i801 i2c_core uhci_hcd usbcore i8xx_tco hw_random floppy parport_pc
parport tsdev joydev nls_iso8859_1 ntfs dm_mod snd_seq_oss snd_seq_midi_event snd_seq
snd_seq_device snd_pcm_oss snd_pcm snd_timer snd_page_alloc snd_mixer_oss snd soundcore
ide_cd cdrom
 CPU:    0
 EIP:    0060:[<c0235d04>]    Not tainted VLI
 EFLAGS: 00013246   (2.6.10-rc2-mm1) 
 EIP is at i810_mmap_buffers+0x24/0x80
 eax: 00000000   ebx: c90a0e34   ecx: 00000000   edx: cb1d5570
 esi: c9b7dee0   edi: cb515560   ebp: c943ff40   esp: c943ff2c
 ds: 007b   es: 007b   ss: 0068
 Process XFree86 (pid: 3632, threadinfo=c943e000 task=cb1d5570)
 Stack: 000cca1c c943ff80 c90a0e34 cb515560 ffffffea c943ff98 c01494fe c943ff84 
        c943ff88 c943ff4c bffff890 c015559d c943ff60 00000000 00000001 00000000 
        001000fb cb11c9d8 cb68adc0 00002000 b7f9c000 c90f0ac4 c90f0ae4 c90f0adc 
 Call Trace:
  [<c0103e1a>] show_stack+0x7a/0x90
  [<c0103f99>] show_registers+0x149/0x1b0
  [<c010418d>] die+0xdd/0x170
  [<c0113b6a>] do_page_fault+0x33a/0x68a
  [<c0103a9b>] error_code+0x2b/0x30
  [<c01494fe>] do_mmap_pgoff+0x33e/0x6f0
  [<c0108b6c>] sys_mmap2+0x6c/0xa0
  [<c0103011>] sysenter_past_esp+0x52/0x71
 Code: ff ff eb d1 8d 76 00 55 89 e5 83 ec 14 89 5d f4 89 d3 89 7d fc 89 c7 89 75 f8 8b 70
7c e8 85 fd 0c 00 8b 46 20 8b 80 04 07 00 00 <8b> 40 38 8b 40 44 81 4b 14 00 40 02 00 89 7b
4c c7 40 08 01 00 
 
-- 
Joseph Fannin
jfannin@gmail.com || jhf@rivenstone.net
