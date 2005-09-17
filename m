Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbVIQJn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbVIQJn7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 05:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbVIQJn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 05:43:59 -0400
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:24071 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751017AbVIQJn7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 05:43:59 -0400
Date: Sat, 17 Sep 2005 11:44:59 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Bas Vermeulen <bvermeul@blackstar.nl>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc1 - kernel BUG at fs/ntfs/aops.c:403
Message-Id: <20050917114459.647654d4.khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.60.0509150954290.29921@hermes-1.csi.cam.ac.uk>
References: <1126769362.5358.3.camel@laptop.blackstar.nl>
	<Pine.LNX.4.60.0509150954290.29921@hermes-1.csi.cam.ac.uk>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton, Bas, all,

[Bas Vermeulen]
> > I get a kernel BUG when mounting my (dirty) NTFS volume.
> > 
> > Sep 12 18:54:47 laptop kernel: [4294708.961000] NTFS volume version
> > 3.1. Sep 12 18:54:47 laptop kernel: [4294708.961000] NTFS-fs error
> > (device sda2): load_system_files(): Volume is dirty.  Mounting
> > read-only.  Run chkdsk and mount in Windows.
> > Sep 12 18:54:47 laptop kernel: [4294709.063000] ------------[ cut
> > here ]------------
> > Sep 12 18:54:47 laptop kernel: [4294709.063000] kernel BUG at
> > fs/ntfs/aops.c:403!

I just hit the same BUG in different conditions. My NTFS volume is not
dirty, not compressed (BTW, is there a way to tell from Linux directly?)
and the BUG triggered on use (updatedb), not mount.

[Anton Altaparmakov]
> Ouch.  )-:  Could you do two things for me so I can figure out what
> is going on?
> 
> 1) Apply this patch to fs/ntfs/aops.c:
> 
> --- aops.c.old	2005-09-15 09:51:30.000000000 +0100
> +++ aops.c	2005-09-15 09:53:53.000000000 +0100
> @@ -400,6 +400,10 @@ retry_readpage:
>  		}
>  		/* Compressed data streams are handled in compress.c. */
>  		if (NInoNonResident(ni) && NInoCompressed(ni)) {
> +			ntfs_error(ni->vol->sb, "Eeek!  i_ino = 0x%lx, "
> +					"type = 0x%x, name_len = 0x%x.",
> +					VFS_I(ni)->i_ino, ni->type,
> +					ni->name_len);
>  			BUG_ON(ni->type != AT_DATA);
>  			BUG_ON(ni->name_len);
>  			return ntfs_read_compressed_block(page);
> 
> 2) Enable ntfs debugging in the kernel configuration.
> 
> Recompile the ntfs module (or the kernel if ntfs is built in).
> 
> Then load the new module (if not built in).
> 
> Then enable debug output (as root do):
> 
> 	echo 1 > /proc/sys/fs/ntfs-debug
> 
> Now do the mount and send me the resulting dmesg output.  That should 
> hopefully enable me to fix it.

I've done all this, ran updatedb and got a segmentation fault, here is
the resulting dmesg log:

