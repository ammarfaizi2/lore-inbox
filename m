Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbVISJjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVISJjR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 05:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbVISJjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 05:39:17 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:37589 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932389AbVISJjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 05:39:16 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: 2.6.14-rc1 - kernel BUG at fs/ntfs/aops.c:403
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: kronos@kronoz.cjb.net
Cc: linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>,
       Bas Vermeulen <bvermeul@blackstar.nl>
In-Reply-To: <20050917145150.GA5481@dreamland.darkstar.lan>
References: <20050917145150.GA5481@dreamland.darkstar.lan>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Mon, 19 Sep 2005 10:39:07 +0100
Message-Id: <1127122747.493.5.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2005-09-17 at 16:51 +0200, Luca wrote:
> Jean Delvare <khali@linux-fr.org> ha scritto:
> > Hi Anton, Bas, all,
> > 
> > [Bas Vermeulen]
> >> > I get a kernel BUG when mounting my (dirty) NTFS volume.
> >> > 
> >> > Sep 12 18:54:47 laptop kernel: [4294708.961000] NTFS volume version
> >> > 3.1. Sep 12 18:54:47 laptop kernel: [4294708.961000] NTFS-fs error
> >> > (device sda2): load_system_files(): Volume is dirty.  Mounting
> >> > read-only.  Run chkdsk and mount in Windows.
> >> > Sep 12 18:54:47 laptop kernel: [4294709.063000] ------------[ cut
> >> > here ]------------
> >> > Sep 12 18:54:47 laptop kernel: [4294709.063000] kernel BUG at
> >> > fs/ntfs/aops.c:403!
> >
> > I just hit the same BUG in different conditions. My NTFS volume is not
> > dirty, not compressed and the BUG triggered on use (updatedb), not
> > mount.
> 
> Same here, but it only triggers accessing a compressed directory. I can
> reproduce at will just by using 'ls' inside a compressed dir.

Below is the fix I just sent off to Linus.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

Subject: [PATCH 2/3] NTFS: Fix handling of compressed directories that I broke in earlier changeset.

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


