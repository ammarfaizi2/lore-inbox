Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265122AbUEVACB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265122AbUEVACB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 20:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265492AbUEVAAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 20:00:54 -0400
Received: from zeus.kernel.org ([204.152.189.113]:39613 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265122AbUEUXeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:34:18 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 20 May 2004 15:29:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16556.16982.957729.595623@cse.unsw.edu.au>
Cc: linux@horizon.com, kerndev@sc-software.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6 is crashing repeatedly
In-Reply-To: message from Andrew Morton on Wednesday May 19
References: <20040520040505.14642.qmail@science.horizon.com>
	<20040519212328.0eea3350.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday May 19, akpm@osdl.org wrote:
> linux@horizon.com wrote:
> >
> > I already reported (I thought) this message:
> > 
> >  May 19 02:23:47: Unable to handle kernel paging request at virtual address efd78000

> >  May 19 02:23:47: EIP is at encode_entry+0x4b/0x530
> >  May 19 02:23:47: eax: 00000000   ebx: 00000000   ecx: 00000644   edx: f3532df8
> >  May 19 02:23:47: esi: efd78000   edi: e4a19644   ebp: 00000654   esp: f14b7b98

> >  May 19 02:23:47: 
> >  May 19 02:23:47: Code: 89 06 89 c8 0f c8 89 46 04 81 7c 24 1c 00 01 00 00 b8 ff 00 
> 

cd->offset is 0xefd78000, which is the start of a, presumably unused, page.

Yes... this patch should fix it.

Thanks for the report.

NeilBrown

===============================================================
Fix NFSD oops in readdir.

If a single readdir entry needs to be split over two pages in
the reply, we first encode it into a new page, and then copy the
bits into place.  When we do this relocation, we have to modify
the "offset" pointer to be either in the first or the second page,
as appropriate.

If the pointer should be at the start of the second page, it is currently
put past the end of the first page.

Note that as the offset and whole response is known to be 4byte-aligned,
the offset pointer will never be split over two pages.


 ----------- Diffstat output ------------
 ./fs/nfsd/nfs3xdr.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff ./fs/nfsd/nfs3xdr.c~current~ ./fs/nfsd/nfs3xdr.c
--- ./fs/nfsd/nfs3xdr.c~current~	2004-05-20 15:10:15.000000000 +1000
+++ ./fs/nfsd/nfs3xdr.c	2004-05-20 15:22:23.000000000 +1000
@@ -936,7 +936,7 @@ encode_entry(struct readdir_cd *ccd, con
 			memmove(tmp, (caddr_t)tmp+len1, len2);
 
 			/* update offset */
-			if (((cd->offset - tmp) << 2) <= len1)
+			if (((cd->offset - tmp) << 2) < len1)
 				cd->offset = p + (cd->offset - tmp);
 			else
 				cd->offset -= len1 >> 2;
