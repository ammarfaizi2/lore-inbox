Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbVISJb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVISJb7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 05:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbVISJb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 05:31:59 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:61113 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932401AbVISJb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 05:31:58 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 19 Sep 2005 10:31:56 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [2/3] NTFS: Fix handling of compressed directories that I broke in
 earlier changeset.
In-Reply-To: <Pine.LNX.4.60.0509190950420.19497@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509191031320.19497@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509190950420.19497@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Fix handling of compressed directories that I broke in earlier changeset.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/aops.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

4e64c88693fde1b1cbaa4cfecad43a0c3fad354e
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -389,9 +389,11 @@ retry_readpage:
 	 * Only $DATA attributes can be encrypted and only unnamed $DATA
 	 * attributes can be compressed.  Index root can have the flags set but
 	 * this means to create compressed/encrypted files, not that the
-	 * attribute is compressed/encrypted.
+	 * attribute is compressed/encrypted.  Note we need to check for
+	 * AT_INDEX_ALLOCATION since this is the type of both directory and
+	 * index inodes.
 	 */
-	if (ni->type != AT_INDEX_ROOT) {
+	if (ni->type != AT_INDEX_ALLOCATION) {
 		/* If attribute is encrypted, deny access, just like NT4. */
 		if (NInoEncrypted(ni)) {
 			BUG_ON(ni->type != AT_DATA);
@@ -1341,9 +1343,11 @@ retry_writepage:
 	 * Only $DATA attributes can be encrypted and only unnamed $DATA
 	 * attributes can be compressed.  Index root can have the flags set but
 	 * this means to create compressed/encrypted files, not that the
-	 * attribute is compressed/encrypted.
+	 * attribute is compressed/encrypted.  Note we need to check for
+	 * AT_INDEX_ALLOCATION since this is the type of both directory and
+	 * index inodes.
 	 */
-	if (ni->type != AT_INDEX_ROOT) {
+	if (ni->type != AT_INDEX_ALLOCATION) {
 		/* If file is encrypted, deny access, just like NT4. */
 		if (NInoEncrypted(ni)) {
 			unlock_page(page);
