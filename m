Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbTEIHyE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 03:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbTEIHyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 03:54:04 -0400
Received: from 237.oncolt.com ([213.86.99.237]:65265 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S262351AbTEIHyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 03:54:03 -0400
Subject: Re: PATCH - Don't remove inode from hash until filesystem has
	deleted it.
From: David Woodhouse <dwmw2@infradead.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <16057.46720.778667.845306@notabene.cse.unsw.edu.au>
References: <16057.46720.778667.845306@notabene.cse.unsw.edu.au>
Content-Type: text/plain
Organization: 
Message-Id: <1052467585.23135.97.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Fri, 09 May 2003 09:06:33 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-08 at 02:44, Neil Brown wrote:
> Don't remove inode from hash until filesystem has deleted it.
> 
> There is a small race with knfsd using iget to get an inode
> that is currently being deleted.  This is because it is removed
> from the hash table *before* the filesystem gets to delete it.
> If nfsd does an iget in this window it will cause a read_inode which
> will return an apparently valid inode.  However that inode will
> shortly be deleted from disc without knfsd noticing... until
> it is too late.

JFFS2 suffers similarly from the VFS simultaneously calling read_inode()
and clear_inode() for the same inode, since it uses iget() internally
for garbage collection. Since deletion is a slow operation which
involves marking nodes obsolete on the medium, it's nice and easy to hit
the race and have jffs2_read_inode() start walking the list of nodes
belonging to a certain inode at the same time as jffs2_clear_inode() is
walking the same list freeing them all :)

I've added locking to prevent this from happening in that particular
case, by suspending garbage collection during jffs2_clear_inode(), but
that's undesirable and anyway, the problem still exists when a JFFS2
file system is exported by nfsd, if nfsd attempts to open the inode
while it's being deleted.

Your patch should solve that too -- looks sane to me.

-- 
dwmw2

