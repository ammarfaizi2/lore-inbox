Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290032AbSAKRrn>; Fri, 11 Jan 2002 12:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290036AbSAKRrd>; Fri, 11 Jan 2002 12:47:33 -0500
Received: from 216-42-72-167.ppp.netsville.net ([216.42.72.167]:43395 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S290032AbSAKRrX>; Fri, 11 Jan 2002 12:47:23 -0500
Date: Fri, 11 Jan 2002 12:46:26 -0500
From: Chris Mason <mason@suse.com>
To: Oleg Drokin <green@namesys.com>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] [PATCH] corrupted reiserfs may cause kernel to
 panic on lookup() sometimes.
Message-ID: <147220000.1010771186@tiny>
In-Reply-To: <20020103101830.A2610@namesys.com>
In-Reply-To: <20020103101830.A2610@namesys.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, January 03, 2002 10:18:30 AM +0300 Oleg Drokin
<green@namesys.com> wrote:

> Hello!
> 
>     Certain disk corruptions and i/o errors may cause lookup() to panic,
> which is wrong.     This patch fixes the problem.
>     Please apply.

Hmmm, none of the callers of reiserfs_find_entry have been changed to check
for IO_ERROR.  We should at least change reiserfs_add_entry to check for
IO_ERROR, so it doesn't try to create a name after getting io error during
the lookup.

-chris

--- linux/fs/reiserfs/namei.c.orig	Tue Dec 25 16:27:27 2001
+++ linux/fs/reiserfs/namei.c	Tue Dec 25 16:29:13 2001
@@ -309,9 +309,10 @@
 
     while (1) {
 	retval = search_by_entry_key (dir->i_sb, &key_to_search, path_to_entry, de);
-	if (retval == IO_ERROR)
-	    // FIXME: still has to be dealt with
-	    reiserfs_panic (dir->i_sb, "zam-7001: io error in " __FUNCTION__ "\n");
+	if (retval == IO_ERROR) {
+	    reiserfs_warning ("zam-7001: io error in " __FUNCTION__ "\n");
+	    return IO_ERROR;
+	}
 
 	/* compare names for all entries having given hash value */
 	retval = linear_search_in_dir_item (&key_to_search, de, name, namelen);

