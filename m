Return-Path: <linux-kernel-owner+w=401wt.eu-S1751145AbXAFCmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbXAFCmu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbXAFCaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:30:08 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36524 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbXAFC3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:29:42 -0500
Message-Id: <20070106023340.856658000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:19 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, dimitri.gorokhovik@free.fr
Subject: [patch 26/50] ramfs breaks without CONFIG_BLOCK
Content-Disposition: inline; filename=ramfs-breaks-without-config_block.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Dimitri Gorokhovik <dimitri.gorokhovik@free.fr>

ramfs doesn't provide the .set_dirty_page a_op, and when the BLOCK layer is
not configured in, 'set_page_dirty' makes a call via a NULL pointer.

Signed-off-by: Dimitri Gorokhovik <dimitri.gorokhovik@free.fr>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 fs/ramfs/file-mmu.c   |    4 +++-
 fs/ramfs/file-nommu.c |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

--- linux-2.6.19.1.orig/fs/ramfs/file-mmu.c
+++ linux-2.6.19.1/fs/ramfs/file-mmu.c
@@ -25,11 +25,13 @@
  */
 
 #include <linux/fs.h>
+#include <linux/mm.h>
 
 const struct address_space_operations ramfs_aops = {
 	.readpage	= simple_readpage,
 	.prepare_write	= simple_prepare_write,
-	.commit_write	= simple_commit_write
+	.commit_write	= simple_commit_write,
+	.set_page_dirty = __set_page_dirty_nobuffers,
 };
 
 const struct file_operations ramfs_file_operations = {
--- linux-2.6.19.1.orig/fs/ramfs/file-nommu.c
+++ linux-2.6.19.1/fs/ramfs/file-nommu.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
 #include <linux/init.h>
@@ -30,7 +31,8 @@ static int ramfs_nommu_setattr(struct de
 const struct address_space_operations ramfs_aops = {
 	.readpage		= simple_readpage,
 	.prepare_write		= simple_prepare_write,
-	.commit_write		= simple_commit_write
+	.commit_write		= simple_commit_write,
+	.set_page_dirty = __set_page_dirty_nobuffers,
 };
 
 const struct file_operations ramfs_file_operations = {

--
