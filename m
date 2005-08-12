Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbVHLNqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbVHLNqO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 09:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVHLNqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 09:46:14 -0400
Received: from pat.uio.no ([129.240.130.16]:60348 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751176AbVHLNqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 09:46:13 -0400
Subject: Re: Oops in NFS client's call_decode()
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Beat Rubischon <rubischon@phys.ethz.ch>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58L.0508121411570.2031@wigwam.lugs.ch>
References: <Pine.LNX.4.58L.0508121411570.2031@wigwam.lugs.ch>
Content-Type: multipart/mixed; boundary="=-Mu8yILbTH5NV/ah4aWxD"
Date: Fri, 12 Aug 2005 09:45:59 -0400
Message-Id: <1123854360.8652.23.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.576, required 12,
	autolearn=disabled, AWL 2.24, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Mu8yILbTH5NV/ah4aWxD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

fr den 12.08.2005 Klokka 14:46 (+0200) skreiv Beat Rubischon:
> Hello!
> 
> "wiggis" is our mailserver, is using NFS from several FreeBSD
> fileservers. From time to time, usually all one to ten days, we
> have an Oops while Postfix's local trys to fstat64() the user's
> ~/.forward. After that, errors in every part of the system occurs
> and a crash follows in 10-20 hours.
> 
> Kernel is vanilla 2.4.31 running on a Debian Woody. Computer was
> replaced by a complete different hardware - same effect.
> 
> The servers are running FreeBSD 4.11-RELEASE-p11 and
> 5.4-RELEASE-p6.
> 
> Output of ksymoops:
> 
> ---8<---
> ksymoops 2.4.5 on i686 2.4.31.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.31/ (default)
>      -m /boot/System.map (specified)
> 
> Unable to handle kernel paging request at virtual address ffa4a000
> c0172089
> *pde = 00002063
> Oops: 0002
> CPU:    0
> EIP:    0010:[<c0172089>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010292
> eax: 00000ffc   ebx: f7050408   ecx: ffa49000   edx: dd0a0000
> esi: 0000001c   edi: f7050464   ebp: f70503d0   esp: e18f9d94
> ds: 0018   es: 0018   ss: 0018
> Process local (pid: 19425, stackpage=e18f9000)
> Stack: e18f9e1c f7050428 c02502f2 f70503d0 c8f9da38 00000000 e18f8000 e18f9ddc
>        e18f9e84 e18f9e1c c0171fe4 c025310a e18f9e1c e18f9e1c fffffff5 e18f9e1c
>        f6f5d080 e18f8000 00000000 e18f8000 00000000 00000000 c0253364 e18f9e1c
> Call Trace:    [<c02502f2>] [<c0171fe4>] [<c025310a>] [<c0253364>] [<c024f8cd>]
>   [<c0252810>] [<c0172e0f>] [<c017452c>] [<c0124f44>] [<c017457b>] [<c0174510>]
>   [<c017467e>] [<c0139b39>] [<c013a056>] [<c013a1c7>] [<c013a3f6>] [<c013703d>]
>   [<c0106b63>]
> Code: c6 44 08 04 00 8b 43 10 8b 10 a1 88 22 31 c0 f7 d8 39 05 84
> 
> 
> >>EIP; c0172089 <nfs_xdr_readlinkres+a5/e0>   <=====

Actually, the Oops appears to be in nfs_xdr_readlinkres. It looks very
much like it might be a symlink buffer overflow.

Does the attached patch help?

Cheers,
  Trond


--=-Mu8yILbTH5NV/ah4aWxD
Content-Disposition: inline; filename=linux-2.4.28-fix_readlink.dif
Content-Type: text/plain; name=linux-2.4.28-fix_readlink.dif; charset=UTF-8
Content-Transfer-Encoding: 7bit

[NFS] Fix symlink length bound checking

  We were not taking into account the fact that the string length shares
  buffer space with the symlink text itself.

 Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---
 nfs2xdr.c |    4 ++--
 nfs3xdr.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.4.28-rc1/fs/nfs/nfs2xdr.c
===================================================================
--- linux-2.4.28-rc1.orig/fs/nfs/nfs2xdr.c
+++ linux-2.4.28-rc1/fs/nfs/nfs2xdr.c
@@ -571,8 +571,8 @@ nfs_xdr_readlinkres(struct rpc_rqst *req
 	strlen = (u32*)kmap(rcvbuf->pages[0]);
 	/* Convert length of symlink */
 	len = ntohl(*strlen);
-	if (len > rcvbuf->page_len)
-		len = rcvbuf->page_len;
+	if (len > rcvbuf->page_len - sizeof(*strlen) - 1)
+		len = rcvbuf->page_len - sizeof(*strlen) - 1;
 	*strlen = len;
 	/* NULL terminate the string we got */
 	string = (char *)(strlen + 1);
Index: linux-2.4.28-rc1/fs/nfs/nfs3xdr.c
===================================================================
--- linux-2.4.28-rc1.orig/fs/nfs/nfs3xdr.c
+++ linux-2.4.28-rc1/fs/nfs/nfs3xdr.c
@@ -759,8 +759,8 @@ nfs3_xdr_readlinkres(struct rpc_rqst *re
 	strlen = (u32*)kmap(rcvbuf->pages[0]);
 	/* Convert length of symlink */
 	len = ntohl(*strlen);
-	if (len > rcvbuf->page_len)
-		len = rcvbuf->page_len;
+	if (len > rcvbuf->page_len - sizeof(*strlen) - 1)
+		len = rcvbuf->page_len - sizeof(*strlen) - 1;
 	*strlen = len;
 	/* NULL terminate the string we got */
 	string = (char *)(strlen + 1);

--=-Mu8yILbTH5NV/ah4aWxD--

