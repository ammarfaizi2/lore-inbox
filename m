Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWGYWQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWGYWQo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 18:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWGYWQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 18:16:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:1631 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030185AbWGYWQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 18:16:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pw8qGb0zzh17c3Te2MNsixDvbwFFkqebAMm/wTUqpSGTSjVi3OfOku3lh0XBGgAnqwoXFTgvfsxJgI/naaZNbMlMX0s3uuHWeHWAEeNS+2IdSHb4VRK1ziIp0m5lHY40fE7aHmKdO2DP9ZtZb3TKEcqsqUttaVDh2vMjAiDScvM=
Message-ID: <9a8748490607251516j1433306ek9c64cc84c0838f7b@mail.gmail.com>
Date: Wed, 26 Jul 2006 00:16:42 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: possible recursive locking detected - while running fs operations in loops - 2.6.18-rc2-git5
Cc: "Hans Reiser" <reiser@namesys.com>,
       "Alexander Viro" <viro@zeniv.linux.org.uk>,
       "Al Viro" <viro@ftp.linux.org.uk>, reiserfs-dev@namesys.com,
       reiserfs-list@namesys.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just got this from the lock validator :

=============================================
[ INFO: possible recursive locking detected ]
---------------------------------------------
rm/2498 is trying to acquire lock:
 (&inode->i_mutex){--..}, at: [<c031c3ac>] mutex_lock+0x1c/0x20

but task is already holding lock:
 (&inode->i_mutex){--..}, at: [<c031c3ac>] mutex_lock+0x1c/0x20

other info that might help us debug this:
2 locks held by rm/2498:
 #0:  (&inode->i_mutex/1){--..}, at: [<c017b6f3>] do_rmdir+0x73/0xe0
 #1:  (&inode->i_mutex){--..}, at: [<c031c3ac>] mutex_lock+0x1c/0x20

stack backtrace:
 [<c0103faa>] show_trace_log_lvl+0x12a/0x150
 [<c0103fe2>] show_trace+0x12/0x20
 [<c01040f9>] dump_stack+0x19/0x20
 [<c0138a19>] print_deadlock_bug+0xb9/0xd0
 [<c0138a9b>] check_deadlock+0x6b/0x80
 [<c013a344>] __lock_acquire+0x354/0x990
 [<c013b0a5>] lock_acquire+0x75/0xa0
 [<c031c430>] __mutex_lock_slowpath+0x70/0x2a0
 [<c031c3ac>] mutex_lock+0x1c/0x20
 [<c01ac8b3>] reiserfs_delete_inode+0x63/0xd0
 [<c01854e1>] generic_delete_inode+0x61/0xe0
 [<c01856af>] generic_drop_inode+0xf/0x20
 [<c0185716>] iput+0x56/0x80
 [<c01826de>] dentry_iput+0x5e/0xc0
 [<c01827e8>] dput+0xa8/0x170
 [<c0182c0b>] prune_one_dentry+0x6b/0x80
 [<c0182d7b>] prune_dcache+0x15b/0x170
 [<c0182ff0>] shrink_dcache_parent+0x10/0x20
 [<c017b55a>] dentry_unhash+0x5a/0xc0
 [<c017b61f>] vfs_rmdir+0x5f/0xc0
 [<c017b74d>] do_rmdir+0xcd/0xe0
 [<c017b770>] sys_rmdir+0x10/0x20
 [<c010304b>] syscall_call+0x7/0xb
 [<b7e79d7d>] 0xb7e79d7d


What I did to provoke it was to run 6 different xterms (with a bash
shell) with the following loops in them in a test directory that was
initially empty :

xterm1:   while true; do mkdir a; done
xterm2:   while true; do rmdir a; done
xterm3:   while true; do touch a/foo; done
xterm4:   while true; do find .; done
xterm5:   while true; do sync; sleep 1; done
xterm6:   while true; do rm -r a; done

I then left that alone for ~15 minutes and then lockdep complained.

This was on a reiserfs 3.6 filesystem.
My kernel version is 2.6.18-rc2-git5 (i386 build, not x86_64)
The CPU is a Athlon64 X2 4400+

Some details :

$ uname -a
Linux dragon 2.6.18-rc2-git5 #1 SMP PREEMPT Tue Jul 25 22:58:52 CEST
2006 i686 athlon-4 i386 GNU/Linux

juhl@dragon:~/download/kernel/linux-2.6.18-rc2-git5$ scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux dragon 2.6.18-rc2-git5 #1 SMP PREEMPT Tue Jul 25 22:58:52 CEST
2006 i686 athlon-4 i386 GNU/Linux

Gnu C                  3.4.6
Gnu make               3.81
binutils               2.15.92.0.2
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
reiserfsprogs          3.6.19
quota-tools            3.13.
PPP                    2.4.4b1
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Linux C++ Library      6.0.3
Procps                 3.2.7
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.97
udev                   071
Modules Loaded         snd_seq_oss snd_seq_midi_event snd_seq
snd_pcm_oss snd_mixer_oss uhci_hcd usbcore snd_emu10k1 snd_rawmidi
snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_timer
snd_page_alloc snd_util_mem snd_hwdep snd agpgart

If more info is needed then just ask and I'll be happy to provide what I can.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
