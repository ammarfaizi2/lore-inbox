Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263129AbUKTFa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbUKTFa4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 00:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262875AbUKTAON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 19:14:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56720 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262849AbUKTANc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 19:13:32 -0500
Date: Sat, 20 Nov 2004 00:13:17 GMT
Message-Id: <200411200013.iAK0DHhM006636@sisko.sctweedie.blueyonder.co.uk>
From: Stephen Tweedie <sct@redhat.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 3/3]: ext3: handle attempted double-delete of metadata.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch improves ext3's ability to deal with corruption on-disk.
If we try to delete a metadata block twice, we confuse ext3's internal
revoke error-checking, resulting in a BUG().  But this can occur in
practice due to a corrupt indirect block, so we should attempt to fail
gracefully.

Downgrade the assert failure to a JH_EXPECT_BH failure, and return EIO
when it occurs.

This is easily reproduced with a sample ext3 fs image containing an
inode which references the same indirect block more than once.
Deleting that inode will BUG() an unfixed kernel with:

Assertion failure in journal_revoke() at fs/jbd/revoke.c:379:
"!buffer_revoked(bh)"

With the fix, ext3 recovers gracefully.

Signed-off-by: Stephen Tweedie <sct@redhat.com>

--- linux-2.6-ext3/fs/jbd/revoke.c.=K0002=.orig
+++ linux-2.6-ext3/fs/jbd/revoke.c
@@ -376,7 +376,12 @@ int journal_revoke(handle_t *handle, uns
            first having the revoke cancelled: it's illegal to free a
            block twice without allocating it in between! */
 	if (bh) {
-		J_ASSERT_BH(bh, !buffer_revoked(bh));
+		if (!J_EXPECT_BH(bh, !buffer_revoked(bh),
+				 "inconsistent data on disk")) {
+			if (!bh_in)
+				brelse(bh);
+			return -EIO;
+		}
 		set_buffer_revoked(bh);
 		set_buffer_revokevalid(bh);
 		if (bh_in) {
