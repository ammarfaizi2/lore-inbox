Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWJHSgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWJHSgH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 14:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWJHSgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 14:36:06 -0400
Received: from pat.uio.no ([129.240.10.4]:41357 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750866AbWJHSgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 14:36:04 -0400
Subject: Re: BUG when doing parallel NFS mounts (WAS: Re: Merge window
	closed: v2.6.19-rc1)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Osterlund <petero2@telia.com>
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m3mz86hm39.fsf@telia.com>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
	 <m37izbhvvb.fsf@telia.com>  <m3mz86hm39.fsf@telia.com>
Content-Type: multipart/mixed; boundary="=-Y/T95Dcjyn1NaEZ7linj"
Date: Sun, 08 Oct 2006 14:35:45 -0400
Message-Id: <1160332545.11233.3.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.739, required 12,
	autolearn=disabled, AWL 1.12, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Y/T95Dcjyn1NaEZ7linj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2006-10-08 at 17:19 +0200, Peter Osterlund wrote:
> > ------------[ cut here ]------------
> > kernel BUG at fs/nfs/client.c:352!
> > invalid opcode: 0000 [#1]
> > PREEMPT
> > Modules linked in: nfs radeon nfsd exportfs lockd autofs4 sunrpc michael_mic arc4 ecb blkcipher cryptomgr crypto_algapi ieee80211_crypt_tkip binfmt_misc dm_mirror dm_mod lp parport_pc parport pcmcia ehci_hcd joydev ohci1394 ieee1394 ohci_hcd bcm43xx yenta_socket snd_atiixp_modem rsrc_nonstatic ide_cd ieee80211softmac ieee80211 serio_raw 8250_pci pcmcia_core 8250 ieee80211_crypt pcspkr 8139too serial_core cdrom rtc usbcore
> > CPU:    0
> > EIP:    0060:[<e0c836b5>]    Not tainted VLI
> > EFLAGS: 00010202   (2.6.19-rc1 #53)
> > EIP is at nfs_create_server+0x9f1/0xa6e [nfs]
> > eax: 00000000   ebx: d5e11b40   ecx: ca01a000   edx: 00000000
> > esi: 00000001   edi: ca01bdac   ebp: ca01bd08   esp: ca01bbf8
> > ds: 007b   es: 007b   ss: 0068
> > Process mount (pid: 4052, ti=ca01a000 task=ca078030 task.ti=ca01a000)
> > Stack: ca01bc58 c1405c68 ca01bc2c c1405c40 c1405c40 00000296 c05cc5d0 ca078030
> >        ca07857c d6b03380 00000003 ca97704c ca97705c ca078030 00000000 ca01bc8c
> >        c0135211 c01eea52 ca078570 00000246 ca01bc6c 00000246 00000002 ca845cb0
> > Call Trace:
> >  [<e0c899b2>] nfs_get_sb+0xbb/0x531 [nfs]
> >  [<c0166416>] vfs_kern_mount+0x42/0x8c
> >  [<c01664c4>] do_kern_mount+0x3b/0x4e
> >  [<c017a8ca>] do_mount+0x25a/0x6a5
> >  [<c017adaa>] sys_mount+0x95/0xd4
> >  [<c01030c1>] sysenter_past_esp+0x56/0x8d
> >  [<b7fa9410>] 0xb7fa9410
> >  =======================
> > Code: 85 28 ff ff ff 89 44 24 04 c7 04 24 00 61 c9 e0 e8 16 8e 49 df 8b 9d 28 ff ff ff 31 d2 81 fb 00 f0 ff ff 0f 97 c2 e9 62 f9 ff ff <0f> 0b 60 01 40 50 c9 e0 e9 34 f9 ff ff 81 fa 60 ea 00 00 0f 86
> > EIP: [<e0c836b5>] nfs_create_server+0x9f1/0xa6e [nfs] SS:ESP 0068:ca01bbf8

Does the following patch fix it?

Cheers,
  Trond


--=-Y/T95Dcjyn1NaEZ7linj
Content-Disposition: inline; filename=linux-2.6.19-002-fix_nfs_get_client.dif
Content-Type: message/rfc822; name=linux-2.6.19-002-fix_nfs_get_client.dif

From: Trond Myklebust <Trond.Myklebust@netapp.com>
Date: Sun, 8 Oct 2006 14:33:24 -0400
Subject: NFS: Fix typo in nfs_get_client()
Message-Id: <1160332545.11233.4.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

NFS_CS_INITING > NFS_CS_READY, so instead of waiting for the structure to
get initialised, we currently immediately jump out of the loop without ever
sleeping.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/client.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 6e4e48c..d2533e2 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -330,7 +330,7 @@ found_client:
 		for (;;) {
 			set_current_state(TASK_INTERRUPTIBLE);
 			if (signal_pending(current) ||
-			    clp->cl_cons_state > NFS_CS_READY)
+			    clp->cl_cons_state != NFS_CS_INITING)
 				break;
 			schedule();
 		}

--=-Y/T95Dcjyn1NaEZ7linj--

