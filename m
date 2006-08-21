Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWHUSsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWHUSsh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWHUSsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:48:36 -0400
Received: from cantor2.suse.de ([195.135.220.15]:42428 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750723AbWHUSsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:48:00 -0400
Date: Mon, 21 Aug 2006 11:46:25 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Diego Calleja <diegocg@gmail.com>,
       Jens Kilian <jjk@acm.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 06/20] Fix BeFS slab corruption
Message-ID: <20060821184625.GG21938@kroah.com>
References: <20060821183818.155091391@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-befs-slab-corruption.patch"
In-Reply-To: <20060821184527.GA21938@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Diego Calleja <diegocg@gmail.com>

In bugzilla #6941, Jens Kilian reported:

"The function befs_utf2nls (in fs/befs/linuxvfs.c) writes a 0 byte past the
end of a block of memory allocated via kmalloc(), leading to memory
corruption.  This happens only for filenames which are pure ASCII and a
multiple of 4 bytes in length.  [...]

Without DEBUG_SLAB, this leads to further corruption and hard lockups; I
believe this is the bug which has made kernels later than 2.6.8 unusable
for me.  (This must be due to changes in memory management, the bug has
been in the BeFS driver since the time it was introduced (AFAICT).)

Steps to reproduce:
Create a directory (in BeOS, naturally :-) with files named, e.g.,
"1", "22", "333", "4444", ...  Mount it in Linux and do an "ls" or "find""

This patch implements the suggested fix. Credits to Jens Kilian for
debugging the problem and finding the right fix.

Signed-off-by: Diego Calleja <diegocg@gmail.com>
Cc: Jens Kilian <jjk@acm.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/befs/linuxvfs.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- linux-2.6.17.8.orig/fs/befs/linuxvfs.c
+++ linux-2.6.17.8/fs/befs/linuxvfs.c
@@ -512,7 +512,11 @@ befs_utf2nls(struct super_block *sb, con
 	wchar_t uni;
 	int unilen, utflen;
 	char *result;
-	int maxlen = in_len; /* The utf8->nls conversion can't make more chars */
+	/* The utf8->nls conversion won't make the final nls string bigger
+	 * than the utf one, but if the string is pure ascii they'll have the
+	 * same width and an extra char is needed to save the additional \0
+	 */
+	int maxlen = in_len + 1;
 
 	befs_debug(sb, "---> utf2nls()");
 
@@ -588,7 +592,10 @@ befs_nls2utf(struct super_block *sb, con
 	wchar_t uni;
 	int unilen, utflen;
 	char *result;
-	int maxlen = 3 * in_len;
+	/* There're nls characters that will translate to 3-chars-wide UTF-8
+	 * characters, a additional byte is needed to save the final \0
+	 * in special cases */
+	int maxlen = (3 * in_len) + 1;
 
 	befs_debug(sb, "---> nls2utf()\n");
 

--
