Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWCMJwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWCMJwE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 04:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbWCMJwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 04:52:04 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:48886 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750749AbWCMJwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 04:52:01 -0500
From: Hans-Peter Jansen <hpj@urpla.net>
To: Olaf Kirch <okir@suse.de>
Subject: Re: [NFS] NFS client hangs under certain circumstances on SMP machine
Date: Mon, 13 Mar 2006 10:51:45 +0100
User-Agent: KMail/1.8
Cc: Olivier Croquette <ocroquette@free.fr>, linux-kernel@vger.kernel.org
References: <4404B41C.10404@free.fr> <44127800.4090905@free.fr> <20060313090033.GB12896@suse.de>
In-Reply-To: <20060313090033.GB12896@suse.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xCUFEHIL7ZGdUXt"
Message-Id: <200603131051.45896.hpj@urpla.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:18d01dd0a2a377f0376b761557b5e99a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_xCUFEHIL7ZGdUXt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Olaf,

Am Montag, 13. M=E4rz 2006 10:00 schrieb Olaf Kirch:
> Hi Olivier,
>
> On Sat, Mar 11, 2006 at 08:10:56AM +0100, Olivier Croquette wrote:
> > I think the corresponding patch is:
> > +nfs-fix-client-hang-due-to-race-condition.patch
> >
> > I could not find a lot of info about it, however.
>
> Do you have a URL for this patch?

I attached the (modified) patch here, that fixed it for me. You should=20
be able to locate the original LKML post.=20

Note that I disabled the first hunk, since it doesn't apply to=20
2.6.11.4-21.11 and isn't necessary, because you already added the=20
locking for this case ;-).

BTW, the nfs locking in later kernel releases is done much different=20
(much more fine grained with atomic bitops, but also much more a hassle=20
to apply to that kernel in question, thus I resigned it).

> If you point out the exact patch that you think fixed the problem
> on older kernels, we may consider including it in a future
> update.

I will test before and after the patch with the referenced test program=20
and let you know.=20

Is there a new 9.3 kernel release already scheduled?

Pete

--Boundary-00=_xCUFEHIL7ZGdUXt
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="NFS-fix-client-hang-due-to-race-condition.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="NFS-fix-client-hang-due-to-race-condition.diff"

=46rom njw@osdl.org Wed Jul  6 23:27:44 2005
Return-Path: <linux-kernel-owner+hpj=3D40urpla.net-S262527AbVGFVan@vger.ker=
nel.org>
Received: from mail.lisa.loc ([unix socket])
	 by tyrex (Cyrus v2.2.12) with LMTPA;
	 Wed, 06 Jul 2005 23:36:38 +0200
X-Sieve: CMU Sieve 2.2
Received: from localhost (localhost [127.0.0.1])
	by mail.lisa.loc (Postfix) with ESMTP id B2BF12001B20
	for <hp@localhost.lisa.loc>; Wed,  6 Jul 2005 23:36:38 +0200 (CEST)
Delivery-Date: Wed, 06 Jul 2005 23:35:33 +0200
Received: from pop.kundenserver.de [212.227.15.181]
	by localhost with POP3 (fetchmail-6.2.5)
	for hp@localhost (single-drop); Wed, 06 Jul 2005 23:36:25 +0200 (CEST)
Received: from [12.107.209.244] (helo=3Dvger.kernel.org)
	by mxeu8.kundenserver.de with ESMTP (Nemesis),
	id 0MKt1w-1DqHYK2XiU-00069O for hpj@urpla.net; Wed, 06 Jul 2005 23:35:32 +=
0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbVGFVan (ORCPT <rfc822;hpj@urpla.net>);
	Wed, 6 Jul 2005 17:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVGFV1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 17:27:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60624 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262522AbVGFVZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 17:25:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j66LOtjA000774
	(version=3DTLSv1/SSLv3 cipher=3DEDH-RSA-DES-CBC3-SHA bits=3D168 verify=3DN=
O);
	Wed, 6 Jul 2005 14:24:55 -0700
Received: from nwilson.pdx.osdl.net (nwilson.pdx.osdl.net [10.8.0.89])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j66LOtda024497;
	Wed, 6 Jul 2005 14:24:55 -0700
Received: from nwilson.pdx.osdl.net (localhost [127.0.0.1])
	by nwilson.pdx.osdl.net (8.13.3/8.13.1) with ESMTP id j66LRjYx013441;
	Wed, 6 Jul 2005 14:27:45 -0700
Received: (from njw@localhost)
	by nwilson.pdx.osdl.net (8.13.3/8.13.3/Submit) id j66LRin7013430;
	Wed, 6 Jul 2005 14:27:44 -0700
Date:	Wed, 6 Jul 2005 14:27:44 -0700
=46rom:	Nick Wilson <njw@osdl.org>
To: trond.myklebust@fys.uio.no
Cc: akpm@osdl.org,
 linux-kernel@vger.kernel.org,
 nfs@lists.sourceforge.net
Subject: [PATCH] NFS: fix client hang due to race condition
Message-ID: <20050706212744.GC20698@njw.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset=3Dus-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender:	linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org
Envelope-To: hpj@urpla.net
X-Virus-Scanned: amavisd-new at lisa.loc
X-UID: 57427
X-Length: 7015
Status: RO
X-Status: OC
X-KMail-EncryptionState: =20
X-KMail-SignatureState: =20
X-KMail-MDN-Sent: =20

