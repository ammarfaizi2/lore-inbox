Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbTIPHVr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 03:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbTIPHVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 03:21:47 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:49843 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261246AbTIPHVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 03:21:44 -0400
Date: Tue, 16 Sep 2003 09:21:37 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Yu Chen <dychen@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu,
       David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org
Subject: [PATCH] fix memleak in fs/jffs2/scan.c (was: re: [CHECKER] 32 Memory Leaks on Error Paths)
Message-ID: <20030916072137.GB12329@wohnheim.fh-wedel.de>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU> <20030916065553.GA12329@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030916065553.GA12329@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 September 2003 08:55:53 +0200, Jörn Engel wrote:
> 
> > [FILE:  2.6.0-test5/fs/jffs2/scan.c]
> > [FUNC:  jffs2_scan_medium]
> > [LINES: 98-109]
> > [VAR:   flashbuf]
> >   93:			buf_size = c->sector_size;
> >   94:		else
> >   95:			buf_size = PAGE_SIZE;
> >   96:
> >   97:		D1(printk(KERN_DEBUG "Allocating readbuf of %d bytes\n", buf_size));
> > START -->
> >   98:		flashbuf = kmalloc(buf_size, GFP_KERNEL);
> >   99:		if (!flashbuf)
> >  100:			return -ENOMEM;
> >  101:	}
> >  102:
> >  103:	for (i=0; i<c->nr_blocks; i++) {
> >  104:		struct jffs2_eraseblock *jeb = &c->blocks[i];
> >  105:
> >  106:		ret = jffs2_scan_eraseblock(c, jeb, buf_size?flashbuf:(flashbuf+jeb->offset), buf_size);
> >  107:
> >  108:		if (ret < 0)
> > END -->
> >  109:			return ret;
> >  110:
> >  111:		ACCT_PARANOIA_CHECK(jeb);
> >  112:
> >  113:		/* Now decide which list to put it on */
> >  114:		switch(ret) {
> 
> Valid.  And not trivial to fix.

But at least trivial to band-aid around it.  This doesn't make the
function any nicer, but it should get rid of the leaks.

David, consider this to be public domain. :)

Jörn

-- 
Mundie uses a textbook tactic of manipulation: start with some
reasonable talk, and lead the audience to an unreasonable conclusion.
-- Bruce Perens

--- linux-2.6.0-test3/fs/jffs2/scan.c~jffs2_memleak	2003-07-05 23:59:33.000000000 +0200
+++ linux-2.6.0-test3/fs/jffs2/scan.c	2003-09-16 09:16:30.000000000 +0200
@@ -106,7 +106,7 @@
 		ret = jffs2_scan_eraseblock(c, jeb, buf_size?flashbuf:(flashbuf+jeb->offset), buf_size);
 
 		if (ret < 0)
-			return ret;
+			goto out;
 
 		ACCT_PARANOIA_CHECK(jeb);
 
@@ -230,7 +230,8 @@
 		if ( !c->used_size && ((empty_blocks+bad_blocks)!= c->nr_blocks || bad_blocks == c->nr_blocks) ) {
 			printk(KERN_NOTICE "Cowardly refusing to erase blocks on filesystem with no valid JFFS2 nodes\n");
 			printk(KERN_NOTICE "empty_blocks %d, bad_blocks %d, c->nr_blocks %d\n",empty_blocks,bad_blocks,c->nr_blocks);
-			return -EIO;
+			ret = -EIO;
+			goto out;
 		}
 		jffs2_erase_pending_trigger(c);
 	}
@@ -241,6 +242,10 @@
 		c->mtd->unpoint(c->mtd, flashbuf, 0, c->mtd->size);
 #endif
 	return 0;
+out:
+	if (buf_size)
+		kfree(flashbuf);
+	return ret;
 }
 
 static int jffs2_fill_scan_buf (struct jffs2_sb_info *c, unsigned char *buf,
