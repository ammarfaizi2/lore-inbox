Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269444AbTCDNvT>; Tue, 4 Mar 2003 08:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269445AbTCDNvT>; Tue, 4 Mar 2003 08:51:19 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:7346 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S269444AbTCDNvQ>;
	Tue, 4 Mar 2003 08:51:16 -0500
Message-ID: <3E64B1C8.2090706@namesys.com>
Date: Tue, 04 Mar 2003 17:01:44 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Oleg Drokin <green@namesys.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Fwd: 2.4 journal overflow fix, please forward]
Content-Type: multipart/mixed;
 boundary="------------080904000708050303010402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080904000708050303010402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Please apply.

-- 
Hans


--------------080904000708050303010402
Content-Type: message/rfc822;
 name="2.4 journal overflow fix, please forward"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4 journal overflow fix, please forward"

Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 21247 invoked from network); 4 Mar 2003 13:52:24 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 4 Mar 2003 13:52:24 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id C646F328B95; Tue,  4 Mar 2003 16:52:24 +0300 (MSK)
Date: Tue, 4 Mar 2003 16:52:24 +0300
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: 2.4 journal overflow fix, please forward
Message-ID: <20030304165224.B8434@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i

Hello!

    This changeset fixes possible journal overflow (and assertion) while deleting
    large highly fragmented files on large enough fs (each file block should
    be in different bitmap). While this condition is hard to trigger, it is still
    possible and Philippe Gramoulle managed to reproduce it for us.

    Please pull from bk://namesys.com/bk/reiser3-linux-2.4-journal-overflow-fix

    Tested by me and Elena, reviewed by Chris Mason.

Diffstat:
 stree.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+)

Plain text path:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1009  -> 1.1010 
#	 fs/reiserfs/stree.c	1.20    -> 1.21   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/04	green@angband.namesys.com	1.1010
# reiserfs: Fix possible transaction overflow when deleting highly fragmented large files.
# 
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
--- a/fs/reiserfs/stree.c	Tue Mar  4 16:48:52 2003
+++ b/fs/reiserfs/stree.c	Tue Mar  4 16:48:52 2003
@@ -1125,6 +1125,21 @@
 		journal_mark_dirty (th, p_s_sb, p_s_bh);
 		inode->i_blocks -= p_s_sb->s_blocksize / 512;
 		reiserfs_free_block(th, tmp);
+		/* In case of big fragmentation it is possible that each block
+		   freed will cause dirtying of one more bitmap and then we will
+		   quickly overflow our transaction space. This is a
+		   counter-measure against that scenario */
+		if (journal_transaction_should_end(th, th->t_blocks_allocated)) {
+		    int orig_len_alloc = th->t_blocks_allocated ;
+		    pathrelse(p_s_path) ;
+
+		    journal_end(th, p_s_sb, orig_len_alloc) ;
+		    journal_begin(th, p_s_sb, orig_len_alloc) ;
+		    reiserfs_update_inode_transaction(inode) ;
+		    need_research = 1;
+		    break;
+		}
+
 		if ( item_moved (&s_ih, p_s_path) )  {
 			need_research = 1;
 			break ;



--------------080904000708050303010402--

