Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760064AbWLCUbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760064AbWLCUbx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 15:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760073AbWLCUbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 15:31:53 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:9154 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1760064AbWLCUbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 15:31:52 -0500
Date: Sun, 3 Dec 2006 12:31:49 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: What's in ocfs2.git
Message-ID: <20061203203149.GC19617@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This e-mail describes the OCFS2 patches which I intend to push
upstream to Linus for 2.6.20.

* Various ocfs2 cleanups, including a patchset by me intended to clean up
  some of the internal ocfs2 journal api. Mostly this revolves around
  removing the ocfs2_journal_handle wrapper around handle_t. The immediate
  benefits are better readability and a slightly smaller memory footprint
  for open journal transactions.


* Configfs gets some small cleanups and some mutex annotations.


* Atime updates - thanks to Tiger Yang <tiger.yang@oracle.com>, ocfs2 now
  writes to the inode atime field. This doesn't require any disk changes,
  and is completely backwards compatible with older ocfs2 versions. An
  inodes Atime is only updated if it hasn't changed within a certain
  quantum. The user can define their own value at mount time, with 0
  indicating that atime should always be updated. This is very similar to
  the scheme implemented by gfs2. In the future, I'd like to see a "relative
  atime" mode, which functions in the manner described by Valerie Henson at:

http://lkml.org/lkml/2006/8/25/380


* sys_splice - ocfs2 now has splice read and write support. Thanks again to
  Tiger for the bulk of this functionality. Mostly we make use of the
  generic_splice_read() and generic_file_splice_write_nolock() functions
  provided already in fs/splice.c.

 - There is one patch in the ocfs2 splice() series external to fs/ocfs2 - a
   simple export of should_remove_suid(). This is done for code reuse
   purposes. That particular patch can be seen at:

http://ftp.kernel.org/pub/linux/kernel/people/mfasheh/ocfs2/ocfs2_git_patches/ocfs2-upstream-linus-20061201/0025-Export-should_remove_suid.txt

   I'll also attach it to this mail for review purposes.


* Last in the list of notable patches is a somewhat involved fix by Kurt
  Hackel <kurt.hackel@oracle.com> within the ocfs2 dlm. We had temporarily
  disable automatic migration of certain lock types because it was causing
  us problems during stress testing. This patch fixes those problems and
  re-enables migration. Overall this should reduce memory usage of the ocfs2
  dlm.


The patches can be found in

git://git.kernel.org/pub/scm/linux/kernel/git/mfasheh/ocfs2.git upstream-linus

Additionally, broken out patches are available at:

http://ftp.kernel.org/pub/linux/kernel/people/mfasheh/ocfs2/ocfs2_git_patches/ocfs2-upstream-linus-20060924/

Thanks,
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com


[PATCH] Export should_remove_suid()

This helps us avoid replicating the same logic within file system drivers.

Signed-off-by: Mark Fasheh <mark.fasheh@oracle.com>

---

 mm/filemap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

d23a147bb6e8d467e8df73b6589888717da3b9ce
diff --git a/mm/filemap.c b/mm/filemap.c
index 7b84dc8..13df01c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1893,6 +1893,7 @@ int should_remove_suid(struct dentry *de
 
 	return 0;
 }
+EXPORT_SYMBOL(should_remove_suid);
 
 int __remove_suid(struct dentry *dentry, int kill)
 {
-- 
1.3.3

