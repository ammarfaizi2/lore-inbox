Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933291AbWKNEB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933291AbWKNEB3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 23:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933296AbWKNEB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 23:01:29 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:19112 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S933291AbWKNEB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 23:01:28 -0500
Date: Tue, 14 Nov 2006 15:00:53 +1100
From: David Chinner <dgc@sgi.com>
To: Martin Braun <mbraun@uni-hd.de>
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: xfs kernel BUG again in 2.6.17.11
Message-ID: <20061114040053.GD8394166@melbourne.sgi.com>
References: <44E1D9CA.30805@uni-hd.de> <20060816101122.E2740551@wobbly.melbourne.sgi.com> <44EB228F.6020903@uni-hd.de> <20060823134211.E2968256@wobbly.melbourne.sgi.com> <45583ABE.6080909@uni-hd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45583ABE.6080909@uni-hd.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 10:28:30AM +0100, Martin Braun wrote:
> Hi ,
> 
> is it possible that the xfs  kernel bug is in the 2.6.17.11 Kernel again?
> we got obviously the same bug as with 2.6.17.8:

It's likely that XFS is identical in those 2 releases.

BTW, Martin, can you cc XFS bug reports to xfs@oss.sgi.com in future?

> Nov 13 09:27:01 pers109 kernel: Access to block zero: fs: <sdc1> inode:
> 637540399 start_block : 0 start_off : 23812530000000 blkcnt : 84
> extent-state : 0

Looks like you are managing to trigger an inode corruption
of some sort.

Have you managed to repair the filesystem since you first
reported this problem? I don't know the history of the bug
you are seeing othat than what you included, so can you
give us a more complete picture of your hardware and
what sort of workload you are doing that triggers this
problem?

FWIW, are there any I/o errors being reported in dmesg or syslog?

Cheers,

Dave.

