Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVDHEwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVDHEwq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 00:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbVDHEwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 00:52:46 -0400
Received: from [151.97.230.9] ([151.97.230.9]:35335 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261375AbVDHEwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 00:52:41 -0400
Subject: [patch 1/1] reiserfs: make resize option auto-get new device size
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, blaisorblade@yahoo.it,
       reiserfs-dev@namesys.com, reiserfs-list@namesys.com,
       mtk-manpages@gmx.net
From: blaisorblade@yahoo.it
Date: Fri, 08 Apr 2005 06:55:50 +0200
Message-Id: <20050408045553.278CA11B7FE@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cc: <reiserfs-dev@namesys.com>, <reiserfs-list@namesys.com>, <mtk-manpages@gmx.net>

It's trivial for the resize option to auto-get the underlying device size, while
it's harder for the user. I've copied the code from jfs.

Since of the different reiserfs option parser (which does not use the superior
match_token used by almost every other filesystem), I've had to use the
"resize=auto" and not "resize" option to specify this behaviour. Changing the
option parser to the kernel one wouldn't be bad but I've no time to do this
cleanup in this moment.

Btw, the mount(8) man page should be updated to include this option. Cc the
relevant people, please (I hope I cc'ed the right people).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/fs/reiserfs/super.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff -puN fs/reiserfs/super.c~reiserfs-resize-option-like-jfs-auto-get fs/reiserfs/super.c
--- linux-2.6.11/fs/reiserfs/super.c~reiserfs-resize-option-like-jfs-auto-get	2005-04-07 20:37:58.000000000 +0200
+++ linux-2.6.11-paolo/fs/reiserfs/super.c	2005-04-08 01:01:18.000000000 +0200
@@ -889,12 +889,18 @@ static int reiserfs_parse_options (struc
 	    char * p;
 	    
 	    p = NULL;
-	    /* "resize=NNN" */
-	    *blocks = simple_strtoul (arg, &p, 0);
-	    if (*p != '\0') {
-		/* NNN does not look like a number */
-		reiserfs_warning (s, "reiserfs_parse_options: bad value %s", arg);
-		return 0;
+	    /* "resize=NNN" or "resize=auto" */
+
+	    if (!strcmp(arg, "auto")) {
+		    /* From JFS code, to auto-get the size.*/
+		    *blocks = s->s_bdev->bd_inode->i_size >> s->s_blocksize_bits;
+	    } else {
+		    *blocks = simple_strtoul (arg, &p, 0);
+		    if (*p != '\0') {
+			/* NNN does not look like a number */
+			reiserfs_warning (s, "reiserfs_parse_options: bad value %s", arg);
+			return 0;
+		    }
 	    }
 	}
 
@@ -903,7 +909,8 @@ static int reiserfs_parse_options (struc
 		unsigned long val = simple_strtoul (arg, &p, 0);
 		/* commit=NNN (time in seconds) */
 		if ( *p != '\0' || val >= (unsigned int)-1) {
-			reiserfs_warning (s, "reiserfs_parse_options: bad value %s", arg);			return 0;
+			reiserfs_warning (s, "reiserfs_parse_options: bad value %s", arg);
+			return 0;
 		}
 		*commit_max_age = (unsigned int)val;
 	}
_
