Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbWGJNiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWGJNiK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbWGJNiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:38:10 -0400
Received: from mail.zelnet.ru ([80.92.97.13]:6124 "EHLO mail.zelnet.ru")
	by vger.kernel.org with ESMTP id S964948AbWGJNiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:38:09 -0400
Message-ID: <44B2582E.30004@namesys.com>
Date: Mon, 10 Jul 2006 17:37:50 +0400
From: Edward Shishkin <edward@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Laurent Riffard <laurent.riffard@free.fr>, Andrew Morton <akpm@osdl.org>
CC: Kernel development list <linux-kernel@vger.kernel.org>,
       reiserfs-list@namesys.com
Subject: Re: 2.6.18-rc1-mm1 reiser4 module calls generic_file_read
References: <20060709021106.9310d4d1.akpm@osdl.org> <44B1798A.7080901@free.fr>
In-Reply-To: <44B1798A.7080901@free.fr>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040103070807070605000105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040103070807070605000105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Laurent Riffard wrote:
> generic_file_read has been dropped from 2.6.18-rc1-mm1. This patch 
> works for me. Does it look good to reiser4 devloppers ?
> 

No, it does not.
I have attached the correct one.
Andrew, please apply

Thanks,
Edward.

--------------040103070807070605000105
Content-Type: text/x-diff;
 name="reiser4-generic_file_read-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reiser4-generic_file_read-fix.patch"

Use do_sync_read() instead of generic_file_read()

Signed-off-by: Edward Shishkin <edward@namesys.com>
---
 linux-2.6.18-rc1-mm1/fs/reiser4/plugin/file/cryptcompress.c |    2 +-
 linux-2.6.18-rc1-mm1/fs/reiser4/plugin/object.c             |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rc1-mm1/fs/reiser4/plugin/file/cryptcompress.c
===================================================================
--- linux-2.6.18-rc1-mm1/fs/reiser4/plugin/file/cryptcompress.c.orig
+++ linux-2.6.18-rc1-mm1/fs/reiser4/plugin/file/cryptcompress.c
@@ -2883,7 +2883,7 @@
 	down_read(&info->lock);
 	LOCK_CNT_INC(inode_sem_r);
 
-	result = generic_file_read(file, buf, size, off);
+	result = do_sync_read(file, buf, size, off);
 
 	up_read(&info->lock);
 	LOCK_CNT_DEC(inode_sem_r);
Index: linux-2.6.18-rc1-mm1/fs/reiser4/plugin/object.c
===================================================================
--- linux-2.6.18-rc1-mm1/fs/reiser4/plugin/object.c.orig
+++ linux-2.6.18-rc1-mm1/fs/reiser4/plugin/object.c
@@ -305,6 +305,7 @@
 			.llseek = generic_file_llseek,
 			.read = read_cryptcompress,
 			.write = write_cryptcompress,
+			.aio_read = generic_file_aio_read,
 			.mmap = mmap_cryptcompress,
 			.release = release_cryptcompress,
 			.fsync = sync_common,

--------------040103070807070605000105--