> > On Tue, Aug 22, 2006 at 05:28:15PM +0200, Martin Braun wrote:
> >> Hi Nathan,
> >>
> >> since I haven't repaired the fs we had a crash again (see below).
> >>
> >> unfortunately we copied at the time of the crash over iscsi some files
> >> to an xfs-fs on a nas.
> >> and the directory was completely deleted. neither a xfs-check or a
> >> xfs_repair did find something. was that due to the combination of iscsi
> >> and xfs?
> > 
> > Sorry for not getting back to you earlier, I've been too busy. :(
> > 
> > I think you will need to clear out the affected inode (looks like a
> > form of corruption that repair doesn't know about today) - you'll
> > need to forcibly remove that inode via xfs_db, something like:
> > 
> > # xfs_db -x -c 'inode 35141650' -c 'write core.mode 0' /dev/sdc1
> > # xfs_repair /dev/sdc1
> > 
> > cheers.
> > 
> > ps: Barry, looks like repair needs some work in this area...
> > 
> >> Aug 22 12:48:12 pers109 kernel: Access to block zero: fs: <sdc1> inode:
> >> 35141650 start_block : 0 start_off : 3a1531 blkcnt : c
> >>  extent-state : 0
> >> Aug 22 12:48:12 pers109 kernel: ------------[ cut here ]------------
> >> Aug 22 12:48:12 pers109 kernel: kernel BUG at <bad filename>:50307!
> >> Aug 22 12:48:12 pers109 kernel: invalid opcode: 0000 [#1]
> >> Aug 22 12:48:12 pers109 kernel: SMP
> >> Aug 22 12:48:12 pers109 kernel: Modules linked in: iscsi_tcp libiscsi
> >> scsi_transport_iscsi
> >> Aug 22 12:48:12 pers109 kernel: CPU:    0
> >> Aug 22 12:48:12 pers109 kernel: EIP:    0060:[<c025cb74>]    Not tainted VLI
> >> Aug 22 12:48:12 pers109 kernel: EFLAGS: 00010246   (2.6.17.8 #5)
> >> Aug 22 12:48:12 pers109 kernel: EIP is at cmn_err+0xa0/0xaa
> >> Aug 22 12:48:12 pers109 kernel: eax: c048a2c4   ebx: c04359e4   ecx:
> >> c047c9bc   edx: 00000282
> >> Aug 22 12:48:12 pers109 kernel: esi: e595dcb0   edi: c056a120   ebp:
> >> 00000000   esp: e595db70
> >> Aug 22 12:48:12 pers109 kernel: ds: 007b   es: 007b   ss: 0068
> >> Aug 22 12:48:12 pers109 kernel: Process smbd (pid: 25510,
> >> threadinfo=e595c000 task=d9628a90)
> >> Aug 22 12:48:12 pers109 kernel: Stack: c044497a c0427525 c056a120
> >> 00000282 f3507260 e595dcb0 00000000 d9f9de00
> >> Aug 22 12:48:12 pers109 kernel:        c0202f0d 00000000 c04359e4
> >> f686cba0 02183812 00000000 00000000 00000000
> >> Aug 22 12:48:12 pers109 kernel:        003a1531 00000000 0000000c
> >> 00000000 00000000 e595dcb0 00000000 00000000
> >> Aug 22 12:48:12 pers109 kernel: Call Trace:
> >> Aug 22 12:48:12 pers109 kernel:  <c0202f0d>
> >> xfs_bmap_search_extents+0xf5/0xf7  <c0204407> xfs_bmapi+0x229/0x162c
> >> Aug 22 12:48:12 pers109 kernel:  <c039d890> dev_queue_xmit+0x1f4/0x26f
> >> <c03b8660> ip_output+0x189/0x270
> >> Aug 22 12:48:12 pers109 kernel:  <c012018e> __do_softirq+0x6e/0xdc
> >> <c0104d7a> do_IRQ+0x1e/0x24
> >> Aug 22 12:48:12 pers109 kernel:  <c0103222> common_interrupt+0x1a/0x20
> >> <c0259e03> xfs_zero_eof+0x1ca/0x340
> >> Aug 22 12:48:12 pers109 kernel:  <c039a342> memcpy_toiovec+0x37/0x5c
> >> <c01762b3> file_update_time+0xa1/0xc0
> >> Aug 22 12:48:12 pers109 kernel:  <c025a463> xfs_write+0x4ea/0xda5
> >> <c0393654> sock_aio_read+0x83/0x8e
> >> Aug 22 12:48:12 pers109 kernel:  <c016e098> fasync_helper+0x4b/0xd3
> >> <c028dc12> copy_to_user+0x3c/0x4a
> >> Aug 22 12:48:12 pers109 kernel:  <c025572f> xfs_file_aio_write+0x8f/0x9a
> >>  <c015ba73> do_sync_write+0xd5/0x130
> >> Aug 22 12:48:12 pers109 kernel:  <c012de03>
> >> autoremove_wake_function+0x0/0x4b  <c015bb99> vfs_write+0xcb/0x195
> >> Aug 22 12:48:12 pers109 kernel:  <c015be3e> sys_pwrite64+0x73/0x80
> >> <c01027ef> sysenter_past_esp+0x54/0x75
> >> Aug 22 12:48:12 pers109 kernel: Code: c0 c7 44 24 08 20 a1 56 c0 c7 04
> >> 24 7a 49 44 c0 89 44 24 04 e8 ab eb eb ff b8 c4 a2 48 c
> >> 0 8b 54 24 0c e8 fc 95 1a 00 85 ed 75 02 <0f> 0b 83 c4 10 5b 5e 5f 5d c3
> >> 55 b8 07 00 00 00 57 bf 20 a1 56
> >> Aug 22 12:48:12 pers109 kernel: EIP: [<c025cb74>] cmn_err+0xa0/0xaa
> >> SS:ESP 0068:e595db70
> >>
> >>
> >>
> >>
> >>
> >>
> >>  Scott schrieb:
> >>> Hi Martin,
> >>>
> >>> On Tue, Aug 15, 2006 at 04:27:22PM +0200, Martin Braun wrote:
> >>>> ...
> >>>> What does this bug mean?
> >>>> ...
> >>>> Aug 15 15:01:02 pers109 kernel: Access to block zero: fs: <sdc1> inode:
> >>>> 254474718 start_block : 0 start_off : c0a0b0e8a099
> >>>> 0 blkcnt : 90000 extent-state : 0
> >>>> Aug 15 15:01:02 pers109 kernel: ------------[ cut here ]------------
> >>>> Aug 15 15:01:02 pers109 kernel: kernel BUG at <bad filename>:50307!
> >>> It means XFS detected ondisk corruption in inode# 254474718, and
> >>> paniced your system (stupidly; a fix for this is around, will be
> >>> merged with the next mainline update).  For me, a more interesting
> >>> question is how that inode got into this state... have you had any
> >>> crashes recently (i.e. has the filesystem journal needed to be
> >>> replayed recently?)  Can you send the output of:
> >>>
> >>> 	# xfs_db -c 'inode 254474718' -c print /dev/sdc1
> >>>
> >>> You'll need to run xfs_repair on that filesystem to fix this up,
> >>> but please send us that output first.
> >>>
> >>> thanks.
> >>>
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
