Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312267AbSCRJd5>; Mon, 18 Mar 2002 04:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312268AbSCRJdi>; Mon, 18 Mar 2002 04:33:38 -0500
Received: from tsukuba.m17n.org ([192.47.44.130]:62390 "EHLO tsukuba.m17n.org")
	by vger.kernel.org with ESMTP id <S312267AbSCRJdg>;
	Mon, 18 Mar 2002 04:33:36 -0500
Date: Mon, 18 Mar 2002 18:33:29 +0900 (JST)
Message-Id: <200203180933.g2I9XTg07727@mule.m17n.org>
From: NIIBE Yutaka <gniibe@m17n.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
In-Reply-To: <shs8z8qb8c5.fsf@charged.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
 > Er... Why?

Because the inode could be on inode_unused, being still on the hash at
the client side, and server could reuse the inode (in case of
unfsd/ext3).  When the inode will be reused for different type, it
will result error.  Here is a scenario for non-patched 2.4.18:

   (1) Symbolic link has been removed.  The inode is put on inode_unused.
       Say the inode # was 0x1234.
   (2) Client issue "creat", server returns inode # 0x1234 (by the reuse).
   (3) Call chain is:

	 nfs_create -> nfs_instantiate -> nfs_fhget -> __nfs_fhget -> iget4

       iget4 returns the cached inode object on inode_unused.
   (4) nfs_fill_inode doesn't fill it, because inode->i_mode is not 0.
   (5) nfs_refresh_inode result error because inode->i_mode != fattr->mode.

Note that this is _real_ case.

 > If you really want to change something in nfs_find_actor() then the
 > following works better w.r.t. init_special_inode() on character
 > devices:
 > 
 >         if ((inode->i_mode & S_IFMT) != (fattr->mode & S_IFMT))
 >                 return 0;

Well, I've just tested this.  This works well, thank you.
-- 
