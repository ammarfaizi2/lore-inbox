Return-Path: <linux-kernel-owner+w=401wt.eu-S1754226AbWL0JEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbWL0JEF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 04:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754094AbWL0JEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 04:04:04 -0500
Received: from smtp.osdl.org ([65.172.181.25]:42195 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754226AbWL0JED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 04:04:03 -0500
Date: Wed, 27 Dec 2006 01:03:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: dimitri.gorokhovik@free.fr
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1 2.6.20-rc2] MM: ramfs breaks without CONFIG_BLOCK
Message-Id: <20061227010348.2e84b0cd.akpm@osdl.org>
In-Reply-To: <1167152987.4591575b1a824@imp8-g19.free.fr>
References: <1167152987.4591575b1a824@imp8-g19.free.fr>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Dec 2006 18:09:47 +0100
dimitri.gorokhovik@free.fr wrote:

> From: Dimitri Gorokhovik <dimitri.gorokhovik@free.fr>
> 
> ramfs doesn't provide the .set_dirty_page a_op, and when the BLOCK
> layer is not configured in, 'set_page_dirty' makes a call via a NULL
> pointer.

OK.  But I think it'd be better to fill in the address_space_operations:


From: Dimitri Gorokhovik <dimitri.gorokhovik@free.fr>

ramfs doesn't provide the .set_dirty_page a_op, and when the BLOCK layer is
not configured in, 'set_page_dirty' makes a call via a NULL pointer.

Signed-off-by: Dimitri Gorokhovik <dimitri.gorokhovik@free.fr>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/ramfs/file-mmu.c   |    4 +++-
 fs/ramfs/file-nommu.c |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff -puN fs/ramfs/file-mmu.c~mm-ramfs-breaks-without-config_block fs/ramfs/file-mmu.c
--- a/fs/ramfs/file-mmu.c~mm-ramfs-breaks-without-config_block
+++ a/fs/ramfs/file-mmu.c
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
diff -puN fs/ramfs/file-nommu.c~mm-ramfs-breaks-without-config_block fs/ramfs/file-nommu.c
--- a/fs/ramfs/file-nommu.c~mm-ramfs-breaks-without-config_block
+++ a/fs/ramfs/file-nommu.c
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
_

