Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWEWUOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWEWUOD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 16:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWEWUOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 16:14:02 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:14605 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751216AbWEWUOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 16:14:00 -0400
Date: Tue, 23 May 2006 22:13:26 +0200
From: Willy TARREAU <willy@w.ods.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       marcelo@kvack.org, akpm@osdl.org
Subject: Re: [PATCH] Fix memory leak when the ext3's journal file is corrupted
Message-ID: <20060523201326.GA478@w.ods.org>
References: <E1Fhx2I-0001lb-Gk@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Fhx2I-0001lb-Gk@candygram.thunk.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Theodore,

On Sun, May 21, 2006 at 07:08:34PM -0400, Theodore Ts'o wrote:
> 
> Fix memory leak when the ext3's journal file is corrupted
> 
> Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
> 
> Index: linux-2.6/fs/jbd/recovery.c
> ===================================================================
> --- linux-2.6.orig/fs/jbd/recovery.c	2006-05-21 18:39:27.000000000 -0400
> +++ linux-2.6/fs/jbd/recovery.c	2006-05-21 18:39:34.000000000 -0400
> @@ -531,6 +531,7 @@
>  		default:
>  			jbd_debug(3, "Unrecognised magic %d, end of scan.\n",
>  				  blocktype);
> +			brelse(bh);
>  			goto done;
>  		}
>  	}

It seems to me that this one is a clear candidate for 2.4 too, isn't it ?
While reviewing diffs between 2.4 and 2.6 on this file, I also found this
patch from Andrew two years ago which also seems appropriate for 2.4 : 


[PATCH] JBD: avoid panic on corrupted journal superblock

Don't panic if the journal superblock is wrecked: just fail the mount.


--- 1.11/fs/jbd/recovery.c	2006-05-23 20:44:53 -07:00
+++ 1.12/fs/jbd/recovery.c	2006-05-23 20:44:53 -07:00
@@ -137,7 +137,10 @@
 
 	*bhp = NULL;
 
-	J_ASSERT (offset < journal->j_maxlen);
+	if (offset >= journal->j_maxlen) {
+		printk(KERN_ERR "JBD: corrupted journal superblock\n");
+		return -EIO;
+	}
 
 	err = journal_bmap(journal, offset, &blocknr);
 

I'm about to queue them both for Marcelo, do you have any objection ?

Thanks in advance,
Willy

