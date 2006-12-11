Return-Path: <linux-kernel-owner+w=401wt.eu-S937052AbWLKVp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937052AbWLKVp5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 16:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937627AbWLKVp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 16:45:57 -0500
Received: from sp604001mt.neufgp.fr ([84.96.92.60]:64907 "EHLO Smtp.neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937052AbWLKVp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 16:45:57 -0500
Date: Mon, 11 Dec 2006 22:23:44 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: [PATCH] reorder struct pipe_buf_operations
In-reply-to: <200612112027.kBBKR4nG006298@shell0.pdx.osdl.net>
To: akpm@osdl.org
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Message-id: <457DCC60.3050006@cosmosbay.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_I7HTPKRCevDe0GDQZgoyJA)"
References: <200612112027.kBBKR4nG006298@shell0.pdx.osdl.net>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_I7HTPKRCevDe0GDQZgoyJA)
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT

Fields of struct pipe_buf_operations have not a precise layout (ie not 
optimized to fit cache lines nor reduce cache line ping pongs)

The bufs[] array is *large* and is placed near the beginning of the structure, 
so all following fields have a large offset. This is unfortunate because many 
archs have smaller instructions when using small offsets relative to a base 
register. On x86 for example, 7 bits offsets have smaller instruction lengths.

Moving bufs[] at the end of pipe_buf_operations permits all fields to have 
small offsets, and reduce text size, and icache pressure.

# size vmlinux.pre vmlinux
    text    data     bss     dec     hex filename
3268989  664356  492196 4425541  438745 vmlinux.pre
3268765  664356  492196 4425317  438665 vmlinux

So this patch reduces text size by 224 bytes on my x86_64 machine. Similar 
results on ia32.


Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--Boundary_(ID_I7HTPKRCevDe0GDQZgoyJA)
Content-type: text/plain; name=reorder_pipe_inode_info.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=reorder_pipe_inode_info.patch

--- linux-2.6.19/include/linux/pipe_fs_i.h	2006-12-11 23:06:57.000000000 +0100
+++ linux-2.6.19-ed/include/linux/pipe_fs_i.h	2006-12-11 22:58:42.000000000 +0100
@@ -41,7 +41,6 @@ struct pipe_buf_operations {
 struct pipe_inode_info {
 	wait_queue_head_t wait;
 	unsigned int nrbufs, curbuf;
-	struct pipe_buffer bufs[PIPE_BUFFERS];
 	struct page *tmp_page;
 	unsigned int readers;
 	unsigned int writers;
@@ -51,6 +50,7 @@ struct pipe_inode_info {
 	struct fasync_struct *fasync_readers;
 	struct fasync_struct *fasync_writers;
 	struct inode *inode;
+	struct pipe_buffer bufs[PIPE_BUFFERS];
 };
 
 /* Differs from PIPE_BUF in that PIPE_SIZE is the length of the actual

--Boundary_(ID_I7HTPKRCevDe0GDQZgoyJA)--
