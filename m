Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265016AbTFLVqN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 17:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265017AbTFLVqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 17:46:12 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:29639 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S265016AbTFLVqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 17:46:02 -0400
Date: Thu, 12 Jun 2003 17:59:26 -0400
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Frank Cusack <fcusack@fcusack.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number mismatch)
Message-ID: <20030612215926.GA11684@delft.aura.cs.cmu.edu>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Frank Cusack <fcusack@fcusack.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0306110929260.1653-100000@home.transmeta.com> <1055352127.2419.25.camel@dhcp22.swansea.linux.org.uk> <16103.26865.361044.360120@charged.uio.no> <shsn0goy09f.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shsn0goy09f.fsf@charged.uio.no>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 07:47:24PM +0200, Trond Myklebust wrote:
> >>>>> " " == Trond Myklebust <trond.myklebust@fys.uio.no> writes:
> 
>      > 2.4 has the 'return ESTALE if current dir fails d_revalidate()'
>      > test. Looks like the vfat stuff has the same problem that
> 
> I should learn to complete my own sentences before sending... The
> above should read:
> 
> Looks like the vfat stuff has the same problem that Coda did. It is
> unintentionally triggering the ESTALE code, as it assumes that
> d_revalidate() is advisory only.

Coda still has the problem with 2.4. The only thing I have been telling
people that hit the problem is to take the revalidate patch out.

btw. The sheer number of problem cases is already reduced significantly
by the following patch which avoids calling revalidate on every name
that happens to start with a '.'.

Jan


diff -urN --exclude-from=dontdiff linux-2.4.21-rc2/fs/namei.c linux-2.4.21-rc2-coda/fs/namei.c
--- linux-2.4.21-rc2/fs/namei.c	2003-05-09 02:20:44.000000000 -0400
+++ linux-2.4.21-rc2-coda/fs/namei.c	2003-05-14 02:23:07.000000000 -0400
@@ -627,6 +627,8 @@
 			nd->last_type = LAST_DOT;
 		else if (this.len == 2 && this.name[1] == '.')
 			nd->last_type = LAST_DOTDOT;
+		else
+			goto return_base;
 return_reval:
 		/*
 		 * We bypassed the ordinary revalidation routines.


