Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWJHLsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWJHLsJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 07:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWJHLsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 07:48:09 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:50409 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751097AbWJHLsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 07:48:06 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trond.myklebust@fys.uio.no
Subject: BUG when doing parallel NFS mounts (WAS: Re: Merge window closed: v2.6.19-rc1)
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 08 Oct 2006 13:47:52 +0200
In-Reply-To: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
Message-ID: <m37izbhvvb.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> so please give it a good testing, and let's see if there are any 
> regressions.

If I run this one-liner script:

while true ; do echo -n . ; mount p4:/home /p4home -ohard,intr & mount p4:/extra /p4extra -ohard,intr ; umount /p4home ; umount /p4extra ; done

I get a BUG after a few iterations, see below. If I replace the '&' with
a ';' so the mounts happen one at a time, it works as expected.

The NFS server runs kernel 2.6.17.11.

------------[ cut here ]------------
kernel BUG at fs/nfs/client.c:352!
invalid opcode: 0000 [#1]
PREEMPT
Modules linked in: nfs radeon nfsd exportfs lockd autofs4 sunrpc michael_mic arc4 ecb blkcipher cryptomgr crypto_algapi ieee80211_crypt_tkip binfmt_misc dm_mirror dm_mod lp parport_pc parport pcmcia ehci_hcd joydev ohci1394 ieee1394 ohci_hcd bcm43xx yenta_socket snd_atiixp_modem rsrc_nonstatic ide_cd ieee80211softmac ieee80211 serio_raw 8250_pci pcmcia_core 8250 ieee80211_crypt pcspkr 8139too serial_core cdrom rtc usbcore
CPU:    0
EIP:    0060:[<e0c836b5>]    Not tainted VLI
EFLAGS: 00010202   (2.6.19-rc1 #53)
EIP is at nfs_create_server+0x9f1/0xa6e [nfs]
eax: 00000000   ebx: d5e11b40   ecx: ca01a000   edx: 00000000
esi: 00000001   edi: ca01bdac   ebp: ca01bd08   esp: ca01bbf8
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 4052, ti=ca01a000 task=ca078030 task.ti=ca01a000)
Stack: ca01bc58 c1405c68 ca01bc2c c1405c40 c1405c40 00000296 c05cc5d0 ca078030
       ca07857c d6b03380 00000003 ca97704c ca97705c ca078030 00000000 ca01bc8c
       c0135211 c01eea52 ca078570 00000246 ca01bc6c 00000246 00000002 ca845cb0
Call Trace:
 [<e0c899b2>] nfs_get_sb+0xbb/0x531 [nfs]
 [<c0166416>] vfs_kern_mount+0x42/0x8c
 [<c01664c4>] do_kern_mount+0x3b/0x4e
 [<c017a8ca>] do_mount+0x25a/0x6a5
 [<c017adaa>] sys_mount+0x95/0xd4
 [<c01030c1>] sysenter_past_esp+0x56/0x8d
 [<b7fa9410>] 0xb7fa9410
 =======================
Code: 85 28 ff ff ff 89 44 24 04 c7 04 24 00 61 c9 e0 e8 16 8e 49 df 8b 9d 28 ff ff ff 31 d2 81 fb 00 f0 ff ff 0f 97 c2 e9 62 f9 ff ff <0f> 0b 60 01 40 50 c9 e0 e9 34 f9 ff ff 81 fa 60 ea 00 00 0f 86
EIP: [<e0c836b5>] nfs_create_server+0x9f1/0xa6e [nfs] SS:ESP 0068:ca01bbf8

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
