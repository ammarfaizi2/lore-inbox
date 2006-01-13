Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161616AbWAMAho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161616AbWAMAho (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 19:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161618AbWAMAho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 19:37:44 -0500
Received: from uproxy.gmail.com ([66.249.92.193]:28653 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161616AbWAMAhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 19:37:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=aAEalxzEdwRoMOgCPGBxMw7lVx/J/Nlh8tOLspQDtSimj9WD8xyZyEIZHMog6lK5rnCb9DIFS/cEAZUyzaXT1k6qc4DKVrQ0jMonSuZHHmZrhmMuMKCmgnMEBnFxzbZby051J9rDzY9qBqFyjo3y3Xdddzmnc+9bnn99DFW8rqA=
Date: Fri, 13 Jan 2006 03:54:50 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Oops in ufs_fill_super at mount time
Message-ID: <20060113005450.GA7971@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.6.15-43ecb9a33ba8c93ebbda81d48ca05f0d1bbf9056

Actually more or less latest -git is affected too, but
I'm sick of recompiling right now so please wait for bisecting results.

It's random wrt one mount of UFS, but several mount/umounts in a row
reproduce it reliably:

	mount -t ufs -o ro,ufstype=44bsd /dev/hda9 /home/openbsd/usr/

I've tracked this down to line 926 of fs/ufs/super.c:

   921		uspi->s_ntrak = fs32_to_cpu(sb, usb1->fs_ntrak);
   922		uspi->s_nsect = fs32_to_cpu(sb, usb1->fs_nsect);
   923		uspi->s_spc = fs32_to_cpu(sb, usb1->fs_spc);
   924		uspi->s_ipg = fs32_to_cpu(sb, usb1->fs_ipg);
   925		uspi->s_fpg = fs32_to_cpu(sb, usb1->fs_fpg);
   926	===>	uspi->s_cpc = fs32_to_cpu(sb, usb2->fs_cpc);	<=== Oops here
   927		uspi->s_contigsumsize = fs32_to_cpu(sb, usb3->fs_u2.fs_44.fs_contigsumsize);
   928		uspi->s_qbmask = ufs_get_fs_qbmask(sb, usb3);
   929		uspi->s_qfmask = ufs_get_fs_qfmask(sb, usb3);
   930		uspi->s_postblformat = fs32_to_cpu(sb, usb3->fs_postblformat);

(fs/ufs/super.c, 1029), ufs_put_super: ENTER
(fs/ufs/super.c, 545), ufs_fill_super: ENTER
(fs/ufs/super.c, 553), ufs_fill_super: flag 1
(fs/ufs/super.c, 310), ufs_parse_options: ENTER
(fs/ufs/super.c, 593), ufs_fill_super: ufstype=44bsd
(fs/ufs/super.c, 822), ufs_fill_super: another value of block_size or super_block_size 2048, 2048
ufs_print_super_stuff
size of usb:     1380
  magic:         0x11954
  sblkno:        8
  cblkno:        16
  iblkno:        24
  dblkno:        1312
  cgoffset:      16
  ~cgmask:       0xf
  size:          2097144
  dsize:         2063231
  ncg:           26
  bsize:         16384
  fsize:         2048
  frag:          8
  fragshift:     3
  ~fmask:        2047
  fshift:        11
  sbsize:        2048
  spc:           1008
  cpg:           328
  ipg:           20608
  fpg:           82656
  csaddr:        1312
  cssize:        2048
  cgsize:        16384
  fstodb:        2
  contigsumsize: 3
  postblformat:  1
  nrpos:         1
  ndir           29518
  nifree         339567
  nbfree         107711
  nffree         5167

(fs/ufs/super.c, 844), ufs_fill_super: fs is clean
(fs/ufs/super.c, 904), ufs_fill_super: uspi->s_bshift = 14,uspi->s_fshift = 11
before uspi->s_cpc = fs32_to_cpu(sb, usb2->fs_cpc);
Unable to handle kernel paging request at virtual address d734c158
 printing eip:
c019f138
*pde = 0005c067
*pte = 1734c000
Oops: 0000 [#1]
PREEMPT DEBUG_PAGEALLOC
Modules linked in: snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd uhci_hcd usbcore
CPU:    0
EIP:    0060:[<c019f138>]    Not tainted VLI
EFLAGS: 00010286   (2.6.15-43ecb9a33ba8c93ebbda81d48ca05f0d1bbf9056)
EIP is at ufs_fill_super+0x1094/0x151e
eax: d734c000   ebx: 00000000   ecx: dd270e4c   edx: c0289c4b
esi: dd378df8   edi: 00000800   ebp: dd394df8   esp: dd270e4c
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 7857, threadinfo=dd270000 task=ddb70b00)
Stack: <0>dd270ec3 00000020 d7b7c374 c0283146 dd270e88 dd270ea4 dd325ef8 00002130
       dd378df8 d730c400 d734c000 d730c000 dd378df8 00000020 c0283142 00001000
       dd394df8 dd394df8 d730be5c 00000000 d7309000 c014a1ce 39616468 c0142000
Call Trace:
 [<c014a1ce>] get_sb_bdev+0xbf/0xfa
 [<c0142000>] kmem_cache_alloc+0x59/0x5c
 [<c015afb3>] alloc_vfsmnt+0x97/0xbe
 [<c015afb3>] alloc_vfsmnt+0x97/0xbe
 [<c019fc31>] ufs_get_sb+0xe/0x11
 [<c019e0a4>] ufs_fill_super+0x0/0x151e
 [<c014a340>] do_kern_mount+0x3b/0x9d
 [<c015c22a>] do_new_mount+0x61/0x90
 [<c015c7d4>] do_mount+0x161/0x179
 [<c012e8d3>] __alloc_pages+0x47/0x256
 [<c015cab5>] sys_mount+0x6f/0xad
 [<c01025fd>] syscall_call+0x7/0xb
Code: 91 bc 00 00 00 83 b8 80 00 00 00 00 89 d1 74 02 0f c9 8b 74 24 30 89 8e cc 00 00 00 68 4b 9c 28 c0 e8 ec 25 f7 ff 58 8b 44 24 28 <8b> 90 58 01 00 00 8b 85 68 01 00 00 83 b8 80 00 00 00 00 89 d1

