Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266324AbUJOHGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbUJOHGK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 03:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266252AbUJOHGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 03:06:10 -0400
Received: from clusterfw.gprsrus.net ([217.118.66.232]:40769 "EHLO
	crimson.namesys.com") by vger.kernel.org with ESMTP id S266341AbUJOHFa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 03:05:30 -0400
Date: Fri, 15 Oct 2004 11:03:39 +0400
From: Alex Zarochentsev <zam@namesys.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: [RFC] MS_VERBOSE handling in get_sb_bdev()
Message-ID: <20041015070339.GE25932@backtop.namesys.com>
References: <20041014160638.GD25932@backtop.namesys.com> <416ECA78.6020405@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416ECA78.6020405@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 11:50:32AM -0700, Randy.Dunlap wrote:
> Alex Zarochentsev wrote:
> >Hello,
> >
> >Anybody knows why the "silent" agrument of the fs' ->fill_super() routines 
> >is
> >passed as ((flags & MS_VERBOSE) ? 1 : 0) ?.  It should be !(flags & 
> >MS_VERBOSE)
> >instead, yes?
> >
> >I don't belive the bug is not known... 
> 
> I saw several of those about 1 year ago when I updated Al's
> fs option patches and got them merged.
> 
> They should be fixed IMO, but it's low priority, they work ("it ain't
> broke so don't fix it"), and maybe someone else thinks that there is
> no problem at all, i.e., they aren't broken at all...

The kernel (2.6.9-rc4) patch is simple
==================================
--- linux/fs/super.c.orig	2004-10-14 18:12:50.213426568 +0400
+++ linux/fs/super.c	2004-10-14 18:13:46.923805280 +0400
@@ -692,7 +692,7 @@ struct super_block *get_sb_bdev(struct f
 		strlcpy(s->s_id, bdevname(bdev, b), sizeof(s->s_id));
 		s->s_old_blocksize = block_size(bdev);
 		sb_set_blocksize(s, s->s_old_blocksize);
-		error = fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
+		error = fill_super(s, data, !(flags & MS_VERBOSE));
 		if (error) {
 			up_write(&s->s_umount);
 			deactivate_super(s);
==================================

there is another bug in the mount utility, it seems to me.  mount never sets
MS_VERBOSE.  I think it should be set when the mount does not do "fs probing"
as in "mount -t auto ".

> -- 
> ~Randy

-- 
Alex.