The flags field in struct nfs_inode is protected by the BKL.  The
following two code paths (there may be more, but my test program only
hits these two) modify the flags without obtaining the lock:

    nfs_end_data_update
    nfs_release
    nfs_file_release
    __fput
    fput
    filp_close
    sys_close
    syscall_call

    nfs_revalidate_mapping
    nfs_file_write
    do_sync_write
    vfs_write
    sys_write
    syscall_call

Running multiple instances of a simple program [1] that opens, writes
to, and closes NFS mounted files eventually results in the programs
hanging on an SMP system (see kernel .config [3]).

I've been testing this with 100 instances of the program:
    $ ./breaknfs 100 &

Usually within 10 minutes, all instances of breaknfs will hang.  They
disappear from the output of 'top' and there is no NFS activity between
the client and server.

/proc/*/wchan shows 22 instances of breaknfs are waiting on
nfs_wait_on_inode, and 78 on .text.lock.namei

echo t > /proc/sysrq-trigger output [2] shows 22 instances of breaknfs
similar to this...:
    breaknfs      S 00100100  5060  5530   5523          5531  5529 (NOTLB)
    de0d1e24 00000086 c01178e0 00100100 de0d1de4 00000000 00000000 de0d1e14
    de0d1dec c0309513 de0d1e0c c0127c7e 00000000 dfaff020 c140e400 000004c3
    b37f50b5 0000003a c140e8c0 de7815b0 de7816d8 dbb5963c dbb59650 de0d0000
    Call Trace:
    [<c01eac01>] nfs_wait_on_inode+0x1b1/0x1c0
    [<c01eb2ac>] __nfs_revalidate_inode+0x2cc/0x340
    [<c01e8b1c>] nfs_file_flush+0x8c/0xc0
    [<c0159366>] filp_close+0x56/0x70
    [<c01593e9>] sys_close+0x69/0x90
    [<c0103039>] syscall_call+0x7/0xb

=2E.. and 78 similar to this:
    breaknfs      D 00000310  5060  5523   5466  5524               (NOTLB)
    ddcafebc 00000082 c0369810 00000310 ddcaff58 ddcafe90 db975690 00000000
    ddcafee0 ddcafe94 c0170a75 ddcaff58 00000000 dfaff020 c140e400 00000178
    b2b3096d 0000003a c140e8c0 df839550 df839678 dbb59e70 dbb59e78 00000286
    Call Trace:
    [<c03075b3>] __down+0x83/0xe0
    [<c030772e>] __down_failed+0xa/0x10
    [<c016b295>] .text.lock.namei+0xaa/0x1e5
    [<c0158e5d>] filp_open+0x2d/0x50
    [<c01592ad>] sys_open+0x4d/0x80
    [<c0103039>] syscall_call+0x7/0xb

NFS mount options from /proc/mounts:
    rw,v3,rsize=3D32768,wsize=3D32768,hard,intr,udp,lock,addr=3Dnjw

I've reproduced this bug on 2.6.11.10, 2.6.12-mm2, and 2.6.13-rc2.

With my patch against 2.6.13-rc2 below, I ran 100 instances of breaknfs
with this patch for 14 hours and I was unable to get the client to hang.

Thanks,

Nick Wilson

[1] http://developer.osdl.org/njw/nfs-bug/breaknfs.c
[2] http://developer.osdl.org/njw/nfs-bug/alt-sysrq-t.txt
[3] http://developer.osdl.org/njw/nfs-bug/kernel-config



The flags field in struct nfs_inode is protected by the BKL. This patch
fixes a couple places where the lock is not obtained before changing the
flags.

Signed-off-by: Nick Wilson <njw@osdl.org>

won't apply and isn't necessary due to surrounding BKL:=20
#@@ -1118,7 +1118,9 @@ void nfs_revalidate_mapping(struct inode
# 			nfs_wb_all(inode);
# 		}
# 		invalidate_inode_pages2(mapping);
#+		lock_kernel();
# 		nfsi->flags &=3D ~NFS_INO_INVALID_DATA;
#+		unlock_kernel();
# 		if (S_ISDIR(inode->i_mode)) {
# 			memset(nfsi->cookieverf, 0, sizeof(nfsi->cookieverf));
# 			/* This ensures we revalidate child dentries */
=2D--

 inode.c |    4 ++++
 1 files changed, 4 insertions(+)

=2D-- linux.orig/fs/nfs/inode.c	2005-07-06 11:08:27.000000000 -0700
+++ linux/fs/nfs/inode.c	2005-07-06 11:20:19.000000000 -0700
@@ -1153,10 +1155,12 @@ void nfs_end_data_update(struct inode *i
=20
 	if (!nfs_have_delegation(inode, FMODE_READ)) {
 		/* Mark the attribute cache for revalidation */
+		lock_kernel();
 		nfsi->flags |=3D NFS_INO_INVALID_ATTR;
 		/* Directories and symlinks: invalidate page cache too */
 		if (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))
 			nfsi->flags |=3D NFS_INO_INVALID_DATA;
+		unlock_kernel();
 	}
 	nfsi->cache_change_attribute ++;
 	atomic_dec(&nfsi->data_updates);
_
=2D
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


--Boundary-00=_xCUFEHIL7ZGdUXt--