NTFS driver 2.1.24 [Flags: R/O DEBUG MODULE].
NTFS volume version 3.0.
(...)
NTFS-fs DEBUG (fs/ntfs/namei.c, 135): ntfs_lookup(): Done.  (Case 1.)
NTFS-fs DEBUG (fs/ntfs/dir.c, 1121): ntfs_readdir(): Entering for inode 0x19, fpos 0xf400.
NTFS-fs DEBUG (fs/ntfs/dir.c, 1451): ntfs_readdir(): EOD, fpos 0xf400, returning 0.
NTFS-fs DEBUG (fs/ntfs/dir.c, 1121): ntfs_readdir(): Entering for inode 0x2e26, fpos 0x0.
NTFS-fs DEBUG (fs/ntfs/dir.c, 1130): ntfs_readdir(): Calling filldir for . with len 1, fpos 0x0, inode 0x2e26, DT_DIR.
NTFS-fs DEBUG (fs/ntfs/dir.c, 1139): ntfs_readdir(): Calling filldir for .. with len 2, fpos 0x1, inode 0x19, DT_DIR.
NTFS-fs DEBUG (fs/ntfs/mft.c, 155): map_mft_record(): Entering for mft_no 0x2e26.
NTFS-fs DEBUG (fs/ntfs/attrib.c, 1013): ntfs_attr_lookup(): Entering.
NTFS-fs DEBUG (fs/ntfs/mft.c, 215): unmap_mft_record(): Entering for mft_no 0x2e26.
NTFS-fs DEBUG (fs/ntfs/dir.c, 1216): ntfs_readdir(): In index root, offset 0x20.
NTFS-fs DEBUG (fs/ntfs/dir.c, 1279): ntfs_readdir(): Reading bitmap with page index 0x0, bit ofs 0x0
NTFS-fs DEBUG (fs/ntfs/mft.c, 155): map_mft_record(): Entering for mft_no 0x2e26.
NTFS-fs DEBUG (fs/ntfs/attrib.c, 1013): ntfs_attr_lookup(): Entering.
NTFS-fs DEBUG (fs/ntfs/mft.c, 215): unmap_mft_record(): Entering for mft_no 0x2e26.
NTFS-fs DEBUG (fs/ntfs/dir.c, 1310): ntfs_readdir(): Handling index buffer 0x0.
NTFS-fs error (device hda1): ntfs_readpage(): Eeek!  i_ino = 0x2e26, type = 0xa0, name_len = 0x4.
------------[ cut here ]------------
kernel BUG at fs/ntfs/aops.c:407!
invalid operand: 0000 [#1]
Modules linked in: cpufreq_powersave cpufreq_conservative powernow_k8 freq_table it87 hwmon_vid hwmon i2c_isa rtc snd_pcm_oss snd_mixer_oss smbfs ohci_hcd sr_mod cdrom sym53c8xx scsi_transport_spi scsi_mod zr36060 adv7175 saa7110 zr36067 videocodec videodev uhci_hcd ehci_hcd usbcore i2c_viapro snd_via82xx snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd soundcore ohci1394 eth1394 ieee1394 via_rhine mii r8169 nls_iso8859_1 nls_cp437 vfat nls_utf8 ntfs radeon drm amd64_agp agpgart
CPU:    0
EIP:    0060:[<f8862ad3>]    Not tainted VLI
EFLAGS: 00010202   (2.6.14-rc1) 
EIP is at ntfs_readpage+0x2a3/0x2eb [ntfs]
eax: 00000068   ebx: c1552220   ecx: c0367380   edx: 007c742b
esi: eaf632c0   edi: c1552220   ebp: eaf633fc   esp: f1b73e18
ds: 007b   es: 007b   ss: 0068
Process updatedb (pid: 5385, threadinfo=f1b72000 task=f15c8a90)
Stack: f887458b f7150400 f8875e40 00002e26 000000a0 00000004 c1552220 00000000 
       c1552220 00000000 c013442a c1552220 c1552220 c1552220 00000000 00000000 
       eaf633fc c0135d82 00000000 c1552220 00000000 000000d0 00000000 eaf633fc 
Call Trace:
 [<c013442a>] add_to_page_cache_lru+0x4a/0x50
 [<c0135d82>] read_cache_page+0x72/0x230
 [<f8867da2>] ntfs_readdir+0xa52/0x1690 [ntfs]
 [<f8862830>] ntfs_readpage+0x0/0x2eb [ntfs]
 [<c0161ff7>] vfs_readdir+0x77/0x90
 [<c01622e0>] filldir64+0x0/0x100
 [<c0162457>] sys_getdents64+0x77/0xcb
 [<c01622e0>] filldir64+0x0/0x100
 [<c0102cf5>] syscall_call+0x7/0xb
Code: 80 00 00 00 75 25 8b 6e 2c 85 ed 75 14 8b 44 24 30 89 44 24 48 83 c4 34 5b 5e 5f 5d e9 b7 23 00 00 0f 0b 98 01 80 51 87 f8 eb e2 <0f> 0b 97 01 80 51 87 f8 eb d1 83 c1 80 75 0d c7 44 24 24 f3 ff 

There is much more debug stuff before the BUG happens but it was a bit
large to include here. Available of request.

The relevant line in /etc/fstab is:
/dev/hda1        /mnt/win/c       ntfs        gid=497,umask=0227,nls=utf8,noexec,ro        1 0

Note that I don't care about that NTFS volume myself, I don't use it,
I'm only mounting it in order to help find bugs in the ntfs driver. It
seems to work ;)

Thanks,
-- 
Jean Delvare
