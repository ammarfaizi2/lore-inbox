Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264585AbUGFUmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264585AbUGFUmH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 16:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbUGFUlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 16:41:47 -0400
Received: from outmx016.isp.belgacom.be ([195.238.2.115]:57315 "EHLO
	outmx016.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S264405AbUGFUjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 16:39:05 -0400
Subject: Re: [OFFTOPIC] f_pos ? [PATCH 2.6.7-mm6] ext2_readdir commenting
From: FabF <fabian.frederick@skynet.be>
To: maneesh@in.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040706195816.GB3097@in.ibm.com>
References: <1088968685.2429.1.camel@localhost.localdomain>
	 <20040706195816.GB3097@in.ibm.com>
Content-Type: multipart/mixed; boundary="=-8ukCgMCnx6YvVNhidpBc"
Message-Id: <1089146330.3691.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 06 Jul 2004 22:38:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8ukCgMCnx6YvVNhidpBc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-07-06 at 21:58, Maneesh Soni wrote:
> On Sun, Jul 04, 2004 at 07:31:29PM +0000, FabF wrote:
> > Hi,
> > 	
> > 	I try to understand how readdir process works and I can't understand
> > f_pos management :
> > 
> >         Having in mind things work that way :
> > 
> >         user : ls
> >         glibc : 
> >                 open (->sys_open)
> >                 getdentries64 (->sys_getdentries64)
> >                 
> >         kernel:
> >                 sys_getdentries64
> >                 ->vfs_readdir
> >                         ->ext2_readdir
> > 
> > At that point, I don't understand why ext2_readdir is playing with
> > filp->f_pos .... It should be 0 ...Why does it care about offset ?
> > 
> 
> I think it may not be 0 all the time. A seekdir() could change could change
> the offset to non-zero.
Thanks Maneesh :) Anton brightly explained me readdir : it can be called
more than once (buffering ...) so the reason for that offset.Action
taking place in filldir return.'over' in ext2 readdir could bring
confusion though....It's 'over' for kernel duty but the whole path is
not necessarily explored yet.

I think the trivial comment patch attached (against 2.6.7-mm6) could be
interesting for that issue.

Regards,
FabF

> 
> Thanks
> Maneesh

--=-8ukCgMCnx6YvVNhidpBc
Content-Disposition: attachment; filename=ext2readdir_comment.patch
Content-Type: text/x-patch; name=ext2readdir_comment.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

ext2_readdir commenting

Signed off by FabF
---


diff -puN fs/ext2/dir.c~ext2readdir_comment fs/ext2/dir.c
--- linux-2.6.7/fs/ext2/dir.c~ext2readdir_comment	2004-07-06 22:20:14.514980596 +0200
+++ linux-2.6.7-heatwave/fs/ext2/dir.c	2004-07-06 22:31:52.822458517 +0200
@@ -245,6 +245,12 @@ static inline void ext2_set_de_type(ext2
 		de->file_type = 0;
 }
 
+/*
+ *	ext2_readdir()
+ *
+ * copy directory entries to userland from its current offset (filp->f_pos)
+ * up to the end or when buffer is full (over=-EFAULT | -EINVAL)
+ */
 static int
 ext2_readdir (struct file * filp, void * dirent, filldir_t filldir)
 {
_

--=-8ukCgMCnx6YvVNhidpBc--

