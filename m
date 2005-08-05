Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263013AbVHEN2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263013AbVHEN2l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 09:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbVHEN2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 09:28:41 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:8785 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S263013AbVHEN2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 09:28:40 -0400
Message-ID: <42F36AA2.7030807@sw.ru>
Date: Fri, 05 Aug 2005 17:33:22 +0400
From: Vasily Averin <vvs@sw.ru>
Organization: SW-soft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021224
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: "Artem B. Bityuckiy" <dedekind@infradead.org>,
       Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bugfix: two read_inode() calls without clear_inode()
 call between
X-Enigmail-Version: 0.70.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Could you please explain me, why we need to wake up somebody right 
before freeing an inode? It seems for me, if somebody really wait on 
this inode, then they have a good chance to access already freed memory.

Thank you,
	Vasily Averin


diff --git a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -282,6 +282,13 @@ static void dispose_list(struct list_hea
  		if (inode->i_data.nrpages)
  			truncate_inode_pages(&inode->i_data, 0);
  		clear_inode(inode);
+
+		spin_lock(&inode_lock);
+		hlist_del_init(&inode->i_hash);
+		list_del_init(&inode->i_sb_list);
+		spin_unlock(&inode_lock);
+
+		wake_up_inode(inode);
                 ^^^^^^^^^^^^^^^^^^^^
  		destroy_inode(inode);
  		nr_disposed++;
  	}

tree b4e0b69dbf3d2da69aa49423227a1da6036e9566
parent 168a9fd6a1bf91041adf9909f6c72cf747f0ca8c
author Artem B. Bityuckiy <dedekind@infradead.org>
committer Linus Torvalds <torvalds@g5.osdl.org>

Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>

