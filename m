Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264942AbUAaRHN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 12:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbUAaRHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 12:07:13 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:52229 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264942AbUAaRHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 12:07:12 -0500
Date: Sat, 31 Jan 2004 17:07:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       nathans@sgi.com
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
Message-ID: <20040131170710.A581@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miquel van Smoorenburg <miquels@cistron.nl>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	nathans@sgi.com
References: <bv8qr7$m2v$1@news.cistron.nl> <20040128222521.75a7d74f.akpm@osdl.org> <20040130202155.GM25833@drinkel.cistron.nl> <20040130221353.GO25833@drinkel.cistron.nl> <20040130143459.5eed31f0.akpm@osdl.org> <20040130225353.A26383@infradead.org> <20040130151316.40d70ed3.akpm@osdl.org> <20040131012507.GQ25833@drinkel.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040131012507.GQ25833@drinkel.cistron.nl>; from miquels@cistron.nl on Sat, Jan 31, 2004 at 02:25:07AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an (untested) quickhack to take i_sem in linvfs_getattr.
I'll try to come up with a real fix next week.

--- 1.39/fs/xfs/linux/xfs_iops.c	Fri Jan  9 01:07:07 2004
+++ edited/fs/xfs/linux/xfs_iops.c	Sat Jan 31 18:41:44 2004
@@ -478,8 +478,11 @@
 	vnode_t		*vp = LINVFS_GET_VP(inode);
 	int		error = 0;
 
-	if (unlikely(vp->v_flag & VMODIFIED))
+	if (unlikely(vp->v_flag & VMODIFIED)) {
+		down(&inode->i_sem);
 		error = vn_revalidate(vp);
+		up(&inode->i_sem);
+	}
 	if (!error)
 		generic_fillattr(inode, stat);
 	return 0;
