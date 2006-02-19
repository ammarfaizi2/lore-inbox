Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWBSVwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWBSVwY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 16:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWBSVwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 16:52:24 -0500
Received: from c-66-31-106-233.hsd1.ma.comcast.net ([66.31.106.233]:14004 "EHLO
	nwo.kernelslacker.org") by vger.kernel.org with ESMTP
	id S1751021AbWBSVwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 16:52:23 -0500
Date: Sun, 19 Feb 2006 16:52:09 -0500
From: Dave Jones <davej@redhat.com>
To: Nathan Scott <nathans@sgi.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, bjd <bjdouma@xs4all.nl>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: kernel oops: trying to mount a corrupted xfs partition (2.6.16-rc3)
Message-ID: <20060219215209.GB7974@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nathan Scott <nathans@sgi.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>, bjd <bjdouma@xs4all.nl>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <20060216183629.GA5672@skyscraper.unix9.prv> <20060217063157.B9349752@wobbly.melbourne.sgi.com> <Pine.LNX.4.61.0602171753590.27452@yvahk01.tjqt.qr> <20060220082946.A9478997@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220082946.A9478997@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 08:29:46AM +1100, Nathan Scott wrote:
 > On Fri, Feb 17, 2006 at 05:54:49PM +0100, Jan Engelhardt wrote:
 > > >> XFS mounting filesystem hda3
 > > >> Starting XFS recovery on filesystem: hda3 (logdev: internal)
 > > >> EIP:    0060:[xlog_recover_do_inode_trans+473/2688]    Tainted: P      VLI
 > > >
 > > >This indicates you are running recovery - run xfs_repair first
 > > >if you know the filesystem is corrupt.
 > > >
 > > How does one know a filesystem got "corrupt enough" to require xfs_repair 
 > > first?
 > 
 > Any corruption should be repaired.  You'd notice corruption by
 > either running repair (as the bug reporter here had asserted),
 > or via the filesystem shutting down when the ondisk corruption
 > was encountered.

Just for kicks, I just hacked this up..

#!/bin/bash
wget http://www.digitaldwarf.be/products/mangle.c
gcc mangle.c -o mangle

dd if=/dev/zero of=data.img count=70000

while [ 1 ];
do
        mkfs.xfs -f data.img >/dev/null
		./mangle data.img $RANDOM
        sudo mount -t xfs data.img mntpt -o loop
        sudo ls -R mntpt
        sudo umount mntpt
done


xfs wins the award for 'noisiest fs in the face of corruption' :-)
After a few dozen backtraces from xfs_corruption_error,
this fell out...

divide error: 0000 [1] SMP
last sysfs file: /devices/pci0000:00/0000:00:1d.7/usb1/1-0:1.0/bAlternateSetting
CPU 3
Modules linked in: loop xfs exportfs relayfs snd_usb_audio snd_usb_lib hwmon_vid hwmon i2c_isa snd_seq_midi vfat fat usb_storage radeon drm ppdev autofs4 nfs lockd nfs_acl rfcomm l2cap bluetooth sunrpc ip_conntrack_netbios_ns ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp iptable_filter ip_tables x_tables video button battery ac ipv6 lp parport_pc parport floppy nvram uhci_hcd ehci_hcd sg snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_intel8x0 snd_seq_dummy snd_seq_oss snd_emu10k1 snd_seq_midi_event snd_seq snd_rawmidi snd_pcm_oss snd_mixer_oss snd_ac97_codec snd_ac97_bus snd_seq_device snd_util_mem snd_pcm snd_hwdep snd_timer emu10k1_gp gameport i2c_i801 snd soundcore e1000 i2c_core snd_page_alloc e752x_edac edac_mc dm_snapshot dm_zero dm_mirror dm_mod ext3 jbd ata_piix libata sd_mod scsi_mod
Pid: 15299, comm: mount Not tainted 2.6.15-1.1963_FC5 #1
RIP: 0010:[<ffffffff886b3e93>] <ffffffff886b3e93>{:xfs:xfs_mountfs+1031}
RSP: 0000:ffff81001bacfa28  EFLAGS: 00010246
RAX: 0000000000000800 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 00000000000000aa RDI: ffff81002f1115f8
RBP: ffff81002f1115f8 R08: 0000000000000008 R09: 0000000000000003
R10: 0000000000000001 R11: ffff81002f1115f8 R12: ffff8100162fa188
R13: ffff81002f111650 R14: ffffffffffffffff R15: ffff81003ab16c78
FS:  00002b2a25b01380(0000) GS:ffff81003fe4adf0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 000000392bb17560 CR3: 00000000195b9000 CR4: 00000000000006e0
Process mount (pid: 15299, threadinfo ffff81001bace000, task ffff810038a0a820)
Stack: 000000003ecf72f8 ffff81003ab16c78 0000000000000000 000000001dcd52ea
       0000000000000000 0000000000000002 ffff81003205dc08 ffff810031be8010
       dead4ead00000001 00000000ffffffff
Call Trace: <ffffffff886c2699>{:xfs:xfs_setsize_buftarg_flags+48}
       <ffffffff886ba733>{:xfs:xfs_mount+1880} <ffffffff886c945c>{:xfs:linvfs_fill_super+0}
       <ffffffff886c94ed>{:xfs:linvfs_fill_super+145} <ffffffff80187ade>{bd_claim+131}
       <ffffffff8018756c>{get_sb_bdev+271} <ffffffff801e1f0a>{selinux_sb_copy_data+328}
       <ffffffff8018730a>{do_kern_mount+156} <ffffffff8019bdf5>{do_mount+1755}
       <ffffffff8019a93f>{mntput_no_expire+25} <ffffffff8018fe98>{link_path_walk+211}
       <ffffffff8017bbd2>{poison_obj+38} <ffffffff8017bf38>{cache_free_debugcheck+547}
       <ffffffff80190278>{do_path_lookup+610} <ffffffff8015ac5a>{audit_getname+145}
       <ffffffff801604d8>{bad_range+20} <ffffffff801616e7>{get_page_from_freelist+710}
       <ffffffff8016189a>{__alloc_pages+112} <ffffffff8019bef3>{sys_mount+140}
       <ffffffff8010a91c>{tracesys+209}

Code: 48 f7 f3 48 0f af c1 41 0f b6 4d 7b 48 d3 e0 48 89 85 d0 03
RIP <ffffffff886b3e93>{:xfs:xfs_mountfs+1031} RSP <ffff81001bacfa28>

(The kernel is based on 2.6.16rc4)

		Dave

