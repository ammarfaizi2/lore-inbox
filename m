Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWHGHOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWHGHOW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 03:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWHGHOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 03:14:22 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:34222 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751116AbWHGHOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 03:14:21 -0400
Message-Id: <1154934860.6783.267775866@webmail.messagingengine.com>
X-Sasl-Enc: s3bBf20qfVBlVoDJbWHk7Ohl8iYFxXvL6LB4ZBQp3WCc 1154934860
From: dan@pwienterprises.com
To: "Eric Sandeen" <sandeen@sandeen.net>, linux-kernel@vger.kernel.org
Cc: bfennema@falcon.csc.calpoly.edu
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
References: <44D36E60.2020006@sandeen.net>
Subject: Re: [PATCH]: initialize parts of udf inode earlier in create
In-Reply-To: <44D36E60.2020006@sandeen.net>
Date: Mon, 07 Aug 2006 00:14:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I saw an oops down this path when trying to create a new file on a UDF 
> filesystem which was internally marked as readonly, but mounted rw:
> 
> udf_create
>         udf_new_inode
>                 new_inode
>                         alloc_inode
>                         	udf_alloc_inode
>                 udf_new_block
>                         returns EIO due to readonlyness
>                 iput (on error)

I ran into the same issue today, but when listing a directory with
invalid/corrupt entries:

udf_lookup
        udf_iget
                get_new_inode_fast
                        alloc_inode
                                udf_alloc_inode
                __udf_read_inode
                        fails for any reason
                iput (on error)
                        ...

The following patch to udf_alloc_inode() should take care of both (and
other similar) cases, but I've only tested it with udf_lookup().

Dan

--

Signed-off-by: Dan Bastone <dan@pwienterprises.com>

--- linux-2.6.17.7/fs/udf/super.c.orig
+++ linux-2.6.17.7/fs/udf/super.c
@@ -116,6 +116,13 @@
        ei = (struct udf_inode_info *)kmem_cache_alloc(udf_inode_cachep,
        SLAB_KERNEL);
        if (!ei)
                return NULL;
+
+       ei->i_unique = 0;
+       ei->i_lenExtents = 0;
+       ei->i_next_alloc_block = 0;
+       ei->i_next_alloc_goal = 0;
+       ei->i_strat4096 = 0;
+
        return &ei->vfs_inode;
 }


-- 
  
  diegogarcia@cluemail.com

-- 
http://www.fastmail.fm - Email service worth paying for. Try it for free

