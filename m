Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVAXWhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVAXWhn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVAXWhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:37:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:14054 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261704AbVAXWgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:36:00 -0500
Date: Mon, 24 Jan 2005 14:35:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Jens Axboe <axboe@suse.de>, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, lennert.vanalboom@ugent.be
Subject: Re: Memory leak in 2.6.11-rc1?
In-Reply-To: <20050124125649.35f3dafd.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0501241435010.4191@ppc970.osdl.org>
References: <20050121161959.GO3922@fi.muni.cz> <1106360639.15804.1.camel@boxen>
 <20050123091154.GC16648@suse.de> <20050123011918.295db8e8.akpm@osdl.org>
 <20050123095608.GD16648@suse.de> <20050123023248.263daca9.akpm@osdl.org>
 <1106528219.867.22.camel@boxen> <20050124204659.GB19242@suse.de>
 <20050124125649.35f3dafd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Jan 2005, Andrew Morton wrote:
> 
> Would indicate that the new pipe code is leaking.

Duh. It's the pipe merging.

		Linus

----
--- 1.40/fs/pipe.c	2005-01-15 12:01:16 -08:00
+++ edited/fs/pipe.c	2005-01-24 14:35:09 -08:00
@@ -630,13 +630,13 @@
 	struct pipe_inode_info *info = inode->i_pipe;
 
 	inode->i_pipe = NULL;
-	if (info->tmp_page)
-		__free_page(info->tmp_page);
 	for (i = 0; i < PIPE_BUFFERS; i++) {
 		struct pipe_buffer *buf = info->bufs + i;
 		if (buf->ops)
 			buf->ops->release(info, buf);
 	}
+	if (info->tmp_page)
+		__free_page(info->tmp_page);
 	kfree(info);
 }
 
