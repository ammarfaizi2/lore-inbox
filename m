Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135365AbRAGDEK>; Sat, 6 Jan 2001 22:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135508AbRAGDDv>; Sat, 6 Jan 2001 22:03:51 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:267 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S135363AbRAGDDj>; Sat, 6 Jan 2001 22:03:39 -0500
Date: Sat, 06 Jan 2001 22:03:29 -0500
From: Chris Mason <mason@suse.com>
To: Daniel Phillips <phillips@innominate.de>,
        Hans-Joachim Baader <hjb@pro-linux.de>, linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.4.0-ac2
Message-ID: <264430000.978836609@tiny>
In-Reply-To: <3A57D909.F6B9F8B0@innominate.de>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sunday, January 07, 2001 03:48:41 AM +0100 Daniel Phillips
<phillips@innominate.de> wrote:

> A null buffer was passed by kupdate_one_transaction (looks like a
> Reiserfs function) to __refile_buffer.  Chris?
> 

Known bug, there should be another reiserfs release soon that includes the
fix.  The problem is that another transaction can set cn->bh to null while it
is being waited on.  The fix is to let someone else refile it later.

-chris

--- linux/fs/reiserfs/journal.c.1	Fri Jan  5 15:37:12 2001
+++ linux/fs/reiserfs/journal.c	Fri Jan  5 15:37:15 2001
@@ -1146,7 +1146,6 @@
             clear_bit(BLOCK_NEEDS_FLUSH, &cn->state) ;
             if (!pjl && cn->bh) {
                 wait_on_buffer(cn->bh) ;
-		refile_buffer(cn->bh) ;
             }
             /* check again, someone could have logged while we scheduled */
             pjl = find_newer_jl_for_cn(cn) ;



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
