Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVGCKef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVGCKef (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 06:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVGCKef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 06:34:35 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:34090 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261250AbVGCKea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 06:34:30 -0400
Message-ID: <42C7BF37.9010005@gentoo.org>
Date: Sun, 03 Jul 2005 11:34:31 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050403)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: =?UTF-8?B?RGF2aWQgR8OzbWV6?= <david@pleyades.net>,
       Robert Love <rml@novell.com>, John McCutchan <ttb@tentacle.dhs.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with inotify
References: <20050630181824.GA1058@fargo> <1120156188.6745.103.camel@betsy> <20050630193320.GA1136@fargo> <Pine.LNX.4.60.0506302138230.29755@hermes-1.csi.cam.ac.uk> <20050630204832.GA3854@fargo> <Pine.LNX.4.60.0506302158190.29755@hermes-1.csi.cam.ac.uk> <42C65A8B.9060705@gentoo.org> <Pine.LNX.4.60.0507022253080.30401@hermes-1.csi.cam.ac.uk> <42C72563.7040103@gentoo.org> <Pine.LNX.4.60.0507030053040.15398@hermes-1.csi.cam.ac.uk>
In-Reply-To: <Pine.LNX.4.60.0507030053040.15398@hermes-1.csi.cam.ac.uk>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> Eeek!  I just reread my patch.  I am a muppet!  Instead of the printk (or 
> in addition if you like), please try the corrected version below.  The 
> original version completely fails to do anything at all.  It's amazing 
> what the omission of a single parenthesis pair can do to your code logic.  
> )-:

I reverted the patch you sent earlier
(inotify_unmount_inodes-list-iteration-fix.diff) and applied the one you
attached here (inotify_unmount_inodes-list-iteration-fix2.diff).

The good news is that the hang is gone. The bad news is that you cured the
hang by introducing an oops :(

Unable to handle kernel NULL pointer dereference at virtual address 00000024
 printing eip:
c01751d9
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: ntfs snd_pcm_oss snd_mixer_oss snd_seq_oss
snd_seq_midi_event snd_seq snd_seq_device snd_intel8x0 snd_ac97_codec snd_pcm
snd_timer snd snd_page_alloc
CPU:    0
EIP:    0060:[<c01751d9>]    Tainted: P      VLI
EFLAGS: 00010283   (2.6.12-gentoo-r3)
EIP is at iput+0x19/0x90
eax: 00000000   ebx: deb82e64   ecx: deb82e64   edx: deb82e64
esi: dd01ff00   edi: deb82e64   ebp: dd01ff00   esp: df7b9eb8
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 9201, threadinfo=df7b8000 task=dd656a60)
Stack: dd01fe20 c03feb20 df7b8000 c0182337 deb82e64 00000000 00000000 00000000
       00000000 df7b8000 dd01ff08 deb82e64 dd01f0dc df7b8000 deb82e74 df7b9f08
       df7b8000 c0174050 deb82e74 dffe0040 df7b9f08 df7b9f08 dda12274 deb82e00
Call Trace:
 [<c0182337>] inotify_unmount_inodes+0x187/0x1e0
 [<c0174050>] invalidate_inodes+0x40/0x90
 [<c015f579>] generic_shutdown_super+0x59/0x140
 [<c01601dd>] kill_block_super+0x2d/0x50
 [<c015f40a>] deactivate_super+0x5a/0x90
 [<c01773cf>] sys_umount+0x3f/0x90
 [<c0157e42>] filp_close+0x52/0xa0
 [<c0177437>] sys_oldumount+0x17/0x20
 [<c010326b>] sysenter_past_esp+0x54/0x75
Code: ff ff 89 44 24 04 e9 47 fe ff ff 8d b4 26 00 00 00 00 53 83 ec 08 8b 5c
24 10 85 db 74 58 83 bb 24 01 00 00 20 8b 83 94 00 00 00 <8b> 40 24 74 5a 85
c0 74 07 8b 50 14 85 d2 75 47 8d 43 24 c7 44

(gdb) list *iput+0x19
0x1789 is in iput (inode.c:1131).
1126     *      Consequently, iput() can sleep.
1127     */
1128    void iput(struct inode *inode)
1129    {
1130            if (inode) {
1131                    struct super_operations *op = inode->i_sb->s_op;
1132
1133                    BUG_ON(inode->i_state == I_CLEAR);
1134
1135                    if (op && op->put_inode)


Note that this exact oops happens even when inotify has not been used, i.e. to
reproduce this oops, I can just do:

mount /mnt/ntfs ; umount /mnt/ntfs

What next? :)

Thanks,
Daniel
