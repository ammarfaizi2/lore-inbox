Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272024AbRHVPE5>; Wed, 22 Aug 2001 11:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272025AbRHVPEr>; Wed, 22 Aug 2001 11:04:47 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:15631 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S272024AbRHVPE3>; Wed, 22 Aug 2001 11:04:29 -0400
Date: Wed, 22 Aug 2001 17:04:40 +0200
From: Jan Kara <jack@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Ext2 quota bug in 2.4.8
Message-ID: <20010822170440.C13229@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010822104424.D11019@atrey.karlin.mff.cuni.cz> <Pine.GSO.4.21.0108220520110.10119-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.GSO.4.21.0108220520110.10119-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Aug 22, 2001 at 05:21:02AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> On Wed, 22 Aug 2001, Jan Kara wrote:
> 
> >   Hello,
> > 
> >   Jan Sanislo <oystr@cs.washington.edu> found a bug in ext2 quota code in 2.4.6+.
> > During changes in ext2 code in 2.4.6 some DQUOT_INIT()s were removed but they
> > shouldn't and as a result quota is not computed right.
> >   The patch which adds missing DQUOT_INIT()s is below. I didn't place DQUOT_INIT()s to
> > original places but rather to generic vfs parts which seems better to me.
> >   Please apply - patch is against 2.4.8.
> 
> Wrong place - DQUOT_INIT should be in iput(), just before the call of
> ->delete_inode()
  OK. I was also thinking about this place but finally I chose those places in namei.c..
bad choice :)
  The patch which places DQUOT_INIT() in iput() is below. Please apply.

										Honza
--
Jan Kara <jack@suse.cz>
SuSE Labs
------------------------------------------------------------------------------------

--- linux-2.4.9/fs/inode.c	Wed Aug 22 17:00:51 2001
+++ linux-2.4.9/fs/inode.c	Wed Aug 22 17:01:11 2001
@@ -1049,6 +1049,7 @@
 
 			if (op && op->delete_inode) {
 				void (*delete)(struct inode *) = op->delete_inode;
+				DQUOT_INIT(inode);
 				/* s_op->delete_inode internally recalls clear_inode() */
 				delete(inode);
 			} else
